<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/13
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>

<frameset rows="*" cols="15%,*" frameborder="0" framespacing="0">
    <frame src="/jsp/manager/managerleft.jsp" name="leftFrame" noresize="noresize" id="leftFrame" title="leftFrame" />
    <frameset rows="70px,*" frameborder="0"  framespacing="0">
        <frame src="/jsp/manager/managertop.jsp" name="topFrame" noresize="noresize" id="topFrame" title="topFrame" />
        <frame src="/jsp/frame/tomain.jsp" name="mainFrame" id="mainFrame" title="mainFrame" />
    </frameset>
</frameset>
</html>
