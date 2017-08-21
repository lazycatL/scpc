<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>合同管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/ImgInput/css/ssi-uploader.css"/>
    <script src="${pageContext.request.contextPath}/js/plugin/ImgInput/js/ssi-uploader.js"></script>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/xsgl/htManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div id='content-wrapper'>
        <div class='box bordered-box'  style='margin-bottom: 0;'>
            <div class='box-header'>
                <button id="form_add" class="btn btn-success btn-sm"><i class="icon-add"></i> 增加</button>
                <button id="form_exportbjd" class="btn btn-success btn-sm"><i class="icon-add"></i> 下载报价单模板</button>
                <div class='title '> 合同信息  </div>
            </div>

            <div class='box-content box-no-padding'>
                <div class='responsive-table'>
                    <div class='scrollable-area'>
                <table id="htInfo" class='table table-striped table-bordered tableGrid cell-border' style='margin-bottom: 0;'>
                    <thead>
                    <tr>
                        <th class=""></th>
                        <th class="th-xlarger"> 操作 </th>
                        <th>
                            合同编号
                        </th>
                        <th>
                            客户名称
                        </th>
                        <th>
                            业务类型
                        </th>
                        <th>
                            合同金额
                        </th>
                        <th>
                            签署时间
                        </th>
                        <th>
                            交货时间
                        </th>

                        <th>
                            付款状态
                        </th>
                        <th>
                            结款百分比
                        </th>
                        <th>
                            结款金额
                        </th>
                        <th>
                            计算成本
                        </th>
                        <th>
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
<div class="modal fade" id="myModalUpload" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:350px;height:270px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel"><b>上传报价单</b></h5>
                <button id="modalClose1" type="button" class="close"  data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body1">
                <input type="file" multiple id="import_excel"/>
                <input style="margin-left:200px;margin-top:20px;" id="btn_import" class="btn btn-primary" type="button" value="导入">
            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
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


