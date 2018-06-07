<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/26
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <script type="text/javascript">
        var identity=<%=session.getAttribute("identity")%>;
        if(identity=="admin"){
            window.onload=function()//用window的onload事件，窗体加载完毕的时候
            {
                window.location.href='/frame/personalInfoManage';
            }
        }else{
            window.onload=function()//用window的onload事件，窗体加载完毕的时候
            {
                window.location.href='/frame/toMain';
            }
        }

    </script>
</head>
<body>

</body>
</html>
