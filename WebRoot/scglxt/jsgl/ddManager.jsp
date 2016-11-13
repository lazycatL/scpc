<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>

<html>
<head>

    <title>订单管理</title>
    <script type="text/javascript"
            src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/jsgl/ddManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div id='content-wrapper'>
        <div class='box bordered-box orange-border'
             style='margin-bottom: 0;'>
            <div class='box-header'>
                <button id="form_add" class="btn btn-success btn-sm">
                    <i class="icon-add"></i>
                    增加
                </button>
                <div class='title'>
                    订单信息
                </div>

            </div>
            <div class='box-content box-no-padding'>
                <div class='responsive-table'>
                    <div class='scrollable-area'>
                         <table id="ddInfo" class='table table-striped table-bordered cell-border tableGrid'
                       style='margin-bottom: 0;'>
                    <thead>
                    <tr>
                        <th class="serial" style="width: 20px;">

                        </th>
                        <th class="th-xlarger" style="width:300px;">
                            操作
                        </th>
                        <th>
                            ID
                        </th>

                        <th style="width:150px;">
                            订单编号
                        </th>
                        <th style="width:150px;">
                            订单级别
                        </th>
                        <th style="width:150px;">
                            交货日期
                        </th>
                        <th class="th-middle">
                            下单日期
                        </th>
                        <th class=" th-middle">
                            交付日期
                        </th>
                        <th class=" th-middle">
                            实际开始时间
                        </th>
                        <th class=" th-middle">
                            实际结束时间
                        </th>
                        <th class=" th-middle">
                            所用总工时
                        </th>
                        <th class=" th-middle">
                            当前总进度
                        </th>
                        <th class="th-small">
                            图纸
                        </th>
                        <th class="th-middle">
                            备注
                        </th>
                        <th class="th-small">
                            项目联系人
                        </th>
                        <th class="th-middle">
                            项目负责人
                        </th>
                        <th class="th-middle">
                            出库状态
                        </th>
                        <th  class="th-middle">
                            出库时间
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
<!-- 模态框（Modal）-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:850px;height:550px;">
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
</html>
