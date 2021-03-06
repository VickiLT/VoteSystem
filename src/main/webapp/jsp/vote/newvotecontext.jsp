<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/12
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>


<link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use('form', function () {
        var form = layui.form;

        //各种基于事件的操作，下面会有进一步介绍
    });
</script>
<%--<script type="text/javascript">--%>
    <%--/*--%>
     <%--* 上传文件--%>
     <%--*/--%>
    <%--function upload(){--%>
        <%--var formData = new FormData($( "#uploadfiles" )[0]);--%>
        <%--$.ajax({--%>
            <%--type: "post",--%>
            <%--url: "/file/uploadFile",--%>
            <%--dataType: "json",--%>
            <%--data: formData,--%>
            <%--/**--%>
             <%--*必须false才会自动加上正确的Content-Type--%>
             <%--*/--%>
            <%--contentType : false,--%>
            <%--/**--%>
             <%--* 必须false才会避开jQuery对 formdata 的默认处理--%>
             <%--* XMLHttpRequest会对 formdata 进行正确的处理--%>
             <%--*/--%>
            <%--processData : false,--%>
            <%--success: function(data){//从后端返回数据进行处理--%>
                <%--if(data){--%>
                    <%--alert("上传成功！");--%>
                <%--}else{--%>
                    <%--alert("上传失败！");--%>
                <%--}--%>
            <%--},--%>
            <%--error: function(err) {//提交出错--%>
                <%--$("#msg").html(JSON.stringify(err));//打出响应信息--%>
                <%--alert("服务器无响应");--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>
<%--</script>--%>
<script type="text/javascript">

    var validate = function () {
        var selectNum = $("#selectNum").val();
        var voteMode = $("#voteMode").val()
        var voteSum = $("#voteSum").val();
        var voteExplain = $("#voteExplain").val();
        if (voteMode == '1') {
            if(selectNum < 1){
                alert("多选时选择个数必须大或等于1！")
                return;
            }
            if (selectNum >voteSum) {
                alert("选择个数必须小于选项个数！")
                return;
            }
        } else if(voteExplain==""){
            alert("投票描述不能为空！")
            return;
        }
        document.getElementById("form").submit();


    }
    function IsNum(num) {
        var reNum = /^\d*$/;
        return (reNum.test(num));
    }
</script>
<style>
    .layui-form-label{
        width:25%;
        min-width:100px;
    }
    .layui-input-block{
        margin-left:35%;
        width:30%;
        min-width: 150px;;
    }
    .layui-input{
        border-color:#c2cd96;
    }
</style>
<body>
<a href="/frame/toMain">
    投票主页
</a>>><font style="font-size: 12pt">创建投票</font>
<br>
<br>

<form class="layui-form te-left" id="form" action="/vote/createVote/show" method="post" enctype="multipart/form-data">
    <div class="layui-form-item">
        <label class="layui-form-label">投票类型：</label>
        <div class="layui-input-block">
            <c:if test="${voteProject.voteMode=='0'}"><input class="layui-input" value="单选"readonly></c:if>
            <c:if test="${voteProject.voteMode=='1'}"><input class="layui-input" value="多选"readonly></c:if>
            <c:if test="${voteProject.voteMode=='2'}"><input class="layui-input" value="排序"readonly></c:if>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投票标题：</label>
        <div class="layui-input-block">
            <input type="text" name="voteTitle" lay-verify="required" autocomplete="off" class="layui-input"
                   value="${voteProject.voteTitle}">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">投票描述：</label>
        <div class="layui-input-block">
            <textarea name="voteExplain" id="voteExplain" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>
    <c:forEach begin="1" end="${voteProject.voteSum}" step="1" var="i">
        <div class="layui-form-item">
            <label class="layui-form-label">第${i}项：</label>
            <div class="layui-input-block">
                <input type="text" name="content" lay-verify="required" placeholder="请输入选项内容" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </c:forEach>
    <input type="text" hidden="hidden" id="voteSum" name="voteSum" value="${voteProject.voteSum}">
    <input type="text" hidden="hidden" id="voteMode" name="voteMode" value="${voteProject.voteMode}">
    <c:if test="${voteProject.voteMode=='1'}">
        <div class="layui-form-item">
            <label class="layui-form-label">最多选项数：</label>
            <div class="layui-input-block">
                <input type="number" name="selectNum" lay-verify="required" value="${voteProject.voteSum}" autocomplete="off"
                       class="layui-input" id="selectNum">
            </div>
        </div>
    </c:if>


    <div class="layui-form-item">
        <label class="layui-form-label">允许修改：</label>
        <div class="layui-input-block">
            <select name="isModifyVote" id="isModifyVote" lay-verify="required" lay-filter="test2">
                <option value="false" selected="selected">不可修改</option>
                <option value="true">可修改</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">允许查看结果：</label>
        <div class="layui-input-block">
            <select name="isCheckResults" id="isCheckResults" lay-verify="required" lay-filter="test1">
                <option value="false" selected="selected">不可查看</option>
                <option value="true">可查看</option>
            </select>
        </div>
    </div>
    <input name="time" value="${voteProject.time}" type="text" id="endTime" hidden="hidden">
    <div id="uploadfiles">
    <label>上传文件:</label>
    <input type="file" multiple="multiple" id="file_upload" name="files" />
    <%--<input type="button" value="上传" onclick="upload()" />--%>
</form>
</div>
    <div class="layui-input-block">
        <%--<button class="btn" onclick="validate()">立即提交</button>--%>
        <input type="button" class="layui-btn" onclick="validate()" value="提交">
    </div>
</div>
</body>
</html>

