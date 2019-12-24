<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/21
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en" class="page-fill">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="ok-admin v2.0,ok-admin网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="ok-admin v2.0，顾名思义，很赞的后台模版，它是一款基于Layui框架的轻量级扁平化且完全免费开源的网站后台管理系统模板，适合中小型CMS后台系统。">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/oksub.css"/>
</head>
<body class="page-fill">
<div class="page-fill" id="login">
    <form class="layui-form" action="${pageContext.request.contextPath}/admin/login" method="post">
        <div class="login_face"><img src="${pageContext.request.contextPath}/img/logo.png"></div>
        <div class="layui-form-item input-item">
            <input type="text" lay-verify="required" name="name" placeholder="请输入账号" autocomplete="off" id="username" class="layui-input">
        </div>
        <div class="layui-form-item input-item">
            <input type="password" lay-verify="required|password" name="password" placeholder="请输入密码" autocomplete="off" id="password" class="layui-input">
        </div>
        <%--<div class="layui-form-item input-item captcha-box">
            <label for="captcha">验证码</label>
            <input type="text" lay-verify="required|captcha" name="captcha" placeholder="请输入验证码" autocomplete="off" id="captcha" maxlength="4" class="layui-input">
            <div class="img ok-none-select" id="captchaImg"></div>
        </div>--%>
        <div class="layui-form-item">
            <button type="submit" class="layui-btn layui-block">登录</button>
        </div>
        <div class="login-link">
            <a href="register.html">注册</a>
            <a href="forget.html">忘记密码?</a>
        </div>
    </form>
</div>
<!--js逻辑-->
<script src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
<%--<script>
    layui.use(["form", "okGVerify", "okUtils", "okLayer"], function () {
        let form = layui.form;
        let $ = layui.jquery;
        let okGVerify = layui.okGVerify;
        let okUtils = layui.okUtils;
        let okLayer = layui.okLayer;

        /**
         * 初始化验证码
         */
        let verifyCode = new okGVerify("#captchaImg");

        /**
         * 数据校验
         */
        form.verify({
            password: [/^[\S]{6,12}$/, "密码必须6到12位，且不能出现空格"],
            captcha: function (val) {
                if (verifyCode.validate(val) != "true") {
                    return verifyCode.validate(val)
                }
            }
        });

        /**
         * 表单提交
         */
        form.on("submit(login)", function (data) {
            okUtils.ajax("/admin/adminLogin", "post", data.field, true).done(function (response) {
                okLayer.greenTickMsg(response.msg, function () {
                    window.location = "${pageContext.request.contextPath}/page/admin/index.jsp";
                })
            }).fail(function (error) {
                console.log(error)
            });
            return false;
        });

        /**
         * 表单input组件单击时
         */
        $("#login .input-item .layui-input").click(function (e) {
            e.stopPropagation();
            $(this).addClass("layui-input-focus").find(".layui-input").focus();
        });

        /**
         * 表单input组件获取焦点时
         */
        $("#login .layui-form-item .layui-input").focus(function () {
            $(this).parent().addClass("layui-input-focus");
        });

        /**
         * 表单input组件失去焦点时
         */
        $("#login .layui-form-item .layui-input").blur(function () {
            $(this).parent().removeClass("layui-input-focus");
            if ($(this).val() != "") {
                $(this).parent().addClass("layui-input-active");
            } else {
                $(this).parent().removeClass("layui-input-active");
            }
        })
    });
</script>--%>
</body>
</html>
