<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/16
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>回复意见</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body>
<div class="ok-body">
    <!--form表单-->
    <form class="layui-form layui-form-pane ok-form" lay-filter="filter">
        <input type="hidden" name="id" autocomplete="off" class="layui-input" lay-verify="required">

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-block">
                <textarea name="replybody" id="replybody" placeholder="请输入回复内容" class="layui-textarea" lay-verify="required"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
        <div class="layui-input-block">
            <button id="commit" class="layui-btn" lay-submit lay-filter="reply">回复</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
    </form>
</div>

</body>
<script src="../../lib/layui/layui.js"></script>
<script>
    let initData;

    function initForm(data) {
        let jsonString = JSON.stringify(data);
        initData = JSON.parse(jsonString);
    }
    layui.use(["element","form", "okUtils", "okLayer"], function () {
        let form = layui.form;
        let okUtils = layui.okUtils;
        let okLayer = layui.okLayer;

        form.val("filter", initData);

        form.on("submit(reply)", function (data) {
            okUtils.ajax("${pageContext.request.contextPath}/reply/addReply", "post", data.field, true).done(function (response) {
                okLayer.greenTickMsg(response.msg, function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            })
            return false;
        });
    });
</script>
</html>
