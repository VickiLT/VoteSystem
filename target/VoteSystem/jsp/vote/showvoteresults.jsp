<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/27
  Time: 0:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <style>
        .voteTitle{
            text-align: center;
            font-size: 30px;
        }
        table th,table td{
            text-align: center;
        }
        a{
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>查看投票结果
<div>

    <form action="/vote/vote" theme="simple" id="form">
        <input type="text" hidden="hidden" id="id" name="id" value="${voteProject.id}">
        <div>
            <div name="voteTitle" class="voteTitle">
                <label style="">${voteProject.id}.${voteProject.voteTitle}</label>
            </div>
            <br>

        </div>
        <div style="margin: 10px auto 30px 10%;width: 80%;min-width:200px;min-height: 50px">
            <span style="margin-left: 5px">&nbsp;&nbsp;${voteProject.voteExplain}</span>
        </div>
        <center>
            <table class="table table-striped table-bordered table-hover"style="margin-top:50px;width:50%;min-width: 200px">
                <thead style="background: #5848482b">
                    <th>选项</th>
                    <th>结果统计</th>
                </thead>
                <c:forEach items="${voteItems}" var="item">
                    <tr>
                        <td>${item.voteItemNumber}.${item.voteItemContent}</td>
                        <td>&nbsp;&nbsp;&nbsp;${item.voteItemPoll}</td>
                    </tr>
                </c:forEach>
            </table>
            <br>
            合计:${sum}票
        </center>
    </form>



</div>
</body>
</html>
