package com.wwl.daos;

import com.wwl.entity.Project;
import com.wwl.entity.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface Users_ProjectsMapper {
    @Insert("insert into user_project values(#{user.userid},#{project.projectid})")
    int joinProject(@Param("user") User user,@Param("project") Project project);

    @Select("select count(*) from user_project where userid=#{user_id} and projectid=#{project_id}")
    int getCount(@Param("user_id") String user_id,@Param("project_id") int project_id);

    @Delete("delete from user_project where userid=#{user.userid} and projectid=#{project.projectid}")
    int del(@Param("user") User user,@Param("project") Project project);
}
