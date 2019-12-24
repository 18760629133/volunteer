package com.wwl.services;

import com.wwl.entity.User;

import java.util.List;

public interface UserService {
    User userLogin(String id,String password);

    int userRegister(User user);

    int updateInfo(String phone,String email,String id);

    User getUserById(String id);

    List<User> getAllUser(int page,int limit);

    int getUserCount();

    int deleteUserById(String id);

    int updateUser(User user);

    User getByEamil(String email);

    int updatePw(String id, String new_password);

}
