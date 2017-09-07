Date.prototype.format = function(format){
 /*
  * eg:format="YYYY-MM-dd hh:mm:ss";
  */
 var o = {
  "M+" :  this.getMonth()+1,  //month
  "d+" :  this.getDate(),     //day
  "h+" :  this.getHours(),    //hour
  "m+" :  this.getMinutes(),  //minute
  "s+" :  this.getSeconds(), //second
  "q+" :  Math.floor((this.getMonth()+3)/3),  //quarter
  "S"  :  this.getMilliseconds() //millisecond
}
 
   if(/(y+)/.test(format)) {
    format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
   }
 
   for(var k in o) {
    if(new RegExp("("+ k +")").test(format)) {
      format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
    }
   }
 return format;
}
/*字符转日期*/
 function StringToDate(DateStr){
	 if(typeof DateStr=="undefined")
		 return new Date();
	 if(typeof DateStr=="date")
		 return DateStr;
	 var converted = Date.parse(DateStr);
	 var myDate = new Date(converted);
	 if(isNaN(myDate)){
		 DateStr=DateStr.replace(/:/g,"-");
		 DateStr=DateStr.replace(" ","-");
		 DateStr=DateStr.replace(".","-");
		 var arys= DateStr.split('-');
		 switch(arys.length){
			 case 7 : 
				 myDate = new Date(arys[0],--arys[1],arys[2],arys[3],arys[4],arys[5],arys[6]);
				 break;
			 case 6 : 
				 myDate = new Date(arys[0],--arys[1],arys[2],arys[3],arys[4],arys[5]);
				 break;
			 default: 
				 myDate = new Date(arys[0],--arys[1],arys[2]);
			 	 break;
		 };
	 };
	 return myDate;
}
