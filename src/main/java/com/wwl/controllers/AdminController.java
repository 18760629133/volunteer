package com.wwl.controllers;


import com.alibaba.fastjson.JSON;
import com.wwl.entity.Admin;
import com.wwl.entity.Message;
import com.wwl.services.AdminService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public String adminLogin(@ModelAttribute Admin admin, HttpSession session){
        Admin ad=adminService.login(admin);
        if(ad!=null){
            session.setAttribute("admin",ad);
            return "redirect:/page/admin/index.jsp";
        }else {
            return "redirect:/page/admin/login.jsp";
        }
    }

    @RequestMapping(value = "/updateInfo")
    @ResponseBody
    public String updateInfo(@ModelAttribute Admin admin){
        int i=adminService.updateInfo(admin);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("修改成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }

    }

    @RequestMapping(value = "/updatePw")
    @ResponseBody
    public String updatePw(@ModelAttribute Admin admin){
        int i=adminService.updatePw(admin);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("修改失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }

    }

    @RequestMapping(value = "/adminLogOut")
    public String loginOut(HttpSession session){
        session.removeAttribute("admin");
        return "redirect:/page/admin/login.jsp";
    }

    @RequestMapping(value = "/getAll")
    @ResponseBody
    public String getAll(@RequestParam("page") int page, @RequestParam("limit") int limit){
        ResponseData<Admin> responseData=adminService.getAll(page,limit);
        return JSON.toJSONString(responseData);
    }

    @RequestMapping(value = "/del")
    @ResponseBody
    public String read(@RequestParam(value = "id",required = true) int id){
        ResponseCodeAndMsg responseCodeAndMsg=adminService.del(id);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/stop")
    @ResponseBody
    public String stop(@RequestParam(value = "id",required = true) int id){
        ResponseCodeAndMsg responseCodeAndMsg=adminService.stop(id);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/start")
    @ResponseBody
    public String start(@RequestParam(value = "id",required = true) int id){
        ResponseCodeAndMsg responseCodeAndMsg=adminService.start(id);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/add")
    @ResponseBody
    public String add(@ModelAttribute Admin admin){
        ResponseCodeAndMsg responseCodeAndMsg=adminService.add(admin);
        return JSON.toJSONString(responseCodeAndMsg);
    }

}
