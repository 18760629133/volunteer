<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 23:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>图片列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body>
<div class="ok-body">
    <!--数据表格-->
    <table class="layui-hide" id="tableId" lay-filter="tableFilter"></table>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["table", "form", "laydate", "okLayer", "okUtils", "okMock"], function () {
        let table = layui.table;  //layui的依赖模板
        let form = layui.form;
        let util = layui.util;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let okMock = layui.okMock;

        util.fixbar({});

        let articleTable = table.render({       //渲染
            elem: "#tableId",                   //绑定容器
            url: "${pageContext.request.contextPath}/img/getAll",  //数据接口
            limit: 20,
            page: true,                         //分页
            even: true,
            toolbar: "#toolbarTpl",
            size: "sm",
            cols: [[
                {type: "checkbox", fixed: "left"},
                {field: "id", title: "ID", width: 170, sort: true},
                {field: "url", title: "链接", width: 250, templet: "#urlTpl"},
                {field: "description", title: "描述", width: 250},
                {title: "操作", width: 100, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count)
            }
        });



        table.on("toolbar(tableFilter)", function (obj) {
            switch (obj.event) {
                case "add":
                    add();
                    break;
            }
        });

        table.on("tool(tableFilter)", function (obj) {
            let data = obj.data;
            switch (obj.event) {
                case "del":
                    del(data.id);
                    break;
            }
        });
        function del(id) {
            okLayer.confirm("确定要删除吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/img/del", "get", {id: id}).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }
        function add() {
            okLayer.open("添加图片", "image-add.jsp", "90%", "90%", null, function () {
                articleTable.reload();
            })
        }



    })
</script>

<script type="text/html" id="toolbarTpl">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加图片</button>
    </div>
</script>


<!-- 链接模板 -->
<script type="text/html" id="urlTpl">
    <a href="{{d.url}}" target="_blank">{{d.url}}</a>
</script>



<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    <a href="javascript:" title="删除" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
</script>
</body>
</html>

