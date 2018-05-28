<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/14
  Time: 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-ui.js"></script>
    <script type="text/javascript" src="<%=path%>/js/grid.locale-cn.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="<%=path%>/layui/layui.js"></script>
    <style type="text/css">

        ul.tabs {
            margin: 0;
            padding: 0;
            float: left;
            list-style: none;
            height: 32px;
            border-bottom: 1px solid #999;
            border-left: 1px solid #999;
            width: 100%;
        }

        ul.tabs li {
            float: left;
            margin: 0;
            padding: 0;
            height: 31px;
            line-height: 31px;
            border: 1px solid #999;
            border-left: none;
            margin-bottom: -1px;
            background: #e0e0e0;
            overflow: hidden;
            position: relative;
        }

        ul.tabs li a {
            text-decoration: none;
            color: #000;
            display: block;
            font-size: 1.2em;
            padding: 0 20px;
            border: 1px solid #fff;
            outline: none;
        }

        ul.tabs li a:hover {
            background: #ccc;
        }

        html ul.tabs li.active, html ul.tabs li.active a:hover {
            background: #fff;
            border-bottom: 1px solid #fff;
        }

        .tab_container {
            border: 1px solid #999;
            border-top: none;
            clear: both;
            float: left;
            width: 100%;
            background: #fff;
            -moz-border-radius-bottomright: 5px;
            -khtml-border-radius-bottomright: 5px;
            -webkit-border-bottom-right-radius: 5px;
            -moz-border-radius-bottomleft: 5px;
            -khtml-border-radius-bottomleft: 5px;
            -webkit-border-bottom-left-radius: 5px;
        }

        .tab_content {
            padding: 20px;
            font-size: 1.2em;
        }

        .tab_content h2 {
            font-weight: normal;
            padding-bottom: 10px;
            border-bottom: 1px dashed #ddd;
            font-size: 1.8em;
        }

        .tab_content h3 a {
            color: #254588;
        }

        .searForm {
            font-size: 12pt;
        }
    </style>
    <script type="text/javascript">
        $.ajaxSetup({
            complete: function (xhr, status) {
                //拦截器实现超时跳转到登录页面
                // 通过xhr取得响应头
                var REDIRECT = xhr.getResponseHeader("REDIRECT");
                //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                if (REDIRECT == "REDIRECT") {
                    var win = window;
                    while (win != win.top) {
                        win = win.top;
                    }
                    //重新跳转到 login.html
                    var s = xhr.getResponseHeader("CONTEXTPATH");
                    win.location.href = xhr.getResponseHeader("CONTEXTPATH");
                }
                if(REDIRECT == "REDIRECT1"){
                    var s =  xhr.getResponseHeader("CONTEXTPATH");
                    window.location.href = xhr.getResponseHeader("CONTEXTPATH");
                }
            }
        });
        $(document).ready(function () {
            //Default Action
            $(".tab_content").hide(); //Hide all content
            $("ul.tabs li:first").addClass("active").show(); //Activate first tab
            $(".tab_content:first").show(); //Show first tab content

            //On Click Event
            $("ul.tabs li").click(function () {
                $("ul.tabs li").removeClass("active"); //Remove any "active" class
                $(this).addClass("active"); //Add "active" class to selected tab
                $(".tab_content").hide(); //Hide all tab content
                var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
                $(activeTab).fadeIn(); //Fade in the active content
                return false;
            });
            $("#grid").jqGrid({
                url: '/vote/voteProject/tab1Load',//请求数据的地址
                datatype: "json",
                colNames: ['投票编号', '投票主题', '创建时间', '截止时间', '投票状态', '投票类型', '投票', '', ''],
                //jqgrid主要通过下面的索引信息与后台传过来的值对应
                colModel: [
                    {name: 'id', index: 'id', width: 100, key: true},
                    {
                        name: 'voteTitle', index: 'name', width: 200, editable: true,
                        editoptions: {size: "20", maxlength: "30"},formatter:formattitle
                    },
                    {name: 'createTime', index: 'createTime', width: 200},
                    {name: 'endTime', index: 'endTime', width: 200, editable: true},
                    {name: 'isClose', index: 'isClose', width: 100, formatter: formatclose, unformat: unformatclose},
                    {name: 'voteMode', index: 'voteMode', width: 100, formatter: formatvode, unformat: unformatvode},
                    {name: 'vote', width: 80, align: 'center', sortable: false},
                    {name: 'isCheckResults', hidden: true},
                    {name: 'isModifyVote', hidden: true}
                ],
                caption: "投票",
                sortname: 'createTime',
                sortable: true,
                sortorder: 'desc',
                height: 270,
                shrinkToFit: true,
                autowidth:true,
                gridComplete: function () {
                    var ids = $("#grid").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var id = ids[i];
                        var rowData = $("#grid").jqGrid('getRowData', id);
                        var isClose = rowData.isClose;
                        var isCheckResults = rowData.isCheckResults;
                        var isModifyVote = rowData.isModifyVote;
                        var identity = "${sessionScope.identity}";
                        if (isClose == "false") {
                            vote = "<a href='javascript:return false;' style='opacity: 0.2'>投票</a>"
                        }else {
                            vote = "<a href='/vote/showVoteDetails?id=" + id + "' style='color:#f60'>投票</a>"; //这里的onclick就是调用了上面的javascript函数 Modify(id)
                        }
                        jQuery("#grid").jqGrid('setRowData', ids[i], {vote: vote, checkResults: checkResults});
                    }
                },

                //分页
                pager: 'pager',
                rowNum: 10,
                viewrecords: true,
                //rowList : [5,10,15],
                jsonReader: {
                    root: "list", // json中代表实际模型数据的入口
                    records: "total", // json中代表数据行总数的数据
                    page: "pageNum", // json中代表当前页码的数据
                    total: "pages", // json中代表页码总数的数据
                    repeatitems: false
                },
                autoScroll: true,
                cellEdit: false,
                multiselect: false,
                rownumbers: false
            });

            $("#grid").jqGrid('navGrid', '#pager', {

                edit: false, add: false, del: false, search: false, refresh: false

            });
            /**tab2**/
            $("#grid1").jqGrid({
                url: '/vote/voteProject/tab2Load',//请求数据的地址
                datatype: "json",
                colNames: ['投票编号', '投票主题', '创建时间', '截止时间', '投票状态', '投票类型', '投票', '查看结果', '', ''],
                //jqgrid主要通过下面的索引信息与后台传过来的值对应
                colModel: [
                    {name: 'id', index: 'id', width: 100, key: true,sortable:false},
                    {
                        name: 'voteTitle', index: 'name', width: 200, editable: true,
                        editoptions: {size: "20", maxlength: "30"},sortable:false,formatter:formattitle
                    },
                    {name: 'createTime', index: 'createTime', width: 200},
                    {name: 'endTime', index: 'endTime', width: 200, editable: true},
                    {name: 'isClose', index: 'isClose', width: 100, formatter: formatclose, unformat: unformatclose,sortable:false},
                    {name: 'voteMode', index: 'voteMode', width: 100, formatter: formatvode, unformat: unformatvode,sortable:false},
                    {name: 'vote', width: 80, align: 'center', sortable: false},
                    {name: 'checkResults', width: 80, align: 'center', sortable: false},
                    {name: 'isCheckResults', hidden: true,sortable:false},
                    {name: 'isModifyVote', hidden: true,sortable:false}
                ],
                width: 1060,
                caption: "投票",
                sortname: 'createTime',
                sortable: true,
                sortorder: 'desc',
                height: 270,
                shrinkToFit: true,
                gridComplete: function () {
                    var ids = $("#grid1").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var id = ids[i];
                        var rowData = $("#grid1").jqGrid('getRowData', id);
                        var isClose = rowData.isClose;
                        var isCheckResults = rowData.isCheckResults;
                        var isModifyVote = rowData.isModifyVote;
                        var identity = "${sessionScope.identity}";
                        if (identity == "manager") {
                            checkResults = "<a href='/vote/showVoteResults?id=" + id + "' style='color:#f60'>查看结果</a>"
                        } else if (isClose == "false") {
                            if (isCheckResults == "true") {
                                checkResults = "<a href='/vote/showVoteResults?id=" + id + "' style='color:#f60'>查看结果</a>"
                            } else {
                                checkResults = "<a href='javascript:return false;' style='opacity: 0.2'>查看结果</a>";
                            }
                        } else {
                            checkResults = "<a href='javascript:return false;' style='opacity: 0.2'>查看结果</a>";
                        }
                        if (isClose == "false") {
                            vote = "<a href='javascript:return false;' style='opacity: 0.2'>投票</a>"
                        } else {
                            vote = "<a href='/vote/showVoteDetails?id=" + id + "' style='color:#f60'>投票</a>"; //这里的onclick就是调用了上面的javascript函数 Modify(id)
                        }
                        jQuery("#grid1").jqGrid('setRowData', ids[i], {vote: vote, checkResults: checkResults});
                    }
                },

                //分页
                pager: 'pager1',
                rowNum: 10,
                viewrecords: true,
                //rowList : [5,10,15],
                jsonReader: {
                    root: "list", // json中代表实际模型数据的入口
                    records: "total", // json中代表数据行总数的数据
                    page: "pageNum", // json中代表当前页码的数据
                    total: "pages", // json中代表页码总数的数据
                    repeatitems: false
                },
                autoScroll: true,
                cellEdit: false,
                multiselect: false,
                rownumbers: false
            });

            $("#grid1").jqGrid('navGrid', '#pager', {

                edit: false, add: false, del: false, search: false, refresh: false

            });
        })
        var formatvode = function (cellvalue, options, rowObject) {
            if (cellvalue == false)
                return '单选';
            else
                return '多选';
        }
        var unformatvode = function (cellvalue, options, rowObject) {
            if (cellvalue == "单选")
                return "false";
            else
                return "true";
        }
        var formatclose = function (cellvalue, options, rowObject) {
            if (cellvalue == false)
                return "已关闭";
            else
                return "开放";
        }
        var unformatclose = function (cellvalue, options, rowObject) {
            if (cellvalue == "已关闭")
                return "false";
            else
                return "true";

        }
        var formattitle = function (cellvalue, options, rowObject) {
            var id = rowObject.id;
            return "<a href='/vote/showVoteProjectDetails?id=" + id + "' style='text-decoration:none;out-line:none'>"+cellvalue+"</a>";
        }

        var vote = function (id) {
            window.location.href = "vote/showVoteDetails?id=" + id;
        }
        var checkResults = function (id) {
            window.location.href = 'vote/showVoteResults?id=' + id;
        }
        var search = function () {
            var voteTitle = $("#voteTitle").val();
            var voteMode = $("#voteMode").val();
            var isClose = $("#isClose").val();

            $("#grid").jqGrid("setGridParam",
                {
                    url: "/vote/search",
                    datatype: 'json',
                    postData: { //传递查询参数到后台
                        'search_title': voteTitle,
                        'search_mode': voteMode,
                        'search_close':isClose
                    },
                    page: 1
                }).trigger("reloadGrid");

        };
        var search1 = function () {
            var voteTitle = $("#voteTitle1").val();
            var voteMode = $("#voteMode1").val();
            var isClose = $("#isClose1").val();

            $("#grid1").jqGrid("setGridParam",
                {
                    url: "/vote/search1",
                    datatype: 'json',
                    postData: { //传递查询参数到后台
                        'search_title': voteTitle,
                        'search_mode': voteMode,
                        'search_close':isClose
                    },
                    page: 1
                }).trigger("reloadGrid");

        };
    </script>
