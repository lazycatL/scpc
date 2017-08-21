/**
 * @author apple
 * @constructor 
 * @date 20141024
 */
(function(){
	var operateFlag = "";
    var selectRowId="";
	window.HtManage = (function(){
		var _t = this ,
		_operateFlag = "",
		/**
		 * 初始化函数
		 */
		
		init = function(){
			var urlParam = new Object();
			urlParam = $.GetRequest();
			if(urlParam.showModal){
				$("#form_add").remove();
			}
			tableInit(urlParam);
			registerEvent();
		},
		/**
		 * 注册事件
		 */
		registerEvent = function(){
			$("#form_add").on('click',function(){
				Main.swapIframUrl('scglxt/xsgl/editHtInfo.jsp');//跳转iframe页面
			});
            //导出报价单模板
            $("#form_exportbjd").on("click",function(){
                window.location.href=resUrl+'/resourceImport_exportAllTemplate.action?tableId=0110&ISIMPORT=1&ISSHOWDELETE=1&PAGEBEAN.CURRENTPAGE=1&ISEXPORT=1&PAGEBEAN.PAGESIZE=10&ISSHOWQUERY=1&ISSHOWDATA=1&LISTORDERRULE=&ISSHOWNO=1&ISSHOWLOG=1&TABLEID=0104&ISBATCHDELETE=1&LISTORDERCOLUMN=&ISSHOWMODIFY=1&ISSHOWPAGE=1&ISSHOWHEAD=1&ISBATCHMODIFY=1&ISSUPERQUERY=1&ISSHOWINSERT=1&ISSHOWTITLE=1&ISSHOWPROPERTY=1&';
            });
            //点击导入
            $("#btn_import").on("click",function(){
                var file= $('#import_excel').attr("filepath");
                if(file==null || file=="")
                {
                    Main.ShowErrorMessage("请先选择excel上传后再执行导入！");
                    return;
                }else{
                    var url = "import_excel.action", successFun = function (resStr) {
                        if (resStr) {
                            $('#bomInfo').DataTable().ajax.reload(function(){},true);
                            $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                            $('#myModalUpload').modal('hide');
                            Main.ShowSuccessMessage("导入成功！");
                        }else{
                            $('#myModalUpload').modal('hide');
                            Main.ShowSuccessMessage("导入失败，请联系管理员！");
                        }
                    };
                    if (confirm("确定导入上传的Excel？")) {
                        $.asyncAjaxPost(url, {"filepath": file,"ssht":selectRowId}, successFun, true);
                    }
                }
            });
		},
		/**
		 * 初始化表格函数
		 */
		tableInit = function(urlParam){
			var khid ="";
			if(urlParam &&urlParam.khid){
				khid = urlParam.khid ;
			}
			var table = $('#htInfo').DataTable( {
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
			"ajax":"htInfo_getTableData.action?khid="+khid,
			 "sScrollY" : 450, //DataTables的高  
            "sScrollX" : 600, //DataTables的宽 
//            "bAutoWidth" : false, //是否自适应宽度 
			scrollY:        true,
			scrollX:        true,
			scrollCollapse: true,
			paging:         true,
			"columnDefs": [ 
		        {
		            "render": function ( data, type, row ) {
		                return '<div class="">'+
		                ' <a class="" href="#" onclick = "HtManage.editRow(\''+data+'\')" title＝"修改">修改 </a> '+
		                '<a class="" href="#" title="删除" onclick = "HtManage.deleteRow(\''+data+'\')">删除</a>'+
                            ' <a class="" href="#" title＝"上传报价单" onclick = "HtManage.showHtfj(\''+data+'\')">上传报价单</a> '+
							' <a class="" href="#" title＝"查看" onclick = "HtManage.showModel(\''+data+'\',\'dd\')">查看订单</a> '+
                            ' <a class="" href="#" title＝"查看" onclick = "HtManage.showModel(\''+data+'\',\'bjd\')">查看报价单</a> '+
                            ' </div>';
		            },
		            "targets": 1
		        },
				{
					"render": function ( data, type, row ) {
						if(data !=null  && data !="" ){
							return data + "%" ;
						}else{
							return data ;
						}
					},
					"targets": 9
				}
		    ],
		    "columns": [
		    	{"data":null},
		    	{"data":'id',"sWidth": "280px"},
		        { "data": "htbh" ,"sWidth": "180px"},
                { "data": "khmc" ,"sWidth": "250px" },
		        { "data": "ywlx" },
		        { "data": "htje" },
		        { "data": "qssj" },
		        { "data": "jssj" },
		        { "data": "fkztmc" },
		        { "data": "jkbfb" },
		        { "data": "jkje" },
		        { "data": "jscb" },
		        { "data": "htmx" }
		    ]
		   
		} );

		  /**加上序号**/
		  table.on( 'order.dt search.dt', function () {
		    table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
		        cell.innerHTML = i+1;
		    } );
			  } ).draw();
//		  new $.fn.dataTable.FixedColumns( table );
			new $.fn.dataTable.FixedColumns( table, {leftColumns:3});


		},
		/**
		 * 删除信息
		 */
		deleteRow = function(id){
			 var url = "htInfo_deleteRow.action",successFun = function(resStr){
                 if (resStr == "SUCCESS") {
                    $('#htInfo').DataTable().ajax.reload(function(){},true);
	    			$("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
                     Main.ShowSuccessMessage("删除成功！");
                 }
         } ;
         if(confirm("是否删除？")){
        	 $.asyncAjaxPost(url, {"id": id}, successFun, true);
         }
		},
		//跳转页面
		editRow = function(id){
			Main.swapIframUrl('scglxt/xsgl/editHtInfo.jsp?id='+id);//跳转iframe页面
		},
		/**
		 * 更新合同信息
		 */
		saveHtInfo = function(flag){
			
		},
		initHtInfo = function(flag){
			
		},
        showHtfj = function(data){
            selectRowId=data;
            $('#import_excel').ssi_uploader({url:'../../ImageUploadServlet?type=excel',preview:false,dropZone:false,allowed:['xls'],ajaxOptions:{
                success:function(file){
                    $('#import_excel').attr("filepath",file);
                    Main.ShowSuccessMessage("上传成功！");
                }
            }});
            $('#myModalUpload').modal({
                backdrop: false,
                show: true
            });
        },
		/**
		 * 显示modal框
		 */
		showModel = function(data,type) {

            if (type === "dd") {
                Main.swapIframUrl("scglxt/jsgl/ddManager.jsp?showModal=true&ssht=" + data);//跳转iframe页面
            }else{
                $('#myModal').modal({
                    backdrop:false,
                    show:true
                });
                //在modalbody 中家在iframe 内容为 工序编排的内容
                $content = "<iframe src='../../resmgr/resView.html?tableId=0110&isFlag=list&queryColumn=ssht_id&queryKey="+data+"&temp="+Math.random()+"' class='modal_iframe'></iframe>" ;
                $container = $('#modal-body');
                $container.empty().append($content);
            }
		}
		;
		 return{
			 init:init ,
			 deleteRow:deleteRow,
			 editRow:editRow,
             showHtfj:showHtfj,
			 showModel:showModel
		 }
	})();
	
	
})();



$(document).ready(function(){
	HtManage.init();
});
 
 
	
 
 