<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>bom表管理</title>

</head>
<body>
<div class='container-fluid'>
    <div  id='content-wrapper'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <button id="form_add" class="btn btn-success btn-sm"><i class="icon-add"></i> 增加</button>
                    <button id="form_export" class="btn btn-success btn-sm"><i class="icon-add"></i> 导出</button>
                    <button id="form_import" class="btn btn-success btn-sm"><i class="icon-add"></i> 导入</button>
                    <div class='title '> BOM表  </div>

                </div>
                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="bomInfo" class='table table-striped table-bordered tableGrid cell-border'
                                   style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th class=""></th>
                                    <th class="th-larger"> 操作</th>
                                    <th> 订单名称</th>
                                    <th> 零件名称</th>
                                    <th> 子订单状态</th>
                                    <th> 订单结束时间</th>
                                    <th> 子订单材质</th>
                                    <th> 工序内容</th>
                                    <th> 工序进度(报废件数/已加工件数/可加工件数)</th>
                                    <th> 加工数量</th>
                                    <th> 料的形状</th>
                                    <th> 料的大小</th>
                                    <th> 料的体积</th>
                                    <th> 料的金额</th>
                                    <th> 表面处理</th>
                                    <th> 子订单工时</th>
                                    <th> 料的状态</th>
                                    <th> 子订单图纸</th>
                                    <th> 入库时间</th>
                                    <th>报废件数</th>
                                    <th>不合格件数</th>
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
    <div class="modal-dialog" style="width:950px;height:700px;">
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
<div class="modal fade" id="myModalImport" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:350px;height:270px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel"><b>导入BOM</b></h5>
                <button id="modalClose1" type="button" class="close"  data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body1">
                选择导入数据方式，默认<span style="color: red">更新导入</span>
                <select class="form-control" id="importtype" style="">
                    <option value="02">更新导入</option>
                    <option value="01">新增导入</option>
                </select>
                <input type="file" multiple id="import_excel"/>
                <input style="margin-left:200px;margin-top:20px;" id="btn_import" class="btn btn-primary" type="button" value="导入">
            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
</body>
<script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/ImgInput/css/ssi-uploader.css"/>
<script src="${pageContext.request.contextPath}/js/plugin/ImgInput/js/ssi-uploader.js"></script>
<script type="text/javascript" src="../../js/scglxt/jsgl/bomManage.js"></script>
</html>
