<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/31
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <title>异常统一处理</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
</head>
<body>
${msg}
</body>
</html>
