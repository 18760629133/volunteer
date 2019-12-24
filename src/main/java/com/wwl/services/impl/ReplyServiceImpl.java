package com.wwl.services.impl;

import com.wwl.daos.ReplyMapper;
import com.wwl.entity.Reply;
import com.wwl.services.ReplyService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    private ReplyMapper replyMapper;
    @Override
    public ResponseCodeAndMsg addReply(Reply reply) {
        int i=replyMapper.addReply(reply);
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("回复成功");
        }else{
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("回复失败");
        }
        return responseCodeAndMsg;
    }
}
