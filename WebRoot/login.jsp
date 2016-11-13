<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
    <title>登陆</title>
    <link href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.css" media="all" rel="stylesheet"
          type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.js"
            type="text/javascript"></script>
    <style>
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #eee;
        }

        .form-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }

        .form-signin .checkbox {
            font-weight: normal;
        }

        .form-signin .form-control {
            position: relative;
            height: auto;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            padding: 10px;
            font-size: 16px;
        }

        .form-signin .form-control:focus {
            z-index: 2;
        }

        .form-signin input[type="email"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

    </style>
</head>
<body>
<div class="container">

    <form class="form-signin" action="${pageContext.request.contextPath}/login.action" method="post">
        <h2 class=" qform-signin-heading">生产排产系统－登陆</h2>

        <div class="form-group">
            <label for="username">用户名</label>
            <input type="name" name="username" class="form-control" id="username" placeholder="用户名">
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" name="password" class="form-control" id="password" placeholder="密码">
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
        <span class="span_message"><% if (request.getAttribute("message") != null) {%>
                	<%=request.getAttribute("message")%>
                	<%} %>
                </span>
    </form>

</div>
</body>
</html>

