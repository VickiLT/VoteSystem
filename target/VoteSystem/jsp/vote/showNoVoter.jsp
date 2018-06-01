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
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
</head>
<script>
    function remindVote(name){
        var projectId='<%=request.getAttribute("projectId")%>'
        var data={
            projectId:projectId,
            name:name
        }
        $.ajax({
            url: "${basePath}/vote/sentRemindEmail",
            type:'POST',
            data: JSON.stringify(data),
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                if(data.errno==0){
                    alert("已发送邮件提醒成功");
                }

            },
            error: function (textStatus, e) {
                alert("系统ajax交互错误: " + textStatus);
            }
        });
    }
</script>
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
        <c:forEach items="${whoHasNotVote}" var="item" varStatus="i">
                <tr style="margin: 10px">
                    <td>${i.count}、${item}</td>
                    <td><button onclick="remindVote('${item}')">提醒他投票</button></td>
                </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
