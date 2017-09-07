<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<head>
	<script type="text/javascript" src="../../js/util/commonFun.js"></script>
	<script>
	 		var flag =  getValueOfURLParamter("flag");
	 		$(document).ready(function() {
				initSbZd();
				if(flag==='edit'){
					var id = getValueOfURLParamter("id");
					initForm(id);
				}
				$("#cgsj").datepicker({format: 'yyyy-mm-dd hh:ii'});
				$("#wbjz").datepicker({format: 'yyyy-mm-dd hh:ii'});

                //返回按钮
                $("#form_return").click(function () {
                    var $outFrame = $(window.parent.document.body);
                    var $iframe = $outFrame.find("#mainIframe");
                    var src = $iframe.attr("src");
                    $iframe.attr('src', "scglxt/scgl/sbxxIndex.jsp");
                });
			} );
			
			function initForm(id){
				
				$.ajax({
				  type: "post",
				  url: "scglsb_getSbInfoById.action",
				  dataType: "json",
				  data:{
				  	"id":id
				  },
				  success:function(dt){
				  	
				  	$('#sbmc').val((dt[0].sbmc));
				  	$('#sblx').val((dt[0].sblx));
                    $('#sbxh').val((dt[0].sbxh));
				  	$('#cgsj').val((dt[0].cgsj));
				  	$('#wbjz').val((dt[0].bxjssj));
				  	$('#cfdd').val((dt[0].sbszd));
				  	$('#sbzt').val((dt[0].sbzt));
				  	$('#sbbz').val((dt[0].sbbz));
				  	$('#wxjl').val((dt[0].wxjl));
				  	$('#sccj').val((dt[0].sccj));
                    $('#ccbh').val((dt[0].ccbh));
				  	$('#sccjdetail').val((dt[0].SCCJDETAIL));
				  	$('#bz').val((dt[0].bz));
				  	
				  }
				}); 
			}
			
			function saveSbInfo(){
			
				if(flag==='edit'){
					
					var id = getValueOfURLParamter("id");
					$('#formAction').attr('action','scgl/scglsb_updateSbInfo.action?id='+id)
				}
				
				$("#formAction").submit();
				
			}
			
			function initSbZd(){
			
				$.ajax({
				  type: "post",
				  url: "scglsb_getSbZdInfo.action",
				  dataType: "json",
				  data:{
				  	"xh":'0101'
				  },
				  success:function(dt){
				  	
				  	for(var i = 0;i<dt.length;i++){
				  		var html = "<option value="+dt[i].id+">"+dt[i].mc+"</option>";
				  		$("#sblx").append(html);
				  	}
				  	
				  }
				}); 
				$.ajax({
				  type: "post",
				  url: "scglsb_getSBzInfo.action",
				  dataType: "json",
				  data:{
				  },
				  success:function(dt){
				  	
				  	for(var i = 0;i<dt.length;i++){
				  		var html = "<option value="+dt[i].id+">"+dt[i].mc+"</option>";
				  		$("#sbbz").append(html);
				  	}
				  	
				  }
				});
				$.ajax({
				  type: "post",
				  url: "scglsb_getSbZdInfo.action",
				  dataType: "json",
				  data:{
				  	"xh":'0102',
				  },
				  success:function(dt){
				  	
				  	for(var i = 0;i<dt.length;i++){
				  		var html = "<option value="+dt[i].id+">"+dt[i].mc+"</option>";
				  		$("#sbzt").append(html);
				  	}
				  	
				  }
				}); 
			}
	 	</script>
</head>

<div id='wrapper'>
	<div class="row">
		<div class="col-sm-12">
			<div class="box">

                <div class="box-header blue-background">
                    <button id="form_return" class="btn btn-success btn-sm">
                        <i class="icon-add"></i> 返回
                    </button>
					<div class="title">
						<div class="icon-edit"></div>
						设备
					</div>
				</div>
				<div class="box-content box-no-padding">
					<form class="form form-horizontal "
						style="margin-bottom: 0;" method="post" id="formAction" action="scpc/scglsb_addSbInfo.action"
						accept-charset="UTF-8">
						<input name="authenticity_token" type="hidden">
						<div class="form-group">
							<label class="col-md-2 control-label" for="">
								设备名称
							</label>
							<div class="col-md-3">
								<input class="form-control" name="sbmc" id="sbmc" placeholder="请输入设备名称"
									type="text">
							</div>
                            <label class="col-md-2 control-label" for="">
                                设备型号
                            </label>
                            <div class="col-md-3">
                                <input class="form-control" name="sbxh" id="sbxh" placeholder="设备型号"
                                       type="text">
                            </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" for="">
								设备类型
							</label>
							<div class="col-md-3">
								<select class='form-control' name="sblx" id='sblx'>
									
								</select>
							</div>
                            <label class="col-md-2 control-label" for="">
                                设备班组
                            </label>
                            <div class="col-md-3">
                                <select class='form-control' name="sbbz" id='sbbz'>

                                </select>
                            </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" for="">
								设备状态
							</label>
							<div class="col-md-3">
								<select class='form-control' name="sbzt" id='sbzt'>
									
								</select>
							</div>
                            <label class="col-md-2 control-label" >
                                设备详情
                            </label>
                            <div class="col-md-3">
                                <input class="form-control" name="sccjdetail" id="sccjdetail" placeholder="设备详情"
                                       type="text">
                            </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" for="">
								采购时间
							</label>
							<div class="col-md-3">
								<div class="input-append date form_datetime">
									<input name="cgsj" id="cgsj" readonly class="form-control"
										   placeholder="请选择采购时间" type="text">
								</div>
							</div>
                            <label class="col-md-2 control-label" for="">
                                维保截止
                            </label>

                            <div class="col-md-3">
                                <input class="form-control" name="wbjz" id="wbjz"
                                       placeholder="请选择维保截止时间" readonly type="text">
                            </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" for="">
								存放地点
							</label>
							<div class="col-md-3">
								<input class="form-control" name="cfdd" id="cfdd" placeholder="请输入存放地"
									type="text">
							</div>
                            <label class="col-md-2 control-label" for="">
                                维修记录
                            </label>
                            <div class="col-md-3">
                                <input class="form-control" name="wxjl" id="wxjl" placeholder="请输入维修记录"
                                       type="text">
                            </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" >
								生产厂家
							</label>
							<div class="col-md-3">
								<input class="form-control" name="sccj" id="sccj" placeholder="生产厂家"
									   type="text">
							</div>
                            <label class="col-md-2 control-label" for="">
                                出厂编号
                            </label>
                            <div class="col-md-3">
                                <input class="form-control" name="ccbh" id="ccbh" placeholder="出厂编号"
                                       type="text">
                            </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" for="">
								备注
							</label>
							<div class="col-md-3">
								<textarea class="form-control" name="bz" id="bz" placeholder="请输入备注信息"
									rows="3"></textarea>
							</div>
						</div>
						<div class="form-actions" style="margin-bottom: 0;">
							<div class="row">
								<div class="col-md-4 col-md-offset-3">
									<div class="btn btn-primary " onclick = "saveSbInfo()">
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