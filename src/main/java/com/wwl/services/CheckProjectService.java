package com.wwl.services;

import com.wwl.entity.Check_Project;
import com.wwl.utils.entity.ResponseCodeAndMsg;

import java.util.List;

public interface CheckProjectService {
    int add(Check_Project check_project);

    List<Check_Project> getByUserId(String userid);

    int del(int id);

    List<Check_Project> getAll(int page, int limit);

    int getCount();

    ResponseCodeAndMsg refuse(int projectid);
}
