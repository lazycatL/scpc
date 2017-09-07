/** 订单信息 @author apple @constructor @date 20141024 */ (function () {
    var operateFlag = "";
    window.BomManage = (function () {
        var _t = this, _operateFlag = "",
        ssdd = null;var request = $.GetRequest();
            /** 初始化函数 */
            init = function () {


                if (request.ssdd) {
                    ssdd = request.ssdd;
                }
                tableInit(ssdd);
                registerEvent();
                if (request.model == "linked") {
                    linkedPattern();
                    calculateTimeLength();
                }
            },

            /** 注册事件 */
            registerEvent = function () {
                $("#form_add").on('click', function () {
                    var request = $.GetRequest();
                    Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp?ssdd='+ssdd);
                    /*跳转iframe页面*/
                });
                $("#form_export").on('click', function () {
                   exportData();
                });
                $("#form_import").on("click",function(){

                    //在modalbody 中家在iframe 内容为 工序编排的内容
                    $('#import_excel').ssi_uploader({url:'../../ImageUploadServlet?type=excel',preview:false,dropZone:false,allowed:['xls'],ajaxOptions:{
                        success:function(file){
                            $('#import_excel').attr("filepath",file);
                            Main.ShowSuccessMessage("上传成功！");
                        }
                    }});
                    $('#myModalImport').modal({
                        backdrop: false,
                        show: true
                    });
                });
                //点击导入
                $("#btn_import").on("click",function(){
                    var file= $('#import_excel').attr("filepath");
                    var importtype =$("#importtype").val();
                    if(file==null || file=="")
                    {
                        Main.ShowErrorMessage("请先选择excel上传后再执行导入！");
                        return;
                    }else{
                        var url = "import_excel.action", successFun = function (resStr) {
                            if (resStr == "SUCCESS") {
                                $('#bomInfo').DataTable().ajax.reload(function(){},true);
                                $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                                $('#myModalImport').modal('hide');
                                Main.ShowSuccessMessage("导入成功！");

                            }else{
                                Main.ShowSuccessMessage("导入失败，请联系管理员！");
                            }
                        };
                        if (confirm("确定导入上传的Excel？")) {
                            $.asyncAjaxPost(url, {"filepath": file,"importtype":importtype}, successFun, true);
                        }
                    }
                });
                $("#form_reload").on('click', function () {
                    window.location.reload();
                });
                //处理时间调整
                $("#btn_saveDate").on('click', function () {
                    var id=$("#form_bomInfo_starttime").attr("bomid");
                    var url = "bomInfo_updateTime.action", successFun = function (resStr) {
                        if (resStr == "SUCCESS") {
                            $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                            $('#myTime').modal("toggle");
                            Main.ShowSuccessMessage("修改成功！");
                        }
                    };
                    if (confirm("确定修改子订单时间？")) {
                        $.asyncAjaxPost(url, {"id": id,"starttime":$("#form_bomInfo_starttime").val(),"endtime":$("#form_bomInfo_endtime").val()}, successFun, true);
                    }
                });
            },
            /**数据导出*/
            exportData = function(){
                var params="tableId=0104";
                var request = $.GetRequest();
                var ssdd = null;
                if (request.ssdd) {
                    ssdd = request.ssdd;
                    params= params+"&queryColumn=SSDD&queryKey="+ssdd;
                }
                window.location.href='../resmgr_exportResourceData.action?'+params;
                //window.location.href='../bomInfo_exportData.action';
                //window.location.href=resUrl+'/resourceImport_exportAllTemplate.action?tableId=0104&ISIMPORT=1&ISSHOWDELETE=1&PAGEBEAN.CURRENTPAGE=1&ISEXPORT=1&PAGEBEAN.PAGESIZE=10&ISSHOWQUERY=1&ISSHOWDATA=1&LISTORDERRULE=&ISSHOWNO=1&ISSHOWLOG=1&TABLEID=0104&ISBATCHDELETE=1&LISTORDERCOLUMN=&ISSHOWMODIFY=1&ISSHOWPAGE=1&ISSHOWHEAD=1&ISBATCHMODIFY=1&ISSUPERQUERY=1&ISSHOWINSERT=1&ISSHOWTITLE=1&ISSHOWPROPERTY=1&';
            },
            /** 初始化表格函数 */
            tableInit = function (ssdd) {

                var table = $('#bomInfo').DataTable({
                    "bLengthChange": false,
                    "oLanguage": {
                        "sProcessing": "正在加载中......",
                        "sLengthMenu": "每页显示 _MENU_ 条记录",
                        "sZeroRecords": "对不起，查询不到相关数据！",
                        "sEmptyTable": "表中无数据存在！",
                        "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                        "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                        "sSearch": "搜索",
                        "oPaginate": {"sFirst": "首页", "sPrevious": "上一页", "sNext": "下一页", "sLast": "末页"}
                    },
                    "aLengthMenu": [16, 24],
                    "ajax": "bomInfo_getTableData.action?ssdd=" + ssdd,
                    scrollY: "disabled",
                    scrollX: true, /*scrollCollapse: false,*/
                    paging: true,
                    "columnDefs": [
                        {
                            "render": function (data, type, row) {
                                return '<div>' +
                                    ' <a class=" " href="#" title="工序编排" onclick = "BomManage.showModel(\'' + data + '\')"> 工艺编排</a>' +
                                    ' <a class=" " href="#" title="复制" onclick = "BomManage.copyRow(\'' + data + '\')">复制</a>' +
                                   ' <a class=" " href="#" title＝"修改" ' +  'onclick = "BomManage.editRow(\'' + data + '\')"> 修改</a> <a href="#" onclick = "BomManage.deleteRow(\'' + data + '\')" title="删除">删除</a></div>';
                            }, "targets": 1
                        },
                        {
                            "render":function(data,type,row){
                                var text=data;
                                if(row.tzlx!=null && row.tzlx!="")
                                {

                                    if(row.tzlx.toUpperCase().indexOf("JPG")!=-1 || row.tzlx.toUpperCase().indexOf("PNG")!=-1 || row.tzlx.toUpperCase().indexOf("GIF")!=-1)
                                    {
                                        var url=encodeURI('../lctImg.html?img=' + row.tzurl);
                                        text=' <a class=" "  TARGET="viewer"  href="'+url+ '" title="图纸"> '+data+'</a>';
                                    }else{
                                        var url=encodeURI('../../'+ row.tzurl );
                                        text=' <a class=""  TARGET="viewer"  href="'+url + '" title="图纸"> '+data+'</a>';
                                    }
                                }
                                return text;
                            },"targets":3
                        },
                        {
                            "render": function (data, type, row) {
                                var str = "";
                                if(data=='1'){
                                    str =  "已完成" ;
                                }else if(data=="2"){
                                    str =  "自备料" ;
                                }
                                else{
                                    str = "未完成" ;
                                }
                                return str ;
                            }, "targets": 16
                        }, {
                            "render": function ( data, type, row ) {
                                var jb=row.zddjb;
                                if (jb=="0601") {
                                    return '<span class="label label-danger">'+row.zddmc+'</span>';
                                }else if(jb=="0602")
                                {
                                    return '<span class="label label-warning">'+row.zddmc+'</span>';
                                }else{
                                    return '<span>'+row.zddmc+'</span>';
                                }
                            }, "targets": 3
                        },{
                            "render": function ( data, type, row )  {
                                var date = new Date();
                                var now="";
                                now = date.getFullYear() + "/";
                                now = now + (date.getMonth() + 1) + "/";  //取月的时候取的是当前月-1如果想取当前月+1就可以了
                                now = now + date.getDate() + " ";
                               // var cha = Math.round(( Date.parse(data['ddendtime'])-Date.parse(now) ) / 86400000)+1;
                                var cha=$.DateDiff(now,row.ddendtime);
                                if( cha<=0)
                                {
                                    return data;
                                }
                                else if ( cha<=3 ) {
                                    //$('td', row).eq(3).css('font-weight',"bold").css("background","red").css("color","#FFF");;
                                    return '<span class="label label-danger">'+data+'</span>';
                                }else if(cha <7)
                                {
                                    return '<span class="label label-warning">'+data+'</span>';
                                }else{
                                    return data;
                                }
                            }, "targets": 2
                        }
                         /*是否显示列*/],

                    "columns": [{"data": null},
                                {"data": "id","sWidth": "180px"},
                        {"data": "ddmc", "sWidth": "120px"},
                        {"data": "zddmc", "sWidth": "200px"},
                        {"data": "ddztmc", "sWidth": "80px"},
                        {"data": "ddendtime", "sWidth": "120px"},
                        {"data": "clmc","sWidth": "120px"},
                        {"data": "gxnr","sWidth": "300px"},
                        {"data":"bomjd","sWidth":"300px"},
                        {"data": "jgsl","sWidth": "60px"},
                        {"data": "clxz"},
                        {"data": "cldx"},
                        {"data": "cltj"},
                        {"data": "clje"},
                        {"data": "bmcl"},
                        {"data": "gs", "sWidth": "120px"},
                        {"data": "clzt", "sWidth": "120px"},
                        {"data": "ddtz", "sWidth": "120px"},
                        {"data": "rksj", "sWidth": "120px"},
                        {"data": "bfjs"},
                        {"data": "bhgjs", "sWidth": "120px"}
                    ]

                });

                /**加上序号**/
                table.on('order.dt search.dt', function () {
                    table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                        cell.innerHTML = i + 1;
                    });
                }).draw();
                new $.fn.dataTable.FixedColumns(table, {leftColumns: 4});
            },
            /**
             * 删除信息
             */
            deleteRow = function (id) {
                var url = "bomInfo_deleteRow.action", successFun = function (resStr) {
                    if (resStr == "SUCCESS") {
                        $('#bomInfo').DataTable().ajax.reload(function(){},true);
                        $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                        Main.ShowSuccessMessage("删除成功！");
                    }
                };
                if (confirm("确定删除？")) {
                    $.asyncAjaxPost(url, {"id": id}, successFun, true);
                }
                //判断是否要删除
                //删除数据库成功后删除表格
                //1、删除数据库
                //2、删除表格
            },
        //跳转页面
            editRow = function (id) {
                Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp?id=' + id+"&ssdd="+ssdd);//跳转iframe页面
            },
            copyRow = function (id) {
                Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp?copy=copy&id=' + id+"&ssdd="+ssdd);//跳转iframe页面
            },
            /**
             * 更新合同信息
             */
            saveHtInfo = function (flag) {

            },
            initHtInfo = function (flag) {

            },
            /**
             * 显示modal框
             */
            showModel = function (data) {
                $('#myModal').modal({
                    backdrop: false,
                    show: true
                });
                var ssdd = null;
                if (request.ssdd) {
                    ssdd = request.ssdd;
                }
                //在modalbody 中家在iframe 内容为 工序编排的内容
                $content = "<iframe src='gygcManager.jsp?ssdd="+ssdd+"&bomid=" + data + "' style='border:0;width:100%;height:550px;overflow:hidden;'></iframe>";
                $container = $('#modal-body');
                $container.empty().append($content);
            },

            updateDate = function(id,starttime,endtime) {
                if (starttime != "null") {
                    $("#form_bomInfo_starttime").val(starttime);
                }
                else{
                    $("#form_bomInfo_starttime").val("");
                }
                if(endtime == "null") {
                    $("#form_bomInfo_endtime").val("");
                }else{
                    $("#form_bomInfo_endtime").val(endtime);
                }

                $("#form_bomInfo_starttime").attr("bomid",id);

                $('#myTime').modal({
                    backdrop: false,
                    show: true
                });

            },
            linkedPattern = function () {
                $("#form_add").remove();
                $("#form_export").remove();
                $(".dataTables_filter").closest(".row").remove();
            },
            calculateTimeLength = function () {
                var ssdd = 1;
                var url = "bomInfo_calculateTimeLength.action", successFun = function (data) {
                    var str = "(工时统计：";
                    if (data && data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            str += data[i].gynr + "(" + data[i].timelength + ")&nbsp;&nbsp;"
                        }
                        str += ")单位/分钟"
                        $(".box-header .title").append("<small>" + str + "</small>")
                    }
                };
                $.asyncAjax(url, {"ssdd": ssdd}, successFun, true);
            }


            ;

        return {
            init: init,
            tableInit:tableInit,
            deleteRow: deleteRow,
            editRow: editRow,
            copyRow:copyRow,
            showModel: showModel,
            updateDate:updateDate,
            exportData:exportData
        }
    })();


})();


$(document).ready(function () {
    BomManage.init();
});
 
 
	
