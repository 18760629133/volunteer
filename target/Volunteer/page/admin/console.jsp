<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/21
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ok-admin v2.0 | 很赞的后台模版</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="ok-admin v2.0,ok-admin网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="ok-admin v2.0，顾名思义，很赞的后台模版，它是一款基于Layui框架的轻量级扁平化且完全免费开源的网站后台管理系统模板，适合中小型CMS后台系统。">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/echarts/echarts.themez.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/oksub.css" media="all"/>
</head>
<body class="console console1 ok-body-scroll">
<div class="ok-body home">

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md15">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="ok-card-title">今日用户活跃量</div>
                </div>
                <div class="ok-card-body map-body">
                    <div style="height: 100%;" id="userActiveTodayChart"></div>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
<script>
    layui.use(["okUtils", "countUp"], function () {
        var countUp = layui.countUp;
        var okUtils = layui.okUtils;
        var $ = layui.jquery;

        var data=new Array();
        var m1;
        $.ajax({
            url:'${pageContext.request.contextPath}/project/console',
            dataType:'json',
            type:'get',
            success:function (result) {
                data=result;
                console.log(data[11]);
                m1=data[0];
            }
        });

        var userActiveTodayChartOption = {
            color: "#03a9f3",
            xAxis: {type: 'category', data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']},
            yAxis: {type: 'value'},
            series: [{data: [data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11]], type: 'bar'}]
        };

        function initUserActiveTodayChart() {
            var userActiveTodayChart = echarts.init($("#userActiveTodayChart")[0], "themez");
            userActiveTodayChart.setOption(userActiveTodayChartOption);
            okUtils.echartsResize([userActiveTodayChart]);
        }

        initUserActiveTodayChart();
    })

</script>




















