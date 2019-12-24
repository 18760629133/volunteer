<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/21
  Time: 19:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户列表</title>
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
    layui.use(["element", "table", "form", "laydate", "okLayer", "okUtils", "okMock"], function () {
        let table = layui.table;
        let form = layui.form;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let okMock = layui.okMock;


        let userTable = table.render({
            elem: '#tableId',
            url: '${pageContext.request.contextPath}/admin/getAll',
            limit: 20,
            page: true,
            toolbar: true,
            toolbar: "#toolbarTpl",
            size: "sm",
            cols: [[
                {type: "checkbox", fixed: "left"},
                {field: "id", title: "ID", width: 100, sort: true},
                {field: "name", title: "姓名", width: 100},
                {field: "password", title: "密码", width: 150},
                {field: "phone", title: "电话号码", width: 200},
                {field: "state", title: "状态", width: 100, templet:"#statusTpl"},
                {title: "操作", width: 580, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.info(res, curr, count);
            }
        });

        form.on("submit(search)", function (data) {
            userTable.reload({
                where: data.field,
                page: {curr: 1}
            });
            return false;
        });

        table.on("toolbar(tableFilter)", function (obj) {
            switch (obj.event) {
                case "batchEnabled":
                    batchEnabled();
                    break;
                case "batchDisabled":
                    batchDisabled();
                    break;
                case "batchDel":
                    batchDel();
                    break;
                case "add":
                    add();
                    break;
            }
        });

        table.on("tool(tableFilter)", function (obj) {
            let data = obj.data;
            switch (obj.event) {
                case "stop":
                    stop(data.id);
                    break;
                case "start":
                    start(data.id);
                    break;
                case "del":
                    del(data.id);
                    break;
            }
        });


        function add() {
            okLayer.open("添加管理员", "admin-add.jsp", "90%", "90%", null, function () {
                userTable.reload();
            })
        }

        function start(id) {
            okLayer.confirm("确定要启用吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/admin/start", "post", {id: id}, true).done(function (response) {
                    console.log(response);
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error)
                });
            })
        }

        function stop(id) {
            okLayer.confirm("确定要停用吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/admin/stop", "post", {id: id}, true).done(function (response) {
                    console.log(response);
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error)
                });
            })
        }

        function del(id) {
            okLayer.confirm("确定要删除吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/admin/del", "post", {id: id}, true).done(function (response) {
                    console.log(response);
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error)
                });
            })
        }
    })
</script>
<!-- 头工具栏模板 -->
<script type="text/html" id="toolbarTpl">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加管理员</button>
    </div>
</script>
<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    {{#  if(d.state == 0){ }}
    <a href="javascript:" title="停用" lay-event="stop"><i class="layui-icon">&#xe651;</i></a>
    {{#  } else if(d.state == 1) { }}
    <a href="javascript:" title="启用" lay-event="start"><i class="layui-icon">&#xe652;</i></a>
    {{#  } }}
    <a href="javascript:" title="删除" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
</script>

<script type="text/html" id="statusTpl">
    {{#  if(d.state == 0){ }}
    <span class="layui-btn layui-btn-normal layui-btn-xs">启用</span>
    {{#  } else if(d.state == 1) { }}
    <span class="layui-btn layui-btn-warm layui-btn-xs">停用</span>
    {{#  } }}
</script>
</body>
</html>

