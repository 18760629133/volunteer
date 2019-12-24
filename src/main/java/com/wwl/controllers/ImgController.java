package com.wwl.controllers;

import com.alibaba.fastjson.JSON;
import com.wwl.entity.Article;
import com.wwl.entity.Img;
import com.wwl.services.ImgService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/img")
public class ImgController {
    @Autowired
    private ImgService imgService;

    /*
    后台获取图片列表，数据封装到ResponseData工具类中
     */
    @RequestMapping(value = "/getAll")
    @ResponseBody
    public String getAll(@RequestParam("page") int page, @RequestParam("limit") int limit){
        ResponseData<Img> responseData=imgService.getAll(page,limit);
        return JSON.toJSONString(responseData);
    }

    @RequestMapping(value = "/addImg")
    @ResponseBody
    public String addImg(@ModelAttribute Img img, HttpServletRequest request, @RequestParam("file") MultipartFile mf) throws IOException {
        String realPath=request.getServletContext().getRealPath("/volunteerImgs");
        File file=new File(realPath);
        if(!file.exists()){
            file.mkdir();
        }
        String fileName=mf.getOriginalFilename();
        File target=new File(realPath+File.separator+fileName);
        mf.transferTo(target);
        img.setUrl("/volunteerImgs/"+fileName);
        ResponseCodeAndMsg responseCodeAndMsg=imgService.add(img);
        return JSON.toJSONString(responseCodeAndMsg);
    }

    @RequestMapping(value = "/del")
    @ResponseBody
    public String del(@RequestParam(value = "id",required = true) int id,HttpServletRequest request){
        ResponseCodeAndMsg responseCodeAndMsg=null;
        try {
            Img img=imgService.getById(id);
            String path=img.getUrl();
            String realPath=request.getServletContext().getRealPath("");
            File file=new File(realPath+path);
            file.delete();
            responseCodeAndMsg=imgService.del(id);
        }catch (Exception e){
            responseCodeAndMsg.setCode(500);
            responseCodeAndMsg.setMsg("删除失败");
        }
        return JSON.toJSONString(responseCodeAndMsg);
    }

    //获取志愿风采图片信息
    @RequestMapping(value = "/indexGetImg")
    @ResponseBody
    public String indexGetImg(){
        List<Img> imgs=imgService.getImgs();
        return JSON.toJSONString(imgs);
    }
}
