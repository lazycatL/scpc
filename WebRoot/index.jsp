<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body class='contrast-sea-blue'>
<header id="header" class="header">
    <nav class='navbar navbar-default'>
        <a class='navbar-brand' href='index.jsp'>
            北京朝阳兴隆模具生产管理系统
        </a>
        <a class='toggle-nav btn pull-left' href='#'>
            <i class='icon-reorder'></i>
        </a>
        <span class="navbar-right" style="margin-top:17px;color:white;">
            <span id="user" class=''>  </span>
            <span id="datetime" style="margin-left:50px;"></span>
            <span id="exit"><a href="login.jsp">退出系统</a></span>
        </span>
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
        </ul>
    </div>
</nav>
<section id='content'>
    <iframe id="mainIframe" style="border:0px; margin:0px;width:100%;height: 100%;overflow-x:hidden;" src=""></iframe>
</section>
</div>
<!-- / END - page related files and scripts [optional] -->
</body>
