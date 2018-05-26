<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/24
  Time: 23:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>用户左框架</title>
    <link href="../../css/bootstraps.css" rel="stylesheet" media="screen">
    <script src="../../js/jquery.js"></script>
    <script src="../../js/bootstraps.min.js"></script>
    <script type="text/javascript">
        var yes = function () {
            var r = confirm("你确定要退出吗？")
            if(r == true){
                return true;
            }else {
                return false;
            }
        }
    </script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Lato, Helvetica, Arial, sans-serif;
            font-size: 14px;
            line-height: 1.72222;
            color: #34495e;
            background-color: #fff;
        }

        /*body {*/
        /*background-color: #738edf;*/
        /*font-size: 14px;*/
        /*}*/
        .wrap {
            width: 100%;
            position: absolute;
            background: #eff3f6 bottom;
            height: 100%;
            overflow: hidden;
        }

        .left {
            margin-left: 0px;
            position: absolute;
            /*box-sizing: border-box;*/
            width: 100%;
            height: 100%;
            background: #e3e3e3;
            border-right:1px solid #9d9d9d;
        }

        .logoDiv {
            padding-top: 10px;
            padding-bottom: 20px;
            height: 70px;
            background-color: #354457;
            font-size: 12px;
            color: #fff;
            vertical-align: bottom;
        }

        .logoTitle {
            margin-left: 15px;
            line-height: 1.7;
        }

        .menu-title {
            margin-left: 15px;
            color: #0C0C0C;
            padding-top: 10px;
            padding-bottom: 10px;
            font-size: 17px;
            font-weight: bold;
        }

        a {
            color: #3F3F3F;
        }
    </style>

</head>
<body>
<div class="wrap">
    <!-- 左边内容 -->
    <div id="left" class="left">
        <div id="logoDiv" class="logoDiv">
            <div>
            <p id="logoTitle" class="logoTitle" align="left">
                <img id="logo" alt="左右布局" src="../../img/cf.png"
                     style="height: 28px; padding-right: 5px;vertical-align: middle;">
                <span style="font-size:12px;">欢迎你,</span>
                <span>
                    ${sessionScope.username}
                </span>
            </p>
            </div>
            <div align="right">
                <a href="/user/loginOut" onclick="return yes()" font-size="10px" style="color: #F6F6F6">注销</a>
            </div>
        </div>
        <div class="menu-title" style="border-bottom:1px solid #9d9d9d">账号管理</div>
        <ul class="nav nav-pills nav-stacked">
            <li style="border-bottom:1px solid #9d9d9d"><a href="/frame/personalInfoManage" target="mainFrame">-个人信息修改</a></li>
        </ul>
        <div class="menu-title" style="border-bottom:1px solid #9d9d9d">投票管理</div>
        <ul class="nav nav-pills nav-stacked">
            <li><a href="../vote/vote.jsp" target="mainFrame">-投票</a></li>
        </ul>
    </div>
</div>
</body>
</html>
