<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/24
  Time: 18:49
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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
<script type="text/javascript" src="<%=path%>/js/jquery1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-ui.js"></script>
<script type="text/javascript">
    var validate = function () {
        var num = ${voteProject.selectNum};
        var modify = ${voteProject.isModifyVote};
        var voteMode = ${voteProject.voteMode};
        if (voteMode== 1) {
            var length = $("input[name='content']:checked").length;
            if (length > num) {
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
        } else if(voteMode==0){
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
        }else{
            var sort = document.getElementsByName("content");
            var flag1=0;
            var flag2=0;
            var data=new Array(sort.length);
            for (var i = 0; i < sort.length; i++) {
                if (sort[i].value>sort.length||sort[i].value<=0) {
                    flag1 = 1;
                }
                data[i]=sort[i].value;
            }

            var nary=data.sort();

            for(var i=0;i<nary.length;i++){
                if (nary[i]==nary[i+1]){
                   flag2=1;
                }
            }
            if(flag1==1) {
                alert("选填写的数字应该不大于需排序的选项个数");
                return;
            }else if(flag2==1){
                alert("填写的顺序重复，请检查");
                return;
            }else{
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
    .voteTitle{
        text-align: center;
        font-size: 30px;
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
    <div name="voteTitle" class="voteTitle">
        <label style="">${voteProject.id}.${voteProject.voteTitle}</label>
    </div>
    <div style="margin: 10px auto 30px 10%;width: 80%;min-width:200px;min-height: 50px">
        <span style="margin-left: 5px">&nbsp;&nbsp;${voteProject.voteExplain}</span>
    </div>
        <br>
    <form class="form-horizontal" action="/vote/vote" theme="simple" id="form">
        <input type="text" hidden="hidden" id="id" name="id" value="${voteProject.id}">
        <input type="text" hidden="hidden" id="voteMode" name="voteMode" value="${voteProject.voteMode}">
        <div style="margin: 10px auto 30px 20%">
            <c:if test="${voteProject.voteMode=='1'&&voteProject.selectNum<voteProject.voteSum}">
                <label style="color: grey;"><span style="color: red;">注意:</span>最多选择${voteProject.selectNum}项</label>
            </c:if>
            <c:if test="${voteProject.voteMode=='2'}">
                    <label style="color: grey;"><span style="color: red;">注意:</span>请在选项输入框中填写或者点击三角图标选择优先级数字</label>
            </c:if>
            <div class="form-group">
                <c:forEach items="${contentMap}" var="item">
                    <c:if test="${voteProject.voteMode=='1'}">
                        <div class="checkbox" style="margin: 10px">
                            <label for="input${item.key}">
                                <input id="input${item.key}"type="checkbox" name="content" value="${item.key}" >
                                ${item.key}、${item.value}
                            </label>
                        </div>
                    </c:if>
                    <c:if test="${voteProject.voteMode=='0'}">
                        <div class="radio" style="margin: 10px">
                            <label for="input${item.key}">
                                <input id="input${item.key}" type="radio" name="content" value="${item.key}"lay-skin="primary">
                                    ${item.key}、${item.value}
                            </label>
                        </div>
                    </c:if>
                    <c:if test="${voteProject.voteMode=='2'}">
                        <div style="margin: 10px">
                            <input class="sortResult form-control" type="number" name="content" lay-skin="primary" min="1" max="${contentMap.size()}"style="display:inline;width:70px">
                            <label class="control-label">${item.key}、${item.value}</label>

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
                    <td>
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
            <c:if test="${msg == null || voteProject.isModifyVote == 'true'}">
                <input type="button" class="button" value="点击投票" onclick="validate()">
            </c:if>
        </div>
    </form>
    <div style="margin-left:10px;">
        <%--<label style="padding-left: 5px">发布时间：${createTime}</label>--%>
        <label style="color:red">注意：</label>
        <label>截止时间：${voteProject.time}</label>
    </div>
</div>
</body>
</html>
