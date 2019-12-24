package com.wwl.controllers;

import com.alibaba.fastjson.JSON;
import com.wwl.entity.Project;
import com.wwl.entity.User;
import com.wwl.services.ProjectService;
import com.wwl.utils.entity.PageBean;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/project")
public class ProjectController {
    @Autowired
    private ProjectService projectService;

    @RequestMapping(value = "/getAll")
    @ResponseBody
    public String getAllProject(@RequestParam("page") int page,@RequestParam("limit") int limit){
        List<Project> projectList=projectService.getAll(page,limit);
        ResponseData<Project> projectResponseData=new ResponseData<>();
        projectResponseData.setCode(0);
        projectResponseData.setCount(projectService.getProjectCount());
        projectResponseData.setMsg("项目查询成功");
        projectResponseData.setData(projectList);
        return JSON.toJSONString(projectResponseData);
    }

    @RequestMapping(value = "/deleteById")
    @ResponseBody
    public String delete(@RequestParam(value = "id",required = true) int id){
        int i=projectService.deleteById(id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("删除成功!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("删除失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/startProject")
    @ResponseBody
    public String start(@RequestParam(value = "id",required = true) int id){
        int i=projectService.start(id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("活动开启成功!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("开启失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/endProject")
    @ResponseBody
    public String end(@RequestParam(value = "id",required = true) int id){
        int i=projectService.end(id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("活动已结束!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/addProject")
    @ResponseBody
    public String addProject(@ModelAttribute Project project){
        int i=projectService.addProject(project);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("添加成功!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/updateProject")
    @ResponseBody
    public String updateProject(@ModelAttribute Project project){
        int i=projectService.updateProject(project);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("更新成功!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    //前台获取项目列表
    @RequestMapping(value = "/getProjeccList")
    public String getProjectList(@RequestParam(value = "currentPage",required = true) int currentPage, ModelMap modelMap){
        PageBean<Project> projectPageBean=projectService.getProject(currentPage,8);
        modelMap.addAttribute("projectPageBean",projectPageBean);
        return "project";
    }

    @RequestMapping(value = "/getProjectInfo")
    public String getProjectInfo(@RequestParam(value = "id",required = true) int id,ModelMap modelMap){
        Project project=projectService.getById(id);
        modelMap.addAttribute("project",project);
        return "project_detail";
    }

    @RequestMapping(value = "/joinProject")
    @ResponseBody
    public String joinProject(@RequestParam(value = "project_id",required = true) int project_id,
                              @RequestParam(value = "user_id",required = true) String user_id){
        int i=projectService.joinProject(user_id,project_id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(200);
            responseCodeAndMsg.setMsg("报名成功!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else if(i==0){
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("您已报名了该项目，请勿再报名");
            return JSON.toJSONString(responseCodeAndMsg);
        }else{
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("当前人数已满");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/passProject")
    @ResponseBody
    public String passProject(@ModelAttribute Project project){
        int i=projectService.passProject(project);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("审核成功!");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/searchByName")
    public String search(@RequestParam(value = "name",required = true) String name, ModelMap modelMap){
        List<Project> list=projectService.getByName(name);
        modelMap.addAttribute("project",list);
        return "searchResult";
    }

    //志愿者取消报名
    @RequestMapping(value = "/delUser_Project")
    @ResponseBody
    public String delUser_Project(@RequestParam(value = "id",required = true) int id, HttpSession session){
        User user= (User) session.getAttribute("user");
        Project project=projectService.getById(id);
        int i=projectService.delUserAndProject(user,project);
        int j=projectService.updateProjectActualPersonById(id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0 && j>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("取消成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }
    @RequestMapping("/console")
    @ResponseBody
    public String console(){
        List list=projectService.getConsole();
        return JSON.toJSONString(list);
    }
}
