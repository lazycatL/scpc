
/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法

 * @author lihong 2017年5月19日09:40:50
 */
(function(){
	var _t = this,
	//导入js文件 ，后续在init导入js文件
	_oninit = function(e){

        //css
        _includeCss("../js/plugin/bootstrap/css/bootstrap.css");
        _includeCss("../stylesheets/light-theme.css");
        _includeCss("../stylesheets/theme-colors.css");
        // bootstrap Datatables样式引入
        _includeCss("../js/datatablesExtends/dataTables.bootstrap.css");
        _includeCss("../js/plugin/bootstrap_datetimepicker/css/bootstrap-datetimepicker.min.css");

        _includeCss("../js/plugin/bootstrap-datepicker/css/datepicker.css");
        _includeCss("../stylesheets/plugins/fullcalendar/fullcalendar.css");
        _includeCss("../stylesheets/scglxt/main.css");

		//jquery
		_include("../js/jquery/jquery.min.js");
        _include("../js/jquery/jquery-migrate.min.js");

        _include("../js/jquery/jquery-ui.min.js");
        _include("../js/plugin/bootstrap/js/bootstrap.js");
        _include("../js/theme.js");
        _include("../js/util/CommonUtils.js");
        _include("../js/plugin/datatables/jquery.dataTables.js");
        _include("../js/plugin/datatables/dataTables.fixedColumns.js");

        //集成bootstap的datablesJS
        _include("../js/datatablesExtends/dataTables.bootstrap.js");
        _include("../js/plugin/bootstrap-datepicker/js/bootstrap-datepicker.js");
        _include("../js/plugin/bootstrap_datetimepicker/js/bootstrap-datetimepicker.min.js");
        _include("../js/plugin/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js");
        _include("../js/util/Cookies.js");
        _include("../js/plugin/fullcalendar/fullcalendar.min.js");

        _include("../js/plugin/fullcalendar/fullcalendar.min.js");


	},
	//统一结构， 为了实现程序的入口
	_onload = function(e){
	},
	_unload = function(e){
		
	},
    //写入css文件路径
    _includeCss = function(url){
        document.write(" <link href=\""+url+"\" media=\"all\" rel=\"stylesheet\" type=\"text/css\" />");
    };
	//写入js文件路径
	_include = function(url){
		document.write("<script type=\"text/javascript\" src=\""+url+"\"></script>");
	};
	_oninit();
	_t.onload = _onload ;
	_t._unload = _unload ;
})();
