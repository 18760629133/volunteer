<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/24
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改志愿项目</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/oksub.css">
</head>
<body>
<div class="ok-body">
    <!--form表单-->
    <form class="layui-form layui-form-pane ok-form" lay-filter="filter">
        <input type="hidden" name="projectid" autocomplete="off" class="layui-input" lay-verify="required">
        <div class="layui-form-item">
            <label class="layui-form-label">项目名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" placeholder="请输入项目名称" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">招募人数</label>
            <div class="layui-input-block">
                <input type="text" name="needperson" placeholder="请输入招募人数" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">报名人数</label>
            <div class="layui-input-block">
                <input type="text" name="actualperson" placeholder="0" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">招募开始时间</label>
            <div class="layui-input-block">
                <input type="text" name="starttime" placeholder="请输入招募开始时间" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">招募结束时间</label>
            <div class="layui-input-block">
                <input type="text" name="endtime" placeholder="请输入招募人数" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">服务时间</label>
            <div class="layui-input-block">
                <input type="text" name="servicetime" placeholder="请输入服务时间" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">服务地点</label>
            <div class="layui-input-block">
                <input type="text" name="place" placeholder="请输入服务地点" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系人</label>
            <div class="layui-input-block">
                <input type="text" name="contactname" placeholder="请输入项目联系人" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系电话</label>
            <div class="layui-input-block">
                <input type="text" name="contactphone" placeholder="请输入联系人电话" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">志愿者保障</label>
            <div class="layui-input-block">
                <input type="text" name="provide" placeholder="请输入提供的志愿者保障" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">项目状态</label>
            <div class="layui-input-block">
                <select name="state">
                    <option value="0">未开始</option>
                    <option value="1">进行中</option>
                    <option value="2">已完成</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">项目描述</label>
            <div class="layui-input-block">
                <textarea name="description" placeholder="请输入项目详细描述" class="layui-textarea" lay-verify="required"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="addArticle">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    let initData;

    function initForm(data) {
        let jsonString = JSON.stringify(data);
        initData = JSON.parse(jsonString);
    }
    layui.use(["element","form", "okUtils", "okLayer"], function () {
        let form = layui.form;
        let okUtils = layui.okUtils;
        let okLayer = layui.okLayer;

        form.val("filter", initData);

        form.on("submit(addArticle)", function (data) {
            okUtils.ajax("${pageContext.request.contextPath}/project/updateProject", "post", data.field, true).done(function (response) {
                okLayer.greenTickMsg(response.msg, function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            }).fail(function (error) {
                console.log(error)
            });
            return false;
        });
    });
</script>
</body>
</html>

