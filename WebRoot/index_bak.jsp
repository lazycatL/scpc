<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body class='contrast-sea-blue'>
<header id="header" class="header">
    <nav class='navbar navbar-default'>
        <a class='navbar-brand' href='main.html'>
            北京朝阳兴隆模具生产管理系统
        </a>
        <a class='toggle-nav btn pull-left' href='#'>
            <i class='icon-reorder'></i>
        </a>
    </nav>
</header>
<div id='wrapper' style="max-height:100%;">
<!--     <div class="header"> -->
<!--       <nav class='navbar navbar-default'> -->
<!--         <a class='navbar-brand' href='main.html'> -->
<!--         	北京朝阳兴隆模具生产管理系统 -->
<!--         </a> -->
<!--         <a class='toggle-nav btn pull-left' href='#'> -->
<!--           <i class='icon-reorder'></i> -->
<!--         </a> -->
<!--       </nav> -->
<!--     </div> -->
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
            <li class=''>
                <a class="dropdown-collapse in" href="#"><i class='icon-edit'></i>
                    <span id='xsgl'>销售管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked in'>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-user'></i>
                            <span id=khxxgl>客户信息管理</span>
                        </a>
                    </li>
                    <li class='active'>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="htgl">合同管理</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a class='dropdown-collapse ' href='#'>
                    <i class='glyphicon glyphicon-wrench'></i>
                    <span>技术管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked'>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-align-justify'></i>
                            <span id="ddgl">订单管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-th-list'></i>
                            <span id="bomgl">BOM表管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-tower'></i>
                            <span id="gxgl">工序管理</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a class='dropdown-collapse ' href='#'>
                    <i class='glyphicon glyphicon-calendar'></i>
                    <span>生产管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked'>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-inbox'></i>
                            <span id="sbgl">设备管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-bookmark'></i>
                            <span id="bzgl">班组管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-user'></i>
                            <span id="rygl">人员管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-indent-left'></i>
                            <span id="jgryjg">加工人员加工</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-facetime-video'></i>
                            <span id="jgqkhz">生产情况跟踪</span>
                        </a>
                    </li>
                    <li class=''>
                        <a class='dropdown-collapse' href='#'>
                             <i class='glyphicon glyphicon-tasks'></i>
                            <span id="pcrwgl">排产任务管理</span>
                            <i class='icon-angle-down angle-down'></i>
                        </a>
                        <ul class='nav nav-stacked'>
                            <li>
                                <a class='dropdown-collapse' href='#'>
                                    <i class='icon-caret-right'></i>
                                    <span id="scgl-glry-sb">生产设备调配</span>
                                </a>
                            </li>

                            <li>
                            	 <a class='dropdown-collapse'
                                   href=''>
                                    <i class='icon-caret-right'></i>
                                    <span id="scgl-pcgl">总体时间调配</span>
                                </a>
                            </li>
                        </ul>
                </ul>
            </li>
            <li>
                <a class='dropdown-collapse ' href='#'>
                    <i class='glyphicon glyphicon-shopping-cart'></i>
                    <span>采购管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked'>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-tags'></i>
                            <span id="ddcggl">订单采购管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="ghsgl">供货商管理</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%--<li class=''>--%>
                <%--<a href='#'>--%>
                    <%--<i class='icon-star'></i>--%>
                    <%--<span id="wxgl">外协管理</span>--%>
                <%--</a>--%>
            <%--</li>--%>
            <li>
                <a class='dropdown-collapse ' href='#'>
                    <i class='glyphicon glyphicon-plane'></i>
                    <span>质量管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked'>
                    <%--<li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="cpzlgl">产品质量管理</span>
                        </a>
                    </li>--%>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-barcode'></i>
                            <span id="jyryjy">检验人员检验</span>
                        </a>
                    </li>

                </ul>
            </li>
            <li>
                <a class='dropdown-collapse ' href='#'>
                    <i class='glyphicon glyphicon-briefcase'></i>
                    <span>库存管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked'>
                    <li class=''>
                        <a href='#'>
                            <i class='glyphicon glyphicon-pushpin'></i>
                            <span id="jbljgl">基本零件管理</span>
                        </a>
                    </li>
                    <li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="scclgl">生产材料管理</span>
                        </a>
                        </li>
                   <%-- <li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="scclgl">生产材料管理</span>
                        </a>
                    </li>--%>
<%--                    <li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="cpgl">产品管理</span>
                        </a>
                    </li>--%>
                    <li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="kcgl">库存管理</span>
                        </a>
                    </li>

                </ul>
            </li>
            <li>
                <a class='dropdown-collapse ' href='#'>
                    <i class='glyphicon glyphicon-cog'></i>
                    <span>基本信息综合管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='nav nav-stacked'>
<%--                    <li class=''>
                        <a href='#'>
                            <i class='icon-caret-right'></i>
                            <span id="ywlxgl">业务类型管理</span>
                        </a>
                    </li>--%>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<section id='content'>
    <iframe id="mainIframe" style="border:0px; margin:0px;width:100%;height: 100%;" src="success.jsp"></iframe>
</section>
</div>
<!-- / END - page related files and scripts [optional] -->
</body>
