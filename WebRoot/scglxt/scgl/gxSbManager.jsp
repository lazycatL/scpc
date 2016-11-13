<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>工序信息</title>
      <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <link rel="stylesheet" href="../../js/plugin/bootstrap/css/bootstrap.css" type="text/css"></link>
    <!-- bootstrap css 引入 -->
	<link href="../../js/plugin/bootstrap/css/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
	<!-- bootstrap Datatables样式引入 -->
	<link rel="stylesheet" href="../../js/datatablesExtends/dataTables.bootstrap.css" type="text/css"></link>
	<!-- jquery ui css 引入 -->
	
	<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
	<!-- jquery-ui的JS -->
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	
    <script type="text/javascript" src="../../js/scglxt/pcgl/gxSbManage.js"></script>
</head>
<body>
<div class='container-fluid'>
    <div  id='content-wrapper'>
            <div class='box bordered-box orange-border'
                 style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'>
                        设备工序信息
                    </div>

                </div>
                <div class='box-content box-no-padding'>
                    <table id="gxInfo" class='table tableGrid table-striped table-bordered' style='margin-bottom: 0;'>
                        <thead>
                        <tr>
                            <th class="serial">
                            </th>
                            <th class="th-small">
                                操作
                            </th>
                            <th>
                                设备名称
                            </th>
                            <th>
           工艺
                            </th>
                            <th>
                                订单
                            </th>
                            <th>
                                子订单
                            </th>
                            <th class="th-small">
                                额定工时
                            </th>
                             <th class="th-small">
                                加工件数
                            </th>
                              <th class="th-small">
                                已加工件数
                            </th>
                             <th class="th-small">
                               天数
                            </th>
                            <th class="th-small">
                               计划开始时间
                            </th>
                            <th class="th-small">
                               计划结束时间
                            </th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
    </div>
  	<div id="ksjg" class="easyui-dialog" title="开始加工" style="width:400px;height:200px;padding:10px"	data-options="closed:true">
	
		<span style="margin-left:40px;margin-top:40px;">所用设备：</span><select style="height:28px;width:175px;" id='jgsb'></select>
	<div id="dlg-buttons">
		<a href='#' onclick='saveSj(event)' class='btn' id="s">保存</a>
	</div>
	</div>
</div>
</div>
</body>
</html>
