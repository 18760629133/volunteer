package com.wwl.services.impl;

import com.wwl.daos.UserMapper;
import com.wwl.entity.User;
import com.wwl.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Transactional(readOnly = true)
    @Override
    public User userLogin(String id, String password) {
        return userMapper.findByIdAndPassword(id,password);
    }

    @Override
    public int userRegister(User user) {
        return userMapper.userAdd(user.getUserid(),user.getSex(),user.getPassword(),user.getUsername(),user.getPhone(),user.getEmail());
    }

    @Override
    public int updateInfo(String phone,String email,String id) {
        return userMapper.updateInfo(phone,email,id);
    }

    @Transactional(readOnly = true)
    @Override
    public User getUserById(String id) {
        return userMapper.getUserById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUser(int page,int limit) {

        return userMapper.getAllUser((page-1)*limit,limit);
    }

    @Override
    @Transactional(readOnly = true)
    public int getUserCount() {
        return userMapper.getUserCount();
    }

    @Override
    public int deleteUserById(String id) {
        return userMapper.deletById(id);
    }

    @Override
    public int updateUser(User user) {
        return userMapper.updateUser(user.getPassword(),user.getEmail(),user.getPhone(),user.getSex(),user.getUserid());
    }

    @Override
    public User getByEamil(String email) {
        return userMapper.getByEmail(email);
    }


    @Override
    public int updatePw(String id, String new_password) {
        return userMapper.updatePw(id,new_password);
    }


}
