package com.wwl.daos;

import com.wwl.entity.Message;
import com.wwl.entity.Reply;
import com.wwl.entity.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageMapper {
    @Results({
            @Result(id = true,column = "id",property = "reply",javaType = Reply.class,one = @One(select = "com.wwl.daos.ReplyMapper.getById",fetchType= FetchType.LAZY)),
            @Result(column = "userid",property = "user",javaType = User.class,one = @One(select = "com.wwl.daos.UserMapper.getById",fetchType= FetchType.LAZY))
    })
    @Select("select * from message order by time desc limit #{start},#{limit}")
    List<Message> getAllMessage(@Param("start") int start,@Param("limit") int limit);

    @Select("select count(*) from message")
    int getMessageCount();

    @Insert("insert into message value(0,#{message.time},#{message.body},#{message.state},#{message.user.userid})")
    int addMessage(@Param("message") Message message);

    @Delete("delete from message where id=#{id}")
    int del(@Param("id") int id);


    @Update("update message set state=1 where id=#{id}")
    int read(@Param("id") int id);

    @Select("select count(*) from message where state=0")
    int getNotReadCount();

    @Select("select * from message where id=#{id}")
    Message getById(@Param("id") int id);
}
