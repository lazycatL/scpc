<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>客户信息</title>
    <script type="text/javascript"
            src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/xsgl/khxxManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div id='content-wrapper'>
        <div class='box bordered-box'
             style='margin-bottom: 0;'>
            <div class='box-header'>
                <div class='title col-md-6'>
                    客户信息
                </div>
                <div class="col-md-1 col-md-offset-5"></div>
                <div id="form_add" class="btn btn-success btn-sm ">
                    <i class="icon-add"></i>
                    增加
                </div>
            </div>
            <div class='box-content box-no-padding'>
                <table id="ryxx" class='table table-striped table-bordered tableGrid' style='margin-bottom: 0;width:100%'>
                    <thead>
                    <tr>
                        <th  >
                        </th>
                        <th class="operate"  >
                            操作
                        </th>
                    <%--    <th style="width:80px;">
                            合同信息
                        </th>--%>
                        <th  >
                            名称
                        </th>
                        <th  >
                            类型
                        </th>
                        <th  >
                            单位
                        </th>
                        <th  >
                            单位地址
                        </th>
                        <th  >
                            联系人
                        </th><th  >
                        联系电话
                    </th>
                        <th  >
                            是否成交
                        </th>
                        <th  >
                            开始合作时间
                        </th>
                        <th>
                            备注
                        </th>
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







