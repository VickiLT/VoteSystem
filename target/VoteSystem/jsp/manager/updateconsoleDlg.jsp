<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/29
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../../layui/css/layui.css">
    <script src="../../layui/layui.js"></script>
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="../../datetimepicker-master/build/jquery.datetimepicker.min.css"/>
    <script type="text/javascript" src="../../datetimepicker-master/jquery.js"></script>
    <script type="text/javascript" src="../../datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
    <script type="text/javascript">
        var isCheckResults;
        var isModifyVote;
        layui.use('form', function () {
            var form = layui.form;
//            form.render('select');
//            form.on('select(test1)', function (data) {
//                isCheckResults = data.value;
//            });
//            form.on('select(test2)', function (data) {
//                isModifyVote = data.value;
//            });
        });
        $(function () {
            $("#endTime").datetimepicker({timepicker: true, format: 'Y-m-d H:i:s', showSecond: true,});
            $.datetimepicker.setLocale('zh');
        })
        var callbackdata = function () {
            var id = $("#id").val();
            var voteTitle = $("#voteTitle").val();
            var endTime = $("#endTime").val();
            var isCheckResults = $("#isCheckResults").val();
            var isModifyVote = $("#isModifyVote").val();
            var data = {
                id: id,
                voteTitle: voteTitle,
                endTime: endTime,
                isCheckResults: isCheckResults,
                isModifyVote: isModifyVote
            };
            return data;
        }
        var submitForm = function () {
            document.getElementById("consoleForm").submit();
        }
        var validate = function () {
            var params = callbackdata();
            var time = params.endTime;
            if (params.voteTitle == "") {
                alert("投票标题不能为空！")
                return false;
            }
//            if (time == null) {
//                alert("截止时间不能为空！")
//                return false;
//            }
//            var dB = Date.parse(time.replace(/-/g, "/"));//获取当前选择日期
//            var d = new Date();
//            var s = d.getTime();
//            var n = d.getTime() - dB;
//            //时间戳对比
//            if (n > 0) {
//                alert("时间不能小于当前时间！");
//                return false;
//            }
            return true;
        }
    </script>
</head>
<body>
<div id="consoleDlg">
    <form class="layui-form te-left" action="/vote/createVote/firstStep" name="consoleForm" id="consoleForm">
        <input type="text" id="id" name="id" hidden="hidden">
        <div class="layui-form-item">
            <label class="layui-form-label">投票主题</label>
            <div class="layui-input-block" style="width: 200px">
                <input type="text" name="voteTitle" id="voteTitle" required="required"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">截止时间</label>
            <div class="layui-input-block" style="width: 200px">
                <input type="text" name="endTime" id="endTime" required="required" class="layui-input">
            </div>
        </div>
    </form>
    <br>
    <div>
        <label>是否允许修改所投票</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <select name="isModifyVote" id="isModifyVote">
            <option value="false" selected="selected">不可修改</option>
            <option value="true">可修改</option>
        </select>
    </div>
    <br>
    <div style="margin-top: 10px">
        <label>是否允许查看总投票结果</label>
        <select name="isCheckResults" id="isCheckResults">
            <option value="false">不可查看</option>
            <option value="true">可查看</option>
        </select>
    </div>
</div>
</body>
</html>