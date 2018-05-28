<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/24
  Time: 18:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript">
    var validate = function () {
        var num = ${voteProject.selectNum};
        var modify = ${voteProject.isModifyVote};
        if (num != 1) {
            var length = $("input[name='content']:checked").length;
            if (length != num) {
                alert("选择数量不符合！");
                return;
            } else {
                if (modify == false) {
                    var r = confirm("投票过后不得修改，你确定要投票吗？")
                    if (r == true) {
                        document.getElementById("form").submit();
                    } else {
                        return;
                    }
                } else {
                    document.getElementById("form").submit();
                }

            }
        } else {
            var radio = document.getElementsByName("content");
            var flag = 0;
            for (var i = 0; i < radio.length; i++) {
                if (radio.item(i).checked == true) {
                    flag = 1;
                    break;
                }
            }
            if (!flag) {
                alert("请选择选项！");
                return;
            } else {
                if (modify == false) {
                    var r = confirm("投票过后不得修改，你确定要投票吗？")
                    if (r == true) {
                        document.getElementById("form").submit();
                    } else {
                        return;
                    }
                } else {
                    document.getElementById("form").submit();
                }
            }
        }

    }
</script>
<style type="text/css">
    <!--
    /*background-color: #ccc;*/
    body {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 1em;
        vertical-align: middle;
        font-weight: normal
    }

    -->
    a {
        font-size: 12pt;
        text-decoration: none
    }

    .button {
        width: 100px;
        padding: 8px;
        background-color: #428bca;
        border-color: #357ebd;
        color: #fff;
        -moz-border-radius: 8px;
        -webkit-border-radius: 8px;
        border-radius: 8px; /* future proofing */
        -khtml-border-radius: 8px; /* for old Konqueror browsers */
        text-align: center;
        vertical-align: middle;
        border: 1px solid transparent;
        font-weight: 500;
        font-size: 100%
    }
</style>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>>投票
<br>
<br>

<div>
    <form action="/vote/vote" theme="simple" id="form">
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
                            <td><input type="checkbox" name="content" value="${item.key}"></td>
                        </tr>
                    </c:if>
                    <c:if test="${voteProject.voteMode=='false'}">
                        <tr>
                            <td>${item.key}.${item.value}</td>
                            <td><input type="radio" name="content" value="${item.key}"></td>
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
            <c:if test="${msg == null || voteProject.isModifyVote == 'true'}">
                <input type="button" class="button" value="点击投票" onclick="validate()">
            </c:if>
        </center>
    </form>
</div>
</body>
</html>
