<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	</head>
	<script type="text/javascript">

	function deleteRow(id){
		
		//判断是否要删除
		//删除数据库成功后删除表格
		//1、删除数据库
		$.ajax({
		  type: "post",
		  url: "xsgl_deleteRyInfo.action",
		  dataType: "text",
		  data:{
		  	"id":id
		  },
		  success:function(dt){
		  	alert(dt);
		  	window.location.reload(); 
		  	$("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
		  }
		}); 
		
		//2、删除表格
	}
	
	function tableInit(){
	
		var table = $('#ryxx').DataTable( 
	    {
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
        aLengthMenu:[15,30],
		ajax:"pcgl_getZtJgQk.action",
		scrollY:        "500px",
		scrollX:        true,
		scrollCollapse: false,
		paging:         true,
        columns: [
        	{"data":null,"sWidth":"40px"},
            { "data": "ddmc","sWidth":"120px"},
        	{ "data": "zddmc","sWidth":"120px"},
        	{ "data": "gynr","sWidth":"120px"},
            { "data": "jgry","sWidth":"80px"},
            { "data": "jgjs" ,"sWidth":"80px"},
            { "data": "bfjs" ,"sWidth":"80px"},
            { "data": "sbmc" ,"sWidth":"80px"},
            { "data": "edgs" ,"sWidth":"80px"},
            { "data": "sjgs" ,"sWidth":"80px"},
            { "data": "jgkssj" ,"sWidth":"120px"},
            { "data": "jgjssj" ,"sWidth":"120px"}
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
	
	/***
		初始化表格
	**/
	$(document).ready(function() {
	
		tableInit();
        $("#form_export").on('click', function () {
                window.location.href='../resmgr_exportResourceData.action?tableId=0401';
        });
	} );
</script>

	<body>
			<div class='container-fluid'>
				<div   id='content-wrapper'>
							<div class='col-sm-12'>
								<div class='box bordered-box orange-border'
									style='margin-bottom: 0;'>
									<div class='box-header'>
                                        <button id="form_export" class="btn btn-success btn-sm"><i class="icon-add"></i> 导出</button>
										<div class='title'>
											生产加工情况
										</div>
										<div class='actions'>
											<a class="btn box-remove btn-xs btn-link" href="#"><i
												class='icon-remove'></i> </a>

											<a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
											</a>
										</div>
									</div>

									<div class='box-content box-no-padding'>
												<table id="ryxx" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
													<thead>
														<tr>
															<th>
															</th>
                                                            <th>
                                                                订单名称
                                                            </th>
															<th>
																子订单名称
															</th>
															<th>
																工艺内容
															</th>
															<th>
																加工人员
															</th>
															<th>
																加工件数
															</th>
															<th>
																报废件数
															</th>
															<th>
																所用设备
															</th>
                                                            <th>
                                                                额定工时
                                                            </th>
                                                            <th>
                                                                实际工时
                                                            </th>
															<th>
																开始时间
															</th>
															<th>
																结束时间
															</th>
														</tr>
													</thead>

												</table>
									</div>
								</div>
							</div>
				</div>
			</div>
	</body>
</html>
