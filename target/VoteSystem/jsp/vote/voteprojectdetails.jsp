<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/4/5
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<head>
    <style type="text/css">
        .voteTitle{
            text-align: center;
            font-size: 30px;
        }

    </style>
</head>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>投票信息
<br>
<br>

<div>
    <form theme="simple" id="form">
        <input type="text" hidden="hidden" id="id" name="id" value="${voteProject.id}">
        <div>
            <div name="voteTitle" class="voteTitle">
                <label style="">${voteProject.id}.${voteProject.voteTitle}</label>
            </div>
            <br>

        </div>
        <div style="margin: 10px auto 30px 10%;width: 80%;min-width:200px;min-height: 50px">
            <span style="margin-left: 5px">&nbsp;&nbsp;${voteProject.voteExplain}</span>
        </div>
        <div style="margin: 10px auto 30px 20%">
            <c:if test="${voteProject.voteMode=='1'||voteProject.selectNum<voteProject.voteSum}">
                <label><span style="color: red;">注意:</span>只能选择${voteProject.selectNum}项</label>
            </c:if>
            <div>
                <c:forEach items="${contentMap}" var="item">
                    <c:if test="${voteProject.voteMode==1}">
                        <div style="margin: 10px">
                            <label for="input${item.key}">${item.key}、${item.value}</label>
                            <input id="input${item.key}"type="checkbox" name="content" value="${item.key}"lay-skin="primary" disabled>
                        </div>
                    </c:if>
                    <c:if test="${voteProject.voteMode==0}">
                        <div style="margin: 10px">
                            <label for="input${item.key}">${item.key}、${item.value}</label>
                            <input id="input${item.key}" type="radio" name="content" value="${item.key}"lay-skin="primary"disabled>
                        </div>
                    </c:if>
                    <c:if test="${voteProject.voteMode==2}">
                        <div style="margin: 10px">
                            <label>${item.key}、${item.value}</label>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <p/>
            <p/>
            <c:if test="${fileMap!= null &&fn:length(fileMap) != 0}">
                <div>
                    <table>
                        <c:forEach var="me" items="${fileMap}">
                            <tr>
                                <c:url value="/file/downFile" var="downurl">
                                    <c:param name="filename" value="${me.value}"></c:param>
                                </c:url>
                                <td><label>附件:</label></td>
                                <td>${me.value}</td>
                                <td>&nbsp;&nbsp;<a href="${downurl}">下载</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </c:if>
            <font color="#483d8b">
                <c:if test="${msg != null}">
                    注:*${msg}*
                </c:if>
            </font>
            <br>
            <br>
        </div>
    </form>
    <div style="margin-left:10%;">
        <%--<label style="padding-left: 5px">发布时间：${createTime}</label>--%>
        <label style="color:red">注意：</label>
        <label>截止时间：${voteProject.time}</label>
    </div>
</div>
</body>
</html>
