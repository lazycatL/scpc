<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>合同管理</title>
    <script type="text/javascript"
            src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/xsgl/htManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div id='content-wrapper'>
        <div class='box bordered-box'
             style='margin-bottom: 0;'>
            <div class='box-header'>
                <div class='title col-md-6'>
                    合同信息
                </div>
                <div class="col-md-1 col-md-offset-5"></div>
                <div id="form_add" class="btn btn-success btn-sm ">
                    <i class="icon-add"></i>
                    增加
                </div>
            </div>
            <div class='box-content box-no-padding'>
                <table id="htInfo" class='table table-striped table-bordered tableGrid' style='margin-bottom: 0;'>
                    <thead>
                    <tr>
                        <th >
                        </th>
                        <th style="width:140px;">
                            操作
                        </th>

                        <th style="width:80px;">
                            ID
                        </th>
                        <th style="width:100px;">
                            名称
                        </th>
                        <th style="width:100px;">
                            合同编号
                        </th>
                        <th style="width:220px;">
                            客户名称
                        </th>
                        <th style="width:100px;">
                            业务类型
                        </th>
                        <th style="width:100px;">
                            合同金额
                        </th>
                        <th style="width:100px;">
                            签署时间
                        </th>
                        <th style="width:100px;">
                            结束时间
                        </th>
                        <th style="width:100px;">
                            当前进度
                        </th>
                        <th style="width:100px;">
                            付款状态
                        </th>
                        <th style="width:100px;">
                            结款百分比
                        </th>
                        <th style="width:100px;">
                            结款金额
                        </th>
                        <th style="width:100px;">
                            计算成本
                        </th>
                        <th style="width:100px;">
                            汇款账号
                        </th>
                        <th style="width:180px;">
                            汇款开户行
                        </th>
                        <th style="width:200px;">
                            合同明细
                        </th>
                        <!-- 															<th  style="width:100px;"> -->
                        <!-- 																备注 -->
                        <!-- 															</th> -->
                    </tr>
                    </thead>

                </table>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）-->
<div class=" modal fade tableModal" id="myModal" tabindex="-1" role="dialog"
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


