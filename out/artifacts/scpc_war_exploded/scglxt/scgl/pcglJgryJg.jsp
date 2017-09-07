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
        $content = "<iframe src='../jsgl/gygcManager.jsp?type=read&bomid=" + data + "' class='modal_iframe'></iframe>";
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
                         var text= '';
                        if (row.yjgcount == "0")
                        {
                            //text+= '<a href="#" onclick="jgryksjgWindowOpen(' + "\'" + data + "\'" + ')">开始</a>&nbsp;&nbsp;<a href="#" disabled="true" onclick="jgryJgJs(' + "\'" + data + "\'" + ')">结束</a></div>';
                            text+='<button class="btn btn-primary " onclick="jgryksjgWindowOpen(' + "\'" + data + "\'" + ')"> <span class="glyphicon glyphicon-play"></span>开始</button>   &nbsp; ';
                            text+='<button class="btn btn-primary" onclick="jgryJgJs(' + "\'" + data + "\',\'"+row.djgjs+"\'" + ')"> <span class="glyphicon glyphicon-stop"></span>结束</button> ';
                            //text+='<img style="" src="../../images/start-1.png">';
                        }else{
                            //text+= '<a href="#" disabled="true" onclick="jgryksjgWindowOpen(' + "\'" + data + "\'" + ')">开始</a>&nbsp;&nbsp;<a href="#" onclick="jgryJgJs(' + "\'" + data + "\'" + ')">结束</a></div>';
                            text+='<button class="btn btn-primary " onclick="jgryksjgWindowOpen(' + "\'" + data + "\'" + ')"> <span class="glyphicon glyphicon-play"></span>开始</button>   &nbsp; ';
                            text+='<button class="btn btn-primary" onclick="jgryJgJs(' + "\'" + data + "\',\'"+row.djgjs+"\'" + ')"> <span class="glyphicon glyphicon-stop"></span>结束</button> ';
                            text+='<img  style="width:30px;" src="../../images/time.gif">';
                        }
                        return text;
                    }else{
                        return '<span></span>';
                    }
                },
                "targets": 1
            },
            {
                "render": function ( data, type, row ) {
                    var text= '<div class="text-center">  <a class=" " href="#" title="工序编排" ' +
                            'onclick = "showModel(\'' + row.bomid + '\')"> 工艺编排</a>&nbsp;&nbsp;';
                    if(row.tzlx!=null && row.tzlx!="")
                    {
                        if(row.tzlx.toUpperCase().indexOf("JPG")!=-1 || row.tzlx.toUpperCase().indexOf("PNG")!=-1 || row.tzlx.toUpperCase().indexOf("GIF")!=-1)
                        {
                            text+=' <a class=" "  TARGET="viewer"  href="../lctImg.html?img=' + row.tzurl + '" title="图纸">图纸</a>';
                        }else{
                            text+=' <a class=""  TARGET="viewer"  href="../../'+ row.tzurl + '" title="图纸">图纸</a>';
                        }
                    }
                    return text;

                },
                "targets": 2
            },
            {
                    "render": function ( data, type, row ) {
                    var jb=row.zddjb;
                    if (jb=="0601") {
                        return '<span class="label label-danger">'+row.zddmc+'</span>';
                    }else if(jb=="0602")
                    {
                        return '<span class="label label-warning">'+row.zddmc+'</span>';
                    }else{
                        return '<span>'+row.zddmc+'</span>';
                    }
                }, "targets": 4
            },
            {
                "render": function (data, type, row) {
                    var date = new Date();
                    var now = "";
                    now = date.getFullYear() + "/";
                    now = now + (date.getMonth() + 1) + "/";  //取月的时候取的是当前月-1如果想取当前月+1就可以了
                    now = now + date.getDate() + " ";
                    // var cha = Math.round(( Date.parse(data['ddendtime'])-Date.parse(now) ) / 86400000)+1;
                    var cha = $.DateDiff(now, row.ddjssj);
                    if (cha <= 0) {
                        return data ;
                    }
                    else if (cha <= 3) {
                        //$('td', row).eq(3).css('font-weight',"bold").css("background","red").css("color","#FFF");;
                        return '<span class="label label-danger">' + data + '</span>';
                    } else if (cha < 7) {
                        return '<span class="label label-warning">' + data + '</span>';
                    } else {
                        return data;
                    }
                }, "targets": 3
            }
        ],
        "columns": [
             {"data": null},
            {"data": 'id',"sWidth": "220px"},
             {"data": 'id',"sWidth": "130px"},
            {"data": "ddmc", "sWidth": "120px"},
            {"data": "zddmc", "sWidth": "120px"},
            {"data": "clmc", "sWidth": "80px"},
            {"data": "cldx", "sWidth": "80px"},
             {"data": "bmcl","sWidth": "80px"},
             {"data": "ddjssj","sWidth": "100px"},
             {"data": "gs"},
             {"data": "gymc"},
            {"data": "jgsl"},
            {"data": "kjgjs"},
             {"data": "yjgjs"},
             {"data": "bfjs"},
             {"data": "djgjs"},
             {"data": "sjjs"}
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
	
	
	function jgryJgJs(data,kjgsl){
		yksjgryjs(data,kjgsl);
		$('#dlg').dialog('open');
		gygcid = data;
        $('#jgjs').val('');
		$('#jgsb').val('');
		
	}
	
	function yksjgryjs(data,kjgsl){
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
                if(dt.length>0){
                     for (var i = 0; i < dt.length; i++) {
                          var html = "<a href='#' onclick='saveSj(event,"+kjgsl+")' class='btn' id=js"+dt[i].id+">"+dt[i].mc+"</a>";
                          $("#dlg-buttons").append(html);
                     }
                }
            }
        });
	}
	
	function saveSj(event,kjgsl){
		
		var jsjgry = $(event.target).attr("id");
		
		jsjgry = jsjgry.substr(2,jsjgry.length);
		var jgsb = $('#jgsb').val();

		var jgjs = $('#jgjs').val();

        if(jgjs>kjgsl)
        {
            Main.ShowSuccessMessage('加工件数必须小于可加工件数！');
            return;
        }
		if(jgjs==""){
            Main.ShowSuccessMessage('请输入本次加工件数！');
			return;
		}
        if(jgsb==""){
            Main.ShowSuccessMessage("请选择加工设备！");
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
                // $('#pcglJgryJg').DataTable().fnDraw(false);
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
                    Main.ShowSuccessMessage('加工开始成功,已开始计时');
					disableButtonByJgr(gygcid);
                    $('#ksjg').dialog('close');
                    $('#pcglJgryJg').DataTable().ajax.reload(function(){},true);
                    // $('#pcglJgryJg').DataTable().fnDraw(false);
				}else{
                    Main.ShowSuccessMessage("对不起发生错误，请联系管理员！");
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
        //定时器每10秒刷新table如果有新的工作自动更新
        setInterval(function(){
            $('#pcglJgryJg').DataTable().draw(false);
        },10000);
        $("#dlg").dialog({
            onClose: function () {
                $('.auth_keybord').hide();
            }
        });
        $("#form_reload").on("click",function(){
            $('#pcglJgryJg').DataTable().ajax.reload(function(){},true);
        })
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
                    <button id="form_reload" class="btn btn-success btn-sm"> 刷新</button>
                    <div class='actions'><a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                    </a> <a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a></div>
                </div>
                <div class='box-content box-no-padding'>
                      <table id="pcglJgryJg" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th> 操作</th>
                                    <th>查看</th>
                                    <th> 订单名称</th>
                                    <th> 零件名称</th>
                                    <th>材料名称</th>
                                    <th>材料大小</th>
                                    <th> 表面处理</th>
                                    <th>订单结束时间</th>
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
    <div class="modal-dialog" style="width:950px;height:700px;">
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
			data-options="closed:true" onclick="$('.auth_keybord').hide();">
		<span style="margin-left:40px;margin-top:40px;">所用设备：</span><select style="height:28px;width:175px;" id='jgsb'></select>
        <p style="margin-top:15px;">
     <span style="margin-left:40px;margin-top:40px;">完成件数：</span><input id="jgjs"  style="width:175px; height:28px" class="numkeyboard">
	<div id="dlg-buttons">
	</div>
</div>

	<div id="ksjg" class="easyui-dialog" title="开始加工" style="width:400px;height:200px;padding:10px"	data-options="closed:true">
	    班组人员：<select onchange='initBzRy(event)' style="height:28px;width:175px;" id='selbzry'></select>
	    <div id="bzry"></div>
	</div>
</body>
</html>
