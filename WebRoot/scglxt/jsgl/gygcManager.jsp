<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/topFile.jsp"%>
    <!-- jquery ui css 引入 -->
    <link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
    <!-- jquery-ui的JS -->
    <script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/ImgInput/css/ssi-uploader.css"/>
    <script src="${pageContext.request.contextPath}/js/plugin/ImgInput/js/ssi-uploader.js"></script>
<style type="text/css">
.tableGrid  tr th {
	width: 100px;
}
</style>
<title>工艺编排</title>
<script type="text/javascript"
	src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/plugin/tablednd/jquery.tablednd.js"></script>
    <script type="text/javascript" src="../../js/util/clipboard.js"></script>
    <script type="text/javascript" src="../../js/util/NumKeyBoard.js"></script>
    <script type="text/javascript" src="../../js/scglxt/jsgl/gygcManage.js"></script>

</head>
<body>
<div class="container-fluid">
	<div class="  col-md-12">
		<button id="btn-add" type="button" class="btn btn-sm btn-primary">增加</button>
        <button id="form_import" class="btn btn-success btn-primary"> Excel导入</button>
		<button id="btn-save" type="btn-save" class="btn btn-sm btn-success">保存并关闭</button>
	</div>
</div>

	<div id='container' class="container-fluid " style="height:450px;overflow:auto;">

			<div class=' ' id='content-wrapper'>
				<div class='row rowTop'>
					<div class='box bordered-box ' style='margin-bottom: 0;'>
						<div class='box-content box-no-padding'>
							<div class='responsive-table'>
								<div class='scrollable-area'>
									<table id="gygc" class="cell-border  tableGygc table table-striped table-bordered">
										<thead>
											<tr>
												<th class="serial"></th>
												<th style="text-align: center;" class="serial" style=" ">编辑</th>
												<th class="starttime  hide" disabled="disabled" style="width:20px;">开始加工</th>
												<th class="endtime  hide" style="width:20px;">结束加工</th>
                                                <th style="text-align: center;">工序</th>
                                                <th style="text-align: center;">设备类型</th>
                                                <th style="width:80px;text-align:center;">额定工时（分钟）</th>
                                                <th style="width:80px;text-align:center;">总工时（分钟）</th>
												<th style="width:20px;text-align:center;" class=" hide">受图</th>
												<th class="starttime hide ">开始时间</th>
												<th class="endtime  hide">结束时间</th>
												<th style="width:400px;text-align:center;" >工艺内容</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
<div id="div_cyy">
    <div style="color: red;">常用语：点击下列文字，可直接复制使用。
        <%--<a id="a_addCyy" onclick="$('#dlg_addCyy').dialog('open');" href="javscript:void()">新增</a>--%>
        <input id="a_addCyy" class="btn" type="button" value="新增">
    </div>

    <div id="cyyDiv">

    </div>
</div>
<div id="dlg_addCyy" class="easyui-dialog" title="添加常用语" style="width:400px;height:200px;padding:15px;"  data-options="closed:true">

    <textarea id="cyy" class="numkeyboard" cols="55" rows="5"></textarea>
<%--<input id="cyy"  style="width:175px; height:58px" class="numkeyboard"><br>--%>

        <input id="btn_saveCyy" style="margin-left: 200px;" onclick="GygcManage.addCyy();" class="btn" type="button" value="保存">

</div>
<div class="modal fade" id="myModalImport" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:350px;height:270px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel"><b>导入工艺工序</b></h5>
                <button id="modalClose1" type="button" class="close"  data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body1">
                选择导入数据方式，默认<span style="color: red">更新导入</span>
                <select class="form-control" id="importtype" style="">
                    <option value="01">新增导入</option>
                    <option value="02">更新导入</option>
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
</html>
