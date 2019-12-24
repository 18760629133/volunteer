package com.wwl.services.impl;

import com.wwl.daos.AdminMapper;
import com.wwl.entity.Admin;
import com.wwl.services.AdminService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    @Transactional(readOnly = true)
    public Admin login(Admin admin) {
        return adminMapper.getByNameAndPw(admin.getName(),admin.getPassword());
    }

    @Override
    public int updateInfo(Admin admin) {
        return adminMapper.updataInfo(admin.getName(),admin.getPhone(),admin.getId());
    }

    @Override
    public int updatePw(Admin admin) {
        return adminMapper.updatePw(admin.getPassword(),admin.getId());
    }

    @Transactional(readOnly = true)
    @Override
    public ResponseData<Admin> getAll(int page, int limit) {
        ResponseData<Admin> responseData=new ResponseData<>();
        responseData.setCount(adminMapper.getCount());
        responseData.setMsg("查询成功");
        responseData.setCode(0);
        responseData.setData(adminMapper.getAll((page-1)*limit,limit));
        return responseData;
    }

    @Override
    public ResponseCodeAndMsg del(int id) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=adminMapper.del(id);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("删除成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg stop(int id) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=adminMapper.updateState(id,1);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("已停用!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("停用失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg start(int id) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=adminMapper.updateState(id,0);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("启用成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg add(Admin admin) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        admin.setState(0);
        int i=adminMapper.add(admin);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("添加成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("操作失败");
            return responseCodeAndMsg;
        }
    }

}
