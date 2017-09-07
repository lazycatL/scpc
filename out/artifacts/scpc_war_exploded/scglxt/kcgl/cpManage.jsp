<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<title>产品管理</title>
		<script type="text/javascript"
			src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	<script type="text/javascript" src="../../js/scglxt/kcgl/cpManage.js"></script>
	</head>
	<body>
			<div class='container-fluid'>
				<div class='row' id='content-wrapper'>
						<div class='row rowTop'>
								<div class='box bordered-box '
									style='margin-bottom: 0;'>
									<div class='box-header'>
										<button id="form_add" class="btn btn-success btn-sm">
											<i class="icon-add"></i> 增加
										</button>
									<div class='title'>
											产品管理
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
												<table id="bomInfo" class='table table-striped table-bordered' style='margin-bottom: 0;'>
													<thead>
														<tr>
															<th class="serial"></th>
															<th>
																操作
															</th>
<!-- 															<th> -->
<!-- 																工序编排 -->
<!-- 															</th> -->
															<th>
																ID
															</th>
															<th>
																子订单名称
															</th>
															<th>
																子订单材质
															</th>
															<th>
																工序内容
															</th>
															<th>
																料的形状
															</th>
															<th>
																料的大小
															</th>
															<th>
																料的体积
															</th>
															<th>
																料的金额
															</th>
															
															<th>
																加工数量
															</th>
															<th>
																表面处理
															</th>
															<th>
																子订单开始时间
															</th>
															<th>
																子订单结束时间
															</th>
															<th>
																子订单工时
															</th>
															<th>
																当前备料情况
															</th>
															<th>
																备料开始时间
															</th>
															<th>
																备料结束时间
															</th>
															<th>
																料的状态
															</th>
															<th>
																采购人员
															</th>
															<th>
																采购商家
															</th>
															<th>
																子订单图纸
															</th>
															<th>
																入库时间
															</th>
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
			</div>

		<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" style="width:750px;height:500px;">
      <div class="modal-content" style="height:90%;"  >
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                  &times;
            </button>
         </div>
         <div class="modal-body" id="modal-body">
         </div>
<!--          <div class="modal-footer"> -->
<!--             <button type="button" class="btn btn-default"  -->
<!--                data-dismiss="modal">关闭 -->
<!--             </button> -->
<!--             <button type="button" class="btn btn-primary"> -->
<!--                提交更改 -->
<!--             </button> -->
<!--          </div> -->
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
		
		
	</body>
</html>
