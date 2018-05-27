<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/21
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../../css/jquery-ui.css">
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui.js"></script>
    <script type="text/javascript" src="../../layui/layui.js"></script>
    <link rel="stylesheet" type="text/css" href="../../layui/css/layui.css">
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <script src="../../layui/layui.js"></script>
    <script>
        layui.use('form', function () {
            var form = layui.form;

        });
    </script>
    <style type="text/css">
        <!--
        body {

        }
        -->
        a {
            font-size: 12pt;
            text-decoration: none
        }
    </style>
    <script type="text/javascript">
        var callbackdata = function () {
            var id = $("#id").val();
            var name = $("#name").val();
            var password = $("#password").val();
            var tel = $("#tel").val();
            var email = $("#email").val();
            var data = {
                ids:id,
                name:name,
                password:password,
                email:email,
                tel:tel,
            };
            return data;
        }
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

        function trim(str) { //删除左右两端的空格
            return str.replace(/(^\s*)|(\s*$)/g, "");
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
            var params = callbackdata();
            if(params.name==""){
                layui.use(['layer'], function () {
                    var layer = layui.layer;
                    layer.open({
                        content: '用户名必填',
                        btn: '确定'
                    });
                });
                return false;
            }else if(params.email== ""){
                layui.use(['layer'], function () {
                    var layer = layui.layer;
                    layer.open({
                        content: '联系邮箱为必填',
                        btn: '确定'
                    });
                });
                return false;
            } else if (!(checkPhone(params.tel) || checkMobile(params.tel) || trim(params.tel) == null || trim(params.tel) == "")) {
                layui.use(['layer'], function () {
                    var layer = layui.layer;
                    layer.open({
                        content: '联系电话格式不正确',
                        btn: '确定'
                    });
                });
                return false;
            }else if(!(checkEmail(params.email) || trim(params.email) == null || trim(params.email) == "")){
                layui.use(['layer'], function () {
                    var layer = layui.layer;
                    layer.open({
                        content: '联系邮箱格式不正确',
                        btn: '确定'
                    });
                });
                return false;
            }else {
                return true;
            }
        }
    </script>
</head>
<body>
<div id="consoleDlg">
    <%--<form id="consoleForm">--%>
        <%--<table class="formTable">--%>
            <%--<tr>--%>
                <%--<td><input type="text" style="display: none" id="id" name="id"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th><label class="label">姓名</label> </th>--%>
                <%--<td><input type="text" class="input_per" id="name" name="name" required="required"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th><label class="label">密码</label></th>--%>
                <%--<td><input type="password" class="input_per" id="password" name="password" required="required"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th><label class="label">联系电话</label></th>--%>
                <%--<td><input type="text" class="input_per" id="tel" name="tel"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th><label class="label">联系邮箱</label></th>--%>
                <%--<td><input type="text" class="input_per" id="email" name="email"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</form>--%>
    <form class="layui-form te-left" name="consoleForm" id="consoleForm">
        <input type="text" id="id" name="id" hidden="hidden">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block" style="width: 250px">
                <input type="text" name="name"id="name" required="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
            <div class="layui-input-block" style="width: 250px">
                <input type="text" id="password" name="password" required="required"class="layui-input"value="123456" readonly>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">联系电话</label>
            <div class="layui-input-block" style="width: 250px">
                <input type="text" id="tel" name="tel" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系邮箱</label>
            <div class="layui-input-block" style="width: 250px">
                <input type="text" name="email" id="email" lay-verify="required" class="layui-input">
            </div>
        </div>
    </form>
</div>
</body>
</html>
