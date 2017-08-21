<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript"
            src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
</head>
<script type="text/javascript">
    function deleteRow(id){
        var flag = confirm("是否删除？");
        if(flag){
            $.ajax({
                type: "post",
                url: "scglbz_deleteBzInfo.action",
                dataType: "text",
                data:{
                    "id":id
                },
                success:function(str){
                    Main.ShowSuccessMessage("删除成功！");
                    window.location.reload();
                    $("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
                }
            });
        }
    }
    showModel = function (data) {
        $('#myModal').modal({
            backdrop: false,
            show: true
        });
        //在modalbody 中家在iframe 内容为 工序编排的内容
        $content = "<iframe src='../qxgl/qxglManage.jsp?flag=edit&bzid=" + data + "' class='modal_iframe'></iframe>";
        $container = $('#modal-body');
        $container.empty().append($content);
    }
    function tableInit() {

        var height = document.body.offsetHeight;

        var table = $('#bzxx').DataTable({
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
            "ajax": "scglbz_getBzTableData.action",
            scrollY: height-150+ "px",
            scrollX: false,
            scrollCollapse: false,
            paging: true,
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        return '<div class="text-center">' +
                                '<a href="#"  onclick = "showModel(\'' + data + '\')">菜单权限</a>'+
                                "&nbsp;"+
                                '<a href="${pageContext.request.contextPath}/scglxt/scgl/addBzInfo.jsp?flag=edit&id=' + data + '">修改</a>' +
                                        "&nbsp;"+
                                '<a  href="#" onclick="deleteRow(\'' + data + '\')">删除</a>'
                                '</div>';
                    },
                    "targets": 1
                },
                {"visible": true, "targets": [2]}
            ],
            "columns": [
                {"data": null, "sWidth": "40px"},
                {"data": 'id', "sWidth": "60px"},
                {"data": "bzmc"},
                {"data": "bzfzr"}
            ]

        });

        /**加上序号**/
        table.on('order.dt search.dt', function () {
            table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
    }
    $(document).ready(function () {

        tableInit()
    });
</script>

<body>
<div class='container-fluid'>
    <div class='row' id='content-wrapper'>
        <div class='box bordered-box orange-border'
             style='margin-bottom: 0;'>
            <div class='box-header'>
                <button id="form_add" class="btn btn-success btn-sm">
                    <a href="${pageContext.request.contextPath}/scglxt/scgl/addBzInfo.jsp">
                        <i class="icon-add"></i> 增加
                    </a>
                </button>
                <div class='title'>
                    班组信息
                </div>
            </div>
            <div class='box-content box-no-padding'>
                        <table id="bzxx" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
                            <thead>
                            <tr>
                                <th>
                                </th>
                                <th>
                                    操作
                                </th>
                                <th>
                                    班组名称
                                </th>
                                <th>
                                    班组负责人
                                </th>
                            </tr>
                            </thead>
                        </table>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:550px;height:500px;">
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
</body>
</html>
