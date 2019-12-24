package com.wwl.daos;

import com.wwl.entity.Project;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Repository
public interface ProjectMapper {
    @Results({
            @Result(id = true,column = "projectid",property = "projectid"),
            @Result(column = "projectid",property = "users",many = @Many(select = "com.wwl.daos.UserMapper.getAllUserByUserId",fetchType = FetchType.LAZY))
    })
    @Select("select * from project order by state limit #{start},#{limit}")
    List<Project> getAll(@Param("start") int start,@Param("limit") int limit);

    @Select("select count(*) from project")
    int getProjectCount();

    @Delete("delete from project where projectid=#{id}")
    int deleteById(@Param("id") int id);

    @Update("update project set state=#{i} where projectid=#{id}")
    int updateState(@Param("i") int i,@Param("id") int id);

    @Insert("insert into project values(#{project.projectid},#{project.name},#{project.needperson},#{project.actualperson}," +
            "#{project.starttime},#{project.endtime},#{project.servicetime}," +
            "#{project.place},#{project.description},#{project.provide},#{project.contactname},#{project.contactphone},#{project.state})")
    int add(@Param("project") Project project);

    @Update("update project set name=#{project.name},needperson=#{project.needperson},actualperson=#{project.actualperson}," +
            "starttime=#{project.starttime},endtime=#{project.endtime},servicetime=#{project.servicetime},place=#{project.place}," +
            "description=#{project.description},provide=#{project.provide},contactphone=#{project.contactphone},state=#{project.state} where " +
            "projectid=#{project.projectid}")
    int update(@Param("project") Project project);

    @Results({
            @Result(id = true,column = "projectid",property = "projectid"),
            @Result(column = "projectid",property = "users",many = @Many(select = "com.wwl.daos.UserMapper.getAllUserByProjectId",fetchType = FetchType.LAZY))
    })
    @Select("select * from project where projectid=#{id}")
    Project getById(@Param("id") int id);

    @Update("update project set actualperson=actualperson+1 where projectid=#{project_id}")
    void addPerson(@Param("project_id") int project_id);

    @Results({
            @Result(id = true,column = "projectid",property = "projectid"),
            @Result(column = "name",property = "name"),
            @Result(column = "servicetime",property = "servicetime"),
            @Result(column = "place",property = "place"),
            @Result(column = "state",property = "state")
    })
    @Select("select * from project where projectid in (select projectid from user_project where userid=#{userid})")
    List<Project> getAllPorjectByUserId(@Param("userid") String userid);

    @Select("select * from project where name like CONCAT ('%',#{name},'%')")
    List<Project> getByName(@Param("name") String name);

    @Update("update project set actualperson=actualperson-1 where projectid=#{projectid}")
    int updateProjectActualPersonById(@Param("projectid") int id);

    @Select("select count(*) from project where starttime between #{start} and #{end}")
    int getProjectCountByMonth(@Param("start") String start,@Param("end") String end);
}
