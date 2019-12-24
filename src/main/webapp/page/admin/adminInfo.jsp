<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>基本资料</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body class="user-info">
<form class="layui-form">
    <div class="user_left">
        <div class="layui-form-item">
            <label class="layui-form-label">管理员编号</label>
            <div class="layui-input-block">
                <input type="text" value="${sessionScope.admin.id}" name="id" disabled class="layui-input layui-disabled" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" value="${sessionScope.admin.name}" name="name" class="layui-input layui-disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-block">
                <input type="text" value="${sessionScope.admin.phone}" name="phone" placeholder="请输入手机号码" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="margin-left: 3%;">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="edit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
    </div>
</form>
<script type="text/javascript" src="../../lib/layui/layui.js"></script>
<script>
    let initData;

    function initForm(data) {
        let jsonString = JSON.stringify(data);
        initData = JSON.parse(jsonString);
    }
    layui.use(["element", "form", "okLayer", "okUtils"], function () {
        let form = layui.form;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;

        form.val("filter", initData);

        form.on("submit(edit)", function (data) {
            okUtils.ajax("${pageContext.request.contextPath}/admin/updateInfo", "post", data.field, true).done(function (response) {
                console.log(response);
                okLayer.greenTickMsg("修改成功", function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            }).fail(function (error) {
                console.log(error)
            });
            return false;
        });
    })
</script>
</body>
</html>

