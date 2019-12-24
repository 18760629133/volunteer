<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/27
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改文章</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body>
<div class="ok-body">
    <!--form表单-->
    <form class="layui-form layui-form-pane ok-form" enctype="multipart/form-data" method="post" id="myForm" lay-filter="filter">
        <input type="hidden" id="id" name="id" placeholder="" autocomplete="off" class="layui-input" lay-verify="required">
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text" id="title" name="title" placeholder="请输入文章标题" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-block">
                <select name="type">
                    <option value="公告">公告</option>
                    <option value="新闻">新闻</option>
                    <option value="资讯">资讯</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">作者</label>
            <div class="layui-input-block">
                <input type="text" id="author" name="author" placeholder="请输入作者" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片</label>
            <div class="layui-input-block">
                <input type="text" id="img" name="img" placeholder="" autocomplete="off" class="layui-input" >
                <input type="file" id="upload" name="file" placeholder="图片" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-block">
                <textarea name="body" id="body" placeholder="请输入文章内容" class="layui-textarea" lay-verify="required"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="addArticle" type="button">确定数据</button><span style="color: red">提交前请先确定数据</span>
                <button id="commit" class="layui-btn" type="button">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    let initData;

    function initForm(data) {
        let jsonString = JSON.stringify(data);
        initData = JSON.parse(jsonString);
    }
    layui.use(["form", "okUtils", "okLayer","upload"], function () {
        let form = layui.form;
        let okUtils = layui.okUtils;
        let okLayer = layui.okLayer;
        var upload=layui.upload;
        var $=layui.jquery;

        form.val("filter", initData);
        form.on("submit(addArticle)", function (data) {
            upload.render({
                elem:'#upload',
                url:'${pageContext.request.contextPath}/article/editArticle',
                data:data.field,
                method:'post',
                auto:false,
                bindAction:'#commit',
                done:function (res, index, upload) {
                    if(res.code == 0){
                        okLayer.greenTickMsg(res.msg, function () {
                            parent.layer.close(parent.layer.getFrameIndex(window.name));
                        });
                    }
                }
            });
        });

        /*form.on("submit(addArticle)", function (data) {
            okUtils.ajaxUpload("${pageContext.request.contextPath}/article/addArticle", "post", data.field, true).done(function (response) {
                okLayer.greenTickMsg(response.msg, function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            }).fail(function (error) {
                console.log(error)
            });
            return false;
        });*/
    });

    function add() {
        $.ajax({
            url:'${pageContext.request.contextPath}/article/editArticle',
            type:'post',
            data:$("#myForm").serialize(),
            dataType:'json',
            contentType:false,
            processData:false,
            success:function (data) {
                layer.msg(data.msg,{time:3});
            }
        });
    }
</script>
</body>
</html>

