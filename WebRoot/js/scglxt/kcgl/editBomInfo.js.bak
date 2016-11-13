/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法
 * 没有保存操作 ，每次保存时候对相应的bomid 进行删除 然后进行保存
 * @author mukun 20140507
 */
(function(){
	this.BomEditManage = (function(){
		var _t = this , 
		_flag  = "",//标志位 区分当前表单是add模式还是update模式
		/**
		 * 初始化表单信息
		 */
		init = function(){
			var _this = this ;			
			//返回按钮
			$("#form_return").click(function(){
				var $outFrame =  $(window.parent.document.body) ; 
				var $iframe = $outFrame.find("#mainIframe");
				var src = $iframe.attr("src");
				$iframe.attr('src',"scglxt/jsgl/BomManager.jsp");
			});			
			$('#btn_save').live('click',function(){
				saveFormInfo(_this._flag);
			});
			$("#btn-calculateValume").on("click",function(e){
				alert("") ;
				console.log(that) ;
			});
			registerEvent();
			var urlParam = new Object();
			urlParam = $.GetRequest();
			if(urlParam && urlParam.id){
				_this._flag = "UPDATE" ; 
				//如果是update模式 则加载初始化信息
				_this.initFormInfo(urlParam.id);
			}else{
				_this._flag = "ADD" ;
			}			
		},
		/**
		 * 注册事件
		 */
		registerEvent = function(){
			var that = this ;
			$("#form_return").on('click',function(){
				Main.swapIframUrl('scglxt/jsgl/bomManager.jsp');//跳转iframe页面
			})

		},		
		initFormInfo = function(id){
			var url = "ddInfo_getDetailInfo.action",successFun = function(data){
				console.log(data);
				if(data && data.length >0 ){
					var select = $('#form_ddInfo input[info="fromInfo"]');
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
								console.log(id);
								console.log(value);
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
		saveFormInfo = function(flag){
			var formInfo = {
				ssht : $('#form_khxx_ssht').attr("value"),
				xmname : $('#form_khxx_xmname').attr("value"),
				ddlevel : $('#form_khxx_ddlevel').attr("value"),
				jhdate : $('#form_khxx_jhdate').attr("value"),
				planstarttime : $('#form_khxx_planstarttime').attr("value"),
				planendtime : $('#form_khxx_planendtime').attr("value"),
				realstarttime : $('#form_khxx_realstarttime').attr("value"),
				realendtime : $('#form_khxx_realendtime').attr("value"),
				zgs : $('#form_khxx_zgs').attr("value"),
				dqjd : $('#form_khxx_dqjd').attr("value"),
				tz : $('#form_khxx_tz').attr("value"),
				xmlxr : $('#form_khxx_xmlxr').attr("value"),
				xmfzr : $('#form_khxx_xmfzr').attr("value"),
				ckzt : $('#form_khxx_ckzt').attr("value"),
				ckdate : $('#form_khxx_ckdate').attr("value"),
				remark : $('#form_khxx_remark').attr("value"),
				flag : flag
			}
			var JSON = $.toJsonString(formInfo);
			var $save = $('#btn_save'), $saving = $('#btn_save');
            var url = "ddInfo_updateInfo.action", successFun = function(resStr){
                if (resStr == "SUCCESS") {
                	alert('保存成功！');
                }
            }
            $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);		

		},
		/**
		 * 加载相应子订单的工艺过程
		 */
		loadGygcList = function(bomid){
            var url = "ddInfo_loadGygcList.action", successFun = function(resStr){
                if (resStr == "SUCCESS") {
                	alert('保存成功！');
                }
            }
            $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);		
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
//	});
	BomEditManage.init();
});