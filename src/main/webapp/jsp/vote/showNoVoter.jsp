<%--
  Created by IntelliJ IDEA.
  User: luter
  Date: 2018-5-31-0031
  Time: 下午 8:01
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
    <title>未投票人列表</title>
</head>
<style>
    .noVoter table{
        width:60%;
        min-width: 400px;
        margin:auto;
    }
</style>
<body>
<div class="noVoter">
    <table>
        <c:forEach items="${contentMap}" var="item">
                <tr style="margin: 10px">
                    <td>${item.value}</td>
                    <td>提醒他投票</td>
                </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
