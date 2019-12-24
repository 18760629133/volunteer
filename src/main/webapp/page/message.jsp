<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/24
  Time: 13:36
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
                    <button type="button" data-toggle="collapse" data-target=".navbar-collapse"
                            class="navbar-toggle navbar-btn">Menu<i
                            class="fa fa-align-justify"></i></button>
                </div>
            </div>
            <div id="navigation" class="collapse navbar-collapse navbar-right">
                <ul class="nav navbar-nav">
                    <li><a href="${pageContext.request.contextPath}/page/index.jsp">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/page/addproject.jsp">志愿发布</a></li>
                    <li><a href="${pageContext.request.contextPath}/project/getProjeccList?currentPage=1">志愿项目</a></li>
                    <li><a href="${pageContext.request.contextPath}/article/getInfo">志愿资讯</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/message/getAllMessage?currentPage=1">意见中心</a>
                    </li>
                    <c:if test="${!empty sessionScope.user}">
                    <li class="dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">个人中心 <b
                            class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" data-toggle="modal" data-target="#updatePw-modal">修改密码</a></li>
                            <li><a href="${pageContext.request.contextPath}/page/myinfo.jsp">我的个人信息</a></li>
                            <li><a href="${pageContext.request.contextPath}/user/getMyProject">我参与的志愿项目</a></li>
                            <li><a href="${pageContext.request.contextPath}/checkProject/getMyProject">我发布的志愿项目</a></li>
                        </ul>
                    </li>
                    <a href="javascript:(0);" class="btn navbar-btn btn-ghost pull-left" style="margin-left: 8px;">
                        <li class="fa fa-user fa-fw"></li>
                            ${sessionScope.user.username}</a>
                    <a href="${pageContext.request.contextPath}/user/userLogOut"
                       class="btn navbar-btn btn-ghost pull-left" style="margin-left: 8px;"><i
                            class="fa fa-registered"></i>注销</a>
                    </c:if>

                    <c:if test="${empty sessionScope.user}">
                    <a href="#" data-toggle="modal" data-target="#login-modal"
                       class="btn navbar-btn btn-ghost pull-left" style="margin-left: 8px;"><i
                            class="fa fa-sign-in"></i>登陆</a>
                    <a href="${pageContext.request.contextPath}/page/register.jsp"
                       class="btn navbar-btn btn-ghost pull-left" style="margin-left: 8px;"><i
                            class="fa fa-registered"></i>注册</a>
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
                    <button type="button" onclick="login()" class="btn btn-primary"><i class="fa fa-sign-in"></i> 登陆
                    </button>
                </p>
                <p class="text-center text-muted">忘记密码？</p>
                <p class="text-center text-muted"><a href="#" data-toggle="modal" data-target="#findPw-modal"><strong>找回密码</strong></a>
                </p>
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
                    <button type="button" onclick="findPassword()" class="btn btn-primary"><i class="fa fa-sign-in"></i>
                        找回密码
                    </button>
                </p>
                <br>
            </div>
        </div>
    </div>
</div>
<!-- *** 找回密码  ***-->


<!-- *** 修改密码 *** -->
<div id="updatePw-modal" tabindex="-1" role="dialog" aria-labelledby="updatePw-modal" aria-hidden="true"
     class="modal fade">
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
                    <button type="button" onclick="updatePw()" class="btn btn-primary"><i class="fa fa-sign-in"></i>
                        确认修改
                    </button>
                </p>

            </div>
        </div>
    </div>
</div>
<!-- *** 修改密码  ***-->


