//设置COOKIE,expires:多少天后过期
function SetCookie(name,value,expires,path,domain,secure)
{
    var expDays = expires*24*60*60*1000;
    var expDate = new Date();
    expDate.setTime(expDate.getTime()+expDays);
    var expString = ((expires==null) ? "" : (";expires="+expDate.toGMTString()))
    var pathString = ((path==null) ? "" : (";path="+path))
    var domainString = ((domain==null) ? "" : (";domain="+domain))
    var secureString = ((secure==true) ? ";secure" : "" )
    document.cookie = name + "=" + escape(value) + expString + pathString + domainString + secureString;
} 

//获取指定名称的cookie值：
function GetCookie(name)
{
    var result = null;
    var myCookie = document.cookie + ";";
    var searchName = name + "=";
    var startOfCookie = myCookie.indexOf(searchName);
    var endOfCookie;
    if (startOfCookie != -1)
    {
        startOfCookie += searchName.length;
        endOfCookie = myCookie.indexOf(";",startOfCookie);
        result = decodeURI(myCookie.substring(startOfCookie, endOfCookie));
    }
    return result;
} 
//删除指定名称的cookie：
function ClearCookie(name)
{
    var ThreeDays=3*24*60*60*1000;
    var expDate = new Date();
    expDate.setTime(expDate.getTime()-ThreeDays);
    document.cookie=name+"=;expires="+expDate.toGMTString();
}