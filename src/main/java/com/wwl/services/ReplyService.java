package com.wwl.services;

import com.wwl.entity.Reply;
import com.wwl.utils.entity.ResponseCodeAndMsg;

import java.util.List;

public interface ReplyService {
    ResponseCodeAndMsg addReply(Reply reply);
}
