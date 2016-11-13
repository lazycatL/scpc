<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>

	<head>
		<link rel="stylesheet" href="../../js/jquery_ui/jquery-ui.css"
			type="text/css"></link>
		<!-- 引用select2样式 -->
		<link type="text/css"
			href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css"
			media="all" rel="stylesheet" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
			
			<script type="text/javascript">
				$(function(){
					
					$("#isallday").click(function(){
						if($("#sel_start").css("display")=="none"){
							$("#sel_start,#sel_end").show();
						}else{
							$("#sel_start,#sel_end").hide();
						}
					});
					
					$("#isend").click(function(){
						if($("#p_endtime").css("display")=="none"){
							$("#p_endtime").show();
						}else{
							$("#p_endtime").hide();
						}
						$.fancybox.resize();//调整高度自适应
					});
					
					//提交表单
					$('#add_form').ajaxForm({
						beforeSubmit: showRequest, //表单验证
				        success: showResponse //成功返回
				    }); 
					
					//删除事件
					$("#del_event").click(function(){
						if(confirm("您确定要删除吗？")){
							var eventid = $("#eventid").val();
							$.post("do.php?action=del",{id:eventid},function(msg){
								if(msg==1){//删除成功
									$.fancybox.close();
									$('#calendar').fullCalendar('refetchEvents'); //重新获取所有事件数据
								}else{
									alert(msg);	
								}
							});
						}
					});
				});
			
				function showRequest(){
					var events = $("#event").val();
					if(events==''){
						alert("请输入日程内容！");
						$("#event").focus();
						return false;
					}
				}
			
				function showResponse(responseText, statusText, xhr, $form){
					if(statusText=="success"){	
						if(responseText==1){
							$.fancybox.close();
							$('#calendar').fullCalendar('refetchEvents'); //重新获取所有事件数据
						}else{
							alert(responseText);
						}
					}else{
						alert(statusText);
					}
				}
			</script>
	</head>
	<div class="fancy">
		<h3>
			新建任务
		</h3>
		<form id="add_form" action="do.php?action=add" method="post">
			<p>
				选择任务：
				<input type="text" class="input" name="event" id="event"
					style="width: 320px" placeholder="新建任务">
			</p>
			<p>
				开始时间：
				<input type="text" class="input datepicker" name="startdate"
					id="startdate" value="" readonly>
				<span id="sel_start" style="display: none"><select
						name="s_hour">
						<option value="00">
							00
						</option>
						<option value="01">
							01
						</option>
						<option value="02">
							02
						</option>
						<option value="03">
							03
						</option>
						<option value="04">
							04
						</option>
						<option value="05">
							05
						</option>
						<option value="06">
							06
						</option>
						<option value="07">
							07
						</option>
						<option value="08" selected>
							08
						</option>
						<option value="09">
							09
						</option>
						<option value="10">
							10
						</option>
						<option value="11">
							11
						</option>
						<option value="12">
							12
						</option>
						<option value="13">
							13
						</option>
						<option value="14">
							14
						</option>
						<option value="15">
							15
						</option>
						<option value="16">
							16
						</option>
						<option value="17">
							17
						</option>
						<option value="18">
							18
						</option>
						<option value="19">
							19
						</option>
						<option value="20">
							20
						</option>
						<option value="21">
							21
						</option>
						<option value="22">
							22
						</option>
						<option value="23">
							23
						</option>
					</select>: <select name="s_minute">
						<option value="00" selected>
							00
						</option>
						<option value="10">
							10
						</option>
						<option value="20">
							20
						</option>
						<option value="30">
							30
						</option>
						<option value="40">
							40
						</option>
						<option value="50">
							50
						</option>
					</select> </span>
			</p>
			<p id="p_endtime" style="display: none">
				结束时间：
				<input type="text" class="input datepicker" name="enddate"
					id="enddate" value="" readonly>
				<span id="sel_end" style="display: none"><select
						name="e_hour">
						<option value="00">
							00
						</option>
						<option value="01">
							01
						</option>
						<option value="02">
							02
						</option>
						<option value="03">
							03
						</option>
						<option value="04">
							04
						</option>
						<option value="05">
							05
						</option>
						<option value="06">
							06
						</option>
						<option value="07">
							07
						</option>
						<option value="08">
							08
						</option>
						<option value="09">
							09
						</option>
						<option value="10">
							10
						</option>
						<option value="11">
							11
						</option>
						<option value="12" selected>
							12
						</option>
						<option value="13">
							13
						</option>
						<option value="14">
							14
						</option>
						<option value="15">
							15
						</option>
						<option value="16">
							16
						</option>
						<option value="17">
							17
						</option>
						<option value="18">
							18
						</option>
						<option value="19">
							19
						</option>
						<option value="20">
							20
						</option>
						<option value="21">
							21
						</option>
						<option value="22">
							22
						</option>
						<option value="23">
							23
						</option>
					</select>: <select name="e_minute">
						<option value="00" selected>
							00
						</option>
						<option value="10">
							10
						</option>
						<option value="20">
							20
						</option>
						<option value="30">
							30
						</option>
						<option value="40">
							40
						</option>
						<option value="50">
							50
						</option>
					</select> </span>
			</p>
			<p>
				<label>
					<input type="checkbox" value="1" id="isallday" name="isallday"
						checked>
					全天
				</label>
				<label>
					<input type="checkbox" value="1" id="isend" name="isend">
					结束时间
				</label>
			</p>
			<div class="sub_btn">
				<input type="submit" class="btn btn_ok" value="确定">
				<input type="button" class="btn btn_cancel" value="取消"
					onClick="$.fancybox.close()">
			</div>
		</form>
	</div>