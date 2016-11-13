<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<title>终检检验管理</title>
        <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>

        <!-- jquery ui css 引入 -->

        <link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
        <!-- jquery-ui的JS -->
        <script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>

	<script type="text/javascript" src="../../js/scglxt/zlgl/zlManage.js"></script>
	</head>
	<body>
			<div class='container container-wrapper'>
				<div class='row' id='content-wrapper'>
						<div class='row rowTop'>
								<div class='box bordered-box'
									style='margin-bottom: 0;'>
									<div class='box-header'>
<!-- 											<button id="form_add" class="btn btn-success btn-sm"> -->
<!--                         						<i class="icon-add"></i> -->
<!--                         						增加 -->
<!--                       						</button> -->
										<div class='title'>
											终检检验管理
										</div>
										<div class='actions'>
											<a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
											</a>
										</div>
									</div>
									<div class='box-content box-no-padding'>
                                        <table id="bomInfo" class='table table-striped table-bordered tableGrid cell-border'
                                               style='margin-bottom: 0;'>
                                            <thead>
                                            <tr>
                                                <th class=""></th>
                                                <th class="th-larger"> 操作</th>
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
	</body>
</html>
