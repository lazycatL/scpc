<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>基本零件</title>
    <script type="text/javascript"
            src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/kcgl/jbljManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div   id='content-wrapper'>
            <div class='box bordered-box '
                 style='margin-bottom: 0;'>
                <div class='box-header'>
                    <button id="form_add" class="btn btn-success btn-sm">
                        <i class="icon-add"></i> 增加
                    </button>
                    <div class='title'>
                        基本零件
                    </div>
                    <div class='actions'>
                        <a class="btn box-remove btn-xs btn-link" href="#"><i
                                class='icon-remove'></i> </a>

                        <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                        </a>
                    </div>
                </div>
                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="bomInfo" class='table table-striped table-bordered tableGrid cell-border'
                                   style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th class="serial">
                                    </th>
                                    <th>
                                        操作
                                    </th>
                                    <th>
                                       工具名称
                                    </th>
                                    <th>
                                        工具类型
                                    </th>
                                    <th>
                                        尺寸
                                    </th>
                                    <th>
                                        总数量
                                    </th>
                                    <th>
                                        库存数量
                                    </th>
                                    <th>
                                        单价
                                    </th>
                                    <th>
                                        供应商
                                    </th>
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


</body>
</html>
