<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>采购管理</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div  id='content-wrapper'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'> 订单采购管理</div>
                    <div class='actions'><a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                    </a> <a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a></div>
                </div>
                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="bomInfo" class='table table-striped table-bordered tableGrid cell-border'
                                   style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th class="serial"></th>
                                    <th style="width:120px;"> 材料状态</th>
                                    <th> 子订单名称</th>
                                    <th> 备料情况</th>
                                    <th> 材料名称</th>
                                    <th> 工序内容</th>
                                    <th> 料的形状</th>
                                    <th> 料的大小</th>
                                    <th> 料的体积</th>
                                    <th> 料的金额</th>
                                    <th> 加工数量</th>
                                    <th> 表面处理</th>
                                    <th> 子订单开始时间</th>
                                    <th> 子订单结束时间</th>
                                    <th> 子订单工时</th>

                                    <th> 备料开始时间</th>
                                    <th> 备料结束时间</th>

                                    <th> 采购人员</th>
                                    <th> 采购商家</th>
                                    <th> 子订单图纸</th>
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
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:750px;height:500px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <button type="button" class="close"
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

</body>
<script>
    /** 订单信息 @author apple @constructor @date 20141024 */ (function () {
        var operateFlag = "";
        window.CgglManager = (function () {
            var _t = this, _operateFlag = "",

                    /** 初始化函数 */
                    init = function () {
                        var request = $.GetRequest();
                        var ssdd = null;
                        if (request.ssdd) {
                            ssdd = request.ssdd;
                        }
                        tableInit(ssdd);
                        registerEvent();

                    },

                    /** 注册事件 */
                    registerEvent = function () {
                        $("#form_add").on('click', function () {
                            Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp');
                            /*跳转iframe页面*/
                        })
                        $(".clzt input[type='radio']").live("change", function (e) {
                            e.stopPropagation();
                            var rowid = $(this).attr("name");
                            var blqk = $(this).attr("value");
                            changeClzt(rowid, blqk);
                        })
                    },
                    /** 初始化表格函数 */
                    tableInit = function (ssdd) {

                        var table = $('#bomInfo').DataTable({
                            /*			"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",*/
                            "bLengthChange": false,
                            "oLanguage": {
                                "sProcessing": "正在加载中......",
                                "sLengthMenu": "每页显示 _MENU_ 条记录",
                                "sZeroRecords": "对不起，查询不到相关数据！",
                                "sEmptyTable": "表中无数据存在！",
                                "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                                "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                                "sSearch": "搜索",
                                "oPaginate": {"sFirst": "首页", "sPrevious": "上一页", "sNext": "下一页", "sLast": "末页"}
                            },
                            "aLengthMenu": [20, 30],
                            "ajax": "bomInfo_getTableData.action?ssdd=" + ssdd + "&cggl=true",
                            scrollY: "disabled",
                            scrollX: true, /*scrollCollapse: false,*/
                            paging: true,

                            "columnDefs": [{
                                "render": function (data, type, row) {

                                    if (row.blqk == null || row.blqk == "0" ||row.blqk == "") {
                                        return ' <div class="clzt text-center"><input type="radio" value=1    name="' + row.id + '"/> 已采购' +
                                                '<input type="radio" value=0 checked  name="' + row.id + '"/>未采购  ' +
                                                ' </div>';
                                    } else if (row.blqk == "1") {
                                        return '<div class="text-center" style="color:green">已完成</div>';
                                    }else{
                                    	
                                    	return '<div class="text-center" style="color:green">自备料</div>';
                                    }

                                }, "targets": 1
                            },
                                {

                                    "render": function (data, type, row) {
                                        console.log(data);
                                        if (data == 1 || data == 2) {
                                            return '<span class="label label-default">备料完成</span>';
                                        } else   {
                                            return '<span class="label label-danger">备料未完成</span>';
                                        }
                                    },
                                    "targets": 3
                                },
                                {
                            "render": function (data, type, row) {
                                var str = "";
                                if(data=='1'){
                                    str =  "长方体" ;
                                }else if(data=='2'){
                                    str = "圆柱体" ;
                                }
                                console.log(data);
                                return str ;
                            }, "targets": 7
                        },
                                
                            ],
                            "columns": [
                                {"data": null, "sWidth": "60px"},
                                {"data": "clzt", "sWidth": "160px"},
                                {"data": "zddmc", "sWidth": "120px"},
                                {"data": "blqk", "sWidth": "120px"},
                                {"data": "clmc", "sWidth": "120px"},
                                {"data": "gxnr", "sWidth": "300px"},
                                {"data": "clxz"},
                                {"data": "cldx"},
                                {"data": "cltj"},
                                {"data": "clje"},
                                {"data": "jgsl"},
                                {"data": "bmcl"},
                                {"data": "starttime", "sWidth": "120px"},
                                {"data": "endtime", "sWidth": "120px"},
                                {"data": "gs", "sWidth": "120px"},
                                {"data": "blkssj", "sWidth": "120px"},
                                {"data": "bljssj", "sWidth": "120px"},

                                {"data": "cgry"},
                                {"data": "cgsj"},
                                {"data": "rksj", "sWidth": "120px"},
                                {"data": "ddtz", "sWidth": "120px"},
                                {"data": "bfjs"},
                                {"data": "bhgjs", "sWidth": "120px"},
                            ]

                        });

                        /**加上序号**/
                        table.on('order.dt search.dt', function () {
                            table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                                cell.innerHTML = i + 1;
                            });
                        }).draw();
                        new $.fn.dataTable.FixedColumns(table, {leftColumns: 3});

                    },
                    stock = function (id) {
                    },
                    changeClzt = function (rowid, clzt) {
                        var url = "../jsgl/bomInfo_changeStatusClzt.action", successFun = function (resStr) {
                            if (resStr == "SUCCESS") {
                                alert("更新采购状态成功！");
                            }
                        };
                        $.asyncAjaxPost(url, {"id": rowid, "clzt": clzt}, successFun, true);
                    }

                    ;

            return {
                init: init,
                stock: stock

            }
        })();


    })();


    $(document).ready(function () {
        CgglManager.init();
    });


</script>
</html>
