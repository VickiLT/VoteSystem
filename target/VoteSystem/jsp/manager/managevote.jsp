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
    <script type="text/javascript" src="<%=path%>/js/grid.locale-cn.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="<%=path%>/layui/layui.js"></script>
    <script type="text/javascript">
        $.ajaxSetup({
            complete : function(xhr,status) {
                //拦截器实现超时跳转到登录页面
                // 通过xhr取得响应头
                var REDIRECT = xhr.getResponseHeader("REDIRECT");
                //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                if (REDIRECT == "REDIRECT")
                {
                    var win = window;
                    while (win != win.top)
                    {
                        win = win.top;
                    }
                    //重新跳转到 login.html
                    var s =  xhr.getResponseHeader("CONTEXTPATH");
                    win.location.href = xhr.getResponseHeader("CONTEXTPATH");
                }
                if(REDIRECT == "REDIRECT1"){
                    var s =  xhr.getResponseHeader("CONTEXTPATH");
                    window.location.href = xhr.getResponseHeader("CONTEXTPATH");
                }
            }
        });
        $(document).ready(function () {
            $("#grid").jqGrid({
                url: '/vote/voteProject/load',//请求数据的地址
                datatype: "json",
                colNames: ['投票编号', '投票主题', '创建时间', '截止时间', '投票状态', '投票类型'],
                //jqgrid主要通过下面的索引信息与后台传过来的值对应
                colModel: [
                    {name: 'id', index: 'id', width: 100, key: true},
                    {
                        name: 'voteTitle', index: 'name', width: 300, editable: true, title:false,
                        editoptions: {size: "20", maxlength: "30"},formatter:formattitle
                    },
                    {name: 'createTime', index: 'createTime', width: 200},
                    {name: 'endTime', index: 'endTime', width: 200, editable: true},
                    {name: 'isClose', index: 'isClose', width: 130, formatter: formatclose, unformat: unformatclose},
                    {name: 'voteMode', index: 'voteMode', width: 130, formatter: formatvode, unformat: unformatvode}
                ],
                width: 1060,
                caption: "投票项目管理",
                sortname: 'id',
                sortable: true,
                sortorder: 'asc',
                height: 300,
                shrinkToFit: true,

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
                rownumbers: true
            });

            $("#grid").jqGrid('navGrid', '#pager', {
                edit: true,
                del: true,
                search: false,
                refresh: true,
                add: true,
                addfunc: openDialog4Adding,
                delfunc: openDialog4Deleting,
                editfunc: openDialog4Updating,
                alerttext: "请选择需要操作的数据行!"
//            edit:false,add:false,del:false,search:false,refresh:false

            });

        })
        var openDialog4Adding = function () {
            layui.use(['layer'], function () {
                var layer = layui.layer;
                layer.open({
                    type: 2,
                    area: ['400px', '360px'],
                    shadeClose: true, //点击遮罩关闭
                    closeBtn: 1,
                    content: '/vote/consoleDlg',
                    btn: ['取消', '下一步'],
                    btn2: function (index, layero) {
                        //按钮【按钮2】的回调
                        addItem(index, layero);
                        return false;
                    }
                })
            })
        }
        var formatvode = function (cellvalue, options, rowObject) {
            if (cellvalue == false)
                return "单选";
            else
                return "多选";
        }
        var unformatvode = function (cellvalue, options, rowObject) {
            if (cellvalue == "单选")
                return false;
            else
                return true;
        }
        var openDialog4Updating = function () {
            var selectedRowId = $("#grid").jqGrid("getGridParam", "selrow");
            //获得当前行各项属性
            var rowData = $("#grid").jqGrid("getRowData", selectedRowId);

            var params = {
                "id": rowData.id
            };
            $.ajax({
                url: "${basePath}/vote/toUpdate",

                data: params,
                dataType: "json",
                cache: false,
                success: function (data) {
//          alert("id-->" + response.id + "; message-->" + response.message);
                    if (data != null) {
                        var dataRow = {
                            id: data.id,
                            voteTitle: data.voteTitle,
                            endTime: data.endTime,
                            isCheckResults: data.isCheckResults,
                            isModifyVote: data.isModifyVote
                        };
                        layui.use(['layer'], function () {
                            var layer = layui.layer;
                            layer.open({
                                type: 2,
                                area: ['400px', '300px'],
                                shadeClose: true, //点击遮罩关闭
                                skin: 'layui-layer-rim',
                                closeBtn: 1,
                                content: '/vote/updateConsoleDlg',
                                success: function (layero, index) {
                                    var body = layer.getChildFrame('body', index);
                                    body.contents().find("#id").val(rowData.id);
                                    body.contents().find("#voteTitle").val(dataRow.voteTitle);
                                    body.contents().find("#endTime").val(dataRow.endTime);
//                                    if(dataRow.isCheckResults == true){
//                                        var select = 'dd[lay-value=' + dataRow.isCheckResults + ']';
//                                        body.contents().find("#isCheckResults").siblings("div.layui-form-select").find('dl').find(select).click();
//                                    }
//                                    if(dataRow.isModifyVote == true){
//                                        var select = 'dd[lay-value=' + dataRow.isModifyVote + ']';
//                                        body.contents().find("#isModifyVote").siblings("div.layui-form-select").find('dl').find(select).click();
//                                    }
                                    body.contents().find("#isCheckResults").find('option[value='+dataRow.isCheckResults+']').attr('selected','selected');
                                    body.contents().find("#isModifyVote").find('option[value='+dataRow.isModifyVote+']').attr('selected','selected');
//
                                },
                                btn: ['取消', '更新'],
                                btn2: function (index, layero) {
                                    //按钮【按钮2】的回调
                                    editItem(index,layero);
                                    return false;
                                }
                            })
                        })
                       // $("#grid").jqGrid("setRowData", id, dataRow);
                    } else {
                        alert("获取数据失败!");
                    }
                },
                error: function (textStatus, e) {
                    alert("系统ajax交互错误: " + textStatus);
                }
            });

            // loadSelectedRowData();
        };
        var openDialog4Deleting = function () {
            var consoleDlg = $("#consoleDlg");
            layui.use(['layer'], function () {
                var layer = layui.layer;
                layer.alert('', {
                    icon: 2, title: '删除确认', content: '您确定要删除这条记录吗？', closeBtn: 1
                }, function (index) {
                    //business logic
                    deleteItem();
                    layer.close(index);
                });
            })

        };
        var loadSelectedRowData = function () {
            // 当前选中的行
            var selectedRowId = $("#grid").jqGrid("getGridParam", "selrow");
            //获得当前行各项属性
            var rowData = $("#grid").jqGrid("getRowData", selectedRowId);

            if (!selectedRowId) {
                alert("请先选择需要编辑的行!");
                return false;
            } else {
                var consoleDlg = $("#consoleDlg");
                consoleDlg.find("#id").val(rowData.id);
                consoleDlg.find("#voteTitle").val(rowData.voteTitle);
                consoleDlg.find("#createTime").val(rowData.createTime);
                consoleDlg.find("#endTime").val(rowData.endTime);
                consoleDlg.find("#isClose").val(rowData.isClose);
                consoleDlg.find("#voteMode").val(rowData.voteMode);
            }
        }
        var editItem = function (index,layero) {
            var flag = window["layui-layer-iframe" + index].validate();
            if (flag == false) {

            } else {
                var params = window["layui-layer-iframe" + index].callbackdata();
                $.ajax({
                    url: "${basePath}/vote/update",
                    data: params,
                    dataType: "json",
                    cache: false,
                    success: function (data) {
//          alert("id-->" + response.id + "; message-->" + response.message);
                        if (data!=null) {
                            var dataRow = {
                                id: data.id,
                                voteTitle: data.voteTitle,
                                endTime: data.endTime
                            };

                            /*
                             var srcrowid = $("#gridTable").jqGrid("getGridParam",
                             "selrow");
                             */

                            //将表格中对应记录更新一下
                            $("#grid").jqGrid("setRowData", data.id, dataRow);
                            alert("修改成功!");
                            layer.close(index);
                        } else {
                            alert("修改失败!");
                        }
                    },
                    error: function (textStatus, e) {
                        alert("系统ajax交互错误: " + textStatus);
                    }
                });
            }
        }
        var deleteItem = function () {
            var consoleDlg = $("#consoleDlg");
            var selectedRowId = $("#grid").jqGrid("getGridParam", "selrow");
            //获得当前行各项属性
            var rowData = $("#grid").jqGrid("getRowData", selectedRowId);

            var params = {
                "id": rowData.id,
                "voteTitle": rowData.voteTitle,
                "createTime": rowData.createTime,
                "endTime": rowData.endTime,
                "isClose": rowData.isClose,
                "voteMode": rowData.voteMode
            };

            $.ajax({
                url: "${basePath}/vote/delete",
                data: params,
                dataType: "html",
                cache: false,
                success: function (id) {
                    $("#grid").jqGrid("delRowData", id);
                    alert("删除成功!");
                },
                error: function (textStatus, e) {
                    alert("系统ajax交互错误: ");
                }
            })
        }
        var addItem = function (index, layero) {
            var flag = window["layui-layer-iframe" + index].validate();
            if (flag == false) {

            } else {
                var params = window["layui-layer-iframe" + index].callbackdata();
                window.location.href = 'createVote/firstStep?time=' + params.time + '&voteTitle=' + params.voteTitle + '&voteMode=' + params.voteMode + '&voteSum=' + params.voteSum;
            }
        }
        var formatvode = function (cellvalue, options, rowObject) {
            if (cellvalue == false)
                return '单选';
            else
                return '多选';
        }
        var formattitle = function (cellvalue, options, rowObject) {
            var id = rowObject.id;
            return "<a href='/vote/showVoteProjectDetails?id=" + id + "' style='text-decoration:none;out-line:none' title='点击查看投票详情'>"+cellvalue+"</a>";
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
        var search = function () {
            var voteTitle = $("#voteTitle").val();
            var voteMode = $("#voteMode").val();
            var isClose = $("#isClose").val();

            $("#grid").jqGrid("setGridParam",
                {
                    url: "/vote/manageVote/search",
                    datatype: 'json',
                    postData: { //传递查询参数到后台
                        'search_title': voteTitle,
                        'search_mode': voteMode,
                        'search_close': isClose,
                    },
                    page: 1
                }).trigger("reloadGrid");

        };
    </script>
</head>

<body>
<div style="margin-left: 10px">
<a href="/frame/toMain">投票主页
</a>>>>管理投票
<br>
<br>
<div>
    <div style="margin-bottom:10px">
        <form onsubmit="return false;">
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
    <div id="main">
        <table id="grid"></table>
        <div id="pager"></div>
        <div id="popupFormDiv" style="display:none;"></div>
    </div>
</div>
</div>
</body>
</html>

