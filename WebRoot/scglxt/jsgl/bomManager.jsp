<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>bom表管理</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <script type="text/javascript" src="../../js/scglxt/jsgl/bomManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div  id='content-wrapper'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <button id="form_add" class="btn btn-success btn-sm"><i class="icon-add"></i> 增加</button>
                    <button id="form_export" class="btn btn-success btn-sm"><i class="icon-add"></i> 导出</button>

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
                                    <th> ID</th>
                                    <th> 子订单名称</th>
                                    <th> 子订单状态</th>
                                    <th> 子订单材质</th>
                                    <th> 工序内容</th>
                                    <th> 加工数量</th>
                                    <th> 料的形状</th>
                                    <th> 料的大小</th>
                                    <th> 料的体积</th>
                                    <th> 料的金额</th>
                                    <th> 表面处理</th>
                                    <th> 子订单开始时间</th>
                                    <th> 子订单结束时间</th>
                                    <th> 子订单工时</th>
                                    <th> 当前备料情况</th>
                                    <th> 备料开始时间</th>
                                    <th> 备料结束时间</th>
                                    <th> 料的状态</th>
                                    <th> 采购人员</th>
                                    <th> 采购商家</th>
                                    <th> 子订单图纸</th>
                                    <th> 入库时间</th>
                                    <th>
                                        报废件数
                                    </th>
                                    <th>
                                        不合格件数
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

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:950px;height:500px;">
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
<div class="modal fade" id="myTime" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:350px;height:270px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <button id="modalClose1" type="button" class="close"
                        data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body1">
                <div class='form-group'>
                    <label>子订单开始时间</label>

                    <input class="form-control required" id="form_bomInfo_starttime" info="fromInfo"
                    name="starttime" type="text" placeholder='子订单开始时间'/><br/>

                    <label>子订单结束时间</label>

                    <input class="form-control required" id="form_bomInfo_endtime" info="fromInfo"
                    name="endtime" type="text" placeholder='子订单结束时间'/>
                </div>
                <input style="float:right;" id="btn_saveDate" class="btn btn-primary" type="button" value="保存">
            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
</body>
</html>
