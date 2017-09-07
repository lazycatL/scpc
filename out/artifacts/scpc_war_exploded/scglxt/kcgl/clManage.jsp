<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>生产材料管理</title>
	<script type="text/javascript"
			src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	<script type="text/javascript" src="../../js/scglxt/kcgl/clManage.js"></script>
</head>
<body>
<div class='container-fluid'>
	<div id='content-wrapper'>
		<div class='box bordered-box'
			 style='margin-bottom: 0;'>
			<div class='box-header'>
				<div class='title col-md-6'>
					材料管理
				</div>
				<div class="col-md-1 col-md-offset-5"></div>
				<div id="form_add" class="btn btn-success btn-sm ">
					<i class="icon-add"></i>
					增加
				</div>
			</div>
			<div class='box-content box-no-padding'>
				<table id="clInfo" class='table table-striped table-bordered tableGrid' style='margin-bottom: 0;'>
					<thead>
					<tr>
						<th class="serial"></th>
						<th class="th-larger">
							操作
						</th>
						<th>
							ID
						</th>
						<th>
							材料名称
						</th>
						<th>
							材料材质
						</th>
						<th>
							材料数量
						</th>
						<th>
							材料单价
						</th>
						<th>
							材料类型
						</th>
						<th>
							供货商
						</th>
						<th>
							密度
						</th>

						<th>
							材料形状
						</th>
						<th>
							宽度
						</th>
						<th>
							高度
						</th>
						<th>
							长度
						</th>
						<th>
							材料来源
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










