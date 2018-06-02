<%@ page contentType="text/html; charset=GBK" %>
<%@page isELIgnored="false" %>
<% String path=request.getContextPath();
    /*String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";*/
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/whole.css">
    <style type="text/css">

        table{
            width: 50%;
            min-width: 300px;
            font-size: 20px;
            text-align: center;
            background-color: #354457;
            margin: 50px;
        }
        table tr td{
            padding:5px;
        }

        .STYLE2 {
            color: #aa0036;
        }

        -->
    </style>
</head>
<body>
<center>
<table width="35%">
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td bgcolor="#d6dff7" align="center">
            时间信息
        </td>
    </tr>
    <tr>
        <td bgcolor="#ffffff">
            现在的时间是：<br><br>
            <%
                java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                java.util.Date currentTime = new java.util.Date();//得到当前系统时间
                String strdate = formatter.format(currentTime); //将日期时间格式化
            %>
            <%= strdate%>
            <br>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td bgcolor="#d6dff7" align="center">
            统计信息
        </td>
    </tr>
    <tr>
        <td bgcolor="#ffffff">
            <p>
                目前共有
                <span class="STYLE2">
						<STRONG>${sum}</STRONG>
					    </span>
                个开放的投票主题
            </p>
            <p>
                单选投票共有：
                <span class="STYLE2">
						<STRONG>${singleSum}</STRONG>
					    </span>
            </p>
            <p>
                多选投票共有：
                <span class="STYLE2">
						<STRONG>${multiSum}</STRONG>
					    </span>
            </p>
            <p>
                排序投票共有：
                <span class="STYLE2">
						<STRONG>${sortSum}</STRONG>
					    </span>
            </p>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>
</center>
</body>
</html>
