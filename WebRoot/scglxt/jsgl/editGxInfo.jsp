<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
	<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/util/validata.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/jsgl/editGxInfo.js"></script>
	 <div class="container-fluid">
		<div class="row">
                <div class="col-sm-12">
                  <div class="box">
                    <div class="box-header">
                      <div class="title">
                         <div class="icon-edit"></div>
                        工序信息
                      </div>
						<div id="form_return" class="btn btn-success btn-sm">
							<i class="icon-add"></i> 返回
						</div>
                    </div>
                    <div class="box-content box-no-padding">
	                      <form id="form_gxInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
		                        <div class='form-group'>
		                          <label class='control-label col-sm-3 col-sm-3' for='form_khxx_gymc'>工艺名称</label>
		                          <div class='col-sm-4 controls'>
		                          <!-- data-rule-minlength='1' -->
		                            <input class='form-control required' id='form_khxx_gymc' info="fromInfo" name='form_khxx_gxmc'  placeholder='工序名称' type='text'>
									  <label class="textInfo"></label>
		                          </div>
		                        </div>

		                        <div class='form-group'>
		                          <label class='control-label col-sm-3 col-sm-3' for='form_khxx_fzbz'>负责班组</label>
		                          <div class='col-sm-4 controls'>
									  <select class='form-control' id='form_khxx_fzbz'  info="fromInfo" name='form_khxx_fzbz' >
									  </select>
		                          </div>
		                        </div>
							  <div class='form-group'>
								  <label class='control-label col-sm-3 col-sm-3' for='form_khxx_sfwx'>是否外协</label>
								  <div class='col-sm-4 controls'>
									  <select class='form-control'  id='form_khxx_sfwx'  info="fromInfo" name='form_khxx_sfwx' >
										  <option value=""></option>
										  <option value="1">是</option>
										  <option value="0">否</option>
									  </select>
								  </div>

					             <div class='modal-footer'>

					                 <input id="btn_save" class="btn btn-primary"  type="button" value="保存">
					                 <button id="btn_saving" class='btn btn-default'  style="display:none;" type='button'>
					                  <i class="icon-1x icon-spinner icon-spin"></i>
					                   	保存中...
					                 </button>
					             </div>				                        		
		                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>