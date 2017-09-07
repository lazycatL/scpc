<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>班组权限配置</title>
    <link href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-treeview.js"></script>
    <script src="${pageContext.request.contextPath}/js/util/CommonUtils.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/util/commonFun.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/util/Cookies.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/scglxt/index.js" type="text/javascript"></script>
    <script type="text/javascript">

    $(function() {
        var bzid=getValueOfURLParamter("bzid");
        var url = "common_getMenu.action?bzid="+bzid, successFun = function (data) {
            if (data && data.length > 0) {
                $('#tree').treeview({
                    data:eval(data),
                    showCheckbox:true,
                    onNodeSelected: function(event, node) {
                        $('#tree').treeview('toggleNodeChecked', [ node, { silent: true } ]);
                    },onNodeChecked: function(event, node) {

                    }

            });
            }else{
                Main.ShowErrorMessage("菜单数据加载错误！");
            }
        };
        $.asyncAjax(url, {"pid": 0}, successFun, true);
        $("#btn_save").click(function(){
            var checkData=$('#tree').treeview("getChecked");
            var qxJson="";
            for(var i=0;i<checkData.length;i++)
            {
                qxJson+=checkData[i].id+",";
            }


            $.ajax({
                type: "post",
                url: "common_updateQxgl.action",
                dataType: "text",
                data:{
                    "bzid":bzid,
                    "qxsj": qxJson
                },
                success:function(data){
                    if (data=="success") {
                        Main.ShowSuccessMessage("设置班组权限成功！");
                        window.parent.parent.document.getElementById("mainIframe").src="scglxt/scgl/bzxxIndex.jsp";
                    }else{
                        Main.ShowErrorMessage("设置班组权限失败！");
                    }
                },error:function(data)
                {
                    alert("error");
                }
            });
        });
    });

</script>
</head>
<body>
<div class='container container-wrapper'>
    <div class='row' id='content-wrapper'>
        <div class='box-content box-padding'>
                <div  class='control-label col-sm-4'>
                    <div id="tree"></div>
                </div>
            <div  class='control-label col-sm-3'>

                <input id="btn_save" class="btn btn-primary"  type="button" value="保存">
                <button id="btn_saving" class='btn btn-default'  style="display:none;" type='button'>
                    <i class="icon-1x icon-spinner icon-spin"></i>
                    保存中...
                </button>
            </div>
        </div>
        </div>
    </div>
</body>
</html>
