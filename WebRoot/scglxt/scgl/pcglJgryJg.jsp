<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>加工人员加工</title>
<script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
<link rel="stylesheet" href="../../js/plugin/bootstrap/css/bootstrap.css" type="text/css"></link>

<!-- jquery ui css 引入 -->

<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
<!-- jquery-ui的JS -->
<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../../js/util/NumKeyBoard.js"></script>

	<script type="text/javascript">
	
	var gygcid = "";
	
	function jgryksjgWindowOpen(data){
		
		$('#ksjg').dialog('open');
		
		gygcid = data;

        initBzzd();
		disableButtonByJgr(data);
	}
	function initSbzd(){
		
		$.ajax({
            type: "post",
            url: "pcgl_getJgSbInfo.action",
            dataType: "json",
            success: function (dt) {

                for (var i = 0; i < dt.length; i++) {
                    var html = "<option value=" + dt[i].id + ">" + dt[i].sbmc + "</option>";
                    $("#jgsb").append(html);
                }

            }
        });
	}
    function initBzzd(){

        $.ajax({
            type: "post",
            url: "scglbz_getBzTableData.action",
            dataType: "json",
            success: function (dt) {
                $("#selbzry").html('');
                var ssbz=GetCookie("userSsbz");
                for (var i = 0; i < dt.data.length; i++) {
                    var html = "<option value=" + dt.data[i].id + ">" + dt.data[i].bzmc + "</option>";
                    if( dt.data[i].id==ssbz)
                    {
                        html = "<option value=" + dt.data[i].id + "  selected='selected'>" + dt.data[i].bzmc + "</option>";
                    }
                    $("#selbzry").append(html);
                }
                initBzRy();
            }
        });
    }
	
	function initBzRy(){
		
		$.ajax({
            type: "post",
            url: "pcgl_getRyByBz.action",
            dataType: "json",
            data:{
            	
            	ssbz: $("#selbzry option:selected").val()
            },
            async:false,
            success: function (dt) {

                $("#bzry").html('');
                for (var i = 0; i < dt.length; i++) {
                    var html = "<a href='#' onclick='ryKsJg(event)' class='btn' id=ks"+dt[i].id+">"+dt[i].mc+"</a>";
                    $("#bzry").append(html);
                }
            }
        });
	}
	
	function disableButtonByJgr(data){
		
		
		$.ajax({
            type: "post",
            url: "pcgl_getYksGyJgry.action",
            dataType: "json",
            data:{
            	
            	gygcid:data
            },
            success: function (dt) {

            	if(dt!=null){
            		
            		for (var i = 0; i < dt.length; i++) {
               		 
                	 	$("#ks"+dt[i].id).removeClass("btn");
                	 	$("#ks"+dt[i].id).addClass("btn disabled");
                     }	
            	}
            }
        });
	}
	
	function ryKsJg(event){
		
		var ksjgry = $(event.target).attr("id")
		ksjgry=ksjgry.substr(2,ksjgry.length);
		
		jgryJgks(ksjgry,gygcid);
	}
    /**
     * 显示modal框
     */
     function showModel(data) {
        $('#myModal').modal({
            backdrop: false,
            show: true
        });
        //在modalbody 中家在iframe 内容为 工序编排的内容
        $content = "<iframe src='/scglxt/jsgl/gygcManager.jsp?bomid=" + data + "' class='modal_iframe'></iframe>";
        $container = $('#modal-body');
        $container.empty().append($content);
    }
	function tableInit(){
		
		var table = $('#pcglJgryJg').DataTable( {
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
		"ajax":"pcgl_getBomGygcJg.action",
		scrollY:        "580px",
		scrollX:        true,
		scrollCollapse: true,
		paging:         true,
		"columnDefs": [ 
            {
                "render": function ( data, type, row ) {
                    if (row.kjgjs != "0") {
                            return '<div class="text-center">  <a class=" " href="#" title="工序编排" ' +
                            'onclick = "showModel(\'' + row.bomid + '\')"> 工艺编排</a>&nbsp;&nbsp;' +
                            ' <a class=" "  TARGET="viewer"  href="http://' + window.location.hostname + '/uploadFile/' + row.xmname + "/" + row.ddtz + '" title="图纸" ' +
                            '> 图纸</a>&nbsp;&nbsp;'
                            + '<a href="#" onclick="jgryksjgWindowOpen(' + "\'" + data + "\'" + ')">开始</a>&nbsp;&nbsp;<a href="#" onclick="jgryJgJs(' + "\'" + data + "\'" + ')">结束</a></div>';
                    }else{
                        return '<span></span>';
                    }
                },
                "targets": 1
            }
        ],
        "columns": [
             {"data": null,"sWidth": "30px"},
             {"data": 'id',"sWidth": "150px"},
             {"data": "zddmc", "sWidth": "120px"}, 
             {"data": "bmcl","sWidth": "80px"},
             {"data": "jhkssj","sWidth": "100px"},
             {"data": "jhjssj","sWidth": "100px"},
             {"data": "gs", "sWidth": "40px"},
             {"data": "gymc", "sWidth": "100px"},
            {"data": "jgsl", "sWidth": "60px"},
            {"data": "kjgjs", "sWidth": "60px"},
             {"data": "yjgjs", "sWidth": "60px"},
             {"data": "bfjs", "sWidth": "80px"},
             {"data": "djgjs", "sWidth": "80px"},
             {"data": "sjjs", "sWidth": "100px"}
        ]
       
	} );
	
	  /**加上序号**/
	  table.on( 'order.dt search.dt', function () {
        table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
            cell.innerHTML = i+1;
        } );
   	  } ).draw();
	  //new $.fn.dataTable.FixedColumns( table, {leftColumns:4});
	}
	
	
	function jgryJgJs(data){
		
		
		yksjgryjs(data);	
		$('#dlg').dialog('open');
		gygcid = data;
		$('#jgsb').val('')
		
	}
	
	function yksjgryjs(data){
		
		
		$.ajax({
            type: "post",
            url: "pcgl_getYksGyJgry.action",
            dataType: "json",
            data:{
            	
            	gygcid:data
            },
            success: function (dt) {

            	 $("#dlg-buttons").html('');
            	 $('#jgsb').val('')
            	 for (var i = 0; i < dt.length; i++) {
            		 
            		  var html = "<a href='#' onclick='saveSj(event)' class='btn' id=js"+dt[i].id+">"+dt[i].mc+"</a>";
                      $("#dlg-buttons").append(html);
                 }
            	
            }
        });
	}
	
	function saveSj(event){
		
		var jsjgry = $(event.target).attr("id");
		
		jsjgry = jsjgry.substr(2,jsjgry.length);
		var jgsb = $('#jgsb').val();
		
		
		var jgjs = $('#jgjs').val();
		
		if(jgjs==""){
			
			alert('请输入本次加工件数！');
			return;
		}
		$.ajax({
            type: "post",
            url: "pcgl_jgryJs.action",
            dataType: "text",
            data: {
                "gygcid": gygcid,
                "wcjs":jgjs,
                "sbid":jgsb,
                "jsjgry":jsjgry
                
            },
            success: function (dt) {
	              	
            	$('#dlg').dialog('close');
            	$('#pcglJgryJg').DataTable().ajax.reload(function(){},true);
            }
        });
	}
	function jgryJgks(jgry,gygcid){
		$.ajax({
            type: "post",
            url: "pcgl_jgryKs.action",
            dataType: "text",
            data: {
                "gygcid": gygcid,
                "jgryid":jgry
                
            },
            success: function (dt) {

				if(dt=='success'){
				
					alert('加工开始成功,已开始计时');
					disableButtonByJgr(gygcid);
					
				}else{
				
					alert("对不起发生错误，请联系管理员！");
				}
	              	
            }
        });
	}
	$(document).ready(function() {
	
		tableInit();
		initSbzd();
        $(".numkeyboard").numkeyboard({
            keyboardRadix:300,//键盘大小基数
            mainbackground:'#C8BFE7', //主背景色
            menubackground:'#4A81B0', //头背景色
            exitbackground:'#4376A0', //关闭按钮背景色
            buttonbackground:'#ff730e', //键盘背景色
            clickeve:true//是否绑定元素click事件
        });
	} );
	
	</script>
