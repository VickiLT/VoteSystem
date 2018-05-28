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
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
</head>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>>查看投票结果
<div>
    <form action="/vote/vote" theme="simple" id="form">
        <input type="text" hidden="hidden" id="id" name="id" value="${voteProject.id}">
        <center>
            <div name="voteTitle" style="font-size: 18px;">
                <label style="">${voteProject.id}.${voteProject.voteTitle}</label>
            </div>
            <br>
            <div style="width: 80%">
                <label style="padding-left: 5px">发布时间:${createTime}</label>
                <labetl style="padding-left: 150px">截止时间:${voteProject.time}</labetl>
            </div>
        </center>
        <div style="border: 1px dashed #000;margin-top: 10px;margin-left:200px;width: 70%;height: 100px">
            <span style="margin-left: 5px">投票描述:${voteProject.voteExplain}</span>
        </div>
        <center>
            <table style="border: 1px dashed #000">
                <c:forEach items="${voteItems}" var="item">
                    <tr>
                        <td style="border: 1px dashed #000">${item.voteItemNumber}.${item.voteItemContent}</td>
                        <td style="border: 1px dashed #000">&nbsp;&nbsp;&nbsp;${item.voteItemPoll}票</td>
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
