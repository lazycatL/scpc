<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
	<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/util/validata.js" type="text/javascript"></script>
  <%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/jsgl/editBomInfo.js"></script>--%>
	 <div id='wrapper'>	
		<div class="row">
                <div class="col-sm-12">
                  <div class="box">
                    <div class="box-header">
						<button id="form_return" class="btn btn-success btn-sm">
							<i class="icon-add"></i> 返回
						</button>                     
                      <div class="title">
                         <div class="icon-edit"></div>
                        材料管理
                      </div>

                    </div>


					  <div class="box-content box-no-padding">
	                      <form id="form_bomInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
							  <div class='form-group'>
								  <input style="display:none;" id='form_cl_id' info="fromInfo" name='id'
										  type='text'>
								  <label class='control-label col-sm-2' for='form_cl_clmc'>材料名称</label>
								  <div class='col-sm-3 controls'>
									  <input class='form-control required' id='form_cl_clmc' info="fromInfo" name='clmc'
											 placeholder='材料名称' type='text'>
									  <label class="textInfo"></label>
								  </div>
                                  <label class='control-label col-sm-2' for='form_cl_clcz'>材料材质</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_clcz' info="fromInfo" name='clcz'
                                             placeholder='材料材质' type='text'>
                                  </div>
							  </div>
							  <div class='form-group'>
								  <label class='control-label col-sm-2' for='form_cl_clsl'>材料数量</label>
								  <div class='col-sm-3 controls'>
									  <input class='form-control' id='form_cl_clsl' info="fromInfo" name='clsl'
											 placeholder='材料数量' type='text'>
								  </div>
								  <span style="color:red;float: left;">块</span>

                                  <label class='control-label col-sm-2' for='form_cl_cldj' style="margin-left: -13px;">材料单价</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_cldj' info="fromInfo" name='cldj'
                                             placeholder='材料单价' type='text'>
                                  </div>
                                  <span style="color:red">元/克</span>
							  </div>
							  <div class='form-group'>
								  <label class='control-label col-sm-2' for='form_cl_cllx'>材料类型</label>
								  <div class='col-sm-3 controls'>
									  <input class='form-control' id='form_cl_cllx' info="fromInfo" name='cllx'
											 placeholder='材料等级' type='text'>
								  </div>
                                  <label class='control-label col-sm-2' for='form_cl_ghs'>供货商</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_ghs' info="fromInfo" name='ghs'
                                             placeholder='供货商' type='text'>
                                  </div>
							  </div>
							  <div class='form-group'>
                                  <label class='control-label col-sm-2' for='form_cl_clxz'>材料性质</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_clxz' info="fromInfo" name='clxz'
                                             placeholder='材料性质' type='text'>
                                  </div>
                                  <label class='control-label col-sm-2' for='form_cl_clly'>材料来源</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_clly' info="fromInfo" name='clly'
                                             placeholder='材料来源' type='text'>
                                  </div>

							  </div>

							  <div class='form-group'>
                                  <label class='control-label col-sm-2' for='form_cl_mi'>密度</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_mi' info="fromInfo" name='mi'
                                             placeholder='密度' type='text'>
                                  </div>
                                  <span style="color:red;float: left;">克/立方厘米</span>
								  <label class='control-label col-sm-2' for='form_cl_cd' style="margin-left: -63px;">长度</label>
								  <div class='col-sm-3 controls'>
									  <input class='form-control' id='form_cl_cd' info="fromInfo" name='cd'
											 placeholder='长度' type='text'>
								  </div>
								   <span style="color:red;float: left;">厘米</span>

							  </div>
							  <div class='form-group'>

								  <label class='control-label col-sm-2' for='form_cl_kd'>宽度</label>
								  <div class='col-sm-3 controls'>
									  <input class='form-control' id='form_cl_kd' info="fromInfo" name='kd'
											 placeholder='宽度' type='text'>
								  </div>
								   <span style="color:red;float: left;">厘米</span>
                                  <label class='control-label col-sm-2' for='form_cl_gd' style="margin-left: -23px;">高度</label>
                                  <div class='col-sm-3 controls'>
                                      <input class='form-control' id='form_cl_gd' info="fromInfo" name='gd'
                                             placeholder='高度' type='text'>
                                  </div>
                                  <span style="color:red">厘米</span>
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

