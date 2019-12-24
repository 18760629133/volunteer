<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>任务列表</title>
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
        let element = layui.element;
        let table = layui.table;
        let form = layui.form;
        let util = layui.util;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let okMock = layui.okMock;

        util.fixbar({});

        laydate.render({elem: "#startTime", type: "datetime"});
        laydate.render({elem: "#endTime", type: "datetime"});

        let articleTable = table.render({
            elem: "#tableId",
            url: "${pageContext.request.contextPath}/checkProject/getAll",
            limit: 20,
            page: true,
            even: true,
            toolbar: "#toolbarTpl",
            size: "sm",
            cols: [[
                {type: "checkbox", fixed: "left"},
                {field: "projectid", title: "ID", width: 100, sort: true},
                {field: "name", title: "项目名称", width: 150},
                {field: "needperson", title: "招募人数", width: 80},
                {field: "servicetime", title: "项目服务时间", width: 150},
                {field: "place", title: "服务地点", width: 150},
                {field: "contactname", title: "联系人", width: 80,templet: "#contactname"},
                {field: "contactphone", title: "电话号码", width: 130,templet: "#contactphone"},
                {field: "description", title: "描述", width: 80},
                {field: "provide", title: "志愿者保障", width: 100},
                {field: "state", title: "项目状态", width: 110, align: "center", templet: "#statusTpl"},
                {title: "操作", width: 100, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count);
                element.init();
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
                case "batchDelete":
                    batchDelete();
                    break;
                case "add":
                    add();
                    break;
            }
        });

        table.on("tool(tableFilter)", function (obj) {
            let data = obj.data;
            switch (obj.event) {
                case "pass":
                    pass(data);
                    break;
                case "deleteById":
                    deleteById(data.projectid);
                    break;
                case "refuse":
                    refuse(data.projectid);
                    break;
            }
        });


        function batchDelete() {
            okLayer.confirm("确定要批量删除吗？", function (index) {
                layer.close(index);
                let idsStr = okUtils.tableBatchCheck(table);
                if (idsStr) {
                    okUtils.ajax("/task/deleteTask", "delete", {idsStr: idsStr}, true).done(function (response) {
                        okUtils.tableSuccessMsg(response.msg);
                    }).fail(function (error) {
                        console.log(error);
                    });
                }
            });
        }

        function add() {
            okLayer.open("添加任务", "task-add.html", "90%", "90%", null, function () {
                articleTable.reload();
            })
        }

        function pass(data) {
            okLayer.open("项目审核", "projectPass.jsp", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(data);
            }, function () {
                articleTable.reload();
            })
        }

        function refuse(projectid) {
            okLayer.confirm("要拒绝吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/checkProject/refuse", "get", {projectid: projectid}).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }

        function deleteById(id) {
            okLayer.confirm("确定要删除吗？", function () {
                okUtils.ajax("/task/deleteTask", "delete", {idsStr: id}).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }
    })
</script>

<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    <a href="javascript:" title="通过" lay-event="pass"><i class="layui-icon">&#xe605;</i></a>
    <a href="javascript:" title="拒绝" lay-event="refuse"><i class="layui-icon">&#x1006;</i></a>
</script>

<script type="text/html" id="contactname">
    <p>{{d.user.username}}</p>
</script>

<script type="text/html" id="contactphone">
    <p>{{d.user.phone}}</p>
</script>

<!-- 任务状态 -->
<script type="text/html" id="statusTpl">
    {{#  if(d.state == 0){ }}
    <span class="layui-btn layui-btn-normal layui-btn-xs">待审核</span>
    {{#  } }}
</script>
</body>
</html>

