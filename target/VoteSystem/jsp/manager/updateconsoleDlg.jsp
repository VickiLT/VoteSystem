<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/29
  Time: 12:50
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
    <script type="text/javascript" src="<%=path%>/js/dateFormat.js"></script>
    <style>
        .layui-form-label{
            width:25%;
            min-width:110px;
        }
        .layui-input-block{
            margin-left:35%;
            width:50%;
            min-width: 150px;;
        }
    </style>
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
            var startDate=(new Date()).Format("yyyy-MM-dd hh:00:00");
            var endDate = new Date();
            endDate.setFullYear(endDate.getFullYear()+1);
            endDate=endDate.Format("yyyy-MM-dd hh:00:00");
            $("#endTime").datetimepicker({
                format: 'y-m-d H:i:s',
                timepicker:true,
                defaultDate:startDate,
                startDate: startDate,
                minDate:startDate,
                maxDate:endDate
            });
            $.datetimepicker.setLocale('zh');
            $.datetimepicker.setLocale('zh');
        })
        var callbackdata = function () {
            var id = $("#id").val();
            var voteTitle = $("#voteTitle").val();
            var voteExplain = $("#voteExplain").val();
            var endTime = $("#endTime").val();
            var isCheckResults = $("#isCheckResults").val();
            var isModifyVote = $("#isModifyVote").val();
            var data = {
                id: id,
                voteTitle: voteTitle,
                voteExplain: voteExplain,
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
            if (params.voteExplain== "") {
                alert("投票描述不能为空！")
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
            <div class="layui-input-block">
                <input type="text" name="voteTitle" id="voteTitle" required="required"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">投票描述</label>
            <div class="layui-input-block">
                <textarea name="voteExplain" id="voteExplain" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">截止时间</label>
            <div class="layui-input-block">
                <input type="text" name="endTime" id="endTime" required="required" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">允许修改</label>
            <div class="layui-input-block">
                <select name="isModifyVote" id="isModifyVote" lay-verify="required">
                    <option value="false" selected="selected">不可修改</option>
                    <option value="true">可修改</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">允许查看结果</label>
            <div class="layui-input-block">
                <select name="isCheckResults" id="isCheckResults" lay-verify="required" >
                    <option value="false" selected="selected">不可查看</option>
                    <option value="true">可查看</option>
                </select>
            </div>
        </div>
    </form>
</div>
</body>
</html>