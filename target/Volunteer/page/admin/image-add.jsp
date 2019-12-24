<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/29
  Time: 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加图片</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body>
<div class="ok-body">
    <!--form表单-->
    <form class="layui-form ok-form" enctype="multipart/form-data" method="post">


        <div class="layui-form-item">
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" name="description" placeholder="请输入图片描述" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">路径</label>
            <div class="layui-input-block">
                <input type="file" name="file" id="upload" placeholder="" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="addArticle" type="button">确认数据（提交前请先确认数据）</button>
                <button class="layui-btn" id="commit" type="button">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["form", "okUtils", "okLayer","upload"], function () {
        let form = layui.form;
        let okUtils = layui.okUtils;
        let okLayer = layui.okLayer;
        var upload=layui.upload;
        var $=layui.jquery;
        form.on("submit(addArticle)", function (data) {
            upload.render({
                elem:'#upload',
                url:'${pageContext.request.contextPath}/img/addImg',
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
    });
</script>
</body>
</html>

