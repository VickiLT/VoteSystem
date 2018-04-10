<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/13
  Time: 12:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<link rel="stylesheet" type="text/css" href="../../layui/css/layui.css">
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="../../layui/layui.js"></script>
<script>
    layui.use('form', function () {
        var form = layui.form;

        //各种基于事件的操作，下面会有进一步介绍
    });
</script>
<style type="text/css">
    <!--
    body {
        /*background-color: #ccc;*/
    }

    -->
    a {
        font-size: 12pt;
        text-decoration: none
    }
</style>
<script type="text/javascript">
    /**
     验证手机号码是否输入合法
     验证规则：11位数字，以1开头
     */
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
<body>
<a href="/frame/toMain">
    投票主页
</a>>>><font style="font-size: 12pt">个人信息设置</font>
<br>
<br>
<br>
<br>
<form class="layui-form te-left" action="/frame/personalInfoChange" name="form" onsubmit="return validate()">
    <input type="text" id="id" name="id" value="${person.id}" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="text" name="name" required="required" readonly="readonly" style="opacity: 0.3" autocomplete="off" value="${person.name}"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="password" id="password" name="password" required="required" value="${person.password}"
                   class="layui-input">
            <input type="button" class="layui-btn layui-btn-xs" value="点击修改密码" onclick="jump()" style="margin-left: 80px">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">联系电话</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="text" id="tel" name="tel" lay-verify="required" class="layui-input" value="${person.tel}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系邮箱</label>
        <div class="layui-input-block" style="width: 300px">
            <input type="text" name="email" id="email" lay-verify="required" class="layui-input"
                   value="${person.email}">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="submit" class="layui-btn" value="修改" style="margin-left: 80px">
        </div>
    </div>
</form>
</body>
</html>