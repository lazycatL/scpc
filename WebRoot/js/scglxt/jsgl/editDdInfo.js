/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法
 * @author mukun 20140507
 */
(function(){
	this.DdEditManage = (function(){
		var _t = this , 
		_flag  = "",//标志位 区分当前表单是add模式还是update模式
		/**
		 * 初始化表单信息
		 */
		init = function(){
			
			var _this = this ;
			//判断当前表单是新增还是更新模式
			var urlParam = new Object();
			urlParam = $.GetRequest();				
			var urlParam = new Object();
			urlParam = $.GetRequest();
			//加载合同列表
			loadSshtList();
			if(urlParam && urlParam.id){
				_this._flag = "UPDATE" ; 
				//如果是update模式 则加载初始化信息
				_this.initFormInfo(urlParam.id);
			}else{
				_this._flag = "ADD" ;
			}
			$.addRequiredLabel();
			$('#btn_save').live('click',function(e){
//				HtEditManage.saveFormInfo("ADD");
				e.stopPropagation();
				var tips = validata() ;
				if(tips == "" ){
					saveFormInfo(_this._flag,urlParam.id);
				}
			});
            //点击图纸上传按钮
            $("#form_khxx_tz").click(function(){
                $('#myModal').modal({
                    backdrop: false,
                    show: true
                });
            });
			$('#form_khxx_jhdate').datepicker({format: 'yyyy-mm-dd'});
			$('#form_khxx_planstarttime').datepicker({format: 'yyyy-mm-dd'});
			$('#form_khxx_planendtime').datepicker({format: 'yyyy-mm-dd'});
			$('#form_khxx_realstarttime').datepicker({format: 'yyyy-mm-dd'});
			$('#form_khxx_ckdate').datepicker({format: 'yyyy-mm-dd'});

			//注册表单返回按钮事件 。点击返回查询表格页面
			$("#form_return").click(function () {
				var $outFrame = $(window.parent.document.body);
				var $iframe = $outFrame.find("#mainIframe");
				var src = $iframe.attr("src");
				$iframe.attr('src', "scglxt/jsgl/ddManager.jsp");
			});
		},
		initFormInfo = function(id){
			var url = "ddInfo_getDetailInfo.action",successFun = function(data){
				if(data && data.length >0 ){
					var select = $('#form_ddInfo input[info="fromInfo"],#form_ddInfo select[info="fromInfo"]');
					//循环给表单赋值
					for (var i = 0; i < select.length; i++) {
						var s = select[i];
						var id = $(s).attr("id");
						id = id.split("_")[2];
						var key = id.toLowerCase();
						var value = eval("data[0]." + key);
						if(value == undefined){
							value = "";
						}
						for (var j in data[0]) {
							if (id.toLowerCase() == j) {
								$(s).attr("value", value);
								$(s).attr("title", value);
							}
						}
					}
				}
				
           }
           $.asyncAjax(url,{"id":id}, successFun, true);
		},
		/**
		 * 保存或者更改表单信息
		 */
		saveFormInfo = function(flag,id){
			if(flag == "ADD"){
				id = "" ; 
			}
			var formInfo = {
				ssht : $('#form_khxx_ssht').attr("value"),
				xmname : $('#form_khxx_xmname').attr("value"),
				ddlevel : $('#form_khxx_ddlevel').attr("value"),
				jhdate : $('#form_khxx_jhdate').attr("value"),
				planstarttime : $('#form_khxx_planstarttime').attr("value"),
				planendtime : $('#form_khxx_planendtime').attr("value"),
				//realstarttime : $('#form_khxx_realstarttime').attr("value"),
				//realendtime : $('#form_khxx_realendtime').attr("value"),
				//zgs : $('#form_khxx_zgs').attr("value"),
				//dqjd : $('#form_khxx_dqjd').attr("value"),
				tz : $('#form_khxx_xmname').attr("value"),
				xmlxr : $('#form_khxx_xmlxr').attr("value"),
				xmfzr : $('#form_khxx_xmfzr').attr("value"),
				//ckzt : $('#form_khxx_ckzt').attr("value"),
				//ckdate : $('#form_khxx_ckdate').attr("value"),
				remark : $('#form_khxx_remark').attr("value"),
				flag : flag, 
				id  : id 
			}
			var JSON = $.toJsonString(formInfo);
			var $save = $('#btn_save'), $saving = $('#btn_save');
            var url = "ddInfo_updateInfo.action", successFun = function(resStr){
				if (resStr == "SUCCESS") {
                	alert('保存成功!');
					$("#form_return").click();

				}
            }
            $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);		

		} , 
		/**
		 * 加载所属合同select 
		 */
		loadSshtList  = function(){
			var url = "htInfo_getTableData.action",successFun = function(data){
				if(data && data.data&& data.data.length >0 ){
					data = data.data ; 
					for(var i = 0 ; i < data.length; i++){
						$.AddSelectItem(data[i].mc, data[i].id, "form_khxx_ssht") ; 
					}
				}
           }
           $.syncAjax(url,{}, successFun, true);

            $.ajax({
                type: "post",
                url: "scgl_getRyZdInfo.action",
                dataType: "json",
                data: {
                    "xh": '04'
                },
                success: function (dt) {

                    for (var i = 0; i < dt.length; i++) {
                        var html = "<option value=" + dt[i].id + ">" + dt[i].mc + "</option>";
                        $("#form_khxx_ddlevel").append(html);
                    }

                }
            });
		}
		;
		return {
			init:init,
			initFormInfo : initFormInfo,
			saveFormInfo:saveFormInfo
		}
		
	})();
})();
$(document).ready(function(){
	DdEditManage.init();
});