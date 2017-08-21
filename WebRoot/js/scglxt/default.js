/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法

 * @author mukun 20140507
 */
(function(){
	var _t = this,
	//导入js文件 ，后续在init导入js文件
	_oninit = function(e){
		//jquery
		_include("js/jQuery/jquery-1.7.1.min.js");	
//		_include("js/jQuery/jquery-1.7.1.js");
		//easyui	
		_include("js/jQuery/easyui/jquery.easyui.min.js");	
		_include("js/jQuery/easyui/locale/easyui-lang-zh_CN.js");	
		_include("js/jQuery/zTree/js/jquery.ztree.all-3.1.js");	
		//引入的flatty的核心js ，源码有改动
		_include("js/jQuery/Flatty/html/assets/javascripts/bootstrap/bootstrap.qxgl.js");	
		_include("js/jQuery/Flatty/html/assets/javascripts/plugins/select2/select2.js");
		//jquery validateion 插件js
		_include("js/jQuery/validate/jquery.validate.js");
		_include("js/jQuery/validate/jquery.metadata.js");
		_include("js/jQuery/validate/jquery.validate.message_cn.js");
		//jquery ui	
		_include("js/jQuery/Flatty/html/assets/javascripts/jquery/jquery-ui.min.js");
		//flatty  核心js	
		_include("js/jQuery/Flatty/html/assets/javascripts/theme.js");
		//qxgl common 公用js	
		_include("js/Utils/CommonFun.js");
		_include("js/Utils/Date.js");
		// 消息内容js	
		_include("js/lib/ResMS.js");
		//权限管理公用jquery扩展库	
		_include("js/lib/QxglLib.js");
		//sepical	
		_include("js/main/main.js");
		//单位管理模块相关js	
		_include("js/main/UnitManage.js");
		//用户管理相关js	
		_include("js/main/UserManage.js");
		//操作管理相关js	
		_include("js/main/Operate.js");	
		//操作管理js	
		_include("js/main/OperateManage.js");	
		//网系管理
		_include("js/main/NetManage.js");
		//部队管理	
		//_include("js/main/ArmyManage.js");	
		//综合系统兼容
		_include("js/main/AbsorbZhxt.js");
		//网管系统管理	
		_include("js/main/WgxtManage.js");
		//过滤模块	
		_include("js/main/Filter.js");
		_include("js/main/ArmyManage.js");	
		//main	
		_include("js/main/main.js");		
	},
	//统一结构， 为了实现程序的入口
	_onload = function(e){
	},
	_unload = function(e){
		
	},
	//写入js文件路径
	_include = function(url){
		document.write("<script type=\"text/javascript\" src=\""+url+"\"></script>");
//		var id = document.getElementsByTagName("body");
//		id.write()
	};
	_oninit();
	_t.onload = _onload ;
	_t._unload = _unload ;
})();
