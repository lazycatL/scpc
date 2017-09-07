<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>

    <style type="text/css">
        html {
            font-family: sans-serif;
            -webkit-text-size-adjust: 100%;
            -ms-text-size-adjust: 100%;
            font-size: 12px;
        }
        #container{
            width:1000px;
        }
    </style>
</head>
<body>
    <div>
        <div id="banner"><h2>订单进度查看</h2><hr clas="hr"></div>
        <div id="container">
            <div class="h3">test</div>
            <div class="progress">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:20%">20%</div>
            </div>
        </div>
    </div>

</body>
</html>
<script type="text/javascript">
    $(function () {
        var dataInfo = [];
        var url="ddInfo_getDdjdInfo.action";

        $.ajax({
            type: "post",
            url: url,
            dataType: "json",
            success: function (dt) {
                if (dt==null)
                {
                    Main.ShowErrorMessage("没有数据！");
                    return;
                }else{
                    var data=dt;
                    if (data && data.length > 0) {
                        var container=$("#container");
                        for (var i = 0; i < data.length; i++) {
                            var head=$("<div class='h4'>订单名称："+data[i].ddmc+"，结束时间："+data[i].endtime+"</div>");
                            var div=$("<div class='progress'></div>");
                            var bar=$("<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+data[i].yjggs+"' aria-valuemin='0' aria-valuemax='"+data[i].zgs+"' style='width:"+data[i].bfb+"%'>"+data[i].bfb+"%</div>");

                            div.append(bar);
                            container.append(head);
                            container.append(div);
                        }
                    }
                }

            }
        });
    });
</script>