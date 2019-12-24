package com.wwl.services;

import com.wwl.daos.ArticleMapper;
import com.wwl.entity.Article;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface ArticleService {
    List<Article> getNews();

    List<Article> getNotices();

    Article getArticleById(int id);

    List<Article> getInfo();

    List<Article> getNoticesInfo();

    ResponseData<Article> getAll(int page, int limit);

    ResponseCodeAndMsg add(Article article);

    ResponseCodeAndMsg del(int id);

    ResponseCodeAndMsg edit(Article article);
}
