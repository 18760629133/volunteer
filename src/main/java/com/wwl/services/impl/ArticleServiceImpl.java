package com.wwl.services.impl;

import com.wwl.daos.ArticleMapper;
import com.wwl.entity.Article;
import com.wwl.services.ArticleService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT)
@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    private ArticleMapper articleMapper;

    @Transactional(readOnly = true)
    @Override
    public List<Article> getNews() {
        return articleMapper.getNews();
    }

    @Transactional(readOnly = true)
    @Override
    public List<Article> getNotices() {
        return articleMapper.getNotices();
    }

    @Transactional(readOnly = true)
    @Override
    public Article getArticleById(int id) {
        return articleMapper.getArticleById(id);
    }

    @Transactional(readOnly = true)
    @Override
    public List<Article> getInfo() {
        return articleMapper.getInfo();
    }

    @Transactional(readOnly = true)
    @Override
    public List<Article> getNoticesInfo(){ return articleMapper.getNoticesInfo(); }

    @Override
    public ResponseData<Article> getAll(int page, int limit) {
        ResponseData<Article> responseData=new ResponseData<>();
        responseData.setCode(0);
        responseData.setMsg("查询成功");
        responseData.setCount(articleMapper.getCount());
        responseData.setData(articleMapper.getAll((page-1)*limit,limit));
        return responseData;
    }

    @Override
    public ResponseCodeAndMsg add(Article article) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=articleMapper.add(article);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("添加成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("添加失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg del(int id) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=articleMapper.del(id);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("删除成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("删除失败");
            return responseCodeAndMsg;
        }
    }

    @Override
    public ResponseCodeAndMsg edit(Article article) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=articleMapper.edit(article);
        if(i>0){
            responseCodeAndMsg.setCode(0);
            responseCodeAndMsg.setMsg("修改成功!");
            return responseCodeAndMsg;
        }else {
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("修改失败");
            return responseCodeAndMsg;
        }
    }
}
