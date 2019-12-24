package com.wwl.daos;

import com.wwl.entity.Admin;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminMapper {

    @Select("select * from admin where name=#{name} and password=#{password}")
    Admin getByNameAndPw(@Param("name") String name,@Param("password") String password);

    @Update("update admin set name=#{name},phone=#{phone} where id=#{id}")
    int updataInfo(@Param("name") String name,@Param("phone") String phone,@Param("id") int id);

    @Update("update admin set password=#{password} where id=#{id}")
    int updatePw(@Param("password") String password,@Param("id") int id);

    @Select("select count(*) from admin")
    int getCount();

    @Select("select * from admin order by state limit #{i},#{limit}")
    List<Admin> getAll(@Param("i") int i,@Param("limit") int limit);

    @Delete("delete from admin where id=#{id}")
    int del(@Param("id") int id);

    @Update("update admin set state=#{i} where id=#{id}")
    int updateState(@Param("id") int id,@Param("i") int i);

    @Insert("insert into admin value(#{admin.id},#{admin.name},#{admin.password},#{admin.phone},#{admin.state})")
    int add(@Param("admin") Admin admin);
}
