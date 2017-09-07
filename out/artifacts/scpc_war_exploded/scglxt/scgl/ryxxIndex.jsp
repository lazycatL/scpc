<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript"
            src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
</head>
<script type="text/javascript">

    function deleteRow(id) {

        //判断是否要删除
        //删除数据库成功后删除表格
        //1、删除数据库
        $.ajax({
            type: "post",
            url: "xsgl_deleteRyInfo.action",
            dataType: "text",
            data: {
                "id": id,
            },
            success: function (dt) {
                alert(dt);
                window.location.reload();
                $("#sorting-advanced").dataTable().fnPageChange('previous', true);
            }
        });

        //2、删除表格
    }

    function tableInit() {

        var table = $('#ryxx').DataTable({
//            "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
            "ajax": "scgl_getRyTableData.action",
            scrollY: "600px",
            scrollX: true,
            scrollCollapse: true,
            paging: false,
            columnDefs: [
                {width: '20%', targets: 0}
            ]
            ,
            "columnDefs": [
                {
                    "render": function (data, type, row) {
                        return '<div class="text-center">' +
                                '<a  href="${pageContext.request.contextPath}/scglxt/scgl/addRyInfo.jsp?flag=edit&id=' + data + '">修改</a>&nbsp; ' +
                                '<a href="${pageContext.request.contextPath}/scglxt/scgl/scgl_deleteRyInfo.action?id=' + data + '">删除</a>' +
                                '</div>';
                    },
                    "targets": 1
                },
                {"visible": true, "targets": [2]}
            ],
            "columns": [
                {"data": null, "sWidth": "40px"},
                {"data": 'id', "sWidth": "60px"},
                {"data": "rymc"},
                {"data": "ssbz"},
                {"data": "rynl"},
                {"data": "jsjb"},
                {"data": "dqgz"}
            ]

        });

        /**加上序号**/
        table.on('order.dt search.dt', function () {
            table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        new $.fn.dataTable.FixedColumns(table, {leftColumns: 4});
    }
    $(document).ready(function () {

        tableInit()
    });
</script>

<body>
<div class='container-fluid'>
    <div id='content-wrapper'>
            <div class='box bordered-box '
                 style='margin-bottom: 0;'>
                <div class='box-header'>
                    <button id="form_add" class="btn btn-success btn-sm">
                        <a href="${pageContext.request.contextPath}/scglxt/scgl/addRyInfo.jsp">
                            <i class="icon-add"></i> 增加
                        </a>
                    </button>
                    <div class='title'>
                        人员信息
                    </div>
                    <div class='actions'>
                        <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                        </a>
                    </div>
                </div>

                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="ryxx" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th class="serial">
                                    </th>
                                    <th class="th-middle">
                                        操作
                                    </th>
                                    <th>
                                        名称
                                    </th>
                                    <th>
                                        班组
                                    </th>
                                    <th>
                                        年龄
                                    </th>
                                    <th>
                                        技术级别
                                    </th>
                                    <th>
                                        工资
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
</body>
</html>
