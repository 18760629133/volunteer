package com.wwl.daos;

import com.wwl.entity.Img;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImgMapper {
    @Select("select count(*) from img")
    int getCount();

    @Select("select * from img order by id desc limit #{i},#{limit}")
    List<Img> getAll(@Param("i") int i,@Param("limit") int limit);

    @Insert("insert into img value(#{img.id},#{img.url},#{img.description})")
    int add(@Param("img") Img img);

    @Delete("delete from img where id=#{id}")
    int del(@Param("id") int id);

    @Select("select * from img where id=#{id}")
    Img getById(@Param("id") int id);

    @Select("select * from img order by id desc limit 8")
    List<Img> getImgs();
}
