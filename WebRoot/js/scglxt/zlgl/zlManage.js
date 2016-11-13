/**
 * @author apple
 * @constructor 
 * @date 20141024
 */
(function(){
	var operateFlag = ""; 
	window.ZlManage = (function(){
		var _t = this ,
		_operateFlag = "",
		/**
		 * 初始化函数
		 */
		
		init = function(){
			tableInit();
			registerEvent();
		},
		/**
		 * 注册事件
		 */
		registerEvent = function(){

		},
		/**
		 * 初始化表格函数
		 */
		tableInit = function(){
			var table = $('#bomInfo').DataTable( {
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
		    "aLengthMenu":[20,30],
			"ajax":"bomInfo_getTableData.action?zddzt=0503",
			 "sScrollY" : 450, //DataTables的高  
            "sScrollX" : 600, //DataTables的宽 
//            "bAutoWidth" : false, //是否自适应宽度 
			scrollY:        true,
			scrollX:        true,
			scrollCollapse: true,
			paging:         true,
			columnDefs: [
				{ width: '20%', targets: 0 }
			]
			,
			"columnDefs": [ 
		        {
		            "render": function ( data, type, row ) {
		                return '<div class="">'+
		                ' <a class="btn btn-danger btn-xs" href="#" title＝"通过并入库" onclick = "ZlManage.passAllInfo(\''+data+'\')">通过并入库<i class="icon-edit"></i></a> '+
		                ' <a class="btn btn-success btn-xs" href="#" title＝"不通过" onclick = "ZlManage.editRow(\''+data+'\')">不通过<i class="icon-edit"></i></a>'+
//		                '<a class="btn btn-danger btn-xs" href="#" title="删除">报废<i class="icon-remove" onclick = "HtManage.deleteRow(\''+data+'\')"></i></a>'+
		                ' </div>';
		            },
		            "targets": 1
		        },
		        { "visible": true,  "targets": [ 2 ] }
		    ],
                "columns": [{"data": null, "sWidth": "30px"},
                    {"data": "id"},
                    {"data": "zddmc", "sWidth": "120px"},
                    {"data": "ddztmc", "sWidth": "120px"},
                    {"data": "clmc","sWidth": "120px"},
                    {"data": "gxnr","sWidth": "300px"},
                    {"data": "jgsl","sWidth": "60px"},
                    {"data": "clxz"},
                    {"data": "cldx"},
                    {"data": "cltj"},
                    {"data": "clje"},
                    {"data": "bmcl"},
                    {
                        "data": "starttime",
                        "sWidth": "120px"
                    }, {"data": "endtime", "sWidth": "120px"},
                    {"data": "gs", "sWidth": "120px"},
                    {"data": "blqk", "sWidth": "120px"},
                    {"data": "blkssj", "sWidth": "120px"},
                    {"data": "bljssj", "sWidth": "120px"},
                    {"data": "clzt", "sWidth": "120px"},
                    {"data": "cgry"},
                    {"data": "cgsj"},
                    {"data": "rksj", "sWidth": "120px"},
                    {"data": "ddtz", "sWidth": "120px"},
                    {"data": "bfjs"},
                    {"data": "bhgjs", "sWidth": "120px"},
                ]
		   
		} );

		  /**加上序号**/
		  table.on( 'order.dt search.dt', function () {
		    table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
		        cell.innerHTML = i+1;
		    } );
			  } ).draw();
		  new $.fn.dataTable.FixedColumns( table );
			
        },
            /**通过并入库**/
        passAllInfo=function(id){
                var url = "bomInfo_updateZddzt.action", successFun = function (resStr) {
                    if (resStr == "success") {
                        window.location.reload();
                        $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                        alert("该订单成品入库成功！");
                    }else{
                        alert("该订单成品入库失败！");
                    }
                };
                if (confirm("是否确定全部入库？")) {
                    $.asyncAjaxPost(url, {"id": id,"zddzt":"0504","date":"rksj"}, successFun, true);
                }
        }
		;
		 
		 return{
			 init:init ,
             passAllInfo:passAllInfo
		 }
	})();
	
	
})();



$(document).ready(function(){
	ZlManage.init();
});
 
 
	
 
 