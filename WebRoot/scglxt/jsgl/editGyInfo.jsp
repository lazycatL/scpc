<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
	<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/jsgl/editGyInfo.js"></script>
	 <div id='wrapper'>	
		<div class="row">
                <div class="col-sm-12">
                  <div class="box">
                    <div class="box-header">
                      <div class="title">
                         <div class="icon-edit"></div>
                        工艺管理
                      </div>
                      <div class="actions">
                        <a class="btn box-remove btn-xs btn-link" href="#"><i class="icon-remove"></i>
                        </a>
                        <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                        </a>
                      </div>
                    </div>
                    <div class="box-content box-no-padding">
	                      <form id="form_gyInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
		                        <div class='form-group'>
		                          <label class='control-label col-sm-3 col-sm-3' for='form_khxx_sszdd'>所属子订单</label>
		                          <div class='col-sm-4 controls'>
		                          <!-- data-rule-minlength='1' -->
		                            <input class='form-control' id='form_khxx_sszdd' info="fromInfo" name='form_khxx_sszdd'  placeholder='所属子订单' type='text'>
		                          </div>
		                        </div>
		                        <div class='form-group'>
		                          <label class='control-label col-sm-3 col-sm-3' for='form_khxx_gxbh'>工序编号</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_gxbh'  info="fromInfo" name='form_khxx_gxbh'  placeholder='工序编号' type='text'>
		                          </div>
		                        </div>
		                        <div class='form-group'>
		                          <label class='control-label col-sm-3 col-sm-3' for='form_khxx_gxsx'>工序顺序</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_gxsx'  info="fromInfo" name='form_khxx_gxsx'  placeholder='工序顺序' type='text'>
		                          </div>
		                        </div>
		                        <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_gxsysb'>工序使用设备</label>
		                          <div class='col-sm-4 controls'>
			                            <input class="form-control" id="form_khxx_gxsysb" info="fromInfo" name="form_khxx_gxsysb" type="text" placeholder='工序使用设备' 	/>
		                          </div>
		                        </div>
		                        <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_jgjs'>加工件数</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_jgjs'  info="fromInfo" name='form_khxx_jgjs' placeholder='加工件数' type='text'>
		                          </div>
		                        </div>
 		                        <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_bzid'>班组</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_bzid'  info="fromInfo" name='form_khxx_bzid' placeholder='班组' type='text'>
		                          </div>
		                        </div>
 		                        <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_ryid'>人员</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_ryid'  info="fromInfo" name='form_khxx_ryid' placeholder='人员' type='text'>
		                          </div>
		                        </div>
 		                        <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_ghjgs'>规划加工时</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_ghjgs' info="fromInfo" name='form_khxx_ghjgs' placeholder='规划加工时' type='text'>
		                          </div>
		                        </div>	
 		                        <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_jhstarttime'>计划开始时间</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_jhstarttime'  info="fromInfo" name='form_khxx_jhstarttime' placeholder='计划开始时间' type='text'>
		                          </div>
		                        </div>		
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_jhendtime'>计划结束时间</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_jhendtime' info="fromInfo" name='form_khxx_jhendtime' placeholder='计划结束时间' type='text'>
		                          </div>
		                        </div>	
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_gzlsfbh'>工作量是否饱和</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_gzlsfbh' info="fromInfo"  name='form_khxx_gzlsfbh' placeholder='工作量是否饱和' type='text'>
		                          </div>
		                        </div>	
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_gxtz'>工序图纸</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_gxtz' info="fromInfo" name='form_khxx_gxtz' placeholder='工序图纸' type='text'>
		                          </div>
		                        </div>			                        		                        
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_jggy'>加工工艺</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_jggy' info="fromInfo" name='form_khxx_jggy' placeholder='加工工艺' type='text'>
		                          </div>
		                          </div>
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_sfyjwc'>是否已经完成</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_sfyjwc' info="fromInfo" name='form_khxx_sfyjwc' placeholder='是否已经完成' type='text'>
		                          </div>
		                        </div>			                        		                        
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_ywcjs'>已完成件数</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_ywcjs' info="fromInfo" name='form_khxx_ywcjs' placeholder='已完成件数' type='text'>
		                          </div>
		                        </div>	
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_wcbfb'>完成百分比</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_wcbfb' info="fromInfo" name='form_khxx_wcbfb' placeholder='完成百分比' type='text'>
		                          </div>
		                        </div>			                        		                        
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_wcsj'>完成时间</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_wcsj' info="fromInfo" name='form_khxx_wcsj' placeholder='完成时间' type='text'>
		                          </div>
		                        </div>			                        		                        
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_jgmx'>加工时间明细</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_jgmx' info="fromInfo" name='form_khxx_jgmx' placeholder='加工时间明细' type='text'>
		                          </div>
		                        </div>			                        		                        
            		            <div class='form-group'>
		                          <label class='control-label col-sm-3' for='form_khxx_pjjggs'>完成百分比</label>
		                          <div class='col-sm-4 controls'>
		                            <input class='form-control'  id='form_khxx_pjjggs' info="fromInfo" name='form_khxx_pjjggs' placeholder='平均加工工时' type='text'>
		                          </div>
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