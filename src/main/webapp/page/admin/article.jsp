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
    <title>文章列表</title>
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
        let util = layui.util;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let okMock = layui.okMock;

        util.fixbar({});

        let articleTable = table.render({
            elem: "#tableId",
            url: "${pageContext.request.contextPath}/article/getAll",
            limit: 20,
            page: true,
            even: true,
            toolbar: "#toolbarTpl",
            size: "sm",
            cols: [[
                {type: "checkbox", fixed: "left"},
                {field: "id", title: "ID", width: 170, sort: true},
                {field: "title", title: "标题", width: 150},
                {field: "body", body: "内容", width: 250},
                {field: "img", title: "图片", width: 100},
                {field: "author", title: "发布者", width: 100},
                {field: "time", title: "发布时间", width: 150},
                {field: "type", title: "类型", width: 100},
                {title: "操作", width: 100, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count)
            }
        });

        form.on("submit(search)", function (data) {
            articleTable.reload({
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
                case "edit":
                    eidt(data);
                    break;
                case "del":
                    del(data.id);
                    break;
            }
        });

        function add() {
            okLayer.open("添加文章", "article-add.jsp", "90%", "90%", null, function () {
                articleTable.reload();
            })
        }

        function eidt(data) {
            okLayer.open("编辑文章", "article-edit.jsp", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(data);
            }, function () {
                articleTable.reload();
            })
        }

        /*function edit(data) {
            okLayer.open("修改文章", "article-edit.jsp", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(data);
            }, function () {
                articleTable.reload();
            })
        }*/

        function del(id) {
            okLayer.confirm("确定要删除吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/article/del", "get", {id: id}, true).done(function (response) {
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
        <button class="layui-btn layui-btn-sm" lay-event="add">添加文章</button>
    </div>
</script>


<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    <a href="javascript:" title="编辑" lay-event="edit"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:" title="删除" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
</script>
</body>
</html>

