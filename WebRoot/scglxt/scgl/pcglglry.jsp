<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>生产管理总体时间调配</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>

	<!-- jquery ui css 引入 -->
	<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
	<!-- jquery-ui的JS -->
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	
	var varbomid = "";
	function tableInit(){
		
		var table = $('#pcglBomStatus').DataTable( {
//		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "bLengthChange": true,
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
            "aLengthMenu": [5, 15],
		"ajax":"pcgl_getBomStatusList.action",
		scrollY:        "600px",
		scrollX:        true,
		scrollCollapse: true,
		paging:         false,
		"columnDefs": [ 
            {
                "render": function ( data, type, row ) {
                    return '<div class="text-center"><a href="#" onclick="tzkssj('+"\'"+data+"\'"+')"><span>调整时间</span></a></div>';
                },
                "targets": 1
            },
            { "visible": true,  "targets": [ 2 ] }
        ],
        "columns": [
             {"data": null,"sWidth": "40px"}, 
             {"data": "id","sWidth": "80px"}, 
             {"data": "zddmc", "sWidth": "120px"}, 
             {"data": "ddtz","sWidth": "180px"},
             {"data": "bmcl","sWidth": "120px"},
             {"data": "jhkssj","sWidth": "150px"}, 
             {"data": "jhjssj", "sWidth": "150px"},
             {"data": "gs", "sWidth": "150px"}
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
	$(document).ready(function() {
	
		tableInit();
		
		
		
	} );
	
	function tzkssj(bomid){
		
		$('#dlg').dialog('open');
		varbomid = bomid;
		$('#jhkssj').datetimepicker({
			format: 'yyyy-mm-dd hh:ii'
		});
	}
	
	function saveSj(){
		
		var jhkssj = $('#jhkssj').val();
		$.ajax({
            type: "post",
            url: "pcgl_updateJhkssj.action",
            dataType: "text",
            data: {
            	
                "bomid": varbomid,
                "v":jhkssj
                
            },
            success: function (dt) {
	              	
            	$('#dlg').dialog('close');
            	$('#pcglBomStatus').DataTable().ajax.reload(function(){},true);
            }
        });
	}
	</script>
</head>
<body>
<div class='container container-wrapper'>
    <div class='row' id='content-wrapper'>
        <div class='row rowTop'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'>总体时间调配</div>
                    <div class='actions'><a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                    </a> <a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a></div>
                </div>
                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="pcglBomStatus" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th> 操作</th>
                                    <th> 名称</th>
                                    <th> 状态(报废件数/)</th>
                                    <th> 表面处理</th>
                                    <th> 计划开始时间</th>
                                    <th> 计划完成时间</th>
                                    <th> 额定工时</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlg" class="easyui-dialog" title="调整时间" style="width:400px;height:200px;padding:10px"
			data-options="toolbar: '#dlg-toolbar',buttons: '#dlg-buttons',closed:true">
		
	</div>
	<div id="dlg-toolbar" style="padding:10px">
		
		<span style="margin-left:40px;margin-top:40px;">调整时间：</span><input id="jhkssj" width="120px"></input>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveSj()">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
</div>
<script>

</script>
</body>
</html>
