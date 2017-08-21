<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <!--引入样式-->
    <link rel="stylesheet" href="../../js/plugin/ganttView/jquery.ganttView.css" type="text/css"></link>
    <link rel="stylesheet" href="../../js/plugin/ganttView/dhtmlxgantt.css" type="text/css"></link>
    <link rel="stylesheet" href="../../js/plugin/ganttView/lib/jquery-ui-1.8.4.css" type="text/css"></link>
    <style type="text/css">
        html {
            font-family: sans-serif;
            -webkit-text-size-adjust: 100%;
            -ms-text-size-adjust: 100%;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div id="ganttChart"></div>
<br/>

<div id="eventMessage"></div>
<input id="btn_save" class="btn btn-primary" type="button" value="保存">

</body>
</html>


<script type="text/javascript" src="../../js/plugin/ganttView/lib/jquery-1.4.2.js"></script>
<script type="text/javascript" src="../../js/plugin/ganttView/lib/jquery-ui-1.8.4.js"></script>
<script type="text/javascript" src="../../js/plugin/ganttView/jquery.ganttView.js"></script>
<script type="text/javascript" src="../../js/plugin/ganttView/lib/date.js"></script>
<script type="text/javascript" src="../../js/util/commonFun.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/util/CommonUtils.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        var dataInfo = [];
        var type=getValueOfURLParamter("type");
        var url="pcgl_getPcInfo.action?type="+type;
        if(type=="bom")
        {
            var ddid=getValueOfURLParamter("ddid");
            url="pcgl_getPcInfo.action?type="+type+"&ssdd="+ddid;
        }
        $.ajax({
            type: "post",
            url: url,
            dataType: "json",
            success: function (dt) {
                if (dt==null)
                {
                    Main.ShowSuccessMessage("没有数据！");
                    window.location.href="pcglgtt.jsp?type=dd";
                    return;
                }
                    dataInfo = [
                        {id: 1, name: "订单名称",start:"开始时间",end:"结束时间", series: dt }
                    ];
                $("#ganttChart").ganttView({
                    data: dataInfo,
                    slideWidth:900,
                    behavior: {
                        onClick: function (data) {
                            var msg = data.name + ": { 计划开始时间: " + data.start.toString("M/d/yyyy") + ", 计划结束时间: " + data.end.toString("M/d/yyyy") + " }";
                            $("#eventMessage").text(msg);
                        },
                        ondblclick:function(data){
                            window.location.href="pcglgtt.jsp?type=bom&ddid="+data.id;
                        },
                        onResize: function (data) {
                            var msg = "订单日期修改信息: { 计划开始时间: " + data.start.toString("M/d/yyyy") + ", 计划结束时间: " + data.end.toString("M/d/yyyy") + " }";
                            var startDate = data.start.getFullYear() + "-" + (data.start.getMonth() + 1) + "-" + data.start.getDate();

                            dataInfo[0].series[data.rownum].start = data.start.getFullYear() + "-" + (data.start.getMonth() + 1) + "-" + data.start.getDate();
                            dataInfo[0].series[data.rownum].end = data.end.getFullYear() + "-" + (data.end.getMonth() + 1) + "-" + data.end.getDate();
                            $("#eventMessage").text(msg);
                        },
                        onDrag: function (data) {
                            var msg = "修改时间: { 计划开始时间: " + data.start.toString("M/d/yyyy") + ", 计划结束时间: " + data.end.toString("M/d/yyyy") + " }";
                            dataInfo[0].series[data.rownum].start = data.start.getFullYear() + "-" + (data.start.getMonth() + 1) + "-" + data.start.getDate();
                            dataInfo[0].series[data.rownum].end = data.end.getFullYear() + "-" + (data.end.getMonth() + 1) + "-" + data.end.getDate();
                            $("#eventMessage").text(msg);
                        }
                    }
                });
            }
        });

        $("#btn_save").click(function () {

            var url = "ddInfo_updateDdDate.action", successFun = function (resStr) {
                if (resStr == "SUCCESS") {
                    Main.ShowSuccessMessage('保存成功!');
                }
            }
            if (confirm("确定更新所有订单时间？")) {
                var str = "";
                var dt = dataInfo[0].series;
                for (var i = 0; i < dt.length; i++) {
                    str += dt[i].id + "," + dt[i].start + "," + dt[i].end + "#";
                }
                $.asyncAjaxPost(url, {"infos": str.substring(0, str.length - 1),"type":type }, successFun, true);
            }
        });
    });
</script>