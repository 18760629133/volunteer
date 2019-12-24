package com.wwl.controllers;


import com.alibaba.fastjson.JSON;
import com.wwl.entity.Article;
import com.wwl.services.ArticleService;
import com.wwl.utils.Time;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private Time time;

    @RequestMapping("/getNews")
    @ResponseBody
    public String getNews(){
        List<Article> list=articleService.getNews();
        String result= JSON.toJSONString(list);
        return result;
    }

    @RequestMapping("/getNotices")
    @ResponseBody
    public String getNotices(){
        List<Article> list=articleService.getNotices();
        String result= JSON.toJSONString(list);
        return result;
    }

    @RequestMapping(value = "getArticleById")
    public String getArticleById(@RequestParam("id") int id, ModelMap modelMap){
        Article article=articleService.getArticleById(id);
        modelMap.addAttribute("article",article);
        return "article";
    }

    @RequestMapping(value = "/getInfo")
    public String getInfo(ModelMap modelMap){
        List<Article> list=articleService.getInfo();
        modelMap.addAttribute("info",list);
        return "information";
    }

    @RequestMapping(value = "/getNoticesInfo")
    public String getNoticesInfo(ModelMap modelMap){
        List<Article> list=articleService.getNoticesInfo();
        modelMap.addAttribute("notices",list);
        return "notices";
    }


    @RequestMapping(value = "/getByType")
    public String getByType(@RequestParam("type") String type,ModelMap modelMap){
        return null;
    }

    @RequestMapping(value = "/getAll")
    @ResponseBody
    public String getAll(@RequestParam("page") int page,@RequestParam("limit") int limit){
        ResponseData<Article> responseData=articleService.getAll(page,limit);
        return JSON.toJSONString(responseData);
    }

    @RequestMapping(value = "/addArticle")
    @ResponseBody
    public String addArticle(@ModelAttribute Article article,
                             HttpServletRequest request, @RequestParam("file") MultipartFile mf) throws IOException {
        String realPath=request.getServletContext().getRealPath("/images");  //获取上传文件夹的绝对位置，TomCat设置的路径
        File file=new File(realPath);
        if(!file.exists()){
            file.mkdir();
        }
        String fileName=mf.getOriginalFilename();      //获取图片名称
        File target=new File(realPath+File.separator+fileName);
        mf.transferTo(target);     //将图片存储到指定的文件target中
        article.setTime(time.getTime());
        article.setImg(request.getContextPath()+"/images/"+fileName);
        ResponseCodeAndMsg responseCodeAndMsg=articleService.add(article);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/del")
    @ResponseBody
    public String del(@RequestParam(value = "id",required = true) int id){
        ResponseCodeAndMsg responseCodeAndMsg=articleService.del(id);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/editArticle")
    @ResponseBody
    public String edit(@ModelAttribute Article article,
                             HttpServletRequest request, @RequestParam("file") MultipartFile mf) throws IOException {
        String realPath=request.getServletContext().getRealPath("/images");
        String fileName=mf.getOriginalFilename();
        if(!fileName.equals("")){
            File target=new File(realPath+File.separator+fileName);
            mf.transferTo(target);
            article.setImg(request.getContextPath()+"/images/"+fileName);
            ResponseCodeAndMsg responseCodeAndMsg=articleService.edit(article);
            return JSON.toJSONString(responseCodeAndMsg);
        }else {
            ResponseCodeAndMsg responseCodeAndMsg=articleService.edit(article);
            return JSON.toJSONString(responseCodeAndMsg);
        }
    }
}
