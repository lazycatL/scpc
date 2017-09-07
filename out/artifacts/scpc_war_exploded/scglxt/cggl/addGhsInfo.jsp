<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
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
				  url: "cggl_getGhsInfoById.action",
				  dataType: "json",
				  data:{
				  	"id":id,
				  },
				  success:function(dt){
				  	
				  	$('#spmc').val((dt[0].spmc));
				  	$('#gsmc').val((dt[0].gsmc));
				  	$('#gsdz').val((dt[0].gsdz));
				  	$('#lxr').val((dt[0].lxr));
				  	$('#lxfs').val((dt[0].lxfs));
				  }
				}); 
			}
			
			function saveGhsInfo(){
			
				if(flag==='edit'){
					
					var id = getValueOfURLParamter("id");
					$('#formAction').attr('action','${pageContext.request.contextPath}/cggl_updateGhsInfo.action?id='+id);
				}
				
				$("#formAction").submit();
				/*if(flag===''){
					//添加
					$.ajax({
					  type: "post",
					  url: "cggl_addGhsInfo.action",
					  dataType: "json",
					  data:{
				  		"spmc":$('#spmc').val(),
			  			"gsmc":$('#gsmc').val(),
			  			"gsdz":$('#gsdz').val(),
			  			"lxr":$('#lxr').val(),
			  			"lxfs":$('#lxfs').val()
					  }
					  
					}); 
				}else{//修正
				
					var id = getValueOfURLParamter("id");
					$.ajax({
					  type: "post",
					  url: "cggl_updateGhsInfo.action",
					  dataType: "json",
					  data:{
					  	"id" : id,
					  	"spmc":$('#spmc').val(),
			  			"gsmc":$('#gsmc').val(),
			  			"gsdz":$('#gsdz').val(),
			  			"lxr":$('#lxr').val(),
			  			"lxfs":$('#lxfs').val()
					  }
					  
					}); 
				}*/
			}
	 	</script>
	 <div id='wrapper'>	
		<div class="row">
                <div class="col-sm-12">
                  <div class="box">
                    <div class="box-header blue-background">
                      <div class="title">
                        <div class="icon-edit"></div>
                        	供货商
                      </div>
                      <div class="actions">
                        <a class="btn box-remove btn-xs btn-link" href="#"><i class="icon-remove"></i>
                        </a>
                        
                        <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                        </a>
                      </div>
                    </div>
                    <div class="box-content box-no-padding">
                  <form class="form form-horizontal form-striped" style="margin-bottom: 0;" method="post" id="formAction" action="${pageContext.request.contextPath}/cggl_addGhsInfo.action" accept-charset="UTF-8"><input name="authenticity_token" type="hidden">
                  	
                      <div class="form-group">
                        <label class="col-md-3 control-label" for="inputPassword1">公司名称</label>
                        <div class="col-md-6">
                         <input class="form-control" name="gsmc" id="gsmc" placeholder="请输入公司名称" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-md-3 control-label" for="inputTextArea2">公司地址</label>
                        <div class="col-md-6">
                            <input class="form-control" name="gsdz" id="gsdz" placeholder="请输入公司地址" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-md-3 control-label" for="disabledInput2">联系人</label>
                        <div class="col-md-6">
                          <input class='form-control' name="lxr" data-rule-number='true' data-rule-required='true' id='lxr' name='validation_numbers' placeholder='请输入联系人姓名、主要负责事项' type='text'>
                        </div>
                      </div>
                      <div class="form-group">
                      <label class="col-md-3 control-label" for="disabledInput2">联系方式</label>
                        <div class="col-md-6">
                          <input class='form-control' data-rule-number='true' data-rule-required='true' name="lxfs" id='lxfs' name='validation_numbers' placeholder='请输入联系人联系方式' type='text'>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-md-3 control-label" for="inputText2">供应商品描述</label>
                        <div class="col-md-6">
                          <input class="form-control" name="spms" id="spmc" placeholder="请对供应商品描述" type="text">
                        </div>
                      </div>
                      <div class="form-actions" style="margin-bottom: 0;">
                        <div class="row">
                          <div class="col-md-6 col-md-offset-3">
                            <div class="btn btn-primary btn-lg" onclick = "saveGhsInfo()">
                              <i class="icon-save"></i>
                              		保存
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