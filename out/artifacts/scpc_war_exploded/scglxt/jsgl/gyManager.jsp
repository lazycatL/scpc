<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<title>工艺管理</title>
		<script type="text/javascript"
			src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	<script type="text/javascript" src="../../js/scglxt/jsgl/gyManage.js"></script>
	</head>
	<body>
			<div class='container-fluid'>
				<div class='row' id='content-wrapper'>
					<div class='col-xs-12'>
						<div class='row rowTop'>
							<div class='col-sm-12'>
								<div class='box bordered-box orange-border'
									style='margin-bottom: 0;'>
									<div class='box-header'>
											<button id="form_add" class="btn btn-success btn-sm">
                        						<i class="icon-add"></i>
                        						增加
                      						</button>
										<div class='title'>
											工艺编排
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
												<table id="gyInfo" class='table table-striped table-bordered tableGrid cell-border' style='margin-bottom: 0;'>
													<thead>
														<tr>
															<th>
															</th>
															<th>
																操作
															</th>
															<th>
																ID
															</th>
															<th>
																所属子订单
															</th>
															<th>
																工序编号
															</th>
															<th>
																工序顺序
															</th>
															<th>
																工序使用设备编号
															</th>
															<th>
																加工件数
															</th>
															<th>
																班组
															</th>
															<th>
																人员
															</th>
															<th>
																规划加工时
															</th>
															<th>
																计划开始时间
															</th>
															<th>
																计划结束时间
															</th>
															<th>
																工作量是否饱和
															</th>
															<th>
																工序图纸
															</th>
															<th>
																加工工艺
															</th>
															<th>
																是否已经完成
															</th>
															<th>
																完成件数
															</th>
															<th>
																完成百分比
															</th>
															<th>
																完成时间
															</th>
															<th>
																加工明细
															</th>
															<th>
																平均加工时间
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
				</div>
			</div>

		
		<h2>创建模态框（Modal）</h2>
<!-- 按钮触发模态框 -->
<button class="btn btn-primary btn-lg" data-toggle="modal" 
   data-target="#myModal">
   开始演示模态框
</button>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel">
               模态框（Modal）标题
            </h4>
         </div>
         <div class="modal-body">
            按下 ESC 按钮退出。
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary">
               提交更改
            </button>
         </div>
      </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
 
<script>
$(document).ready(function(){
	$('#myModal').modal({
      backdrop:false,
      show:false
   })
});
</script>
	</body>
</html>
