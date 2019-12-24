package com.wwl.services;

import com.wwl.entity.Admin;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;

public interface AdminService {
    Admin login(Admin admin);

    int updateInfo(Admin admin);

    int updatePw(Admin admin);

    ResponseData<Admin> getAll(int page, int limit);

    ResponseCodeAndMsg del(int id);

    ResponseCodeAndMsg stop(int id);

    ResponseCodeAndMsg start(int id);

    ResponseCodeAndMsg add(Admin admin);
}
