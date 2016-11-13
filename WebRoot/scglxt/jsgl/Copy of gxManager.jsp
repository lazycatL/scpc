<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<title>工序管理</title>
<!-- 	<script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script> -->
	<script type="text/javascript" language="javascript" class="init"> </script>
	<script type="text/javascript" src="../../js/scglxt/jsgl/gxManage.js"></script>
	</head>
	<body>
		<div id='wrapper'>
			<div class='container'>
				<div class='row' id='content-wrapper'>
					<div class='col-xs-12'>
						<div class='row rowTop'>
							<div class='col-sm-12'>
								<div class='box bordered-box orange-border'
									style='margin-bottom: 0;'>
									<div class='box-header'>
										<div class='title'>
											工序信息
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
												<table id="gxInfo" class='display' style='margin-bottom: 0;'>
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
																工序名称
															</th>
															<th>
																工序代号
															</th>
															<th>
																负责班组
															</th>
															<th>
																工序顺序
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
		</div>
	</body>
</html>
