/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法
 * @author mukun 20140507
 */
(function(){
	this.HtEditManage = (function(){
		var _t = this , 
		/**
		 * 初始化表单信息
		 */
		init = function(){
			$('#btn_save').live('click',function(){
//				HtEditManage.saveFormInfo("ADD");
				saveFormInfo("ADD");
			});
		},
		initFormInfo = function(id){
			var url = "gxInfo_getDetailInfo.action",successFun = function(data){
				console.log(data);
				if(data && data.length >0 ){
					var select = $('#form_gxInfo input[info="fromInfo"]');
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
		saveFormInfo = function(flag){
			var formInfo = {
				gxmc : $('#form_khxx_gxmc').attr("value"),
				gxdh : $('#form_khxx_gxdh').attr("value"),
				fzbz : $('#form_khxx_fzbz').attr("value"),
				gxsx : $('#form_khxx_gxsx').attr("value"),
				flag : flag
			}
			var JSON = $.toJsonString(formInfo);
			var $save = $('#btn_save'), $saving = $('#btn_save');
            var url = "gxInfo_updateInfo.action", successFun = function(resStr){
                if (resStr == "SUCCESS") {
                	alert('保存成功');
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
	HtEditManage.init();
	HtEditManage.initFormInfo('1');
})();
