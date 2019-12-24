package com.wwl.daos;

import com.wwl.entity.Reply;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface ReplyMapper {
    @Insert("insert into reply value(#{reply.id},#{reply.replybody},#{reply.time})")
    int addReply(@Param("reply")Reply reply);

    @Select("select * from reply where id=#{id}")
    Reply getById(@Param("id") int id);
}
