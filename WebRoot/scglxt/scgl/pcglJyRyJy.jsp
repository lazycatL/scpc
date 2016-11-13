<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>检验人员检验</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	<!-- jquery ui css 引入 -->
	<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
    <link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/ themes/icon.css">
	<!-- jquery-ui的JS -->
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>

	<script type="text/javascript">
	
	var varjgglid = "";
	function tableInit(){
		
		var table = $('#pcglJyryJy').DataTable( {
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
        "aLengthMenu":[15,30],
		"ajax":"pcgl_getBomGygcJy.action",
		scrollY:        "300px",
		scrollX:        true,
		scrollCollapse: false,
		paging:         true,
		"columnDefs": [ 
            {
                "render": function ( data, type, row ) {
                    return '<div class="text-center"><a href="#" onclick="jyryqbtg('+"\'"+data+"\'"+')">全部通过</a>&nbsp;&nbsp;&nbsp;&nbsp<a href="#" onclick="jyryJy('+"\'"+data+"\'"+')">部分通过</a></div>';
                },
                "targets": 1
            },
            { "visible": true,  "targets": [ 2 ] }
        ],
        "columns": [
             {"data": null,"sWidth": "60px"}, 
             {"data": 'id',"sWidth": "150px"}, 
             {"data": "zddmc", "sWidth":"120px"}, 
             {"data": "bmcl","sWidth": "120px"},
             {"data": "gymc","sWidth": "120px"},
             {"data": "rymc","sWidth": "120px"}, 
             {"data": "sbmc", "sWidth": "120px"},
             {"data": "jgjs", "sWidth": "120px"}
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
	
		tableInit()
	} );
	
	function jyryJy(jgglid){
	
		varjgglid = jgglid;
		$('#dlg').dialog('open');
		
	
	}
	
	
	function jyryqbtg(data){
		
		varjgglid = data;
		saveJggl(1);
	}
	function saveJggl(flag){
	
		var bfjs = 0;
		
		if(flag==0){
			
			bfjs = $('#bfjs').val();
		}
	
		$.ajax({
                type: "post",
                url: "pcgl_editJgglJy.action",
                dataType: "text",
                data: {
                    "id": varjgglid,
                    
                    "v": bfjs
                    
                },
                success: function (dt) {

					if(dt=='success'){
					
						$('#dlg').dialog('close');
						$('#pcglJyryJy').DataTable().ajax.reload(function(){},true);
						
					}else{
					
						alert("对不起发生错误，请联系管理员！");
					}
    	              	
                }
            });
	
	}
	</script>
</head>
<body>
<div class='container container-wrapper'>
    <div id='content-wrapper'>
        <div class='row rowTop'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'> 检验</div>
                    <div class='actions'> <button id="form_return" class="btn btn-success btn-sm">
                        <i class="icon-add"></i> 返回
                    </button></div>
                </div>
                <div class='box-content box-no-padding'>
                            <table id="pcglJyryJy" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;width:100%;'>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th> 操作</th>
                                    <th> 子订单名称</th>
                                    <th> 特殊处理</th>
                                    <th> 工艺名称</th>
                                    <th> 加工人员</th>
                                    <th> 所用设备</th>
                                    <th> 送检数量</th>
                                </tr>
                                </thead>
                            </table>
                </div>
            </div>
        </div>
    </div>
    
    <div id="dlg" class="easyui-dialog" title="检验" style="width:400px;height:200px;padding:10px"
			data-options="toolbar: '#dlg-toolbar',buttons: '#dlg-buttons',closed:true">
		
	</div>
	<div id="dlg-toolbar" style="padding:15px">
		
		<span style="margin-left:40px;margin-top:40px;">请输入报废件数：</span><input id="bfjs" width="120px;">
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveJggl(0)">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
</div>
</body>
</html>
