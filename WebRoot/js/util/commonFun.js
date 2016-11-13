/*
 * 描述：公用函数
 * 时间：2012.3.2
 * 编写：qfkong
 * @copyright by project
 * http://www.project.com
 */

/* 获取地址栏传递的参数 */
function getValueOfURLParamter(para) {
    var value = '';
    var args = window.location.href.substring(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < args.length; i++) {
        if (args[i].substring(0, args[i].indexOf('=')).toUpperCase() == para.toUpperCase()) {
            value = args[i].substring(args[i].indexOf('=') + 1);
            break;
        }
    }
    return value;
}
/* 将v精确到小数点后e位 */
function round(v, e) 
{
    var t = 1;
    e = Math.round(e);
    for (; e > 0; t *= 10, e--);
    for (; e < 0; t /= 10, e++);
    return Math.round(v * t) / t;
}
/* 只能输入数字 */
function checkKeyDown() {
    if (!((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 37 || event.keyCode == 39 ||
    event.keyCode == 8 || event.keyCode == 45 || event.keyCode == 46 || event.keyCode == 190)) {
        event.returnvalue = false;
        return false;
    }
    return true;
}

/* 字符长度查询 */
function isStrLen(str, min, max) {
    min = min || 0;
    if (!max) {
        return true;
    }
    var l = String(str).len();
    if (l < min) {
        return false;
    }
    if (l > max) {
        return false;
    }
    return true;
}
/*
 * 描述:将数字转换成中文大写。 num 需要转换的数字,可以是数字或字符串
 */
function NumToBig(num) {
    num = String(num);
    var length = num.length;
    var strReturn = '';
    var tmp = '';
    for (var i = 0; i < length; i++) {
        tmp = num.substring(0, 1); // 截取需要转化的字符
        num = num.substring(1);
        strReturn += (tmp == '0' ? '零' : (tmp == '1' ? '一' : (tmp == '2' ? '二' : (tmp == '3' ? '三' : (tmp == '4' ? '四' : (tmp == '5' ? '五' : (tmp == '6' ? '六' : (tmp == '7' ? '七' : (tmp == '8' ? '八' : (tmp == '9' ? '九' : ''))))))))));
    }
    return strReturn;
}

/*
 * 说明:添加下拉框元素 innerText:下拉框显示文本 value:下拉框选项值 SelectID:需要添加的Select对象ID
 */
function AddSelectItem(innerText, value, SelectID, attr) {
    var select = $('#' + SelectID);
    if (select == null) {
        alert('找不到' + SelectID);
        return;
    }
    if (innerText.indexOf('请选择') > 0) {
        for (var i = 0; select[0].length; ) {
            select[0].removeChild(select[0][i]);
        }
    }
    select.append('<option value="' + value + '" ' + (attr||'') + '>' + innerText + '</option>');
}
/*
 * 描述:清除Select元素 SelectID:需要清除的对象ID innerText:清除的选项显示文本 value:清除的选项值
 */
function ClearSelectItem(SelectID, innerText, value) {
    var select = $('#' + SelectID);
    if (select == null) {
        alert('找不到' + SelectID);
        return;
    }
    if (innerText) {
        for (var i = 0; select[0].length; ) {
            if (select[0][i].innerHTML == innerText) {
                select[0].removeChild(select[0][i]);
                break;
            }
        }
    }
    else if (value) {
        for (var i = 0; select[0].length; ) {
            if (select[0][i].value == value) {
                select[0].removeChild(select[0][i]);
                break;
            }
        }
    }
    else {
        for (var i = 0; select[0].length; ) {
            select[0].removeChild(select[0][i]);
        }
    }
}
/*
 * 说明:设置Select选中元素 sid:下拉框元素ID text:匹配的文本 value:匹配的值
 */
function SetSelectSelected(sid, text, value) {
    var sobj = $('#' + sid);
    var length = $('#' + sid + ' option').length;
    if (text) {
        for (var i = 0; i < length; i++) {
            if (sobj.get(0).options[i].text == text) {
                sobj.get(0).options[i].selected = true;
                break;
            }
        }
    }
    if (value) {
        for (var i = 0; i < length; i++) {
            if (sobj.get(0).options[i].value == value) {
                sobj.get(0).options[i].selected = true;
                break;
            }
        }
    }
}


/* 创建全屏数据加载等待窗口,t提示语句 */
function CreateCommonLoadding(t) {
    var loadding = $('<div>').css({ 'position': 'absolute', 'z-index': '10', 'opacity': 0.9, 'background-color': '#EEEEEE', 'top': '0px', 'left': '0px', 'width': window.innerWidth + 'px', 'height': window.innerHeight + 'px' })
    .attr({ 'id': 'commonLoadding' })
    .append($('<div>').css({ 'color': 'Black', 'text-align': 'center', 'vertical-align': 'middle', 'line-height': window.innerHeight + 'px', 'width': '100%' })
    .append($('<span>').css({ 'padding': '20px', 'font-size': '12px', 'font-family': 'Arial' }).html('数据加载中，请稍候...').append($('<img>').attr({ 'src': '../images/common/Loading.gif' }))))
    .appendTo($('body'));
}
/* 销毁全屏数据加载等待窗口 */
function DestoryCommonLoadding() {
    $('#commonLoadding').remove();
}

function CreateFullScreenDiv(url) {
    url = url || '';
    var windowFullScreen = $('<div>').css({ 'width': '0px', 'height': '0px', 'position': 'absolute',
        'top': '0px', 'left': '0px', 'overflow': 'hidden', 'padding': '0px', 'margin': '0px', 'border': '0px', 'z-index': '50'
    }).attr({ 'id': 'windowFullScreen' })
    .append($('<iframe>').css({ 'width': '100%', 'height': '100%' }).attr({ 'src': url, 'frameborder': '0px', 'scrolling': 'no' }))
     .appendTo($('body').css({ 'overflow': 'hidden' }));
}
function setFullScreenToFullSrceen() {
    $('#windowFullScreen').width(screen.width).height(screen.height);
}

/* 退出全屏删除DIV */
function ClearFullScreen() {
    $('#windowFullScreen').remove();
    if (window.location.pathname.indexOf('ConfigurationEMS.htm') > 1) {
        $('body').css({ 'overflow': 'auto' });
    }
}

/* 退出全屏 */
function ExitFullScreen() {
    FullScreen();
    toLeft();
    ClearFullScreen();
}
/* 页面滚动条事件 */
function bodyScroll() {
    var objLoadding = $('#commonLoadding');
    if (objLoadding) {
        objLoadding.css({ 'width': $('body').innerWidth(), 'height': $('body').innerHeight() });
    }
}

/*
 * 描述：对象数组进行排序 时间：2011.06.02 9:18
 */
var ObjectSortBy = function(name, minor, desc) {
    return function(o, p) {
        var a, b;
        if (o && p && typeof o === 'object' && typeof p === 'object') {
            a = parseFloat(o[name]);
            b = parseFloat(p[name]);
            if (a === b) {
                return typeof minor == 'function' ? minor(o, p) : 0;
            }
            if (typeof a === typeof b) {
                return desc == 'desc' ? (a > b ? -1 : 1) : (a < b ? -1 : 1);
            }
            return desc == 'desc' ? (typeof a > typeof b ? -1 : 1) : (typeof a < typeof b ? -1 : 1);
        }
        else {
            throw ('error');
        }
    }
}
/* 获取限定范围的随机数 */
function getRandomLimit(min, max) {
    var n = parseInt(Math.random() * 10);
    if (n >= min && n <= max) {
        return n;
    }
    else {
        return getRandomLimit(min, max);
    }
}
/* 将时间转化为天小时分钟 */
function GetTimeByMinutes(ss) {
    // console.log(minutes);
    var d = parseInt(ss / (60 * 60 * 24));
    var h = parseInt((ss - d * 24 * 60 * 60) / (60 * 60));
    var m = parseInt((ss - d * 24 * 60 * 60 - h * 60 * 60) / 60);
    var dt = (d > 0 ? (d + '天') : '') + (h > 0 ? (h + '小时') : '') + (m > 0 ? (m + '分') : '');
    // console.log(dt);
    return dt || '0';
}

/*鼠标移过图片onmouseover*/
function onoverImg(imgObj) {
    if (imgObj.src.indexOf('_b') < 0) imgObj.src = imgObj.src.replace("_a", "_b");
}
/*鼠标移出图片onmouseout*/
function onoutImg(imgObj) {
    if (imgObj.id != document.getElementById("hidSel").value) imgObj.src = imgObj.src.replace("_b", "_a");
}
/*获取地址栏传入的参数*/
function getValueOfURLParamter(para) {
    var value = '';
    var args = window.location.href.substring(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < args.length; i++) {
        if (args[i].substring(0, args[i].indexOf('=')).toUpperCase() == para.toUpperCase()) {
            value = args[i].substring(args[i].indexOf('=') + 1);
            break;
        }
    }
    return value;
}
/*将v精确到小数点后e位*/
function round(v, e)   
{
    var t = 1;
    e = Math.round(e);
    for (; e > 0; t *= 10, e--);
    for (; e < 0; t /= 10, e++);
    return Math.round(v * t) / t;
}
/*格式化数字
alert(formatNumber(0,''));
alert(formatNumber(12432.21,'#,###'));
alert(formatNumber(12432.21,'#,###.000#'));
alert(formatNumber(12432,'#,###.00'));
alert(formatNumber('12432.415','#,###.0#'));
*/
function formatNumber(number,pattern){
    var str            = number.toString();
    var strInt;
    var strFloat;
    var formatInt;
    var formatFloat;
    if(/\./g.test(pattern)){
        formatInt        = pattern.split('.')[0];
        formatFloat        = pattern.split('.')[1];
    }else{
        formatInt        = pattern;
        formatFloat        = null;
    }

    if(/\./g.test(str)){
        if(formatFloat!=null){
            var tempFloat    = Math.round(parseFloat('0.'+str.split('.')[1])*Math.pow(10,formatFloat.length))/Math.pow(10,formatFloat.length);
            strInt        = (Math.floor(number)+Math.floor(tempFloat)).toString();                
            strFloat    = /\./g.test(tempFloat.toString())?tempFloat.toString().split('.')[1]:'0';            
        }else{
            strInt        = Math.round(number).toString();
            strFloat    = '0';
        }
    }else{
        strInt        = str;
        strFloat    = '0';
    }
    if(formatInt!=null){
        var outputInt    = '';
        var zero        = formatInt.match(/0*$/)[0].length;
        var comma        = null;
        if(/,/g.test(formatInt)){
            comma        = formatInt.match(/,[^,]*/)[0].length-1;
        }
        var newReg        = new RegExp('(\\d{'+comma+'})','g');

        if(strInt.length<zero){
            outputInt        = new Array(zero+1).join('0')+strInt;
            outputInt        = outputInt.substr(outputInt.length-zero,zero)
        }else{
            outputInt        = strInt;
        }

        var 
        outputInt            = outputInt.substr(0,outputInt.length%comma)+outputInt.substring(outputInt.length%comma).replace(newReg,(comma!=null?',':'')+'$1')
        outputInt            = outputInt.replace(/^,/,'');

        strInt    = outputInt;
    }

    if(formatFloat!=null){
        var outputFloat    = '';
        var zero        = formatFloat.match(/^0*/)[0].length;

        if(strFloat.length<zero){
            outputFloat        = strFloat+new Array(zero+1).join('0');
            //outputFloat        = outputFloat.substring(0,formatFloat.length);
            var outputFloat1    = outputFloat.substring(0,zero);
            var outputFloat2    = outputFloat.substring(zero,formatFloat.length);
            outputFloat        = outputFloat1+outputFloat2.replace(/0*$/,'');
        }else{
            outputFloat        = strFloat.substring(0,formatFloat.length);
        }

        strFloat    = outputFloat;
    }else{
        if(pattern!='' || (pattern=='' && strFloat=='0')){
            strFloat    = '';
        }
    }

    return strInt+(strFloat==''?'':'.'+strFloat);
}

/*消息机制发送消息*/
//example
//msg_type = 13006
//msg_recNameList = "process_neip~process_name";
//msg_recTypeList = "string~string";
//msg_recValueList = "aaaa~bbbb";
//msg_targetEntityName = "metar_res_info";
function SendMsgToDPP(msg_type,msg_recNameList,msg_recTypeList,msg_recValueList,msg_targetEntityName){
	$.ajax({
		cache:false,
		type:'POST',
		data:({msg_type:msg_type,msg_recNameList:msg_recNameList,msg_recTypeList:msg_recTypeList,msg_recValueList:msg_recValueList,msg_targetEntityName:msg_targetEntityName}),
		url:'dpp_SendMsg.action?r='+Math.random()
	});
}
/*获取当前日子2011-08-07*/
function getNowDate()   
{
    var Today=new Date();
    var r=Today.getFullYear() +"-"+ fill0tostr((Today.getMonth()+1)) +"-"+ fill0tostr(Today.getDate());
    return r;
}
/*获取当前日子和时间2011-08-07 12:35:25*/
function getNowDateTime()   
{
    var Today=new Date();
    var r=Today.getFullYear() +"-"+ fill0tostr((Today.getMonth()+1)) +"-"+ fill0tostr(Today.getDate()) +"&nbsp;"+ fill0tostr(Today.getHours()) +":"+ fill0tostr(Today.getMinutes()) +":"+ fill0tostr(Today.getSeconds());
    return r;
}
/*获取当前时间12:35:25*/
function getNowTime()   
{
    var Today=new Date();
    var r=fill0tostr(Today.getHours()) +":"+ fill0tostr(Today.getMinutes()) +":"+ fill0tostr(Today.getSeconds());
    return r;
}
/*两位字符串，不足补0*/
function fill0tostr(str){
	str = "00" + str;
	str = str.substring(str.length-2,str.length);
	return str;
}
function round(v,e)   //将v精确到小数点后e位
{   
    var   t=1;   
    e=Math.round(e);   
    for(;e>0;t*=10,e--);   
    for(;e<0;t/=10,e++);   
    return   Math.round(v*t)/t;   
}       
//把json中的时间对象转换为字符串
function DateTimeToStr1(dateTime){
	var str = (dateTime.year+1900)+'-'+(dateTime.month+1)+'-'+dateTime.date+" "+dateTime.hours+":"+dateTime.minutes+":"+dateTime.seconds;
	return str;
}
//获取随机范围内整数值的函数
function GetIntRandom(n){
    var r=parseInt(Math.floor(Math.random()*n+1));
    return r;
}

/*
 * 描述：将对象设置置顶,功能主要用于导航条置顶 时间：2011.09.30 10:00
 */
function SetTop(id) {
    var o = $('#' + id);
    var _defaultTop = o.offset().top; // 获取对象距屏幕顶部的距离
    var _defaultLeft = o.offset().left; // 对象距屏幕左侧距离
    // 获取对象默认样式，还原出事样式时候使用
    var _position = o.css('position');
    var _top = o.css('top');
    var _left = o.css('left');
    var _width = o.css('width');
    var _zIndex = o.css('z-index');
    var _background = o.css('background');

    // 鼠标滚动事件
    $(window).scroll(function() {
        if ($(this).scrollTop() > _defaultTop) {
            // IE6不认识position:fixed,单独使用position:absolute模拟
            if ($.browser.msie && $.browser.version == '6.0') {
                $('<a>').appendTo($('body')).css({ 'position': 'absolute', 'top': eval(document.documentElement.scrollTop), 'left': _defaultLeft, 'z-index': 99999 });
                // 防止出现抖动
                $('html,body').css({ 'background-image': 'url(about:blank)', 'background-attachment': 'fixed' });
            }
            else {
                o.css({ 'position': 'fixed', 'width': _width, 'top': 0, 'left': _defaultLeft, 'z-index': 99999 });
                // $('html,body').css({ 'background': _background,
				// 'background-attachment': 'fixed' });
            }
        } else {
            o.css({ 'position': _position, 'width': _width, 'top': _top, 'left': _left, 'z-index': _zIndex });
            // $('html,body').css({ 'background': _background,
			// 'background-attachment': 'fixed' });
        }
    });
}

/*
* 	描述：串联加载指定的脚本
* 		    串联加载[异步]逐个加载，每个加载完成后加载下一个
* 		    全部加载完成后执行回调
*	参数:
* 			@param array|string 指定的脚本串或数组
* 			@param function 成功后回调的函数
* 			@return array 所有生成的脚本元素对象数组
*/
function seriesLoadScripts(scripts, callback) {
    if (typeof (scripts) != "object") var scripts = [scripts];
    var HEAD = document.getElementsByTagName("head").item(0) || document.documentElement;
    var s = new Array(), last = scripts.length - 1, recursiveLoad = function (i) {  //递归
        s[i] = document.createElement("script");
        s[i].setAttribute("type", "text/javascript");
        //        s[i].onload = s[i].onreadystatechange = function () { //Attach handlers for all browsers
        //            if (!/*@cc_on!@*/0 || this.readyState == "loaded" || this.readyState == "complete") {
        //                this.onload = this.onreadystatechange = null;
        //                this.parentNode.removeChild(this);
        //                if (i != last) {
        //                    recursiveLoad(i + 1);
        //                }
        //                else if (typeof (callback) == "function") {
        //                    callback();
        //                }
        //            }
        //        }
        s[i].setAttribute("src", scripts[i]);
        HEAD.appendChild(s[i]);
        if (i != last) {
            recursiveLoad(i + 1);
        }
    };
    recursiveLoad(0);
}

/*
* 	描述：并联加载指定的脚本
* 		    并联加载[同步]同时加载，不管上个是否加载完成，直接加载全部
* 		    全部加载完成后执行回调
* 	参数：
* 			@param array|string 指定的脚本串或数组
* 			@param function 成功后回调的函数
* 			@return array 所有生成的脚本元素对象数组
*/
function parallelLoadScripts(scripts, callback) {
    if (typeof (scripts) != "object") var scripts = [scripts];
    var HEAD = document.getElementsByTagName("head").item(0) || document.documentElement, s = new Array(), loaded = 0;
    for (var i = 0; i < scripts.length; i++) {
        s[i] = document.createElement("script");
        s[i].setAttribute("type", "text/javascript");
        s[i].onload = s[i].onreadystatechange = function () { //Attach handlers for all browsers
            if (!/*@cc_on!@*/0 || this.readyState == "loaded" || this.readyState == "complete") {
                loaded++;
                this.onload = this.onreadystatechange = null; this.parentNode.removeChild(this);
                if (loaded == scripts.length && typeof (callback) == "function") callback();
            }
        };
        s[i].setAttribute("src", scripts[i]);
        HEAD.appendChild(s[i]);
    }
}
/*
* 	描述：串联加载指定的样式
*	参数:
* 			@param array|string 指定的样式串或数组
*/
function seriesLoadCsss(csss) {
    if (typeof (csss) != "object") var csss = [csss];
    var HEAD = document.getElementsByTagName("head").item(0) || document.documentElement;
    var s = new Array(), last = csss.length - 1, recursiveLoad = function (i) {  //递归
        s[i] = document.createElement("link");
        s[i].setAttribute("type", "text/css");
        s[i].setAttribute("rel", "stylesheet");
        //        s[i].onload = s[i].onreadystatechange = function () { //Attach handlers for all browsers
        //            if (!/*@cc_on!@*/0 || this.readyState == "loaded" || this.readyState == "complete") {
        //                this.onload = this.onreadystatechange = null; 
        //                //this.parentNode.removeChild(this);
        //                if (i != last) recursiveLoad(i + 1);
        //            }
        //        }
        s[i].setAttribute("href", csss[i]);
        HEAD.appendChild(s[i]);
        if (i != last) recursiveLoad(i + 1);
    };
    recursiveLoad(0);
}


/**
*对象合并(对Object进行拓展时，出现异常，故将其单独写成函数并放置在公共函数中)
*@param org原始对象
*@param ad添加到org对象中的对象
*@return 返回合并后的对象
*/
function mergeObj(org,ad){
	if(!(typeof ad =='object')) return org;
	for(var key in ad){
		if(!org[key]){//如果没有该键值，就创建
			org[key]=new Object();
			org[key]=ad[key];
			continue;
		}
		if(typeof ad[key]=='object'){
			mergeObj(org[key],ad[key]);
		}
		else{
			org[key]=ad[key];
		}
	}
	return org;
}
/**
 * 将‘null’改为‘’
 * @param value
 * @return
 */
function replaceNull(value){
	if(value=='null'||value==null){
		value='';
	}
	return value;
}