<section class="background-gray-lightest">
    <div class="container">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <div class="breadcrumbs">
                <ul class="breadcrumb">
                    <li><a href="index.jsp">首页</a></li>
                    <li class="active">意见中心</li>
                </ul>
            </div>
            <h3>社区意见中心</h3>
            <p class="lead">在此可以提出您的宝贵意见，志愿者服务网和您共同成长</p>

            <form id="messageBox">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="body" class="form-control"></textarea>
                    </div>
                </div>
                <div class="col-sm-12">
                    <c:if test="${!empty user}">
                        <button type="button" onclick="sendMessage()" class="btn btn-primary"><i
                                class="fa fa-comment"></i> Send message
                        </button>
                    </c:if>
                    <c:if test="${empty user}">
                        <button type="button" onclick="sendMessage()" disabled="disabled" class="btn btn-primary"><i
                                class="fa fa-comment"></i> Send message
                        </button>
                    </c:if>
                </div>
                <div class="col-sm-12"><br/><br/></div>
            </form>


            <div class="col-sm-12" id="mess_head">
                <h4>最新留言</h4>
            </div>
            <c:forEach items="${messagePageBean.list}" var="message">
                <div class="col-sm-12" id="mess_body">
                    <span class="mess_span"><i class="fa fa-user" id="mess_logl"></i>${message.user.username}</span>
                    <span class="mess_span"><i class="fa fa-calendar-times-o" id="mess_logl"></i>${message.time}</span>
                    <br/><br/>
                    <span class="mess_span">${message.body}</span>
                    <c:if test="${!empty message.reply}">
                        <span class="mess_span"><strong>管理员回复：</strong>${message.reply.replybody}</span>
                    </c:if>
                </div>
            </c:forEach>

            <div class="col-sm-12" style="text-align: center; margin-top: 18px;">
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-lg">
                        <c:if test="${messagePageBean.currentPage==1}">
                            <li>
                                <a href="javascript:" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${messagePageBean.currentPage!=1 }">
                        <li>
                            <a href="${pageContext.request.contextPath }/message/getAllMessage?currentPage=${messagePageBean.currentPage-1}"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        <li>
                            </c:if>

                            <c:forEach begin="1" end="${messagePageBean.totalPage }" var="page">
                            <!-- 判断当前页 -->
                            <c:if test="${messagePageBean.currentPage==page }">
                        <li class="active"><a href="javascript:void(0);">${page}</a></li>
                        </c:if>
                        <c:if test="${messagePageBean.currentPage!=page }">
                            <li>
                                <a href="${pageContext.request.contextPath }/message/getAllMessage?currentPage=${page}">${page}</a>
                            </li>
                        </c:if>
                        </c:forEach>

                        <!-- 判断当前页是否是最后一页 -->
                        <c:if test="${messagePageBean.currentPage==messagePageBean.totalPage }">
                        <li class="disabled">
                            <a href="javascript:void(0);" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        <li>
                            </c:if>
                            <c:if test="${messagePageBean.currentPage!=messagePageBean.totalPage }">
                        <li>
                            <a href="${pageContext.request.contextPath }/message/getAllMessage?currentPage=${messagePageBean.currentPage+1}"
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        <li>
                            </c:if>
                    </ul>
                </nav>
            </div>

        </div>
    </div>
</section>


<!-- Javascript files-->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>
<script src="${pageContext.request.contextPath}/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/js/front.js"></script><!-- substitute:livereload -->
<script>
    function sendMessage() {
        var body = document.getElementById("message").value;
        var data = {"body": body};
        if (body.trim() != "") {
            $.ajax({
                url: '${pageContext.request.contextPath}/message/addMessage',
                data: $("#messageBox").serialize(),    //序列化表单值，作为URL参数
                dataType: 'json',
                method: 'post',
                success: function (data) {
                    if (data.code != 500) {
                        alert(data.msg);
                        window.location.href = "${pageContext.request.contextPath}/message/getAllMessage?currentPage=1";
                    } else {
                        alert(data.msg)
                    }
                }
            });
        } else {
            alert("内容不能为空")
        }
    }

    function login() {
        var data = {"id": $("#IDcard").val(), "password": $("#password_modal").val()};
        $.ajax({
            url: '${pageContext.request.contextPath}/user/userLogin',
            data: data,
            type: 'post',
            dataType: 'text',
            success: function (result) {
                if (result == 1) {
                    alert("登陆成功");
                    window.location.href = "${pageContext.request.contextPath}/page/index.jsp"
                } else {
                    alert("账号或密码错误，请重试");
                }
            }
        });
    }

    //修改密码
    function updatePw() {
        var data = {
            "password": $("#password1_modal").val(),
            "new_password": $("#new_password").val(),
            "re_password": $("#re_password").val()
        };
        $.ajax({
            url: '${pageContext.request.contextPath}/user/updatePw',
            data: data,
            type: 'post',
            dataType: 'text',
            success: function (result) {
                if (result == 0) {
                    alert("修改成功");
                    window.location.href = "${pageContext.request.contextPath}/page/index.jsp"
                } else if (result == 1) {
                    alert("修改失败");
                } else if (result == 2) {
                    alert("密码和确认密码不一致，请重新输入");
                } else if (result == 3) {
                    alert("原密码输入错误，请重新输入");
                }
            }
        });
    }

    //找回密码
    function findPassword() {
        var data = {"email": $("#email").val()};
        $.ajax({
            url: '${pageContext.request.contextPath}/user/userFindPassword',
            type: 'get',
            dataType: 'json',
            data: data,
            success: function (result) {
                if (result.code == 200) {
                    alert(result.msg);
                    window.location.reload();
                } else {
                    alert(result.msg);
                }
            }
        });
    }
</script>
</body>
</html>

