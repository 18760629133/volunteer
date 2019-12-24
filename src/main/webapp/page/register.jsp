<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/19
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Barunka - Multipurpose Bootstrap template</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- Font Awesome & Pixeden Icon Stroke icon font-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pe-icon-7-stroke.css">
    <!-- Google fonts - Roboto Condensed & Roboto-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto+Condensed:700|Roboto:300,400">
    <!-- lightbox-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/lightbox.min.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="favicon.png">
    <!-- Tweaks for older IEs-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
</head>
<body>
<!-- navbar-->
<header class="header">
    <div role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header"><a href="${pageContext.request.contextPath}/page/index.jsp" class="navbar-brand">首页</a>
                <div class="navbar-buttons">
                    <button type="button" data-toggle="collapse" data-target=".navbar-collapse" class="navbar-toggle navbar-btn">Menu<i
                            class="fa fa-align-justify"></i></button>
                </div>
            </div>
            <div id="navigation" class="collapse navbar-collapse navbar-right">
                <ul class="nav navbar-nav">
                    <li><a href="${pageContext.request.contextPath}/page/index.jsp">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/page/addproject.jsp">志愿发布</a></li>
                    <li><a href="${pageContext.request.contextPath}/project/getProjeccList?currentPage=1">志愿项目</a></li>
                    <li><a href="${pageContext.request.contextPath}/article/getInfo">志愿资讯</a></li>
                    <li><a href="${pageContext.request.contextPath}/message/getAllMessage?currentPage=1">意见中心</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>


<section>
    <div id="contact" class="container">
        <div class="row">
            <div class="col-lg-9">
                <div class="box-simple">
                    <div class="icon"><i class="pe-7s-id"></i></div>
                    <div class="content">
                        <h4>注册成为志愿者</h4>
                        <p class="text-muted">Register</p>
                        <form action="${pageContext.request.contextPath}/user/userRegister" method="post">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="username">姓名</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <input id="username" name="username" type="text" class="form-control" placeholder="name">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="userid">身份证</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <input id="userid" name="userid" type="text" class="form-control" placeholder="ID">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="phone">电话号码</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <input id="phone" name="phone" type="text" class="form-control" placeholder="telphone">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <input id="email" name="email" type="text" class="form-control" placeholder="email@">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="password">密码</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <input id="password" name="password" type="text" class="form-control" placeholder="password">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="repassword">确认密码</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <input id="repassword" name="repassword" type="text" class="form-control" placeholder="repassword">
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inlineRadio1">性别</label>
                                        <span class="form-checked-red" aria-hidden="true">*</span>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" id="inlineRadio1" value="男"> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" id="inlineRadio2" value="女"> 女
                                        </label>
                                    </div>
                                </div>


                                <div class="col-sm-12" style="text-align: right;">
                                    <button type="submit" class="btn btn-primary" ><i class="fa fa-user"></i>注册</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="footer">
    <div class="footer__copyright">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>2019 Volunteer Service</p>
                </div>
                <div class="col-md-6">
                    <p class="credit">奉献 有爱 互助 进步</p>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Javascript files-->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.cookie.js"> </script>
<script src="${pageContext.request.contextPath}/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/js/front.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
<!-- substitute:livereload -->
<script>
    $(function () {
        $("form").validate({
            rules:{
                username:{
                    required:true
                },
                password:{
                    required:true,
                    digits:true,
                    rangelength:[3,9]
                },
                repassword:{
                    required:true,
                    equalTo:"#password"
                },
                email:{
                    required:true,
                    email:true
                },
                phone:{
                    required:true,
                    rangelength:[11,11]
                },
                userid:{
                    required:true,
                    rangelength:[18,18]
                }
            },
            messages:{
                username:{
                    required:"姓名为必填项",
                },
                password:{
                    required:"密码为必填项",
                    digits:"请输入数字",
                    rangelength:"请输入3-9位数字"
                },
                repassword:{
                    required:"确认密码为必填项",
                    equalTo:"确认密码和密码输入不一致"
                },
                email:{
                    required:"邮箱为必填项",
                    email:"请输入正确的邮箱格式"
                },
                phone:{
                    required:"电话号码为必填项",
                    rangelength:"请输入正确的电话号码格式"
                },
                userid:{
                    required:"身份证为必填项",
                    rangelength:"请输入正确的身份证格式"
                }
            },
            success:"valid",
            submitHandler:function (form) {
                form.submit();
            }
        })
    })
</script>
</body>
</html>

