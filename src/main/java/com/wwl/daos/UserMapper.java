package com.wwl.daos;

import com.wwl.entity.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    @Select("select * from user where userid=#{id} and password=#{password}")
    User findByIdAndPassword(@Param("id") String id, @Param("password") String password);

    @Insert("insert into user values(#{id},#{sex},#{password},#{username},#{phone},#{email})")
    int userAdd(@Param("id") String id,@Param("sex") String sex,@Param("password") String password,@Param("username") String username,
                @Param("phone") String phone,@Param("email") String email);

    @Update("update user set phone=#{phone},email=#{email} where userid=#{id}")
    int updateInfo(@Param("phone") String phone,@Param("email") String email,@Param("id") String id);

    @Results(
            {
                @Result(id = true,column = "userid",property = "userid"),
                    @Result(column = "sex",property = "sex"),
                    @Result(column = "username",property = "username"),
                    @Result(column = "phone",property = "phone"),
                    @Result(column = "email",property = "email"),
                    @Result(column = "password",property = "password"),
                    @Result(column = "userid",property = "projects",many = @Many(select = "com.wwl.daos.ProjectMapper.getAllPorjectByUserId",fetchType = FetchType.LAZY))
            }
    )
    @Select("select * from user where userid=#{userid}")
    User getUserById(String userid);

    @Select("select * from user where userid=#{userid}")
    User getById(@Param("userid") String userid);

    @Select("select * from user limit #{start},#{limit}")
    List<User> getAllUser(@Param("start") int start,@Param("limit") int limit);

    @Select("select count(*) from user")
    int getUserCount();

    @Delete("delete from user where userid=#{id}")
    int deletById(@Param("id") String id);

    @Update("update user set password=#{password},email=#{email},phone=#{phone},sex=#{sex} where userid=#{id}")
    int updateUser(@Param("password") String password,@Param("email") String email,
                   @Param("phone") String phone,@Param("sex") String sex,@Param("id") String id);

    @Results({
            @Result(id = true,column = "userid",property = "userid")
    })
    @Select("select * from user where userid in(select userid from user_project where project=#{projectid})")
    List<User> getAllUserByProjectId(int projectid);

    @Select("select * from user where email=#{email}")
    User getByEmail(@Param("email") String email);

    @Update("update user set password=#{new_password} where userid=#{id}")
    int updatePw(@Param("id") String id, @Param("new_password") String new_password);

    @Select("select * from user where userid in (select userid from user_project where projectid=#{projectid})")
    List<User> getAllUserByUserId(@Param("projectid") int projectid);


}
