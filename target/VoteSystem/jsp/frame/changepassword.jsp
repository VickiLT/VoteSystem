<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/13
  Time: 13:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use('form', function () {
        var form = layui.form;

        //各种基于事件的操作，下面会有进一步介绍
    });
    var validate = function () {
        var newps = $("#newPassword").val();
        var newpsAgain = $("#newPasswordAgain").val();
        if (newps != newpsAgain) {
            alert("两次新密码输入不一致！")
            return false;
        }
    }
</script>

<style type="text/css">
    .layui-form-label{
        width:150px;
    }
    .layui-input-block{
        margin-left:190px;
        width:300px;
    }
    form{
        margin: 50px 10%;
    }
    .layui-form-item{
        margin-bottom: 25px;
    }
    .layui-btn{
        width: 100px;
    }

</style>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>修改密码
<br>
<br>
<br>
<br>
<font color="red" style="margin-left:100px">
    ${msg}
</font>
<form class="layui-form te-left" action="/frame/changePwd" name="form" onsubmit="return validate()" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">输入旧密码:</label>
        <div class="layui-input-block">
            <input type="password" name="oldPassword" required="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">输入新密码:</label>
        <div class="layui-input-block">
            <input type="password" id="newPassword" name="newPassword" required="required"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">再次输入新密码:</label>
        <div class="layui-input-block">
            <input type="password" id="newPasswordAgain" name="newPasswordAgain" required="required"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block" style="margin-left: 170px">
            <input type="submit" class="layui-btn" value="修改">
        </div>
    </div>
</form>
</body>
</html>
