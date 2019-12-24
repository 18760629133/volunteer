<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/19
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
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
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/page/favicon.png">
    <!-- Tweaks for older IEs-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
</head>
<body class="home">
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
                    <li class="active"><a href="${pageContext.request.contextPath}/page/index.jsp">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/page/addproject.jsp">志愿发布</a></li>
                    <li><a href="${pageContext.request.contextPath}/project/getProjeccList?currentPage=1">志愿项目</a></li>
                    <li><a href="${pageContext.request.contextPath}/article/getInfo">志愿资讯</a></li>
                    <li><a href="${pageContext.request.contextPath}/message/getAllMessage?currentPage=1">意见中心</a></li>

                    <c:if test="${!empty sessionScope.user}">
                        <li class="dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">个人中心 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" data-toggle="modal" data-target="#updatePw-modal">修改密码</a></li>
                                <li><a href="${pageContext.request.contextPath}/page/myinfo.jsp">我的个人信息</a></li>
                                <li><a href="${pageContext.request.contextPath}/user/getMyProject">我参与的志愿项目</a></li>
                                <li><a href="${pageContext.request.contextPath}/checkProject/getMyProject">我发布的志愿项目</a></li>
                            </ul>
                        </li>
                        <a href="javascript:(0);" class="btn navbar-btn btn-ghost pull-left" style="margin-left: 8px;"><li class="fa fa-user fa-fw"></li>${sessionScope.user.username}</a>
                        <a href="${pageContext.request.contextPath}/user/userLogOut" class="btn navbar-btn btn-ghost pull-left" style="margin-left: 8px;"><i class="fa fa-registered"></i>注销</a>
                    </c:if>

                    <c:if test="${empty sessionScope.user}">
                        <a href="#" data-toggle="modal" data-target="#login-modal" class="btn navbar-btn btn-white pull-left" style="margin-left: 8px;"><i class="fa fa-sign-in"></i>登陆</a>
                        <a href="${pageContext.request.contextPath}/page/register.jsp" class="btn navbar-btn btn-white pull-left" style="margin-left: 8px;"><i class="fa fa-registered"></i>注册</a>
                    </c:if>

            </div>
        </div>
    </div>
</header>
<!-- *** 登陆 *** -->
<div id="login-modal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" data-dismiss="modal" aria-hidden="true" class="close">×</button>
                <h4 id="Login" class="modal-title">登陆</h4>
            </div>
            <div class="modal-body">
                    <div class="form-group">
                        <input id="IDcard" type="text" name="id" placeholder="身份证" class="form-control">
                    </div>
                    <div class="form-group">
                        <input id="password_modal" type="password" name="password" placeholder="密码" class="form-control">
                    </div>
                    <p class="text-center">
                        <button type="button" onclick="login()" class="btn btn-primary"><i class="fa fa-sign-in"></i> 登陆</button>
                    </p>
                <p class="text-center text-muted">忘记密码？</p>
                <p class="text-center text-muted"><a href="#" data-toggle="modal" data-target="#findPw-modal"><strong>找回密码</strong></a></p>
            </div>
        </div>
    </div>
</div>
<!-- *** 登陆 ***-->

<!-- *** 找回密码 *** -->
<div id="findPw-modal" tabindex="-1" role="dialog" aria-labelledby="findPw-modal" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" data-dismiss="modal" aria-hidden="true" class="close">×</button>
                <h4 class="modal-title">找回密码</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    邮箱:<br><br><input id="email" type="text" name="email" class="form-control" required>
                </div>
                <p class="text-center text-muted">请输入您注册时使用的邮箱</p>
                <p class="text-center">
                    <button type="button" onclick="findPassword()" class="btn btn-primary"><i class="fa fa-sign-in"></i> 找回密码</button>
                </p>
                <br>
            </div>
        </div>
    </div>
</div>
<!-- *** 找回密码  ***-->


