package com.wwl.controllers;

import com.alibaba.fastjson.JSON;
import com.wwl.entity.Project;
import com.wwl.utils.SendMail;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import com.wwl.entity.User;
import com.wwl.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 * 登陆
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/userLogin")
    public void getUser(@RequestParam(value = "id",required = true) String id,
                          @RequestParam(value = "password",required = true) String password, HttpSession session,
                        HttpServletResponse response) throws IOException {
        User user=userService.userLogin(id,password);
        if(user!=null){
            session.setAttribute("user",user);
            response.getWriter().println(1);
        }else{
            response.getWriter().println(0);
        }
    }

    /**
     *修改密码
     */
    @RequestMapping(value = "/updatePw")
    public void updatePw(@RequestParam(value = "password",required = true) String password,
                         @RequestParam(value = "new_password",required = true) String new_password,
                         @RequestParam(value = "re_password",required = true) String re_password,
                         HttpSession session,HttpServletResponse response) throws IOException{
        User user= (User) session.getAttribute("user");
        String strPw=user.getPassword();
        if(strPw.equals(password)){
            if(new_password.equals(re_password)){
                int i=userService.updatePw(user.getUserid(),new_password);
                if(i==1){
                    response.getWriter().println(0);
                }else {
                    response.getWriter().println(1);
                }
            }else {
                response.getWriter().println(2);
            }
        }else {
            response.getWriter().println(3);
        }

    }

//注销
    @RequestMapping(value = "/userLogOut")
    public String userLogOut(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/page/index.jsp";
    }

//注册
    @RequestMapping(value = "/userRegister")
    public void userRegister(@ModelAttribute User user,HttpServletResponse response) throws IOException {
        int i=userService.userRegister(user);
        response.setContentType("text/html;charset=utf-8");
        if(i>0){
            response.getWriter().println("<script>alert('注册成功');window.location.href='../page/index.jsp';</script>");
        }else {
            response.getWriter().println("<script>alert('注册失败');window.location.href='../page/registerjsp';</script>");
        }
    }

//更新用户个人信息
    @RequestMapping(value = "/udateInfo")
    public void userUpdateInfo(@RequestParam(value = "phone",required = false) String phone,
                               @RequestParam(value = "email",required = false) String email,
                               @RequestParam(value = "id",required = false) String id,
                               HttpServletResponse response,HttpSession session) throws IOException {
        int i=userService.updateInfo(phone,email,id);
        response.setContentType("text/html;charset=utf-8");
        if(i>0){
            User user=userService.getUserById(id);
            session.setAttribute("user",user);
            response.getWriter().println("<script>alert('修改成功');window.location.href='../page/myinfo.jsp';</script>");
        }else {
            response.getWriter().println("<script>alert('修改失败');window.location.href='../page/change_myinfo.jsp';</script>");
        }
    }


    //后台用户列表显示
    @RequestMapping(value = "/userList")
    @ResponseBody
    public String getUserList(@RequestParam("page") int page,@RequestParam("limit") int limit){
        List<User> list=userService.getAllUser(page,limit);
        ResponseData<User> userUtils=new ResponseData<>();
        userUtils.setCode(0);
        userUtils.setMsg("用户查询成功");
        userUtils.setCount(userService.getUserCount());
        userUtils.setData(list);
        String result=JSON.toJSONString(userUtils);
        return result;
    }

    @RequestMapping(value = "/deleteUserById")
    @ResponseBody
    public String deleteUserById(@RequestParam(value = "id",required = true) String id){
        int i=userService.deleteUserById(id);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("删除成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("删除失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/addUser")
    @ResponseBody
    public String adminAddUser(@ModelAttribute User user){
        int i=userService.userRegister(user);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("添加成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("添加失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/getUserById")
    public String getUserById(@RequestParam(value = "id",required = true) String id, ModelMap modelMap){
        User user=userService.getUserById(id);
        modelMap.addAttribute("user",user);
        return "/page/admin/user-edit";
    }

    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public String updateUser(@ModelAttribute User user){
        int i=userService.updateUser(user);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("修改成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("修改失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    @RequestMapping(value = "/getMyProject")
    public String getMyProject(HttpSession session,ModelMap modelMap){
        User u= (User) session.getAttribute("user");
        User user=userService.getUserById(u.getUserid());
        List<Project> projectList= user.getProjects();
        modelMap.addAttribute("myProjectList",projectList);
        return "myproject";
    }



    //找回密码
    @RequestMapping(value = "/userFindPassword")
    @ResponseBody
    public String userFindPassword(@RequestParam(value = "email",required = true) String email) throws IOException {
        User user=userService.getByEamil(email);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        /*response.setContentType("text/html;charset=utf-8");*/
        if(user!=null){
            SendMail mySendMail=new SendMail();
            mySendMail.sendMail(email,"您的密码为："+user.getPassword());
            responseCodeAndMsg.setCode(200);
            responseCodeAndMsg.setMsg("密码找回成功，请及时查收文件");
            return JSON.toJSONString(responseCodeAndMsg);
            /*response.getWriter().println("<script>alert('密码找回成功，请查看您的邮箱');window.location.href='../page/index.jsp';</script>");*/
        }else {
            /*response.getWriter().println("<script>alert('该邮箱还未在此注册过账号，请输入正确的邮箱地址');window.location.href='../page/findPassword.jsp';</script>");*/
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("输入邮箱错误，请确认该邮箱是否注册");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

}
