package com.wwl.daos;

import com.wwl.entity.Check_Project;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CheckProjectMapper {

    @Insert("insert into check_project value(0,#{check_project.name},#{check_project.needperson},#{check_project.servicetime}," +
            "#{check_project.provide},#{check_project.place},#{check_project.description},#{check_project.state},#{check_project.user.userid})")
    int add(@Param("check_project") Check_Project check_project);

    @Select("select * from check_project where userid=#{userid}")
    List<Check_Project> getByUserId(@Param("userid") String userid);

    @Delete("delete from check_project where id=#{id}")
    int del(@Param("id") int id);

    @Results({
            @Result(id = true,column = "projectid",property = "projectid"),
            @Result(column = "userid",property = "user",one = @One(select = "com.wwl.daos.UserMapper.getById",fetchType= FetchType.LAZY))
    })
    @Select("select * from check_project where state=0 limit #{start},#{limit}")
    List<Check_Project> getAll(@Param("start") int start,@Param("limit") int limit);

    @Select("select count(*) from check_project where state=0")
    int getCount();

    @Update("update check_project set state=1 where projectid=#{projectid}")
    int updateState(@Param("projectid") int projectid);

    @Update("update check_project set state=2 where projectid=#{projectid}")
    int refuse(@Param("projectid") int projectid);//state=2表示审核未通过
}