<!-- *** 修改密码 *** -->
<div id="updatePw-modal" tabindex="-1" role="dialog" aria-labelledby="updatePw-modal" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" data-dismiss="modal" aria-hidden="true" class="close">×</button>
                <h4 class="modal-title">修改密码</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <input id="password1_modal" type="password" name="password" placeholder="原密码" class="form-control">
                </div>
                <div class="form-group">
                    <input id="new_password" type="password" name="new_password" placeholder="新密码" class="form-control">
                </div>
                <div class="form-group">
                    <input id="re_password" type="password" name="re_password" placeholder="确认密码" class="form-control">
                </div>
                <p class="text-center">
                    <button type="button" onclick="updatePw()" class="btn btn-primary"><i class="fa fa-sign-in"></i> 确认修改</button>
                </p>

            </div>
        </div>
    </div>
</div>
<!-- *** 修改密码  ***-->

<div id="carousel-home" data-ride="carousel" class="carousel slide carousel-fullscreen carousel-fade">
    <!-- Indicators-->
    <ol class="carousel-indicators">
        <li data-target="#carousel-home" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-home" data-slide-to="1"></li>
        <li data-target="#carousel-home" data-slide-to="2"></li>
    </ol>
    <!-- Wrapper for slides-->
    <div role="listbox" class="carousel-inner">
        <div style="background-image: url('${pageContext.request.contextPath}/img/index02.PNG');" class="item active">
        </div>
        <div style="background-image: url('${pageContext.request.contextPath}/img/index03.PNG');" class="item">
        </div>
        <div style="background-image: url('${pageContext.request.contextPath}/img/index01.PNG');" class="item">
        </div>
    </div>
</div>
<section class="background-gray-lightest negative-margin">
    <div class="container">
        <div class="col-sm-4">
            <h3> 志愿者精神</h3>
            <p class="lead">奉献 有爱 互助 进步 </p>

        </div>
        <div class="col-sm-4">
            <h3> 最新资讯</h3>
            <div id="news">

            </div>
            <%--<p> <a href="${pageContext.request.contextPath}/article/getByType?type='资讯'" class="btn btn-ghost">了解更多 </a></p>--%>
            <p> <a href="${pageContext.request.contextPath}/article/getInfo" class="btn btn-ghost">了解更多 </a></p>
        </div>
        <div class="col-sm-4">
            <h3> 公示公告</h3>
            <div id="notices">

            </div>
            <%--<p> <a href="${pageContext.request.contextPath}/article/getByType?type='公告'" class="btn btn-ghost">了解更多 </a></p>--%>
            <p> <a href="${pageContext.request.contextPath}/article/getNoticesInfo" class="btn btn-ghost">了解更多 </a></p>
        </div>

    </div>
</section>
<section class="section--padding-bottom-small">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <div class="post">
                    <div class="image"><a href="text.html"><img src="${pageContext.request.contextPath}/img/01.PNG" alt="" class="img-responsive"></a></div>
                    <h3>发起求助</h3>
                    <a href="${pageContext.request.contextPath}/page/addproject.jsp"><p class="index_a"> 寻求志愿者帮助</p></a>
                    <a href="${pageContext.request.contextPath}/message/getAllMessage?currentPage=1"><p class="index_a"> 意见中心</p></a>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="post">
                    <div class="image"><a href="#"><img src="${pageContext.request.contextPath}/img/02.PNG" alt="" class="img-responsive"></a></div>
                    <h3>志愿者</h3>
                    <a href="${pageContext.request.contextPath}/page/register.jsp"><p class="index_a">注册成为志愿者</p></a>
                    <a href="${pageContext.request.contextPath}/project/getProjeccList?currentPage=1"><p class="index_a">参加志愿项目</p></a>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="post">
                    <div class="image"><a href="#"><img src="${pageContext.request.contextPath}/img/03.PNG" alt="" class="img-responsive"></a></div>
                    <h3>志愿社区</h3>
                    <a href="${pageContext.request.contextPath}/article/getInfo"><p class="index_a">志愿资讯</p></a>
                    <a href="${pageContext.request.contextPath}/message/getAllMessage?currentPage=1"><p class="index_a">意见中心</p></a>
                </div>
            </div>
        </div>
    </div>
