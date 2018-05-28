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
    <title>激活成功</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
</head>
<body>
<div style="text-align: center">
    <h1>已激活，您可以登录系统了</h1>
    <h1><a href="<%=path%>\jsp\login.jsp">点击跳转</a></h1>
</div>
</body>
</html>
