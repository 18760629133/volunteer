package com.wwl.controllers;

import com.alibaba.fastjson.JSON;
import com.wwl.entity.Message;
import com.wwl.entity.Reply;
import com.wwl.services.MessageService;
import com.wwl.services.ReplyService;
import com.wwl.utils.Time;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("reply")
public class ReplyController {
    @Autowired
    private ReplyService replyService;
    @Autowired
    private MessageService messageService;

    @ResponseBody
    @RequestMapping("addReply")
    public String addReply(@ModelAttribute Reply reply){
        messageService.read(reply.getId());
        Time time=new Time();
        reply.setTime(time.getDay());
        ResponseCodeAndMsg responseCodeAndMsg=replyService.addReply(reply);
        return JSON.toJSONString(responseCodeAndMsg);
    }
}
