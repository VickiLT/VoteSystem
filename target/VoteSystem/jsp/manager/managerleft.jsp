<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/15
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <title>管理员左框架</title>
    <link href="<%=path%>/css/bootstraps.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <link href="<%=path%>/css/manuLeft.css" rel="stylesheet" media="screen">
    <script src="<%=path%>/js/jquery1.min.js"></script>
    <script src="<%=path%>/js/bootstraps.min.js"></script>
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

</head>
<body>
<div class="wrap">
    <!-- 左边内容 -->
    <div id="left" class="left">
        <div id="logoDiv" class="logoDiv">
            <div>
            <p id="logoTitle" class="logoTitle" align="left">
                <img id="logo" alt="左右布局" src="<%=path%>/img/cf.png"
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