</head>
<body>

<div class='container container-wrapper'>
    <div class='row' id='content-wrapper'>
        <div class='row rowTop'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'>加工</div>
                    <div class='actions'><a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                    </a> <a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a></div>
                </div>
                <div class='box-content box-no-padding'>
                      <table id="pcglJgryJg" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th  style="width:150px;"> 操作</th>
                                    <th> 子订单</th>
                                    <th> 表面处理</th>
                                    <th> 计划开始时间</th>
                                    <th> 计划完成时间</th>
                                    <th> 额定工时</th>
                                    <th> 工艺名称</th>
                                    <th> 订单件数</th>
                                    <th> 可加工件数</th>
                                    <th> 已通过检验件数</th>
                                    <th> 已报废件数</th>
                                    <th> 待加工件数</th>
                                    <th> 已送检件数</th>
                                </tr>
                                </thead>
                            </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:950px;height:500px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <button id="modalClose" type="button" class="close"
                        data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body">
            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<div id="dlg" class="easyui-dialog" title="加工完成" style="width:400px;height:200px;padding:15px"
			data-options="closed:true">
		
		<span style="margin-left:40px;margin-top:40px;">完成件数：</span><input id="jgjs"  style="width:175px; height:28px" class="numkeyboard">
		<p style="margin-top:15px;">
		<span style="margin-left:40px;margin-top:40px;">所用设备：</span><select style="height:28px;width:175px;" id='jgsb'></select>

	<div id="dlg-buttons">
		
	</div>
</div>

	<div id="ksjg" class="easyui-dialog" title="开始加工" style="width:400px;height:200px;padding:10px"	data-options="closed:true">
	    班组人员：<select onchange='initBzRy(event)' style="height:28px;width:175px;" id='selbzry'></select>
	    <div id="bzry"></div>
	</div>
</body>
</html>
