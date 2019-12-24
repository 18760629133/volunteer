package com.wwl.services.impl;

import com.wwl.daos.CheckProjectMapper;
import com.wwl.entity.Check_Project;
import com.wwl.services.CheckProjectService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
@Service
public class CheckProjectServiceImpl implements CheckProjectService {
    @Autowired
    private CheckProjectMapper checkProjectMapper;

    @Override
    public int add(Check_Project check_project) {
        return checkProjectMapper.add(check_project);
    }

    @Transactional(readOnly = true)
    @Override
    public List<Check_Project> getByUserId(String userid) {
        return checkProjectMapper.getByUserId(userid);
    }

    @Override
    public int del(int id) {
        return checkProjectMapper.del(id);
    }

    @Transactional(readOnly = true)
    @Override
    public List<Check_Project> getAll(int page, int limit) {
        return checkProjectMapper.getAll((page-1)*limit,limit);
    }

    @Transactional(readOnly = true)
    @Override
    public int getCount() {
        return checkProjectMapper.getCount();
    }

    @Override
    public ResponseCodeAndMsg refuse(int projectid) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=checkProjectMapper.refuse(projectid);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("已拒绝");
        }else{
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
        }
        return responseCodeAndMsg;
    }
}
