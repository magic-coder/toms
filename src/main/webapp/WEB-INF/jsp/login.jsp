<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>登录</title>
    <style>
        * {
            padding: 0px;
            margin: 0px;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: url(<%= basePath %>images/grass1.jpg);
            position: absolute;
            width: 100%;
            height: 100%;
            font-size: 13px;

        }

        img {
            border: 0;
        }

        .lg {
            width: 468px;
            height: 468px;
            margin: 100px auto;
            background: url(<%= basePath %>images/login_bg.png) no-repeat;
        }

        .lg_top {
            height: 200px;
            width: 468px;
        }

        .lg_main {
            width: 400px;
            height: 180px;
            margin: 0 25px;
        }

        .lg_m_1 {
            width: 290px;
            height: 100px;
            padding: 60px 55px 20px 55px;
        }

        .ur {
            height: 37px;
            border: 0;
            color: #666;
            width: 236px;
            margin: 4px 28px;
            background: url(<%= basePath %>/images/user.png) no-repeat;
            padding-left: 10px;
            font-size: 16pt;
            font-family: Arial, Helvetica, sans-serif;
        }

        .pw {
            height: 37px;
            border: 0;
            color: #666;
            width: 236px;
            margin: 4px 28px;
            background: url(<%= basePath %>/images/password.png) no-repeat;
            padding-left: 10px;
            font-size: 16pt;
            font-family: Arial, Helvetica, sans-serif;
        }

        .bn {
            width: 330px;
            height: 72px;
            background: url(<%= basePath %>/images/enter.png) no-repeat;
            border: 0;
            display: block;
            font-size: 18px;
            color: #FFF;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bolder;
        }

        .lg_foot {
            height: 80px;
            width: 330px;
            padding: 6px 68px 0 68px;
        }
    </style>
</head>

<body class="b">
<div class="lg">
    <form action="<c:url value="/login_process"/>" method="POST">
        <div class="lg_top"></div>
        <div class="lg_main">
            <div class="lg_m_1">

                <p style="color: red;padding-left:25px;">${param.error==true?"用户名或密码错误！":""}${param.msg==true?"登录超时请重新登录！":""}</p>
                <input name="username" value="" placeholder="用户名" class="ur"/>
                <input name="password" type="password" value="" placeholder="密码" class="pw"/>


            </div>
        </div>
        <div class="lg_foot">
            <input type="submit" value="登 录" class="bn"/></div>
    </form>
</div>
<div style="text-align:center;">
    <%--<p>来源:<a href="http://www.mycodes.net/" target="_blank">源码之家</a></p>--%>
</div>
</body>
</html>
