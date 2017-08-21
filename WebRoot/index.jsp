<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<script type="text/javascript">

    function menuInt()
    {
        var menu=$("#main_Menu");
        var url = "common_loadMenuTree.action", successFun = function (data) {
            if (data && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var mli=$("<li></li>");
                    var link=$("<a  onclick='menuClick(this)' class='dropdown-collapse in' href='#'></a>");
                    var icons=$("<i class='"+data[i].cdtb+"'></i>");
                    var mspan=$("<span id='"+data[i].cddz+"'>"+data[i].cdmc+"</span>");
                    var dli=$("<i class='icon-angle-down angle-down'></i>");
                    link.append(icons);
                    link.append(mspan);
                    link.append(dli);
                    mli.append(link);
                    if(data[i].children.length>0) {
                        var pul = $("<ul id='ul_"+ data[i].cddz +"' class='nav nav-stacked in' style='display:block;'></ul>");
                        for (var j = 0; j < data[i].children.length; j++) {
                            var pli = $("<li onclick='Main.changeNavUrl(\""+  data[i].children[j].url +"\");' id='"+  data[i].children[j].url +"'></li>");
                            var plink = $("<a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>");
                            var picons = $("<i class='" +  data[i].children[j].cdtb + "'></i>");
                            var pspan = $("<span class='menu-text' id='" +  data[i].children[j].cddz + "'>" +  data[i].children[j].cdmc + "</span>");

                            plink.append(picons);
                            plink.append(pspan);
                            pli.append(plink);
                            pul.append(pli);
                        }
                        mli.append(pul);
                    }
                    menu.append(mli);
                }
                if($("#main_Menu > li > ul > li").length!=0)
                {
                    Main.changeNavUrl($("#main_Menu > li > ul > li")[0].id);
                }
            }

        };
        $.asyncAjax(url, {"pid": 0}, successFun, true);
    }
    function getTsInfo(){
        //获取菜单中冒泡显示
            var url="common_getDbsxInfo.action", successFun = function (data) {
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var tspan = $("<span class='menu-text' id='" +  data[i].cddz + "'>" +  data[i].cdmc + "</span>");
                        if (data[i].count == "0") {
                            $("#" + data[i].cddz).html(tspan);
                        }else if(data[i].cddz=="bomgl"){

                            if (data[i].jxzcount == "0") {
                            }else{
                                var pspan = $("<span class='pull-right badge badge-warning'>" + data[i].jxzcount + "</span>");
                                tspan.append(pspan);
                            }
                            if (data[i].wkscount == "0") {
                            }else{
                                //var pspan = $("<span class='pull-right badge badge-important'>" + data[i].wkscount + "</span>");
                                //tspan.append(pspan);
                            }
                            $("#" + data[i].cddz).html(tspan);
                        }else{
                            var pspan = $("<span class='pull-right badge badge-warning'>" + data[i].count + "</span>");
                            $("#" + data[i].cddz).html(tspan.append(pspan));
                        }
                    }
                }
            };
            $.asyncAjax(url, {"pid": 0}, successFun, true);

    }
    function menuClick(li)
    {
        var link, list;
        var body, click_event, content, nav, nav_toggler;
        nav_toggler = $("header .toggle-nav");
        nav = $("#main-nav");
        content = $("#content");
        body = $("body");
        link = $(li);
        list = link.next();
        if (list.is(":visible")) {
            if (body.hasClass("main-nav-closed") && link.parents("li").length === 1) {
                false;
            } else {
                link.removeClass("in");
                list.slideUp(300, function() {
                    return $(this).removeClass("in");
                });
            }
        } else {
            if (list.parents("ul.nav.nav-stacked").length === 1) {
                $(document).trigger("nav-open");
            }
            link.addClass("in");
            list.slideDown(300, function() {
                return $(this).addClass("in");
            });
        }
    }

    function gxsm()
    {
        $("#myModal .modal-body").html("");

        var str = '<h4>更新内容</h4>' +
                '<table id="previewHt" class="table table-bordered table-striped table-hover " style="font-size:14px"> ' +
                '<tr>' +
                '<td>更新时间</td>' +
                '<td>2017年5月19日23:07:24</td>' +
                '</tr>' +
                '<tr>' +
                '<td>更新内容</td>' +
                '<td>1.工人加工情况统计菜单添加。<br/>' +
                    '2.订单材料统计菜单添加。<br/>'+
                    '3.图纸查看可放大缩小。<br/>'+
                '</td>' +
                '</tr>' +


                '</table>';
        $("#myModal .modal-body").html(str);

        $('#myModal').modal({
            backdrop: false,
            show: true
        });
    }
    $(document).ready(function () {
        menuInt();
        $("#gxsm").click(function() {
            gxsm();
        });
        setInterval(function(){
            getTsInfo();
        },1000);
    });

</script>
<body class='contrast-sea-blue'>
<header id="header" class="header">
    <nav class='navbar navbar-default'>
        <a class='navbar-brand' href='index.jsp'>
            北京朝阳兴隆模具生产管理系统
        </a>
        <a class='toggle-nav btn pull-left' href='#'>
            <i class='icon-reorder'></i>
        </a>
        <span class="navbar-left" style="margin-top:17px;color:white;">
             <span id="gzlc" style="cursor:pointer;">工作流程图</span>

            <span id="datetime" style="margin-left:50px;font-size:16px;"></span>

            <%--<span id="gxsm" style="margin-left:-50px;font-size:16px;cursor:pointer;color:#F8A326;">更新说明</span>--%>
        </span>
        <span class="navbar-right" style="margin-top:17px;color:white;">
            <span id="user"  style="margin-left:10px;font-size:16px;color:#F8A326;"></span>
            <span id="exit"><a href="login.jsp">退出系统</a></span>
        </span>
    </nav>
</header>
<div id='wrapper' style="max-height:100%;">
<div id='main-nav-bg'></div>
<nav id='main-nav'>
    <div class='navigation'>
        <div class='search'>
            <form action='search_results.html' method='get'>
                <div class='search-wrapper'>
                    <input value="" class="search-query form-control" placeholder="Search..." autocomplete="off"
                           name="q" type="text"/>
                    <button class='btn btn-link icon-search' name='button' type='submit'></button>
                </div>
            </form>
        </div>
        <ul id="main_Menu" class='nav nav-stacked'>
        </ul>
    </div>
</nav>
<section id='content'>
    <img id="gzlctImg" style="display:none;" src="images/lct.png" style="width:90%;height:100%;margin-top: 50px;">
    <iframe id="mainIframe" style="border:0px; margin:0px;width:100%;height: 100%;overflow-x:hidden;" src=""></iframe>

</section>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
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
<!-- / END - page related files and scripts [optional] -->
</body>
