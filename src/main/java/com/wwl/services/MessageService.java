package com.wwl.services;

import com.wwl.entity.Message;
import com.wwl.utils.entity.PageBean;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;

import java.util.List;


public interface MessageService {
    PageBean<Message> getAllMessage(int currentPage,int currentCount);

    int addMessage(Message message);

    ResponseData<Message> getAll(int page, int limit);

    ResponseCodeAndMsg del(int id);

    ResponseCodeAndMsg read(int id);

    ResponseCodeAndMsg getNotRead();

    Message getById(int id);
}
