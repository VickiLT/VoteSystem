<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/13
  Time: 12:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</script>
<script type="text/javascript">
    /**
     验证手机号码是否输入合法
     验证规则：11位数字，以1开头
     */
    $(document).ready(function () {
        isChangeReturn();
    });
    function isChangeReturn(){
        var changeSuccess='<%=request.getAttribute("changeSuccess")%>';
        if(changeSuccess=="0"){
            alert("修改个人信息成功!");
        }

    }
    function checkMobile(str) {
        var re = /^1\d{10}$/;
        if (re.test(str)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     验证电话号码是否输入合法
     验证规则：区号+号码，区号以0开头，3位或4位
     号码由7位或8位数字组成
     区号与号码之间可以无连接符，也可以“-”连接
     如01088888888,010-88888888,0955-7777777
     */
    function checkPhone(str) {
        re = /^0\d{2,3}-?\d{7,8}$/;
        if (re.test(str)) {
            return true;
        } else {
            return false;
        }
    }


    /**
     验证邮箱是否输入合法
     验证规则：姑且把邮箱地址分成“第一部分@第二部分”这样
     第一部分：由字母、数字、下划线、短线“-”、点号“.”组成，
     第二部分：为一个域名，域名由字母、数字、短线“-”、域名后缀组成，
     而域名后缀一般为.xxx或.xxx.xx，一区的域名后缀一般为2-4位，如cn,com,net，现在域名有的也会大于4位
     */
    function checkEmail(str) {
        re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
        if (re.test(str)) {
            return true;
        } else {
            return false;
        }
    }
    function validate() {
        var tel = document.getElementById("tel");
        var email = document.getElementById("email");
        if (!(checkPhone(tel.value) || checkMobile(tel.value) || trim(tel.value) == null || trim(tel.value) == "")) {
            alert("联系电话格式不正确！");
            tel.focus();
            return false;
        }
        if (!(checkEmail(email.value) || trim(tel.value) == null || trim(email.value) == "")) {
            alert("邮箱格式不正确！");
            email.focus();
            return false;
        }
        return true;
    }
    function trim(str) { //删除左右两端的空格
        return str.replace(/(^\s*)|(\s*$)/g, "");
    }
    function jump() {
        window.location.href = "/frame/toChangePwd";
    }
</script>
<style>
    .infoForm{
        margin-left:10%;
    }
    .infoForm input{ border-color: #d1bbbb;}

</style>
<body>
<div>
<c:if test="${sessionScope.identity!='admin'}">
    <a class="voteMain" href="/frame/toMain">投票主页
    </a>
</c:if>
>><span>个人信息设置</span>
</div>
<br>
<br>

<br>
<br>
<form class="layui-form te-left infoForm" action="/frame/personalInfoChange" name="form" onsubmit="return validate()">
    <input type="text" id="id" name="id" value="${person.id}" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="text" name="name" required="required" readonly="readonly" style="opacity: 0.5" autocomplete="off" value="${person.name}"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="password" id="password" name="password" required="required" readonly="readonly" style="opacity: 0.5" value="***"
                   class="layui-input">
            <input type="button" class="layui-btn" value="点击修改密码" onclick="jump()" style="margin-top:20px;margin-left: 80px">
        </div>
    </div>
    <div align="center">
        <span style="color: red;font-size: 18px" >${msg}${param.msg}</span>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系电话</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="text" id="tel" name="tel" lay-verify="required" class="layui-input" value="${person.tel}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"><font color='red'>*</font>联系邮箱</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="text" name="email" id="email" lay-verify="required" class="layui-input"
                   value="${person.email}">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="submit" class="layui-btn" value="修改个人信息" style="margin-left: 80px">
        </div>
    </div>
</form>
</body>
</html>