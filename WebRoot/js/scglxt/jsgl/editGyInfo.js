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
			var url = "gyInfo_getDetailInfo.action",successFun = function(data){
				console.log(data);
				if(data && data.length >0 ){
					var select = $('#form_gyInfo input[info="fromInfo"]');
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
				sszdd : $('#form_khxx_sszdd').attr("value"),
				gxbh : $('#form_khxx_gxbh').attr("value"),
				gxsx : $('#form_khxx_gxsx').attr("value"),
				gxsysb : $('#form_khxx_gxsysb').attr("value"),
				jgjs : $('#form_khxx_jgjs').attr("value"),
				bzid : $('#form_khxx_bzid').attr("value"),
				ryid : $('#form_khxx_ryid').attr("value"),
				ghjgs : $('#form_khxx_ghjgs').attr("value"),
				jhstarttime : $('#form_khxx_jhstarttime').attr("value"),
				jhendtime : $('#form_khxx_jhendtime').attr("value"),
				gzlsfbh : $('#form_khxx_gzlsfbh').attr("value"),
				gxtz : $('#form_khxx_gxtz').attr("value"),
				jggy : $('#form_khxx_jggy').attr("value"),
				sfyjwc : $('#form_khxx_sfyjwc').attr("value"),
				ywcjs : $('#form_khxx_ywcjs').attr("value"),
				wcbfb : $('#form_khxx_wcbfb').attr("value"),
				wcsj : $('#form_khxx_wcsj').attr("value"),
				jgmx : $('#form_khxx_jgmx').attr("value"),
				pjjggs : $('#form_khxx_pjjggs').attr("value"),
				flag : flag
			}
			var JSON = $.toJsonString(formInfo);
			var $save = $('#btn_save'), $saving = $('#btn_save');
            var url = "gyInfo_updateInfo.action", successFun = function(resStr){
                if (resStr == "SUCCESS") {
                	alert('success');
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
