<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>	
  <head>
   <link href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/stylesheets/light-theme.css" media="all" id="color-settings-body-color" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/stylesheets/theme-colors.css" media="all" id="color-settings-body-color" rel="stylesheet" type="text/css" />

      <!-- bootstrap Datatables样式引入 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/datatablesExtends/dataTables.bootstrap.css" type="text/css"></link>
  	 <!-- bootstrap 时间插件样式 -->
 	<link href="${pageContext.request.contextPath}/js/plugin/bootstrap_datetimepicker/css/bootstrap-datetimepicker.min.css" media="all" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap-datepicker/css/datepicker.css" type="text/css"></link>
	<!-- fullcalendar插件样式 -->
   	<link href="${pageContext.request.contextPath}/stylesheets/plugins/fullcalendar/fullcalendar.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/scglxt/main.css" type="text/css"></link>
      <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheets/default.css" type="text/css"></link>--%>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-migrate.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.js" type="text/javascript"></script>

      <script src="${pageContext.request.contextPath}/js/theme.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/util/CommonUtils.js" type="text/javascript"></script>    
  	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/datatables/jquery.dataTables.js"></script>
  	<!--集成bootstap的datablesJS-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/datatablesExtends/dataTables.bootstrap.js"></script>
  	<script src="${pageContext.request.contextPath}/js/plugin/bootstrap-datepicker/js/bootstrap-datepicker.js" type="text/javascript"></script>
  	<script src="${pageContext.request.contextPath}/js/plugin/bootstrap_datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
  	<script src="${pageContext.request.contextPath}/js/plugin/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js" type="text/javascript"></script>
    <!-- 控制主页面左侧及头部导航、控制收缩空间 -->
    <script src="${pageContext.request.contextPath}/js/util/Cookies.js"></script>
    <%--<script src="${pageContext.request.contextPath}/js/plugin/fullcalendar/fullcalendar.min.js"--%>
            <%--type="text/javascript"></script>--%>
     <script src="${pageContext.request.contextPath}/js/scglxt/index.js" type="text/javascript"></script>
    <style>
        body{
            font-family: "微软雅黑";
        }
        #content {
            /* margin-left: 251px; */
            background: #fbfbfb;
            min-width: 276px;
            height: 100%;
            background: #fbfbfb;
        }
        #user{
            padding-right:200px;
        }
        #datetime{
             padding-right:150px;
         }
        #exit a{
            color:white;
        }
        #tip_message {
            z-index: 9999;
            position: fixed;
            left: 0;
            top: 40%;
            text-align: center;
            width: 100%;
        }

        #tip_message span {
            background-color: #03C440;
            opacity: .8;
            padding: 20px 50px;
            border-radius: 5px;
            text-align: center;
            color: #fff;
            font-size: 20px;
        }

        #tip_message span.error {
            background-color: #EAA000;
        }
    </style>

</html>
