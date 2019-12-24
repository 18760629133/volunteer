package com.wwl.controllers;

import com.alibaba.fastjson.JSON;
import com.wwl.entity.Check_Project;
import com.wwl.entity.User;
import com.wwl.services.CheckProjectService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/checkProject")
public class CheckProjectController {

    @Autowired
    private CheckProjectService checkProjectService;

    @RequestMapping("/userAddProject")
    @ResponseBody
    public String userAddPro(@ModelAttribute Check_Project check_project, HttpSession session){
        check_project.setState(0);
        User user= (User) session.getAttribute("user");
        check_project.setUser(user);
        int i=checkProjectService.add(check_project);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("发布成功，等待管理员审核!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "getMyProject")
    public String getMyProject(ModelMap modelMap,HttpSession session){
        User user= (User) session.getAttribute("user");
        List<Check_Project> check_projects=checkProjectService.getByUserId(user.getUserid());
        modelMap.addAttribute("myCheck",check_projects);
        return "mycheckproject";
    }

    @RequestMapping("/del")
    @ResponseBody
    public String del(@RequestParam(value = "id",required = true) int id){
        int i=checkProjectService.del(id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("删除成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/getAll")
    @ResponseBody
    public String getAll(@RequestParam("page") int page,@RequestParam("limit") int limit){
        List<Check_Project> check_projects=checkProjectService.getAll(page,limit);
        ResponseData<Check_Project> check_projectResponseData=new ResponseData<>();
        check_projectResponseData.setCode(0);
        check_projectResponseData.setMsg("查询成功");
        check_projectResponseData.setCount(checkProjectService.getCount());
        check_projectResponseData.setData(check_projects);
        return JSON.toJSONString(check_projectResponseData);
    }
    @RequestMapping(value = "/refuse")
    @ResponseBody
    public String refuse(@RequestParam(value = "projectid",required = true) int projectid) {
        ResponseCodeAndMsg responseCodeAndMsg=checkProjectService.refuse(projectid);
        return JSON.toJSONString(responseCodeAndMsg);
    }

}
