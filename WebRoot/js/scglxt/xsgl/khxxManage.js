/**khxxManager
 * @author apple
 */
$(document).ready(function(){
	tableInit();
	init();
});
 /**
  * 初始化函数
  */
function init(){
	loadKhlxList();
	$("#form_add").on('click',function(){
		skipToFormPage('scglxt/xsgl/editKhInfo.jsp');//跳转iframe页面
	})

}
function loadKhlxList(){
	 var url = "khInfo_loadKhlxList.action",successFun = function(json){
		 console.log(json);
	 } ;
 	 $.asyncAjax(url, {"id": "id"}, successFun, true);	
}

function deleteRow(id){
	var flag = confirm("是否删除？");
	if(flag){
		$.ajax({
			  type: "post",
			  url: "khInfo_deleteKhInfo.action",
			  dataType: "text",
			  data:{
			  	"id":id
			  },
			  success:function(str){
			  	window.location.reload(); 
			  	$("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
			  }
			}); 
	}
}
//跳转页面
function editRow(id){
	skipToFormPage('scglxt/xsgl/editKhInfo.jsp?id='+id);//跳转iframe页面s
}

function tableInit(){

	var table = $('#ryxx').DataTable( {
	"bLengthChange": false,
  	"oLanguage": {
                "sProcessing": "正在加载中......",
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "对不起，查询不到相关数据！",
                "sEmptyTable": "表中无数据存在！",
                "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上一页",
                    "sNext": "下一页",
                    "sLast": "末页"
                }
            },
    "aLengthMenu":[20,40,60],
	//"ajax":"xsgl_getRyInfo.action",
	"ajax":"khxxgl_getKhxxData.action",
        //scrollY:        "200px",
        scrollX:        true,
        scrollY:        '50vh',
	scrollCollapse: false,
	paging:         true,
	"columnDefs": [
        {
            "render": function ( data, type, row ) {
                return '<div class="">'+
                '<a class=" "  onclick = "editRow(\''+data+'\')" title="编辑"  href="#">编辑 </a>'+
                ' <a class=" " onclick = "deleteRow(\''+data+'\')" title="删除" href="#">删除 </a>' +
                    '<a class="" href="#" title＝"查看" onclick = "showModel(\''+data+'\')">合同信息</a>' +
                    '</div>';
            },
            "targets": 1
        },

        { "visible": true,  "targets": [ 2 ] }
    ],
        "bProcessing":true,
    "columns": [
    	{"data":null},
    	{"data":'id'},
        { "data": "mc" },
        { "data": "lx" },
        { "data": "dw" },
        { "data": "dz" },
        //{ "data": "gx" },
        { "data": "iscj" },
        { "data": "starttime"},
        { "data": "remark" }
    	 
    ]
   
} );

  /**加上序号**/
  table.on( 'order.dt search.dt', function () {
    table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
        cell.innerHTML = i+1;
    } );
	  } ).draw();
    new $.fn.dataTable.FixedColumns( table, {leftColumns:3});
}
/**
 * 
 * @param curPageNum跳转之前所在的页面页数
 * @id 编辑的页面数据id （当为update时候有效）
 * @editmodel 编辑模式，判定是add还是update
 */
function skipToFormPage(url,curPageNum,id,editModel){
	var $outFrame =  $(window.parent.document.body)  ; 
	var $iframe = $outFrame.find("#mainIframe");
	var src = $iframe.attr("src");
	$iframe.attr('src',url)
}


/**
 * 显示modal框
 */
function showModel(data){
    $('#myModal').modal({
        backdrop:false,
        show:true
    });
    //在modalbody 中家在iframe 内容为 工序编排的内容
    $content = "<iframe src='../xsgl/htManager.jsp?showModal=true&khid="+data+"' class='modal_iframe'></iframe>" ;
    $container = $('#modal-body');
    $container.empty().append($content);
}
 