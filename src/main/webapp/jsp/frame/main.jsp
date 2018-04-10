<%@ page contentType="text/html; charset=GBK" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <style type="text/css">
        <!--
        body {
            background-color: #ccc;
        }

        a {
            font-size: 12pt;
            text-decoration: none
        }

        .STYLE2 {
            color: #2A00AA
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
        <td bgcolor="#d6dff7">
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
                其中
            </p>
            <p>
                单选投票共有:
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
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>
</center>
</body>
</html>
