$(function(){
	initTable();
});

/**
 * 初始化表格数据
 * @return
 */
function initTable(){
	$.ajax({
		url : 'xsgl_getHeTongData.action',
		async : false,
		dataType : 'json',
		success:function(data){
			if(data&&data.length>0){
				var txt = '';
				for(var i=0;i<data.length;i++){
					txt +="<tr><td>"+(i+1)+"</td><td>"+replaceNull(data[i].htbh)+"</td><td>"+replaceNull(data[i].mc)+"</td><td>"+
					replaceNull(data[i].ywlx)+"</td><td>"+replaceNull(data[i].htje)+"</td>"+
					"<td>"+replaceNull(data[i].qssj)+"</td><td>"+replaceNull(data[i].dqjd)+"</td><td>"+replaceNull(data[i].fkzt)+"</td>"+
					"<td>"+replaceNull(data[i].jkbfb)+"</td><td>"+replaceNull(data[i].jkje)+"</td><td>"+replaceNull(data[i].jscb)+"</td>"+
					"<td>"+replaceNull(data[i].hkzh)+"</td><td>"+replaceNull(data[i].hkkhh)+"</td><td>"+replaceNull(data[i].remark)+"</td>"+
					"</tr>";
				}
				$('#mainTable tbody').html(txt);
			}
		},
		error:function(e){
			console.log(e);
		}
	})
}