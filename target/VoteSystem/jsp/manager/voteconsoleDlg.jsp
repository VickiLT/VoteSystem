<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/17
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <script src="<%=path%>/layui/layui.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/datetimepicker-master/build/jquery.datetimepicker.min.css"/>
    <script type="text/javascript" src="<%=path%>/datetimepicker-master/jquery.js"></script>
    <script type="text/javascript" src="<%=path%>/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
    <script>
        layui.use('form', function () {
            var form = layui.form;

            //各种基于事件的操作，下面会有进一步介绍
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $("#time").datetimepicker({timepicker: true, format: 'm-d-Y H:i:s', showSecond: true,});
            $.datetimepicker.setLocale('zh');
        })
        var callbackdata = function () {
            var voteTitle = $("#voteTitle").val();
            var time = $("#time").val();
            var voteSum = $("#voteSum").val();
            var data = {
                voteTitle: voteTitle,
                time: time,
                voteSum: voteSum
            };
            return data;
        }
        var submitForm = function () {
            document.getElementById("consoleForm").submit();
        }
        var validate = function () {
            var params = callbackdata();
            var time = params.time;
            if (params.voteTitle == "") {
                alert("投票标题不能为空！")
                return false;
            }
            if (time == null) {
                alert("截止时间不能为空！")
                return false;
            }
            var dB = Date.parse(time.replace(/-/g, "/"));//获取当前选择日期
            var d = new Date();
            var s = d.getTime();
            var n = d.getTime() - dB;
            //时间戳对比
            if (n > 0) {
                alert("时间不能小于当前时间！");
                return false;
            }
            if (!IsNum(params.voteSum)) {
                alert("选项个数必须为数字！")
                return false;
            } else if (params.voteSum < 2) {
                alert("选项个数必须大或等于2！")
                return false;
            }
            return true;
        }
        function IsNum(num) {
            var reNum = /^\d*$/;
            return (reNum.test(num));
        }
    </script>
</head>
<body>
<br>

<div id="consoleDlg">
    <form class="layui-form te-left" action="/vote/createVote/firstStep" name="consoleForm" id="consoleForm">
        <div class="layui-form-item">
            <label class="layui-form-label">投票主题</label>
            <div class="layui-input-block" style="width: 340px">
                <input type="text" name="voteTitle" id="voteTitle" required="required" placeholder="请输入内容"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">选项个数</label>
            <div class="layui-input-block" style="width: 340px">
                <input type="number" id="voteSum" name="voteSum" required="required" class="layui-input" placeholder="请输入内容">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">截止时间</label>
            <div class="layui-input-block" style="width: 340px">
                <input type="text" name="time" id="time" required="required" class="layui-input"placeholder="点击选择时间">
            </div>
        </div>
    </form>
</div>
</body>
</html>
