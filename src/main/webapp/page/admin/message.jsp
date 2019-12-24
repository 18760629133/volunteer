<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 23:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>意见列表</title>
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
        let table = layui.table;
        let form = layui.form;
        let util = layui.util;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let okMock = layui.okMock;

        util.fixbar({});


        let MessageTable = table.render({
            elem: "#tableId",
            url: "${pageContext.request.contextPath}/message/getAll",
            limit: 20,
            page: true,
            even: true,
            toolbar: "#toolbarTpl",
            size: "sm",
            cols: [[
                {type: "checkbox", fixed: "left"},
                {field: "id", title: "ID", width: 170, sort: true},
                {field: "username", title: "留言用户", width: 100,templet: "#user"},
                {field: "body", title: "留言内容", width: 350},
                {field: "time", title: "留言时间", width: 150,sort: true},
                {field: "state", title: "状态", width: 110, align: "center", templet: "#statusTpl"},
                {title: "操作", width: 100, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count)
            }
        });


        table.on("toolbar(tableFilter)", function (obj) {
            switch (obj.event) {
                case "batchDelete":
                    batchDelete();
                    break;
            }
        });

        table.on("tool(tableFilter)", function (obj) {
            let data = obj.data;
            switch (obj.event) {
                case "deleteById":
                    deleteById(data.id);
                    break;
                case "read":
                    read(data.id);
                    break;
                case "reply":
                    reply(data);
                    break;
            }
        });


        function deleteById(id) {
            okLayer.confirm("确定要删除吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/message/del", "get", {id: id}, true).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }
        function read(id) {
            okLayer.confirm("确定已读？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/message/read", "get", {id: id}, true).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }

        function reply(data) {
            okLayer.open("回复留言", "message-reply.jsp?", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(data);
            }, function () {
                MessageTable.reload();
            })
        }

    });
</script>

<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    {{#  if(d.state == 0){ }}
    <a href="javascript:" title="回复" lay-event="reply"><i class="layui-icon">&#xe611;</i></a>
    {{#  } }}
    <a href="javascript:" title="删除" lay-event="deleteById"><i class="layui-icon">&#xe640;</i></a>
</script>
<!-- 链接 -->
<script type="text/html" id="user">
    <a href="" target="_blank">{{d.user.username}}</a>
</script>
<!-- 状态-->
<script type="text/html" id="statusTpl">
    {{#  if(d.state == 0){ }}
    <span class="layui-btn layui-btn-normal layui-btn-xs">未读</span>
    {{#  } else if(d.state == 1) { }}
    <span class="layui-btn layui-btn-warm layui-btn-xs">已读</span>
    {{#  } }}
</script>
</body>
</html>

