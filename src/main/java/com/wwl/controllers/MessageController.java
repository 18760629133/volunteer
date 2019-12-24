package com.wwl.controllers;

import com.alibaba.fastjson.JSON;
import com.wwl.entity.Message;
import com.wwl.entity.User;
import com.wwl.services.MessageService;
import com.wwl.utils.Time;
import com.wwl.utils.entity.PageBean;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/message")
public class MessageController {
    @Autowired
    private MessageService messageService;

    @Autowired
    private Time time;

    @Autowired
    private ResponseCodeAndMsg responseCodeAndMsg;

    //前台获取意见列表
    @RequestMapping(value = "/getAllMessage")
    public String getAllMessage(ModelMap modelMap, @RequestParam(value = "currentPage",required = true) int currentPage){
        PageBean<Message> messagePageBean=messageService.getAllMessage(currentPage,5);
        modelMap.addAttribute("messagePageBean",messagePageBean);
        return "message";
    }

    //发表意见
    @RequestMapping(value = "/addMessage")
    @ResponseBody
    public String addMessage(@ModelAttribute Message message, HttpSession session){
        User user= (User) session.getAttribute("user");
        message.setUser(user);
        message.setTime(time.getDay());
        message.setState(0);
        int i=messageService.addMessage(message);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("意见提交成功");
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("提交失败");
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }

    //后台意见列表
    @RequestMapping(value = "/getAll")
    @ResponseBody
    public String getAll(@RequestParam("page") int page,@RequestParam("limit") int limit){
        ResponseData<Message> responseData=messageService.getAll(page,limit);
        return JSON.toJSONString(responseData);
    }

    @RequestMapping(value = "/del")
    @ResponseBody
    public String del(@RequestParam(value = "id",required = true) int id){
        ResponseCodeAndMsg responseCodeAndMsg=messageService.del(id);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    //标记已读
    @RequestMapping(value = "/read")
    @ResponseBody
    public String read(@RequestParam(value = "id",required = true) int id){
        ResponseCodeAndMsg responseCodeAndMsg=messageService.read(id);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/notRead")
    @ResponseBody
    public String onReadCount(){
        ResponseCodeAndMsg responseCodeAndMsg=messageService.getNotRead();
        return JSON.toJSONString(responseCodeAndMsg);
    }
}
