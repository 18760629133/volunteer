<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 21:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body class="childrenBody seting-pass">
<form class="layui-form changePwd">
    <input type="hidden" value="${sessionScope.admin.id}" name="id">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="name" value="${sessionScope.admin.name}" disabled class="layui-input layui-disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">旧密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请输入旧密码"  lay-verify="required|oldPwd" class="layui-input pwd">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请输入新密码" name="password" lay-verify="required|pass" id="oldPwd" class="layui-input pwd">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="edit">立即修改</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="../../lib/layui/layui.js"></script>
<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery,
            $form = $('form');

        //添加验证规则verify
        form.verify({
            pass: [
                /^[\S]{6,16}$/
                , '密码必须6到16位，且不能出现空格'
            ],
            oldPwd: function (value, item) {
                if (value != "${sessionScope.admin.password}") {
                    return "密码错误，请重新输入！";
                }
            },
            confirmPwd: function (value, item) {
                if (!new RegExp($("#oldPwd").val()).test(value)) {
                    return "两次输入密码不一致，请重新输入！";
                }
            },

        });

        //修改密码
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
                okUtils.ajax("${pageContext.request.contextPath}/admin/updatePw", "post", data.field, true).done(function (response) {
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

    });


</script>
</body>
</html>

