<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 22:17
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

        let projectTable = table.render({
            elem: "#tableId",
            url: "${pageContext.request.contextPath}/project/getAll",
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
                {field: "actualperson", title: "报名人数", width: 80},
                {field: "users", title: "报名人员", width: 80 ,templet:"#user"},
                {field: "starttime", title: "项目招募开始时间", width: 130},
                {field: "endtime", title: "项目招募结束时间", width: 130},
                {field: "servicetime", title: "项目服务时间", width: 150,sort: true},
                {field: "place", title: "服务地点", width: 150},
                {field: "contactname", title: "联系人", width: 80},
                {field: "contactphone", title: "电话号码", width: 130},
                {field: "provide", title: "志愿者保障", width: 100},
                {field: "description", title: "描述", width: 80},
                {field: "status", title: "项目状态", width: 110, align: "center", fixed: "right", templet: "#statusTpl",sort: true},
                {title: "操作", width: 100, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count);
                element.init();
            }
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
                case "updateById":
                    updateById(data);
                    break;
                case "deleteById":
                    deleteById(data.projectid);
                    break;
                case "start":
                    start(data.projectid);
                    break;
                case "end":
                    end(data.projectid);
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
            okLayer.open("添加项目", "project-add.jsp", "90%", "90%", null, function () {
                projectTable.reload();
            })
        }

        function updateById(data) {
            okLayer.open("编辑项目", "project-edit.jsp", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(data);
            }, function () {
                projectTable.reload();
            })
        }

        function deleteById(id) {
            okLayer.confirm("确定要删除吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/project/deleteById", "post", {id: id}).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }
        function start(id) {
            okLayer.confirm("确定要开始吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/project/startProject", "get", {id: id}).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }
        function end(id) {
            okLayer.confirm("确定要结束吗？", function () {
                okUtils.ajax("${pageContext.request.contextPath}/project/endProject", "get", {id: id}).done(function (response) {
                    okUtils.tableSuccessMsg(response.msg);
                }).fail(function (error) {
                    console.log(error);
                });
            })
        }
    })
</script>
<!-- 头工具栏模板 -->
<script type="text/html" id="toolbarTpl">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加项目</button>
    </div>
</script>

<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    {{#if(d.state==0){}}
    <a href="javascript:" title="编辑" lay-event="updateById"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:" title="开启" lay-event="start"><i class="layui-icon">&#x1005;</i></a>
    {{#  } else if(d.state == 1) { }}
    <a href="javascript:" title="编辑" lay-event="updateById"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:" title="结束" lay-event="end"><i class="layui-icon">&#x1006;</i></a>
    {{#  } }}
    <a href="javascript:" title="删除" lay-event="deleteById"><i class="layui-icon">&#xe640;</i></a>
</script>

<!-- 任务状态 -->
<script type="text/html" id="statusTpl">
    {{#  if(d.state == 0){ }}
    <span class="layui-btn layui-btn-normal layui-btn-xs">未开始</span>
    {{#  } else if(d.state == 1) { }}
    <span class="layui-btn layui-btn-warm layui-btn-xs">进行中</span>
    {{#  } else if(d.state == 2) { }}
    <span class="layui-btn layui-btn-danger layui-btn-xs">已结束</span>
    {{#  } }}
</script>
<script type="text/html" id="user">
    {{#  for(var i=0;i<d.users.length;i++){ }}
    <a href="" target="_blank">{{d.users[i].username}}</a>
    {{#  } }}
</script>
</body>
</html>

