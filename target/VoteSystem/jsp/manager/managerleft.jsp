<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/15
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>管理员左框架</title>
    <link href="../../css/bootstraps.css" rel="stylesheet" media="screen">
    <script src="../../js/jquery1.min.js"></script>
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
        body{
            margin:0;
            padding:0;
            font-family: Lato,Helvetica,Arial,sans-serif;
            font-size: 16px;
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
        .left{
            margin-left:0px;
            position: absolute;
            /*box-sizing: border-box;*/
            width: 100%;
            height: 100%;
            /*background: #4d5e70 bottom;*/
            background: #e3e3e3;
            border-right:1px solid #9d9d9d;
        }
        .logoDiv{
            padding-top: 10px;
            height: 70px;
            background-color: #354457;
            font-size: 16px;
            color: #fff;
            vertical-align: bottom;
        }
        .logoTitle{
            margin-left:15px;
            line-height: 1.7;
        }
        .login-out{
            color: #b97c7c;
            font-size: 12px;
            margin-left: 35px;
        }
        .panel-group{
            margin-top:50px;
        }
        .menu-title {
            margin-left:15px;
            color: #0C0C0C;
            padding-top: 10px;
            padding-bottom: 10px;
            font-size: 22px;
            font-weight: bold;
        }
        .manu-ul{
            padding-left:10%;
        }
        .manu-ul li{
            border-radius: 10px;
            background-color: #462c2c2b;
            width:80%;
        }
        .nav > li > a{
            padding:6px 15px;
        }
        a{
            color: #3F3F3F;
            text-decoration: none;
        }
        a:hover,a:visited,a:link{
            text-decoration: none;
        }
        .nav > li > a:hover, .nav > li > a:focus{
            background-color: #462c2c2b;

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
                <img id="logo" alt="左右布局" src="http://tool.what21.com/page/image/menu/cf.png"
                     style="height: 28px; padding-right: 5px;vertical-align: middle;">
                <span style="font-size:12px;">欢迎你,</span>
                <span>
                    ${sessionScope.username}
                </span>
                <a class="login-out" href="/user/loginOut" onclick="return yes()" font-size="10px">退出</a>
            </p>
            </div>
        </div>
        <div class="panel-group" id="manage-menu">
        <div class="panel panel-default">
            <div class="panel-heading menu-title" >
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#manage-menu" href="#personList" >账号管理</a>
                </h4>
            </div>
            <div  id="personList" class="collapse panel-collapse collapse in">
                <ul class="panel-body nav nav-pills nav-stacked manu-ul" >
                    <li><a href="/frame/personalInfoManage" target="mainFrame">个人信息修改</a></li>
                    <li><a href="usernamage.jsp" target="mainFrame">委员管理</a></li>
                    <li><a href="secretarymanage.jsp" target="mainFrame">教学秘书管理</a></li>
                    <li><a href="managermanage.jsp" target="mainFrame">主任管理</a> </li>
                </ul>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading menu-title">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#manage-menu" href="#voteList">投票管理</a>
                </h4>
            </div>
            <div  id="voteList" class="collapse panel-collapse collapse">
                <ul class="panel-body nav nav-pills nav-stacked manu-ul">
                    <li><a href="../vote/vote.jsp" target="mainFrame">投票</a></li>
                    <li><a href="/vote/manageVote" target="mainFrame">管理投票</a></li>
                </ul>
            </div>
        </div>
        </div>
    </div>
</div>
</body>
</html>
