/**
 * jquery扩展函数 mk@20140512
 * @param {Object} obj
 */ 
$.extend($, {
	asyncAjax:function(url,data,successFun,showError){
		var ajaxErrorHandler = null ;
		if(showError){
			//showEror 	
			ajaxErrorHandler = $.ajaxErrorHandler;
		}
			$.ajax( {
				type:"POST",
				url : url,
				data:data,
				dataType : "json",
				success : successFun,
				error : ajaxErrorHandler 
			});
		},
	// 封装同步加载ajax方法
	syncAjax:function(url,data,successFun,showError){
		var ajaxErrorHandler = null ;
		if(showError){
			//showEror 	
			ajaxErrorHandler = $.ajaxErrorHandler;
		}
			$.ajax( {
				async:false,
				type:"POST",
				url : url,
				data:data,
				dataType : "json",
				success : successFun,
				error : ajaxErrorHandler 
			});
		},
	// 封装同步加载ajax方法  当action中 处理 delete update 时候 建议 此方法 ， 否则response值返回json格式会异常
	asyncAjaxPost :function(url,data,successFun,showError){
		var ajaxErrorHandler = null ;
		if(showError){
			//showEror 	
			ajaxErrorHandler = $.ajaxErrorHandler;
		}
			$.ajax({
                async:true,
				type:"POST",
				url : url,
				data:data,
				success : successFun,
				error : ajaxErrorHandler 
			});
		},
	// 封装同步加载ajax方法  当action中 处理 delete update 时候 建议 此方法 ， 否则response值返回json格式会异常
	syncAjaxPost :function(url,data,successFun,showError){
		var ajaxErrorHandler = null ;
		if(showError){
			//showEror 	
			ajaxErrorHandler = $.ajaxErrorHandler;
		}
			$.ajax({
				async:false,
				type:"POST",
				url : url,
				data:data,
				success : successFun,
				error : ajaxErrorHandler 
			});
		},

	// 用于jQuery.ajax()的error函数   
	ajaxErrorHandler:function(XMLHttpRequest, textStatus, errorThrown){
	},
	byId:function(s){
		return ((typeof(s)=="object")?s:document.getElementById(s));
	},
	/**
	 * 根据dom的id 注册事件
	 * @param id
	 * @param e
	 * @param f
	 */
	addEvent:function(id,e,f){
		var _this = this ;
		if(!_this.byId(id)){
			return;
		}
		if(this.attachEvent){
			_this.byId(id).attachEvent("on"+e,f);
			return;
		}
		_this.byId(id).addEventListener(e,f,false);
		
		
	},
	/**
	 * 取消绑定事件
	 * @author mk@20140528
	 * @param {Object} id 
	 * @param {Object} e
	 * @param {Object} f
	 */
	unbindEvent :function(id,e,f){
		var _this = this ;
		if(!_this.byId(id)){
			return;
		}
		if(this.detachEvent){
			_this.byId(id).detachEvent("on"+e,f);
			return;
		}
		_this.byId(id).removeEventListener(e,f,false);
	},
	/*
	*   说明:添加下拉框元素
	*   innerText:下拉框显示文本
	*   value:下拉框选项值
	*   SelectID:需要添加的Select对象ID
	*/
	AddSelectItem :function(innerText, value, SelectID){
         var select = $('#' + SelectID);
         if (select == null) {
             alert('找不到' + SelectID);
             return;
         }
         if (innerText.indexOf('请选择') > 0) {
             for (var i = 0; select[0].length;) {
                 select[0].removeChild(select[0][i]);
             }
         }
         select.append('<option value="' + value + '">' + innerText + '</option>');
	},
	AddSelectItemBySelector :function(innerText, value, Selector){
        var select = $(Selector);
        if (select == null) {
            alert('找不到' + SelectID);
            return;
        }
        if (innerText.indexOf('请选择') > 0) {
            for (var i = 0; select[0].length;) {
                select[0].removeChild(select[0][i]);
            }
        }
        select.append('<option value="' + value + '">' + innerText + '</option>');
	},
            loadSelectList:function(selector,pid){
            var url = "common_loadSjzdList.action?pid="+pid, successFun = function (data) {
                if (data && data.length > 0) {
                    $(selector).empty();
                    $.AddSelectItemBySelector("-请选择-", "", selector);
                    for (var i = 0; i < data.length; i++) {
                        $.AddSelectItemBySelector(data[i].mc, data[i].id, selector);
                    }
                }
            };
            $.asyncAjax(url, {"id": "id"}, successFun, true);
},
	/*
	*   描述:清除Select元素
	*   SelectID:需要清除的对象ID
	*   innerText:清除的选项显示文本
	*   value:清除的选项值
	*/
    ClearSelectItem: function(SelectID, innerText, value){
        var select = $('#' + SelectID);
        if (select == null) {
            alert('找不到' + SelectID);
            return;
        }
        if (innerText) {
            for (var i = 0; select[0].length;) {
                if (select[0][i].innerHTML == innerText) {
                    select[0].removeChild(select[0][i]);
                    break;
                }
            }
        }
        else 
            if (value) {
                for (var i = 0; select[0].length;) {
                    if (select[0][i].value == value) {
                        select[0].removeChild(select[0][i]);
                        break;
                    }
                }
            }
            else {
                for (var i = 0; select[0].length;) {
                    select[0].removeChild(select[0][i]);
                }
            }
    },
    /*
    用于将model对象转化成json字符串格式，字符值都经过escape()函数转码，解决中文乱码问题
    多用于post提交时的data参数
    $.syncPost(url,$.toJsonString({aa:"你好",bb:{cc:"xx",dd:[1,2,3,4]},gg:{yy:["a","b","c"]}}));
    */
    toJsonString: function (obj)
    {
        var result = "";
        switch ($.type(obj))
        {
            case "object":
                {
                    result += '{';
                    $.each(obj, function (key, value)
                    {
                        result += '\"' + escape($.filterString(key)) + '\":';
                        result += $.toJsonString(value);
                        result += ',';
                    });
                    result = result.substr(0, result.length - 1);
                    result += '}';
                    break;
                }
            case "function":
                break;
            case "string":
                //result += '\"' + escape($.filterString(obj)) + '\"';
                result += '\"' + ($.filterString(obj)) + '\"';
                break;
            case "array":
                {
                    result += "[";
                    $.each(obj, function (i, value)
                    {
                        if (i < obj.length - 1)
                        {
                            result += $.toJsonString(value) + ",";
                        }
                        else
                        {
                            result += $.toJsonString(value);
                        }
                    });
                    result += "]";
                    break;
                }
            case "date":
                break;
            case "regexp":
                result += '\"' + escape(obj) + '\"';
                break;
            default:
                result += escape(obj);
                break;
        }
        return result;
    },
    /*转换导致JSON串异常的特殊字符*/
    filterString: function (str)
    {
        if (str)
            return str.replace("\r\n", "$n$$r$").replace("\n", "$n$").replace("\r", "$r$").replace("\f", "").replace("\t", "").replace("\b", "").replace("/", "\\/").replace("\\", "\\");
        return str;
    },
    /*修复经过转换JSON字符串*/
    fixFilterString: function (str)
    {
        if (str)
            return str.replace("$n$$r$", "\r\n").replace("$n$", "\n").replace("$r$", "\r");
        return str;
    },
    /*
    格式化字符串,用{数字}的方式占位
    例如：
    var strFormat = "{0}你好！请问{0}有没有火！{1}是我的名字！";
    var str = $.format(strFormat,"tom","dxzhan");
    */
    format: function (source, params)
    {
        if (arguments.length == 1)
            return function ()
            {
                var args = $.makeArray(params);
                args.unshift(source);
                return $.format.apply(this, args);
            };
        if (arguments.length > 2 && params.constructor != Array)
        {
            params = $.makeArray(arguments).slice(1);
        }
        if (params && params.constructor != Array)
        {
            params = [params];
        }
        if (source && params)
        {
            $.each(params, function (i, n)
            {
                source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
            });
        }
        return source;
    },
    //将2011-10-26 14:50;22这样的时间字符串转化成Date对象
    toDateTime: function (dateStr) { return new Date(Date.parse(dateStr.replace(/\-/g, "/"))); },
    toDateTimeString: function (date)
    {
        if (v instanceof Date)
        {
            var y = v.getFullYear();
            var m = v.getMonth() + 1;
            var d = v.getDate();
            var h = v.getHours();
            var i = v.getMinutes();
            var s = v.getSeconds();
            if (h > 0 || i > 0 || s > 0)
            {
                return $.format("{0}-{1}-{2} {3}:{4}:{5}", y, m, d, h, i, s);
            }
            return $.format("{0}-{1}-{2}", y, m, d);
        }
        return '';
    },
    toDateString: function (v)
    {
        if (v instanceof Date)
        {
            var y = v.getFullYear();
            var m = v.getMonth() + 1;
            var d = v.getDate();
            var h = v.getHours();
            var i = v.getMinutes();
            var s = v.getSeconds();
            var ms = v.getMilliseconds();
            if (ms > 0)
            {
                return $.format("{0}-{1}-{2} {3}:{4}:{5}.{6}", y, m, d, h, i, s, ms);
            }
            if (h > 0 || i > 0 || s > 0)
            {
                return $.format("{0}-{1}-{2} {3}:{4}:{5}", y, m, d, h, i, s);
            }
            return $.format("{0}-{1}-{2}", y, m, d);
        }
        return '';
    },
    //获取url参数
    GetRequest :function() {
    	  var url = location.search; //获取url中"?"符后的字串
    	   var theRequest = new Object();
    	   if (url.indexOf("?") != -1) {
    	      var str = url.substr(1);
    	      strs = str.split("&");
    	      for(var i = 0; i < strs.length; i ++) {
    	         theRequest[strs[i].split("=")[0]]=(strs[i].split("=")[1]);
    	      }
    	   }
    	   return theRequest;
    	},
    toShortDate: function (date)
    {
        var v = date;
        if (v instanceof Date)
        {
            var y = v.getFullYear();
            var m = v.getMonth() + 1;
            var d = v.getDate();
            return $.format("{0}-{1}-{2}", y, m, d);
        }
        return '';
    },
    getNowDateString: function ()
    {
        var v = new Date();
        var y = v.getFullYear();
        var m = v.getMonth() + 1;
        var d = v.getDate();
        return $.format("{0}-{1}-{2}", y, m, d);
    },
    getNowDatetimeString: function () { return $.toDateTimeString(new Date()) },
    /*获得中文格式的日期字符串*/
    nowChineseShortDate: function ()
    {
        var v = new Date();
        var y = v.getFullYear();
        var m = v.getMonth() + 1;
        var d = v.getDate();
        return $.format("{0}年{1}月{2}日", y, m, d);
    },
    version1: function ()
    {
        return "1.0.0.0";
    },
    decodeEmptyValue : function(value){
        if(value == null || value == undefined ) { // 等同于 value === undefined || value === null
            return "";
        }else{
        	return value ;
        }
    },
    addRequiredLabel:function(){
        $(".required").closest("div").siblings("label.control-label").append("<label style=\"color:red\">*</label>");
    }
});

