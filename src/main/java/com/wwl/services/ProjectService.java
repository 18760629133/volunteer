package com.wwl.services;

import com.wwl.entity.Project;
import com.wwl.entity.User;
import com.wwl.utils.entity.PageBean;

import java.util.List;

public interface ProjectService {
    List<Project> getAll(int page,int limit);

    int getProjectCount();

    int deleteById(int id);

    int start(int id);

    int end(int id);

    int addProject(Project project);

    int updateProject(Project project);

    PageBean<Project> getProject(int currentPage,int currentCount);

    Project getById(int id);

    int joinProject(String user_id, int project_id);

    int passProject(Project project);

    List<Project> getByName(String name);

    int delUserAndProject(User user, Project project);

    int updateProjectActualPersonById(int id);

    List getConsole();
}