<script>
	/**
	 * 默认的配置js 用来初始化导入js以及其他初始化方法
	 * 没有保存操作 ，每次保存时候对相应的bomid 进行删除 然后进行保存
	 */
	(function () {
		this.ClEditManage = (function () {
			var _t = this,
					_flag = "",//标志位 区分当前表单是add模式还是update模式
					/**
					 * 初始化表单信息
					 */
					init = function () {
						var _this = this;
						//返回按钮
						$("#form_return").click(function () {
							var $outFrame = $(window.parent.document.body);
							var $iframe = $outFrame.find("#mainIframe");
							var src = $iframe.attr("src");
							$iframe.attr('src', "scglxt/kcgl/clManage.jsp");
						});
						$.addRequiredLabel();
						$('#btn_save').on('click', function (e) {
							e.stopPropagation();
							var tips = validata();
							if(tips == ""){
								saveFormInfo(_this._flag);
							}
						});
						$("#form_bomInfo_clxz").on("change", function (e) {
							if ($(this).val() == 1) {
								$("#form_bomInfo_cldx_jx").removeAttr("hidden");
								$("#form_bomInfo_cldx_yx").attr("hidden", true);
							} else {
								$("#form_bomInfo_cldx_jx").attr("hidden", true);
								$("#form_bomInfo_cldx_yx").removeAttr("hidden");
							}
						});
						registerEvent();
						var urlParam = new Object();
						urlParam = $.GetRequest();
						if (urlParam && urlParam.id) {
							_this._flag = "UPDATE";
							//如果是update模式 则加载初始化信息
							_this.initFormInfo(urlParam.id);
						} else {
							_this._flag = "ADD";
						}

					},
					/**
					 * 注册事件
					 */
					registerEvent = function () {
						var that = this;
						$("#form_return").on('click', function () {
							Main.swapIframUrl('scglxt/kcgl/clManage.jsp');//跳转iframe页面
						})

					},
					initFormInfo = function (id) {
						var url = "kcgl_getDetailInfo.action", successFun = function (data) {
							if (data && data.length > 0) {
								var select = $('#form_bomInfo input[info="fromInfo"]');
								//循环给表单赋值
								for (var i = 0; i < select.length; i++) {
									var s = select[i];
									var id = $(s).attr("id");
									id = id.split("_")[2];
									var key = id.toLowerCase();
									var value = eval("data[0]." + key);
									if (value == undefined) {
										value = "";
									}
									for (var j in data[0]) {
										if (id.toLowerCase() == j) {
											$(s).val(value);
											$(s).attr("title", value);
										}
									}
								}
							}

						}
						$.asyncAjax(url, {"id": id}, successFun, true);
					},
					/**
					 * 保存或者更改表单信息
					 */
					saveFormInfo = function (flag) {
						var formInfo = {
							flag: flag
						}
						var JSON = $.toJsonString(formInfo);
						var $save = $('#btn_save'), $saving = $('#btn_save');
						var url = "kcgl_updateInfo.action?flag=" + flag, successFun = function (resStr) {
							if (resStr == "SUCCESS") {
                                Main.ShowSuccessMessage('保存成功！');
								$("#form_return").click();
							}
						}
						//$.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
						$.asyncAjaxPost(url, $('#form_bomInfo').serialize(), successFun, true);

					}


					;
			return {
				init: init,
				initFormInfo: initFormInfo,
				saveFormInfo: saveFormInfo,
			}

		})();
	})();
	$(document).ready(function () {
		ClEditManage.init();
	});


</script>