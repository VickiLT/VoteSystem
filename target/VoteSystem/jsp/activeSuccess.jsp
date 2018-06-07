<%--
  Created by IntelliJ IDEA.
  User: luter
  Date: 2018-5-28-0028
  Time: 下午 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>

<html>
<head>
    <title>初始化密码</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <link href="../css/login2.css" rel="stylesheet" type="text/css"/>
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
            width:90px;
        }
        .layui-input-block{
            margin-left:125px;
            width:300px;
        }
        form{
            margin: 50px auto;
            width: 430px;
            background-color: #fff;
            padding: 30px;
        }
        .layui-form-item{
            margin-bottom: 25px;
        }
        .layui-btn{
            width: 100px;
        }
        .init-pw-title{
            margin: 40px  auto 30px -25px;
            text-align:center;
            color:#4d2578;
            font-size:20px;
            font-weight: bold;
            text-shadow: 0px 1px 1px #555;
        }

    </style>
</head>

<body>
<h1>投票系统<sup>V2018</sup></h1>
<h3 class="init-pw-title">初始化你的密码</h3>
<form class="layui-form te-left" action="/user/firstLogin" name="form" onsubmit="return validate()" method="post">
    <input type="hidden" name="username" value="${username}"/>
    <input type="hidden" name="code" value="${code}"/>
    <input type="hidden" name="identity" value="${identity}"/>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码:</label>
        <div class="layui-input-block">
            <input type="password" id="newPassword" name="newPassword" required="required"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">确认新密码:</label>
        <div class="layui-input-block">
            <input type="password" id="newPasswordAgain" name="newPasswordAgain" required="required"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block" style="margin-left: 170px">
            <input type="submit" class="layui-btn" value="确认">
        </div>
    </div>
</form>
</body>
</html>
