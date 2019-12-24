package com.wwl.daos;


import com.wwl.entity.Article;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleMapper {
    //主页获取资讯
    @Select("select * from article where type='资讯' order by time DESC LIMIT 3 ")
    List<Article> getNews();

    //主页获取公告
    @Select("select * from article where type='公告' order by time DESC LIMIT 3 ")
    List<Article> getNotices();

    //根据id获取相应article
    @Select("select * from article where id=#{id}")
    Article getArticleById(@Param("id") int id);

    //information.jsp获取资讯列表
    @Select("select * from article where type='资讯' order by time DESC")
    List<Article> getInfo();

    //notices.jsp获取公告列表
    @Select("select * from article where type='公告' order by time DESC")
    List<Article> getNoticesInfo();

    @Select("select * from article limit #{i},#{limit}")
    List<Article> getAll(@Param("i") int i,@Param("limit") int limit);

    @Select("select count(*) from article")
    int getCount();

    @Insert("insert into article value(#{article.id},#{article.title},#{article.body},#{article.img},#{article.author}," +
            "#{article.time},#{article.type})")
    int add(@Param("article") Article article);

    @Delete("delete from article where id=#{id}")
    int del(@Param("id") int id);

    @Update("update article set title=#{article.title},body=#{article.body},img=#{article.img},author=#{article.author}," +
            "time=#{article.time},type=#{article.type} where id=#{article.id}")
    int edit(@Param("article") Article article);
}
