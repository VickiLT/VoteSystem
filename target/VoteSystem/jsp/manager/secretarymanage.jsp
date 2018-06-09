<%--
  Created by IntelliJ IDEA.
  User: sunwe
  Date: 2018/3/23
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jqGrid.bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/jqgird-table.css">
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-ui.js"></script>
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
                url: '/manage/secretaryManage/load',//请求数据的地址
                mtype: "POST",
                datatype: "json",
                colNames: ['用户编号', '用户名', '', '联系电话', '联系邮箱'],
                //jqgrid主要通过下面的索引信息与后台传过来的值对应
                colModel: [
                    {name: 'id', index: 'id', hidden:true,width: 0, key: true},
                    {
                        name: 'name', index: 'name',align: 'center', width: 200, editable: true,
                        editoptions: {size: "20", maxlength: "30"}
                    },
                    {name: 'password', index: 'password', align: 'center',width: 200,hidden:true},
                    {name: 'tel', index: 'tel',align: 'center', width: 230, editable: true},
                    {name: 'email', index: 'email',align: 'center', width: 230},

                ],
                width: "90%",
                autowidth:true,
                sortname: 'id',
                sortable: true,
                sortorder: 'asc',
                height: 300,
                shrinkToFit: true,

                //分页
                pager: 'pager',
                rowNum: 10,
                //rowList : [5,10,15],
                viewrecords: true,
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
                rownumbers: true,
                styleUI: 'Bootstrap',
            });

            $("#grid").jqGrid('navGrid', '#pager', {
                edit: false,
                del: true,
                search: false,
                refresh: true,
                add: true,
                addfunc: openDialog4Adding,
                delfunc: openDialog4Deleting,
                //editfunc: openDialog4Updating,
                alerttext: "请选择需要操作的数据行!",
                addtext: "添加",
                deltext: "删除",
                refreshtext:"刷新",
                navButtonAdd:{
                    buttonicon: false,
                }
//            edit:false,add:false,del:false,search:false,refresh:false

            }, {multipleSearch: true});

        })
        var openDialog4Adding = function () {
            layui.use(['layer'], function () {
                var layer = layui.layer;
                layer.open({
                    type: 2,
                    area: ['450px', '360px'],
                    shadeClose: false, //点击遮罩关闭
                    skin: 'layui-layer-rim',
                    closeBtn: 1,
                    content: 'usermanageconsoleDlg.jsp',
                    btn: ['取消', '添加'],
                    success: function (index, layero) {
                        var body = layer.getChildFrame('body', index);
                        //body.contents().find("#id").hide();
                        // alert(body.contents().find("#id"));
                    },
                    btn2: function (index, layero) {
                        //按钮【按钮2】的回调
                        addItem(index, layero);
                        return false;
                    }
                })
            })
        }
        var openDialog4Updating = function () {
            var selectedRowId = $("#grid").jqGrid("getGridParam", "selrow");
            //获得当前行各项属性
            var rowData = $("#grid").jqGrid("getRowData", selectedRowId);
            layui.use(['layer'], function () {
                var layer = layui.layer;
                layer.open({
                    type: 2,
                    area: ['400px', '360px'],
                    shadeClose: false, //点击遮罩关闭
                    skin: 'layui-layer-rim',
                    closeBtn: 1,
                    content: '/manage/secretaryManage/addConsoleDlg',
                    success: function (layero, index) {
                        var body = layer.getChildFrame('body', index);
                        var s = body.contents().find("#id");
                        body.contents().find("#id").val(rowData.id);
                        body.contents().find("#name").val(rowData.name);
                        body.contents().find("#password").val("***");
                        body.contents().find("#tel").val(rowData.tel);
                        body.contents().find("#email").val(rowData.email);
                        //body.contents().find("#id").attr("readOnly", "true");
                    },
                    btn: ['取消', '更新'],
                    btn2: function (index, layero) {
                        //按钮【按钮2】的回调
                        editItem(index, layero);
                        return false;
                    }
                })
            })
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
        var editItem = function (index, layero) {
//            var selectedRowId = $("#grid").jqGrid("getGridParam", "selrow");
//            //获得当前行各项属性
//            var rowData = $("#grid").jqGrid("getRowData", selectedRowId);
//            var params = {
//                "id": rowData.id,
//                "name": rowData.name,
//                "password": rowData.password,
//                "tel": rowData.tel,
//                "email": rowData.email,
//            };
            var flag = window["layui-layer-iframe" + index].validate();
            //var s = window["layui-layer-iframe" + index];
            if (flag == false) {

            } else {
                var params = window["layui-layer-iframe" + index].callbackdata();
                $.ajax({
                    url: "${basePath}/manage/secretaryManage/updateSecretary",
                    data: params,
                    dataType: "json",
                    cache: false,
                    success: function (data) {
//          alert("id-->" + response.id + "; message-->" + response.message);
                        if (data != null) {
                            var dataRow = {
                                id: data.id,
                                name: data.name,
                                password: data.password,
                                tel: data.tel,
                                email: data.email
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
            var selectedRowId = $("#grid").jqGrid("getGridParam", "selrow");
            //获得当前行各项属性
            var rowData = $("#grid").jqGrid("getRowData", selectedRowId);

            var params = {
                "id": rowData.id,
                "name": rowData.name,
                "password": rowData.password,
                "tel": rowData.tel,
                "email": rowData.email
            };

            $.ajax({
                url: "${basePath}/manage/secretaryManage/delete",
                data: params,
                dataType: "html",
                cache: false,
                success: function (id) {
                    $("#grid").jqGrid("delRowData", id);
                    jQuery("#grid").trigger("reloadGrid");
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
            } else
            //var s = window["layui-layer-iframe" + index];
            {
                var params = window["layui-layer-iframe" + index].callbackdata();
                $.ajax({
                    url: "${basePath}/manage/secretaryManage/createSecretary",
                    data: params,
                    dataType: "json",
                    cache: false,
                    success: function (data) {
                        /* alert("id123-->" + response.id + "; message-->" + response.message); */
                        if (data != null) {
                            if (data.message != null) {
                                alert("用户名已存在！");
                            } else {
                                var dataRow = {
                                    id: data.secretary.id,
                                    name: data.secretary.name,
                                    password: data.secretary.password,
                                    tel: data.secretary.tel,
                                    email: data.secretary.email
                                };
                                /*
                                 var srcrowid = $("#gridTable").jqGrid("getGridParam",
                                 "selrow");
                                 */

                                $("#grid").jqGrid("addRowData",
                                    data.secretary.id, dataRow, "last");    //将新行插入到末尾
                                jQuery("#grid").trigger("reloadGrid");
                                alert("添加成功!");
                                layer.close(index);
                            }
                        } else {
                            alert("添加失败");
                        }
                    },
                    error: function (textStatus, e) {
                        alert("系统ajax交互错误: " + textStatus);
                    }
                });
            }
        }
        var search = function () {
            var name = $("#name").val();
            $("#grid").jqGrid("setGridParam",
                {
                    url: "/manage/secretaryManage/search",
                    datatype: 'json',
                    postData: { //传递查询参数到后台
                        'name': name
                    },
                    page: 1
                }).trigger("reloadGrid");

        };
    </script>
</head>

<body>
<div style="margin-left: 10px">
    <c:if test="${sessionScope.identity!='admin'}">
        <a class="voteMain" href="/frame/toMain">投票主页
        </a>
    </c:if>
    >>秘书管理
<br>
<br>
<div>
    <div style="margin-bottom:15px">
        <form class="form-search form-inline" onsubmit="return false;">
            <div class="form-group">
                <label>用户名:</label>
                <input class="form-control input-medium search-query" type="text" name="name" id="name"placeholder="请输入用户名"/>
            </div>
            <button class="btn btn-primary" type="button" value="查询" id="searchBtn" onclick="search()">查询</button>
        </form>
    </div>
    <table id="grid"></table>
    <div id="pager"></div>
</div>
</div>
</body>
</html>
