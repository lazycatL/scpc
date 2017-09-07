<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<title>成品出库管理</title>
        <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>

        <link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
        <!-- jquery-ui的JS -->
        <script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>

	</head>
	<body>
			<div class='container container-wrapper'>
				<div class='row' id='content-wrapper'>
						<div class='row rowTop'>
								<div class='box bordered-box'
									style='margin-bottom: 0;'>
									<div class='box-header'>
<!-- 											<button id="form_add" class="btn btn-success btn-sm"> -->
<!--                         						<i class="icon-add"></i> -->
<!--                         						增加 -->
<!--                       						</button> -->
										<div class='title'>
                                            成品出库管理
										</div>
										<div class='actions'>
											<a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
											</a>
										</div>
									</div>
									<div class='box-content box-no-padding'>
                                        <table id="bomInfo" class='table table-striped table-bordered tableGrid cell-border'
                                               style='margin-bottom: 0;'>
                                            <thead>
                                            <tr>
                                                <th class=""></th>
                                                <th> 操作</th>
                                                <td>订单名称</td>
                                                <th> 子订单名称</th>
                                                <th> 子订单状态</th>
                                                <th> 子订单材质</th>
                                                <th> 工序内容</th>
                                                <th> 加工数量</th>
                                                <th> 子订单开始时间</th>
                                                <th> 子订单结束时间</th>
                                                <th> 子订单工时</th>
                                                <th> 入库时间</th>
                                                <th>
                                                    报废件数
                                                </th>
                                                <th>
                                                    不合格件数
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
<script>
    /** 成品出库信息 @author apple @constructor @date 20141024 */ (function () {
        var operateFlag = "";
        window.CpckManager = (function () {
            var _t = this, _operateFlag = "",

                    /** 初始化函数 */
                    init = function () {
                        var request = $.GetRequest();

                        tableInit();
                        registerEvent();

                    },
                    /** 注册事件 */
                    registerEvent = function () {

                    },
                    /** 初始化表格函数 */
                    tableInit = function () {
                        var table = $('#bomInfo').DataTable( {
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
                            "ajax":"bomInfo_getTableData.action?zddzt=0505",
                            "sScrollY" : 450, //DataTables的高
                            "sScrollX" : 600, //DataTables的宽
                            scrollY:        true,
                            scrollX:        true,
                            scrollCollapse: true,
                            paging:         true,
                            "columnDefs": [
                                {
                                    "render": function ( data, type, row ) {
                                        return '<div class="">'+
                                                ' <a class="btn btn-danger btn-xs" href="#" title＝"出库完成" onclick = "CpckManager.passAllInfo(\''+data+'\')">出库完成<i class="icon-edit"></i></a> '+
                                                ' </div>';
                                    },
                                    "targets": 1
                                },
                                { "visible": true,  "targets": [ 2 ] }
                            ],
                            "columns": [{"data": null, "sWidth": "30px"},
                                {"data": "id"},
                                {"data": "ddmc", "sWidth": "120px"},
                                {"data": "zddmc", "sWidth": "120px"},
                                {"data": "ddztmc", "sWidth": "120px"},
                                {"data": "clmc","sWidth": "120px"},
                                {"data": "gxnr","sWidth": "300px"},
                                {"data": "jgsl","sWidth": "60px"},
                                {"data": "starttime","sWidth": "120px"},
                                {"data": "endtime", "sWidth": "120px"},
                                {"data": "gs", "sWidth": "120px"},
                                {"data": "rksj", "sWidth": "120px"},
                                {"data": "bfjs"},
                                {"data": "bhgjs", "sWidth": "120px"}
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
                    /**通过并入库**/
                    passAllInfo=function(id){
                        var url = "bomInfo_updateZddzt.action", successFun = function (resStr) {
                            if (resStr == "success") {
                                $('#bomInfo').DataTable().ajax.reload(function(){},true);
                                $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                                Main.ShowSuccessMessage("出库完成！");
                            }else{
                                Main.ShowErrorMessage("出库失败！");
                            }
                        };
                        if (confirm("是否确定该订单所有成品出库？")) {
                            $.asyncAjaxPost(url, {"id": id,"zddzt":"0506","date":"cksj"}, successFun, true);
                        }
                    }
                    ;

            return {
                init: init,
                tableInit: tableInit,
                passAllInfo:passAllInfo

            }
        })();


    })();


    $(document).ready(function () {
        CpckManager.init();
    });


</script>