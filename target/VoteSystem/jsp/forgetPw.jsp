<%--
  Created by IntelliJ IDEA.
  User: luter
  Date: 2018-5-27-0027
  Time: 下午 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <title>忘记密码</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <link href="../css/login2.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<div class="forgetPw-box">
    <div class="forgetPw_form">
        <form name="forgetPwform" accept-charset="utf-8" id="forgetPw_form" class="forgetPwForm"
              method="post">
            <div class="uinArea" id="uinArea">
                <label class="input-tips">用户名：</label>
                <div class="inputOuter" id="uArea">
                    <input type="text" id="name" name="name" class="inputstyle"/>
                </div>
            </div>
            <div class="emailArea" id="emailArea">
                <label class="input-tips">邮箱：</label>
                <div class="inputOuter" id="eArea">
                    <input type="email" id="email" name="email" class="inputstyle"/>
                </div>
            </div>
            <div class="idenArea">
                <label class="input-tips">身份：</label>
                <div class="selectOuter" id="identity">
                    <select class="identity" name="identity">
                        <option value="user">委员</option>
                        <option value="manager">主任</option>
                        <option value="secretary">秘书</option>
                    </select>
                </div>
            </div>
        </form>
    </div>

</div>
</body>
</html>