</head>

<body>
<div style="margin-left: 10px">
<a href="/frame/toMain">投票主页
</a>>>>投票
<br>
<div class="container">

    <ul class="tabs">
        <li class="active"><a href="#tab1">未投的投票事项</a></li>
        <li><a href="#tab2">已投的投票事项</a></li>
    </ul>
    <div class="tab_container">
        <div id="tab1" class="tab_content" style="display: block; ">
            <div  style="margin-bottom:10px">
                <form onsubmit="return false;" class="searForm">
                    投票标题:<input name="voteTitle" id="voteTitle"/>&nbsp;
                    投票类型:
                    <select name="voteMode" id="voteMode">
                        <option value="false" selected="selected">单选</option>
                        <option value="true">多选</option>
                    </select>&nbsp;
                    投票状态:
                    <select name="isClose" id="isClose">
                        <option value="false">关闭</option>
                        <option value="true">开放</option>
                    </select>&nbsp;
                    <button type="button" value="查询" id="searchBtn" onclick="search()">查询</button>
                </form>
            </div>
            <table id="grid"></table>
            <div id="pager"></div>

        </div>

        <div id="tab2" class="tab_content" style="display: none; ">
            <div>
                <form onsubmit="return false;" class="searForm">
                    投票标题:<input name="voteTitle" id="voteTitle1"/>&nbsp;
                    投票类型:
                    <select name="voteMode" id="voteMode1">
                        <option value="false" selected="selected">单选</option>
                        <option value="true">多选</option>
                    </select>&nbsp;
                    投票状态:
                    <select name="isClose" id="isClose1">
                        <option value="false">关闭</option>
                        <option value="true">开放</option>
                    </select>&nbsp;
                    <button type="button" value="查询" id="searchBtn1" onclick="search1()">查询</button>
                </form>
            </div>
            <table id="grid1"></table>
            <div id="pager1"></div>
        </div>
    </div>

</div>
<br>
</div>
</body>
</html>