package com.wwl.services.impl;

import com.wwl.daos.MessageMapper;
import com.wwl.daos.ReplyMapper;
import com.wwl.entity.Message;
import com.wwl.entity.Reply;
import com.wwl.services.MessageService;
import com.wwl.utils.entity.PageBean;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private ReplyMapper replyMapper;

    @Override
    @Transactional(readOnly = true)// 将事务设置成只读;从这一点设置的时间点开始到这个事务结束的过程中，其他事务所提交的数据，该事务将看不见！
    public PageBean<Message> getAllMessage(int currentPage,int currentCount) {
        int totalCount=messageMapper.getMessageCount();
        PageBean<Message> messagePageBean=new PageBean<>();
        messagePageBean.setTotalCount(totalCount);
        messagePageBean.setTotalPage((int) Math.ceil(1.0*totalCount/currentCount));
        messagePageBean.setCurrentPage(currentPage);
        messagePageBean.setCurrentCount(currentCount);
        List<Message> list=messageMapper.getAllMessage((currentPage-1)*currentCount,currentCount);
        /*for (int i=0;i<list.size();i++){
            Reply reply=replyMapper.getById(list.get(i).getId());
            if(reply!=null){

                Message message=new Message();
                message.setReply(reply);
                System.out.println(message.getReply().getReplybody());

            }
        }*/
        messagePageBean.setList(list);
        return messagePageBean;
    }

    @Override
    public int addMessage(Message message) {
        return messageMapper.addMessage(message);
    }

    @Override
    public ResponseData<Message> getAll(int page, int limit) {
        ResponseData<Message> responseData=new ResponseData<>();
        responseData.setCount(messageMapper.getMessageCount());
        responseData.setMsg("查询成功！");
        responseData.setCode(0);
        responseData.setData(messageMapper.getAllMessage((page-1)*limit,limit));
        return responseData;
    }

    @Override
    public ResponseCodeAndMsg del(int id) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=messageMapper.del(id);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("删除成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("删除失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg read(int id) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=messageMapper.read(id);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("标记成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg getNotRead() {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        responseCodeAndMsg.setCode(0);
        responseCodeAndMsg.setMsg(messageMapper.getNotReadCount()+"条");
        return responseCodeAndMsg;
    }

    @Override
    public Message getById(int id) {
        return messageMapper.getById(id);
    }
}