</section>

<!--   *** SERVICES END ***-->
<!-- portfolio-->
<section id="portfolio" class="section--no-padding-bottom">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>志愿风采</h1>
                <p class="lead margin-bottom--big">Voluntary demeanor</p>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row no-space" id="imgList">

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
<script src="${pageContext.request.contextPath}/js/front.js"></script><!-- substitute:livereload -->
<script>

    $(function () {
        //获取资讯
        $.ajax({
            url:'${pageContext.request.contextPath}/article/getNews',
            type:'get',
            dataType:'json',
            success:function (result) {
                var news=eval(result);
                var html='';
                for (var i=0;i<news.length;i++){
                    var article=news[i];
                    html+='<p><a href="${pageContext.request.contextPath}/article/getArticleById?id='+article.id+'">'+article.title+'</a></p>'
                }
                $("#news").append(html);
            }
        });

        //公示公告
        $.ajax({
            url:'${pageContext.request.contextPath}/article/getNotices',
            type:'get',
            dataType:'json',
            success:function (result) {
                var notices=eval(result);
                var html='';
                for (var i=0;i<notices.length;i++){
                    var article=notices[i];
                    html+='<p><a href="${pageContext.request.contextPath}/article/getArticleById?id='+article.id+'">'+article.title+'</a></p>'
                }
                $("#notices").append(html);
            }
        });

        //志愿风采模块
        $.ajax({
            url:'${pageContext.request.contextPath}/img/indexGetImg',
            type:'get',
            dataType:'json',
            success:function (result) {
                var imgList=eval(result);    //将JSON的字符串解析成JSON数据格式
                var html="";
                for(var i=0;i<imgList.length;i++){
                    var img=imgList[i];
                    html+='<div class="col-lg-3 col-sm-4 col-xs-6">'
                        +'<div class="box"><a href="${pageContext.request.contextPath}'+img.url+'" title="" data-lightbox="portfolio" data-title="'+img.description+'">'
                        +'<img src="${pageContext.request.contextPath}'+img.url+'" alt="" class="img-picture"></a></div>'
                        +'</div>'
                }
                $("#imgList").append(html);
            }
        });
    })

    function login() {
        var data={"id":$("#IDcard").val(),"password":$("#password_modal").val()};
        $.ajax({
            url:'${pageContext.request.contextPath}/user/userLogin',
            data:data,
            type:'post',
            dataType:'text',
            success:function (result) {
                if(result==1){
                    alert("登陆成功");
                    window.location.href="${pageContext.request.contextPath}/page/index.jsp"
                }
                else{
                    alert("账号或密码错误，请重试");
                }
            }
        });
    }
     //修改密码
     function updatePw() {
        var data={"password":$("#password1_modal").val(),"new_password":$("#new_password").val(),"re_password":$("#re_password").val() };
        $.ajax({
            url:'${pageContext.request.contextPath}/user/updatePw',
            data:data,
            type:'post',
            dataType:'text',
            success:function (result){
                if(result==0){
                    alert("修改成功");
                    window.location.href="${pageContext.request.contextPath}/page/index.jsp"
                }else if(result==1){
                    alert("修改失败");
                }else if(result==2){
                    alert("密码和确认密码不一致，请重新输入");
                }else if(result==3){
                    alert("原密码输入错误，请重新输入");
                }
            }
        });
     }

     //找回密码
     function findPassword() {
        var data={"email":$("#email").val()};
         $.ajax({
             url:'${pageContext.request.contextPath}/user/userFindPassword',
             type:'get',
             dataType:'json',
             data:data,
             success:function (result) {
                 if(result.code==200){
                     alert(result.msg);
                     window.location.reload();
                 }else {
                     alert(result.msg);
                 }
             }
         });
     }
</script>
</body>
</html>

