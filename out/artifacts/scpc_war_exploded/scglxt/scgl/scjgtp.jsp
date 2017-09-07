<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>生产管理总体调配</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>

	<!-- jquery ui css 引入 -->
	<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
	<!-- jquery-ui的JS -->
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>


    <script type="text/javascript">
	
	var varbomid = "";
    $(document).ready(function() {

        tableInit();
        $.ajax({
            type: "post",
            url: "scgl_getRyZdInfo.action",
            dataType: "json",
            data: {
                "xh": '06'
            },
            success: function (dt) {
                for (var i = 0; i < dt.length; i++) {
                    var html = "<option value=" + dt[i].id + ">" + dt[i].mc + "</option>";
                    $("#zddjb").append(html);
                }
            }
        });
    } );

	function tableInit(){
		
		var table = $('#pcglBomStatus').DataTable( {
//		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
            "aLengthMenu": [15, 30],
		"ajax":"pcgl_getBomStatusList.action",
		scrollY:        "600px",
		scrollX:        true,
		scrollCollapse: true,
		paging:         true,
		"columnDefs": [ 
            {
                "render": function ( data, type, row ) {
                    return '<div class="text-center"><a href="#" onclick="tzkssj('+"\'"+data+"\'"+')"><span>调整优先级</span></a></div>';
                },
                "targets": 1
            },{
                "render": function ( data, type, row )  {
                    var date = new Date();
                    var now="";
                    now = date.getFullYear() + "/";
                    now = now + (date.getMonth() + 1) + "/";  //取月的时候取的是当前月-1如果想取当前月+1就可以了
                    now = now + date.getDate() + " ";
                    // var cha = Math.round(( Date.parse(data['ddendtime'])-Date.parse(now) ) / 86400000)+1;
                    var cha=$.DateDiff(now,row.ddendtime);
                    if( cha<=0)
                    {
                        return data;
                    }
                    else if ( cha<=3 ) {
                        //$('td', row).eq(3).css('font-weight',"bold").css("background","red").css("color","#FFF");;
                        return '<span class="label label-danger">'+data+'</span>';
                    }else if(cha <7)
                    {
                        return '<span class="label label-warning">'+data+'</span>';
                    }else{
                        return data;
                    }
                }, "targets": 2
            },
            {
                "render": function ( data, type, row ) {
                    var jb=row.zddjb;
                    if (jb=="0601") {
                        return '<span class="label label-danger">'+row.zddjbmc+'</span>';
                    }else if(jb=="0602")
                    {
                        return '<span class="label label-warning">'+row.zddjbmc+'</span>';
                    }else{
                        return '<span>'+row.zddjbmc+'</span>';
                    }
                }, "targets":4
            }
        ],
        "columns": [
             {"data": null,"sWidth": "40px"}, 
             {"data": "id","sWidth": "80px"},
            {"data": "ddmc", "sWidth": "120px"},
            {"data": "zddmc", "sWidth": "120px"},
            {"data": "zddjb", "sWidth": "120px"},
            {"data":"zddztmc","sWidth":"120px"},
            {"data": "ddendtime", "sWidth": "120px"},
            {"data": "jgsl", "sWidth": "120px"},
             {"data": "ddtz","sWidth": "350px"},
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

    function tzkssj(bomid){

        $('#dlg').dialog('open');
        varbomid = bomid;
    }
	function saveSj(){
		$.ajax({
            type: "post",
            url: "pcgl_updateZddjb.action",
            dataType: "text",
            data: {
                "bomid": varbomid,
                "v":$("#zddjb").val()
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
                    <div class='title'>子订单级别调配</div>
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
                                    <th>订单名称</th>
                                    <th> 零件名称</th>
                                    <th> 级别</th>
                                    <th> 状态</th>
                                    <th>订单结束时间</th>
                                    <th> 加工数量</th>
                                    <th> 进度(报废件数/已加工件数/可加工件数)</th>
                                    <th> 表面处理</th>
                                    <th> 开始时间</th>
                                    <th> 完成时间</th>
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
<div id="dlg" class="easyui-dialog" title="调整子订单级别" style="width:300px;height:150px;padding:10px"
			data-options="toolbar: '#dlg-toolbar',buttons: '#dlg-buttons',closed:true">
		
	</div>
	<div id="dlg-toolbar" style="padding:10px">
		<span style="margin-left:20px;margin-top:40px;">子订单级别：</span><select id="zddjb" style="width: 120px;height: 35px;"></select>
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
