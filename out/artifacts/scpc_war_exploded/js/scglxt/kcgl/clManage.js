




/**
 * 订单信息
 * @author apple
 * @constructor 
 * @date 20141024
 */
(function(){
	var operateFlag = ""; 
	window.ClManage = (function(){
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
			$("#form_add").on('click',function(){
				Main.swapIframUrl('scglxt/kcgl/editCl.jsp');//跳转iframe页面
			})			
		},
		/**
		 * 初始化表格函数
		 */
		tableInit = function(){
			var table = $('#clInfo').DataTable( {
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
		    "aLengthMenu":[15,30],
			"ajax":"kcgl_getTableData.action",
			scrollY:        "600px",
			scrollX:        true,
			scrollCollapse: true,
			paging:         true

			,
			"columnDefs": [ 
		        {
		            "render": function ( data, type, row ) {
		                return '<div class="">'+
							' <a onclick = "ClManage.editRow(\''+data+'\')" href="#" title＝"修改">修改</a> '+
								"&nbsp;"+
							' <a onclick = "ClManage.deleteRow(\''+data+'\')" href="#" title="删除">删除</a></div>';
		            },
		            "targets": 1
		        },
		        { "visible": false,  "targets": [ 2 ] } //是否显示列
		    ],
		    "columns": [
		    	{"data":null },
		    	{"data":'id'},
		    	{ "data": "id" },
		        { "data": "clmc" },
		        { "data": "clcz"},
		        { "data": "clsl" },
		        { "data": "cldj" },
		        { "data": "cllx" },
		        { "data": "ghs" },
		        { "data": "mi" },
		        { "data": "clxz" },
		        { "data": "kd" },
		        { "data": "gd" },
		        { "data": "cd" },
		        { "data": "clly" },
 
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
		/**
		 * 删除信息
		 */
		deleteRow = function(id){
			 var url = "kcgl_deleteRow.action",successFun = function(resStr){
                 if (resStr.toUpperCase() == "SUCCESS") {
					 window.location.reload();
					 $("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
                 }
         } ;
         if(confirm("确定删除？")){
        	 $.asyncAjaxPost(url, {"id": id}, successFun, true);
         }

		},
		//跳转页面
		editRow = function(id){
			Main.swapIframUrl('scglxt/kcgl/editCl.jsp?id='+id);//跳转iframe页面
		},
		/**
		 * 更新合同信息
		 */
		saveHtInfo = function(flag){
			
		},
		initHtInfo = function(flag){
			
		},
		/**
		 * 显示modal框
		 */
		showModel = function(data){
			$('#myModal').modal({
				backdrop:false,
				show:true
			});
			//在modalbody 中家在iframe 内容为 工序编排的内容
			$content = "<iframe src='gygcManager.jsp?bomid="+data+"' class='modal_iframe'></iframe>" ; 
			$container = $('#modal-body');
			$container.empty().append($content);
		}
		;
		 
		 return{
			 init:init ,
			 deleteRow:deleteRow,
			 editRow:editRow,
			 showModel:showModel
		 }
	})();
	
	
})();



$(document).ready(function(){
	ClManage.init();
});
 
 
	
