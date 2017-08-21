/**
 * 订单信息
 * @author apple
 * @constructor 
 * @date 20141024
 */
(function(){
	var operateFlag = ""; 
	window.HtManage = (function(){
		var _t = this ,
		_operateFlag = "",
		/**
		 * 初始化函数
		 */
		
		init = function(){
			tableInit();

		},
		/**
		 * 初始化表格函数
		 */
		tableInit = function(){
			var table = $('#gyInfo').DataTable( {
			"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
		    "aLengthMenu":[2,3],
			"ajax":"gyInfo_getTableData.action",
			scrollY:        "300px",
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
		                '<a class="btn btn-success btn-xs" href="#"><i class="icon-ok"></i></a>'+
		                ' <a class="btn btn-danger btn-xs" href="#" title="删除"><i class="icon-remove" onclick = "HtManage.deleteRow(\''+data+'\')"></i></a>'+
		                ' <a class="btn btn-danger btn-xs" href="#" title＝"修改"><i class="icon-remove" onclick = "HtManage.editRow(\''+data+'\')"></i></a></div>';
		            },
		            "targets": 1
		        },
		        { "visible": true,  "targets": [ 2 ] }
		    ],
		    "columns": [
		    	{"data":null,},
		    	{"data":'id',},
		    	{ "data": "id" },
		        { "data": "sszdd" } ,
		        { "data": "gxbh" },
		        { "data": "gxsx" },
		        { "data": "gxsysb" },
		        { "data": "jgjs" },
		        { "data": "bzid" },
		        { "data": "ryid" },
		        { "data": "ghjgs" },
		        { "data": "jhstarttime" },
		        { "data": "jhendtime" },
		        { "data": "gzlsfbh" },
		        { "data": "gxtz" },
		        { "data": "jggy" },
		        { "data": "sfyjwc" },
		        { "data": "ywcjs" },
		        { "data": "wcbfb" },
		        { "data": "wcsj" },
		        { "data": "jgmx" },
		        { "data": "pjjggs" }
		    ]
		   
		} );

		  /**加上序号**/
		  table.on( 'order.dt search.dt', function () {
		    table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
		        cell.innerHTML = i+1;
		    } );
			  } ).draw();
			new $.fn.dataTable.FixedColumns( table, {leftColumns:3});

		},
		/**
		 * 删除信息
		 */
		deleteRow = function(id){
			 var url = "ddInfo_deleteRow.action",successFun = function(resStr){
                 if (resStr == "SUCCESS") {
	     			  	window.location.reload(); 
	    			  	$("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
                     Main.ShowSuccessMessage("删除成功！");
                 }
         } ;
         if(confirm("确定删除？")){
        	 $.asyncAjaxPost(url, {"id": id}, successFun, true);
         }
			//判断是否要删除
			//删除数据库成功后删除表格
			//1、删除数据库
			//2、删除表格			
		},
		/**
		 * 更新合同信息
		 */
		saveHtInfo = function(flag){
			
		},
		initHtInfo = function(flag){
			
		}
		;
		
		 
		 
		 return{
			 init:init ,
			 deleteRow:deleteRow
		 }
	})();
	
	
})();



$(document).ready(function(){
	HtManage.init();
});
 
 
	
 
 