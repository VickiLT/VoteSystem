<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/4/4
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<!DOCTYPE html>
<html>
<head>
    <title>投票系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/layui/layui.js"></script>
<%--    <script type="text/javascript" src="../js/login.js"></script>--%>

    <%--<script type="text/javascript" src="images/login.js"></script>--%>
    <link href="../css/login2.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        /**
         * Created by luter on 2018-5-26-0026.
         */
        $(document).ready(function () {
            var status='<%=request.getAttribute("status")%>';
            console.log(status);
            if(status=='0'){
                console.log("succe");
                activeCount();
            }

        });
        function activeCount(){
            layui.use(['layer'], function () {
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    area: ['400px', '200px'],
                    shadeClose: true, //点击遮罩关闭
                    skin: 'layui-layer-rim',
                    closeBtn: 1,
                    content:'<div style="text-align: center;margin: 10px;font-size: 16px;">用户未激活，是否重新发送激活邮件</div>',
                    btn: ['发送',"取消"],
                    btn1: function (index, layero) {
                        //按钮【按钮2】的回调
                        $.ajax({
                            url:"/user/retrieve",
                            data: JSON.stringify(data),
                            dataType:"json",
                            type: "POST",
                            async: false,
                            contentType: 'application/json',
                            success:function(data){
                                if(data.status=="1"){
                                    alert("发送成功，请到邮箱查看");
                                    layer.close(index);
                                    window.location.href="<%=path%>/jsp/login.jsp";
                                }else if(data.status=="0"){
                                    alert("发送失败，请稍后尝试");
                                }


                            },
                            error:function(data){
                                alert("发送失败，请稍后尝试");
                            }
                        });
                        return false;
                    }
                });
            });
        }
        function forgetPw(){
            layui.use(['layer'], function () {
                var layer = layui.layer;
                layer.open({
                    type: 2,
                    area: ['400px', '360px'],
                    shadeClose: true, //点击遮罩关闭
                    skin: 'layui-layer-rim',
                    closeBtn: 1,
                    content:"/jsp/forgetPw.jsp",
                    success: function (layero, index) {


                    },
                    btn: ['取消',"确定"],
                    btn2: function (index, layero) {
                        //按钮【按钮2】的回调
                        forgetPwCallBack(layero, index);
                        return false;
                    }
                })
            })
        }

        function forgetPwCallBack(layero, index) {
            var body = layer.getChildFrame('body', index);
            var name=body.find("input#name").val();
            var email=body.find("input#email").val();
            var identity=body.find("select.identity").val();
            var data={
                name:name,
                email:email,
                identity:identity
            }
            $.ajax({
                url:"/user/retrieve",
                data: JSON.stringify(data),
                dataType:"json",
                type: "POST",
                async: false,
                contentType: 'application/json',
                success:function(data){
                    if(data.status=="1"){
                        alert(data.message);
                        layer.close(index);
                    }else if(data.status=="0"){
                        alert(data.message);
                        layer.close(index);
                    }


                },
                error:function(data){
                    alert(data);
                }
            });
        }
    </script>
</head>
<body>
<h1>投票系统<sup>V2018</sup></h1>

<div class="login" style="margin-top:50px;">

    <div class="header">
        欢迎来到投票系统
    </div>
    <div align="center">
        <div style="color: red;font-size: 18px" >${msg}${param.msg}</div>
        <c:if test="${requestScope.status=='0'}" var="condition" scope="request">
            　　<button class="activeCount"onclick="activeCount()">激活账户</button>
        </c:if>
    </div>

    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 275px;">
        <!--登录-->
        <div class="web_login" id="web_login">
            <div class="login-box">
                <div class="login_form">
                    <form action="/user/login" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm"
                          method="post">
                        <input type="hidden" name="did" value="0"/>
                        <input type="hidden" name="to" value="log"/>
                        <div class="uinArea" id="uinArea">
                            <label class="input-tips">用户名：</label>
                            <div class="inputOuter" id="uArea">
                                <input type="text" id="name" name="name" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips">密码：</label>
                            <div class="inputOuter" id="pArea">
                                <input type="password" id="password" name="password" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea">
                            <label class="input-tips">身份：</label>
                            <div class="selectOuter" id="identity">
                                <select name="identity">
                                    <option value="user">委员</option>
                                    <option value="manager">主任</option>
                                    <option value="secretary">秘书</option>
                                </select>
                            </div>
                        </div>
                        <div style="padding-left:70px;margin-top:20px;">
                            <input type="submit" value="登 录"style="width:150px;"class="button_blue"/>
                            <div class="forgetPw"onclick="forgetPw()">忘记密码</div>


                        </div>
                    </form>
                </div>

            </div>

        </div>
        <!--登录end-->
    </div>
</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或FireFox内核浏览器访问本站</div>
</body>
</html>

