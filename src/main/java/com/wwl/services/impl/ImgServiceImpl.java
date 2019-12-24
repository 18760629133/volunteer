package com.wwl.services.impl;

import com.wwl.daos.ImgMapper;
import com.wwl.entity.Img;
import com.wwl.services.ImgService;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ImgServiceImpl implements ImgService {
    @Autowired
    private ImgMapper imgMapper;

    @Override
    public ResponseData<Img> getAll(int page,int limit) {
        ResponseData<Img> responseData=new ResponseData<>();
        responseData.setCount(imgMapper.getCount());
        responseData.setCode(0);
        responseData.setMsg("查询成功");
        responseData.setData(imgMapper.getAll((page-1)*limit,limit));
        return responseData;
    }

    @Override
    public ResponseCodeAndMsg add(Img img) {
        ResponseCodeAndMsg responseCodeAndMsg=new ResponseCodeAndMsg();
        int i=imgMapper.add(img);
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
        int i=imgMapper.del(id);
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
    public Img getById(int id) {
        return imgMapper.getById(id);
    }

    @Override
    public List<Img> getImgs() {
        return imgMapper.getImgs();
    }
}
