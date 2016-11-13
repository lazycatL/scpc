/**
 * 订单信息
 * @author apple
 * @constructor 
 * @date 20141024
 */
(function(){
	var operateFlag = ""; 
	window.CpManage = (function(){
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
				Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp');//跳转iframe页面
			})			
		},
		/**
		 * 初始化表格函数
		 */
		tableInit = function(){
			var table = $('#bomInfo').DataTable( {
//			"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
			"ajax":"bomInfo_getTableData.action",
			scrollY:        "600px",
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
		                ' <a class="btn btn-info btn-xs" href="#" title＝"修改" onclick = "BomManage.editRow(\''+data+'\')"><i class="icon-edit" ></i></a>'+
		                ' <a class="btn btn-danger btn-xs" href="#" title="删除"><i class="icon-remove" onclick = "BomManage.deleteRow(\''+data+'\')"></i></a></div>';
		            },
		            "targets": 1
		        },
		        { "visible": false,  "targets": [ 2 ] } //是否显示列
		    ],
		    "columns": [
		    	{"data":null,"sWidth":"60px"},
		    	{"data":'id', "sWidth":"200px"},
		    	{ "data": "id" },
		        { "data": "zddmc" } ,
		        { "data": "zddcz" },
		        { "data": "gxnr","sWidth":"300px" },
		        { "data": "clxz" },
		        { "data": "cldx" },
		        { "data": "cltj" },
		        { "data": "clje" },
		        { "data": "jgsl" },
		        { "data": "bmcl" },
		        { "data": "starttime" },
		        { "data": "endtime" },
		        { "data": "gs" },
		        { "data": "blqk" },
		        { "data": "blkssj" },
		        { "data": "bljssj" },
		        { "data": "clzt" },
		        { "data": "cgry" },
		        { "data": "cgsj" },
		        { "data": "rksj" },
		        { "data": "ddtz" },
		        { "data": "bfjs" },
		        { "data": "bhgjs" },
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
			 var url = "bomInfo_deleteRow.action",successFun = function(resStr){
                 if (resStr == "SUCCESS") {
	     			  	window.location.reload(); 
	    			  	$("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
						alert("SUCCESS！");
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
		//跳转页面
		editRow = function(id){
			alert();
			Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp?id='+id);//跳转iframe页面
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
	CpManage.init();
});
 
 
	
