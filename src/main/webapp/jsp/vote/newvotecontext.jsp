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
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
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
        var voteMode = $("#voteMode").val();
        var voteSum = $("#voteSum").val();
        if (!IsNum(selectNum)) {
            alert("需选择的选项个数必须为数字！")
            return;
        } else if (voteMode == 'false' && selectNum != 1) {
            alert("单选时选择个数必须等于1！")
            return;
        } else if (voteMode == 'true' && selectNum < 2) {
            alert("多选时选择个数必须大或等于2！")
            return;
        } else if (voteMode == 'true' && selectNum >= voteSum) {
            alert("选择个数必须小于选项个数！")
            return;
        } else {
            document.getElementById("form").submit();
        }

    }
    function IsNum(num) {
        var reNum = /^\d*$/;
        return (reNum.test(num));
    }
</script>
<body>
<a href="/frame/toMain">
    投票主页
</a>>>><font style="font-size: 12pt">创建投票</font>
<br>
<br>

<form class="layui-form te-left" id="form" action="/vote/createVote/show" method="post" width="60%" enctype="multipart/form-data">
    <div class="layui-form-item">
        <label class="layui-form-label">投票标题</label>
        <div class="layui-input-block">
            <input type="text" name="voteTitle" lay-verify="required" autocomplete="off" class="layui-input"
                   value="${voteProject.voteTitle}" style="width: 600px">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">投票描述</label>
        <div class="layui-input-block">
            <textarea name="voteExplain" id="voteExplain" placeholder="请输入内容" class="layui-textarea"
                      style="width: 700px"></textarea>
        </div>
    </div>
    <c:forEach begin="1" end="${voteProject.voteSum}" step="1" var="i">
        <div class="layui-form-item">
            <label class="layui-form-label">第${i}项</label>
            <div class="layui-input-block">
                <input type="text" name="content" lay-verify="required" placeholder="请输入选项内容" autocomplete="off"
                       class="layui-input" style="width: 600px">
            </div>
        </div>
    </c:forEach>
    <div class="layui-form-item">
        <label class="layui-form-label">投票类型</label>
        <div class="layui-input-block" style="width: 100px">
            <select name="voteMode" id="voteMode" lay-verify="required">
                <option value="false" selected="selected">单选</option>
                <option value="true">多选</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">输入需要选择的选项个数</label>
        <div class="layui-input-block" style="width: 150px">
            <input type="text" name="selectNum" lay-verify="required" value="${mode}" autocomplete="off"
                   class="layui-input" id="selectNum" style="width:100px">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">是否允许修改所投票</label>
        <div class="layui-input-block" style="width: 150px">
            <select name="isModifyVote" id="isModifyVote" lay-verify="required" lay-filter="test2">
                <option value="false" selected="selected">不可修改</option>
                <option value="true">可修改</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否允许查看总投票结果</label>
        <div class="layui-input-block" style="width: 150px">
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