/***********comtools*************/
/*!
Math.uuid.js (v1.4)
http://www.broofa.com
mailto:robert@broofa.com
 
Copyright (c) 2010 Robert Kieffer
Dual licensed under the MIT and GPL licenses.
*/
 
/*
 * Generate a random uuid.
 *
 * USAGE: Math.uuid(length, radix)
 *   length - the desired number of characters
 *   radix  - the number of allowable values for each character.
 *
 * EXAMPLES:
 *   // No arguments  - returns RFC4122, version 4 ID
 *   >>> Math.uuid()
 *   "92329D39-6F5C-4520-ABFC-AAB64544E172"
 *
 *   // One argument - returns ID of the specified length
 *   >>> Math.uuid(15)     // 15 character ID (default base=62)
 *   "VcydxgltxrVZSTV"
 *
 *   // Two arguments - returns ID of the specified length, and radix. (Radix must be <= 62)
 *   >>> Math.uuid(8, 2)  // 8 character ID (base=2)
 *   "01001010"
 *   >>> Math.uuid(8, 10) // 8 character ID (base=10)
 *   "47473046"
 *   >>> Math.uuid(8, 16) // 8 character ID (base=16)
 *   "098F4D35"
 */
(function() {
  // Private array of chars to use
  var CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
 
  Math.uuid = function (len, radix) {
    var chars = CHARS, uuid = [], i;
    radix = radix || chars.length;
 
    if (len) {
      // Compact form
      for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random()*radix];
    } else {
      // rfc4122, version 4 form
      var r;
 
      // rfc4122 requires these characters
      uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
      uuid[14] = '4';
 
      // Fill in random data.  At i==19 set the high bits of clock sequence as
      // per rfc4122, sec. 4.1.5
      for (i = 0; i < 36; i++) {
        if (!uuid[i]) {
          r = 0 | Math.random()*16;
          uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
        }
      }
    }
 
    return uuid.join('');
  };
 
  // A more performant, but slightly bulkier, RFC4122v4 solution.  We boost performance
  // by minimizing calls to random()
  Math.uuidFast = function() {
    var chars = CHARS, uuid = new Array(36), rnd=0, r;
    for (var i = 0; i < 36; i++) {
      if (i==8 || i==13 ||  i==18 || i==23) {
        uuid[i] = '-';
      } else if (i==14) {
        uuid[i] = '4';
      } else {
        if (rnd <= 0x02) rnd = 0x2000000 + (Math.random()*0x1000000)|0;
        r = rnd & 0xf;
        rnd = rnd >> 4;
        uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
      }
    }
    return uuid.join('');
  };
 
  // A more compact, but less performant, RFC4122v4 solution:
  Math.uuidCompact = function() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
      return v.toString(16);
    });
  };
})();