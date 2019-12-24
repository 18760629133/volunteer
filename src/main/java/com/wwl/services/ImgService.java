package com.wwl.services;

import com.wwl.entity.Img;
import com.wwl.utils.entity.ResponseCodeAndMsg;
import com.wwl.utils.entity.ResponseData;

import java.util.List;

public interface ImgService {
    ResponseData<Img> getAll(int page,int limit);

    ResponseCodeAndMsg add(Img img);

    ResponseCodeAndMsg del(int id);

    Img getById(int id);

    List<Img> getImgs();
}
