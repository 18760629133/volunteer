package com.wwl.services.impl;

import com.wwl.daos.CheckProjectMapper;
import com.wwl.daos.ProjectMapper;
import com.wwl.daos.UserMapper;
import com.wwl.daos.Users_ProjectsMapper;
import com.wwl.entity.Project;
import com.wwl.entity.User;
import com.wwl.services.ProjectService;
import com.wwl.utils.Time;
import com.wwl.utils.entity.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
@Service
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    private ProjectMapper projectMapper;

    @Autowired
    private Users_ProjectsMapper users_projectsMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CheckProjectMapper checkProjectMapper;

    @Transactional(readOnly = true)
    @Override
    public List<Project> getAll(int page,int limit) {
        return projectMapper.getAll((page-1)*limit,limit);
    }

    @Override
    public int getProjectCount() {
        return projectMapper.getProjectCount();
    }

    @Override
    public int deleteById(int id) {
        return projectMapper.deleteById(id);
    }

    @Override
    public int start(int id) {
        return projectMapper.updateState(1,id);
    }

    @Override
    public int end(int id) {
        return projectMapper.updateState(2,id);
    }

    @Override
    public int addProject(Project project) {
        return projectMapper.add(project);
    }

    @Override
    public int updateProject(Project project) {
        return projectMapper.update(project);
    }

    @Override
    public PageBean<Project> getProject(int currentPage,int currentCount) {
        int totalCount=projectMapper.getProjectCount();
        PageBean<Project> projectPageBean=new PageBean<>();
        projectPageBean.setCurrentCount(currentCount);
        projectPageBean.setCurrentPage(currentPage);
        projectPageBean.setTotalCount(totalCount);
        projectPageBean.setTotalPage((int) Math.ceil(1.0*totalCount/currentCount));
        projectPageBean.setList(projectMapper.getAll((currentPage-1)*currentCount,currentCount));
        return projectPageBean;
    }

    @Override
    public Project getById(int id) {
        return projectMapper.getById(id);
    }

    @Override
    public int joinProject(String user_id, int project_id) {
        int flag=0;
        Project project=projectMapper.getById(project_id);
        User user=userMapper.getUserById(user_id);
        int i=users_projectsMapper.getCount(user_id,project_id);
        if(i<1){
            if(project.getNeedperson()>project.getActualperson()) {
                flag= users_projectsMapper.joinProject(user, project);
                if(flag>0){
                    projectMapper.addPerson(project_id);
                }
            }else {
                flag=-1;//报名人数已满
            }
        }else {
            flag=0;
        }

        return flag;
    }

    @Override
    public int passProject(Project project) {
        int flag=0;
        int i=checkProjectMapper.updateState(project.getProjectid());
        if(i>0){
            project.setProjectid(0);
            project.setActualperson(0);
            int f=projectMapper.add(project);
            if(f>0){
                flag=f;
            }
        }
        return flag;
    }

    @Override
    public List<Project> getByName(String name) {
        return projectMapper.getByName(name);
    }

    @Override
    public int delUserAndProject(User user, Project project) {
        return users_projectsMapper.del(user,project);
    }

    @Override
    public int updateProjectActualPersonById(int id) {
        return projectMapper.updateProjectActualPersonById(id);
    }

    @Override
    public List getConsole() {
        List list=new ArrayList();
        Time time=new Time();
        for(int i=1;i<=12;i++){
            String start=time.getYear()+i+"-1";
            String end=time.getYear()+i+"-31";
            int count=projectMapper.getProjectCountByMonth(start,end);
            list.add(count);
        }
        return list;
    }
}
