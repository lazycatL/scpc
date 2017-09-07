<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>检验人员检验</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	<!-- jquery ui css 引入 -->
	<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
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
                    var text= '<div class="text-center"><a href="#" onclick="jyryqbtg('+"\'"+data+"\'"+')">全部通过</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="jyryJy('+"\'"+data+"\'"+')">部分通过</a>&nbsp;&nbsp;&nbsp;'+
                                '<a href="#" onclick="jyryqbdh('+"\'"+data+"\'"+')">全部返工</a>';
                    return text;
                },
                "targets": 1
            }, {
                "render": function ( data, type, row ) {
                    var jb=row.zddjb;
                    var text=data;
                    if(row.tzlx!=null && row.tzlx!="")
                    {
                        if(row.tzlx.toUpperCase().indexOf("JPG")!=-1 || row.tzlx.toUpperCase().indexOf("PNG")!=-1 || row.tzlx.toUpperCase().indexOf("GIF")!=-1)
                        {
                            text=' <a class=" "  TARGET="viewer"  href="../lctImg.html?img=' + row.tzurl + '" title="图纸"> '+row.zddmc+'</a>';
                        }else{
                            text=' <a class=""  TARGET="viewer"  href="../../'+ row.tzurl + '" title="图纸"> '+row.zddmc+'</a>';
                        }
                    }
                    if (jb=="0601") {
                        return '<span class="label label-danger">'+text+'</span>';
                    }else if(jb=="0602")
                    {
                        return '<span class="label label-warning">'+text+'</span>';
                    }else{
                        return '<span>'+text+'</span>';
                    }
                }, "targets": 3
            },
                {
                "render": function ( data, type, row )  {
                    var date = new Date();
                    var now="";
                    now = date.getFullYear() + "/";
                    now = now + (date.getMonth() + 1) + "/";  //取月的时候取的是当前月-1如果想取当前月+1就可以了
                    now = now + date.getDate() + " ";
                    // var cha = Math.round(( Date.parse(data['ddendtime'])-Date.parse(now) ) / 86400000)+1;
                    var cha=$.DateDiff(now,row.ddjssj);
                    if( cha<=0)
                    {
                        return '<span class="label">'+data+'</span>';
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
            }
        ],
        "columns": [
             {"data": null,"sWidth": "60px"}, 
             {"data": 'id',"sWidth": "200px"},
             {"data": "ddmc", "sWidth":"220px"},
             {"data": "zddmc", "sWidth":"220px"},
             {"data": "bmcl","sWidth": "180px"},
             {"data": "gymc","sWidth": "120px"},
             {"data": "rymc","sWidth": "120px"}, 
             {"data": "sbmc", "sWidth": "180px"},
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
	
		tableInit();
        //定时器每10秒刷新table如果有新的工作自动更新
        setInterval(function(){
            $('#pcglJyryJy').DataTable().draw(false);;
        },5000);
	} );
	
	function jyryJy(jgglid){
	
		varjgglid = jgglid;
		$('#dlg').dialog('open');
	}
	
	
	function jyryqbtg(data){
		
		varjgglid = data;
        $.ajax({
            type: "post",
            url: "pcgl_jyqbtg.action",
            dataType: "text",
            data: {
                "id": varjgglid
            },
            success: function (dt) {

                if(dt=='success'){

                    Main.ShowSuccessMessage("检验全部通过！");
                    $('#pcglJyryJy').DataTable().ajax.reload(function(){},true);

                }else{
                    Main.ShowSuccessMessage("对不起发生错误，请联系管理员！");
                }

            }
        });
	}
	function saveJggl(flag){

		var bfjs = $('#bfjs').val();
        var dhyy= $("#bf_dhyy").val();
		if(bfjs==0 || bfjs==null){
            Main.ShowErrorMessage("请填写件数再提交！");
            return;
		}
        if(dhyy=="" || dhyy==null){
            Main.ShowErrorMessage("请填写打回原因再提交！");
            return;
        }
		$.ajax({
                type: "post",
                url: "pcgl_editJgglJy.action",
                dataType: "text",
                data: {
                    "id": varjgglid,
                    "sjzt":$("#bftgyy").val(),
                    "bfjs":bfjs,
                    "dhyy":dhyy
                },
                success: function (dt) {
					if(dt=='success'){
						$('#dlg').dialog('close');
						$('#pcglJyryJy').DataTable().ajax.reload(function(){},true);
					}else{
                        Main.ShowErrorMessage("对不起发生错误，请联系管理员！");
					}
                }
            });
	
	}
	//全部打回送检产品
    function jyryqbdh(data)
    {
        varjgglid = data;
        $('#myModal').modal({backdrop: false, show: true });
    }

    function saveJyqbdh()
    {
        $.ajax({
            type: "post",
            url: "pcgl_jyqbdh.action",
            dataType: "text",
            data: {
                "id": varjgglid,
                "dhyy":$("#dhyy").val()
            },
            success: function (dt) {
                if(dt=='success'){
                    $('#myModal').modal('hide');
                    Main.ShowSuccessMessage("全部打回！");
                    $('#pcglJyryJy').DataTable().ajax.reload(function(){},true);
                }else{
                    Main.ShowSuccessMessage("对不起发生错误，请联系管理员！");
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
                                    <th> 订单名称</th>
                                    <th> 零件名称</th>
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
			data-options="toolbar: '#dlg-body',buttons: '#dlg-buttons',closed:true">
		
	</div>
	<div id="dlg-body" style="padding:15px">
        <div class='form-group'>
            <label class='control-label'>选择部分通过原因</label>
                <select class="form-control" id="bftgyy" style="">
                    <option value="2201">返工</option>
                    <option value="2202">报废</option>
                </select>
        </div>
        <div>
            <label class='control-label'>请输入不通过件数</label>
            <div class='controls'>
                <input class="form-control" id="bfjs" width="" type="text">
            </div>
        </div>
        <div>
            <label class='control-label'>请输入不通过原因</label>
            <div class='controls'>
                <input class="form-control" id="bf_dhyy" width="" type="text">
            </div>
        </div>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveJggl(0)">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
</div>
<!-- 模态框（Modal）-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:400px;height:260px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel"><b>填写返工原因</b></h5>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>

            <div class="modal-body" id="modal-body">
                <textarea id="dhyy" cols="55" rows="5"></textarea>
                <input id="btn_saveCyy" style="margin-left: 200px;" onclick="saveJyqbdh();" class="btn" type="button" value="保存">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
</body>
</html>
