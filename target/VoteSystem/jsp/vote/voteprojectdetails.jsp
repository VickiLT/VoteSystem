<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/4/5
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<html>
<script type="text/javascript" src="../../js/jquery.js"></script>
<head>
    <style type="text/css">
        <!--
        body {
            /*background-color: #ccc;*/
        }

        -->
        a {
            font-size: 12pt;
            text-decoration: none
        }
    </style>
</head>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>>投票
<br>
<br>

<div>
    <form theme="simple" id="form">
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
            <c:if test="${voteProject.voteMode=='false'}">
                <label>注意:只能选择一项</label>
            </c:if>
            <c:if test="${voteProject.voteMode=='true'}">
                <label>注意:只能选择${voteProject.selectNum}项</label>
            </c:if>
            <table>
                <c:forEach items="${contentMap}" var="item">
                    <c:if test="${voteProject.voteMode=='true'}">
                        <tr>
                            <td>${item.key}.${item.value}</td>
                        </tr>
                    </c:if>
                    <c:if test="${voteProject.voteMode=='false'}">
                        <tr>
                            <td>${item.key}.${item.value}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
            <p/>
            <p/>
            <div>
                <label>附件:</label>
                <table>
                <c:forEach var="me" items="${fileMap}">
                    <tr>
                    <c:url value="/file/downFile" var="downurl">
                        <c:param name="filename" value="${me.value}"></c:param>
                    </c:url>
                        <td>${me.value}</td>
                        <td>&nbsp;&nbsp;<a href="${downurl}">下载</a></td>
                    </tr>
                </c:forEach>
                </table>
            </div>
            <font color="#483d8b">
                <c:if test="${msg != null}">
                    注:*${msg}*
                </c:if>
            </font>
            <br>
            <br>
        </center>
    </form>
</div>
</body>
</html>
