<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<head>
	<script type="text/javascript" src="../../js/util/commonFun.js"></script>
	<script>
	 		var flag =  getValueOfURLParamter("flag");
	 		$(document).ready(function() {
				if(flag==='edit'){
					var id = getValueOfURLParamter("id");
					initForm(id);
				}				
			} );
			
			function initForm(id){
				
				$.ajax({
				  type: "post",
				  url: "scglbz_getBzInfoById.action",
				  dataType: "json",
				  data:{
				  	"id":id,
				  },
				  success:function(dt){
				  	
				  	$('#bzmc').val((dt[0].bzmc));
				  	$('#bzfzr').val((dt[0].bzfzr));
				  	
				  }
				}); 
			}
			
			function saveBzInfo(){
			
				if(flag==='edit'){
					
					var id = getValueOfURLParamter("id");
					$('#formAction').attr('action','${pageContext.request.contextPath}/scglbz_updateBzInfo.action?id='+id);
				}
				
				$("#formAction").submit();
				/*
				if(flag===''){
					//添加
					$.ajax({
					  type: "post",
					  url: "scgl_addBzInfo.action",
					  dataType: "json",
					  data:{
					  	"bzmc" : $('#bzmc').val(),
						"bzfzr" : $('#bzfzr').val()
					  }
					  
					}); 
				}else{//修正
				
					var id = getValueOfURLParamter("id");
					$.ajax({
					  type: "post",
					  url: "scgl_updateSbInfo.action",
					  dataType: "json",
					  data:{
					  	"bzid" : id,
					  	"bzmc" : $('#bzmc').val(),
						"bzfzr" : $('#bzfzr').val()
					  }
					  
					}); 
				}*/
			}
	 	</script>
</head>

<div id='wrapper'>
	<div class="row">
		<div class="col-sm-12">
			<div class="box">
				<div class="box-header blue-background">
					<div class="title">
						<div class="icon-edit"></div>
						班组
					</div>
					<div class="actions">
						<a class="btn box-remove btn-xs btn-link" href="#"><i
							class="icon-remove"></i> </a>

						<a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a>
					</div>
				</div>
				<div class="box-content box-no-padding">
					<form id="formAction" class="form form-horizontal form-striped"
						style="margin-bottom: 0;" method="post" action="${pageContext.request.contextPath}/scglbz_addBzInfo.action"
						accept-charset="UTF-8">
						<input name="authenticity_token" type="hidden">
						<div class="form-group">
							<label class="col-md-3 control-label" for="inputText2">
								班组名称
							</label>
							<div class="col-md-6">
								<input class="form-control required" name="bzmc" id="bzmc" placeholder="请输入班组名称"
									type="text">
                                <label class="textInfo"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label" for="inputPassword1">
								负责人
							</label>
							<div class="col-md-6">
								<input class="form-control required" name="bzfzr" id="bzfzr" placeholder="请输入负责人"
									type="text">
                                <label class="textInfo"></label>
							</div>
						</div>
						
						<div class="form-actions" style="margin-bottom: 0;">
							<div class="row">
								<div class="col-md-6 col-md-offset-3">
									<div class="btn btn-primary" onclick = "saveBzInfo()">
										<i class="icon-save" ></i> 保存
									</div>
								</div>
							</div>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
</div>