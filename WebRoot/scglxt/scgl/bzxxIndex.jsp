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
                    alert("删除成功！");
                    window.location.reload();
                    $("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
                }
            });
        }
    }
    function tableInit() {

        var height = document.body.offsetHeight;

        var table = $('#bzxx').DataTable({
//            "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
                                '<a href="${pageContext.request.contextPath}/scglxt/scgl/addBzInfo.jsp?flag=edit&id=' + data + '">修改</a>' +
                                        "&nbsp;"+
                                <%--'<a  href="${pageContext.request.contextPath}/scglxt/scgl/scglbz_deleteBzInfo.action?id=' + data + '">删除</a>' +--%>
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
</body>
</html>
