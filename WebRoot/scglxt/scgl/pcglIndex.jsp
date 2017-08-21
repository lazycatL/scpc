<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<!--引入样式-->
		<link rel="stylesheet" href="../../js/plugin/fancybox/fancybox.css" type="text/css"></link>
		<link rel="stylesheet" href="../../js/plugin/fancybox/fullcalendar.css" type="text/css"></link>
		<!-- 引入当前界面样式 -->
		<style type="text/css">
		  	#calendar{width:960px; margin:20px auto 10px auto}
			.fancy{width:450px; height:auto}
			.fancy h3{height:30px; line-height:30px; border-bottom:1px solid #d3d3d3; font-size:14px}
			.fancy form{padding:10px}
			.fancy p{height:28px; line-height:28px; padding:4px; color:#999}
			.input{height:20px; line-height:20px; padding:2px; border:1px solid #d3d3d3; width:100px}
			.btn{-webkit-border-radius: 3px;-moz-border-radius:3px;padding:5px 12px; cursor:pointer}
			.btn_ok{background: #360;border: 1px solid #390;color:#fff}
			.btn_cancel{background:#f0f0f0;border: 1px solid #d3d3d3; color:#666 }
			.btn_del{background:#f90;border: 1px solid #f80; color:#fff }
			.sub_btn{height:32px; line-height:32px; padding-top:6px; border-top:1px solid #f0f0f0; text-align:right; position:relative}
			.sub_btn .del{position:absolute; left:2px}
		</style>
		<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
		<script type="text/javascript" src="../../js/jquery_ui/jquery-ui.min.js"></script>
		<script type="text/javascript" src="../../js/plugin/fancybox/fullcalendar.min.js"></script>
		<script type="text/javascript" src="../../js/plugin/fancybox/jquery.fancybox-1.3.1.pack.js"></script>
		<script type="text/javascript">
		$(function() {
			/**
				定义排产管理的日历插件
			***/
			$('#div_pcgl').fullCalendar({
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
				},
				events: 'pcgl_getPcInfo.action',
				//点击没有任务的空白处
				dayClick: function(date, allDay, jsEvent, view) {
					var selDate =$.fullCalendar.formatDate(date,'yyyy-MM-dd');
					$.fancybox({
						'type':'ajax',
						'href':''
					});
		    	},
				//点击有排产任务的内容
				eventClick: function(calEvent, jsEvent, view) {
					$.fancybox({
						'type':'ajax',
						'href':'event.php?action=edit&id='+calEvent.id
					});
		    	}
			});
			
		});
		</script>
	</head>
	<body>
		<div id="sxParams">
			<!---->
		</div>
		<div id="pcgl" style="width:1060px">
		   <div id='div_pcgl'></div>
		</div>
	</body>
</html>