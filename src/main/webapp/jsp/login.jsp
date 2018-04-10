<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/4/4
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>投票系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <%--<script type="text/javascript" src="images/login.js"></script>--%>
    <link href="../css/login2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<h1>投票系统<sup>V2018</sup></h1>

<div class="login" style="margin-top:50px;">

    <div class="header">
        欢迎来到投票系统
    </div>
    <div align="center">
        <span style="color: red;font-size: 18px" >${msg}${param.msg}</span>
    </div>

    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 275px;">
        <!--登录-->
        <div class="web_login" id="web_login">
            <div class="login-box">
                <div class="login_form">
                    <form action="/user/login" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm"
                          method="post">
                        <input type="hidden" name="did" value="0"/>
                        <input type="hidden" name="to" value="log"/>
                        <div class="uinArea" id="uinArea">
                            <label class="input-tips">用户名：</label>
                            <div class="inputOuter" id="uArea">
                                <input type="text" id="name" name="name" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips">密码：</label>
                            <div class="inputOuter" id="pArea">
                                <input type="password" id="password" name="password" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea">
                            <label class="input-tips">身份：</label>
                            <div class="selectOuter" id="identity">
                                <select name="identity">
                                    <option value="user">委员</option>
                                    <option value="manager">管理员</option>
                                    <option value="secretary">秘书</option>
                                </select>
                            </div>
                        </div>
                        <div style="padding-left:70px;margin-top:20px;"><input type="submit" value="登 录"
                                                                               style="width:150px;"
                                                                               class="button_blue"/></div>
                    </form>
                </div>

            </div>

        </div>
        <!--登录end-->
    </div>
</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
</body>
</html>

