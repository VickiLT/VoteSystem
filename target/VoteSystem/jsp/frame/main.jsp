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
            ʱ����Ϣ
        </td>
    </tr>
    <tr>
        <td bgcolor="#ffffff">
            ���ڵ�ʱ���ǣ�<br><br>
            <%
                java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ��
                String strdate = formatter.format(currentTime); //������ʱ���ʽ��
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
            ͳ����Ϣ
        </td>
    </tr>
    <tr>
        <td bgcolor="#ffffff">
            <p>
                Ŀǰ����
                <span class="STYLE2">
						<STRONG>${sum}</STRONG>
					    </span>
                �����ŵ�ͶƱ����
            </p>
            <p>
                ��ѡͶƱ���У�
                <span class="STYLE2">
						<STRONG>${singleSum}</STRONG>
					    </span>
            </p>
            <p>
                ��ѡͶƱ���У�
                <span class="STYLE2">
						<STRONG>${multiSum}</STRONG>
					    </span>
            </p>
            <p>
                ����ͶƱ���У�
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
