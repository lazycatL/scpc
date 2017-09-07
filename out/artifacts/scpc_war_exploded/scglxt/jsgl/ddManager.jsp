<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单管理</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/ImgInput/css/ssi-uploader.css"/>
    <script src="${pageContext.request.contextPath}/js/plugin/ImgInput/js/ssi-uploader.js"></script>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/jsgl/ddManage.js"></script>
</head>
<style>
    .col_class{
        color:#FFFFFF;
    }
    .cos_class{
        color:#F5F683;

    }
</style>
<body>
<div class='container-fluid'>
    <div id='content-wrapper'>
        <div class='box bordered-box'  style='margin-bottom: 0;'>
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
                         <table id="ddInfo" class='table table-striped table-bordered tableGrid cell-border'
                       style='margin-bottom: 0;'>
                    <thead>
                    <tr>
                        <th class=""></th>
                        <th class="th-xlarger"> 操作 </th>
                        <th> ID </th>
                        <th>
                            订单编号
                        </th>
                        <th>
                            订单级别
                        </th>
                        <th>
                            开始时间
                        </th>
                        <th>
                            结束时间
                        </th>
                        <th>
                            当前总进度
                        </th>
                        <th>
                            所需总工时
                        </th>
                        <th>
                            图纸目录
                        </th>
                        <th>
                            备注
                        </th>
                        <th>
                            项目联系人
                        </th>
                        <th>
                            项目负责人
                        </th>
                        <th>
                            出库状态
                        </th>
                        <th>
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
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModalUpload" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:950px;height:500px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <button id="modalClose" type="button" class="close"
                        data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body2">
                <iframe id="uploadFile" name="ajaxUpload" style="display:none;"></iframe>
                <form enctype="multipart/form-data" method="post" target="ajaxUpload">
                    <input type="file" multiple id="ssi-upload"  name="ssi-upload"/>
                </form>

            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
</body>
</html>
