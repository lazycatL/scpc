/** 订单信息 @author apple @constructor @date 20141024 */ (function () {
    var operateFlag = "";
    window.BomManage = (function () {
        var _t = this, _operateFlag = "",

            /** 初始化函数 */
            init = function () {
                var request = $.GetRequest();
                var ssdd = null;
                if (request.ssdd) {
                    ssdd = request.ssdd;
                }
                tableInit(ssdd);
                registerEvent();
                if (request.model == "linked") {
                    linkedPattern();
                    calculateTimeLength();
                }
                //初始化日期控件
                $('#form_bomInfo_starttime').datetimepicker({
                    format: 'yyyy-mm-dd hh:ii',
                    autoclose:true
                });
                $('#form_bomInfo_endtime').datetimepicker({
                    format: 'yyyy-mm-dd hh:ii',
                    autoclose:true
                });
            },

            /** 注册事件 */
            registerEvent = function () {
                $("#form_add").on('click', function () {
                    Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp');
                    /*跳转iframe页面*/
                });
                $("#form_export").on('click', function () {
                   exportData();
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
                            alert("修改成功！");
                        }
                    };
                    if (confirm("确定修改子订单时间？")) {
                        $.asyncAjaxPost(url, {"id": id,"starttime":$("#form_bomInfo_starttime").val(),"endtime":$("#form_bomInfo_endtime").val()}, successFun, true);
                    }
                });
            },
            /**数据导出*/
            exportData = function(){
                window.location.href='../bomInfo_exportData.action';
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
                    "aLengthMenu": [20, 30],
                    "ajax": "bomInfo_getTableData.action?ssdd=" + ssdd,
                    scrollY: "disabled",
                    scrollX: true, /*scrollCollapse: false,*/
                    paging: true,
                    "columnDefs": [
                        {
                            "render": function (data, type, row) {
                                return '<div class="">' +
                                    ' <a class=" " href="#" title="工序编排" ' +
                                    'onclick = "BomManage.showModel(\'' + data + '\')"> 工艺编排</a>' +
                                    ' <a class=" " href="#" title＝"时间调整" ' +
                                    'onclick = "BomManage.updateDate(\'' + data + '\',\''+row.starttime+'\',\''+row.endtime+'\')"> 时间调整</a>' +
                                    ' <a class=" " href="#" title＝"修改" ' +
                                    'onclick = "BomManage.editRow(\'' + data + '\')"> 修改</a>' +
                                    ' <a href="#" onclick = "BomManage.deleteRow(\'' + data + '\')" title="删除">删除</a></div>';
                            }, "targets": 1
                        },
                        {
                            "render": function (data, type, row) {
                                var str = "";
                                if(data=='1'){
                                    str =  "长方体" ;
                                }else if(data=='2'){
                                    str = "圆柱体" ;
                                }
                                return str ;
                            }, "targets": 8
                        },
                        {
                            "render": function (data, type, row) {
                                var str = "";
                                if(data=='1'){
                                    str =  "已完成" ;
                                }else{
                                    str = "未完成" ;
                                }
                                return str ;
                            }, "targets": 16
                        },
                        {"visible": false, "targets": [2]}
                         /*是否显示列*/],
                    "columns": [{"data": null, "sWidth": "30px"},
                                {"data": 'id',"sWidth": "190px"},
                                {"data": "id"}, 
                                {"data": "zddmc", "sWidth": "120px"},
                        {"data": "ddztmc", "sWidth": "120px"},
                        {"data": "clmc","sWidth": "120px"},
                                {"data": "gxnr","sWidth": "300px"},
                        {"data": "jgsl","sWidth": "60px"},
                        {"data": "clxz"},
                        {"data": "cldx"},
                        {"data": "cltj"},
                        {"data": "clje"},
                        {"data": "bmcl"},
                        {
                            "data": "starttime",
                            "sWidth": "120px"
                        }, {"data": "endtime", "sWidth": "120px"},
                        {"data": "gs", "sWidth": "120px"},
                        {"data": "blqk", "sWidth": "120px"},
                        {"data": "blkssj", "sWidth": "120px"},
                        {"data": "bljssj", "sWidth": "120px"},
                        {"data": "clzt", "sWidth": "120px"},
                        {"data": "cgry"},
                        {"data": "cgsj"},
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
                        window.location.reload();
                        $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                        alert("删除成功！");
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
                Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp?id=' + id);//跳转iframe页面
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
                //在modalbody 中家在iframe 内容为 工序编排的内容
                $content = "<iframe src='gygcManager.jsp?bomid=" + data + "' class='modal_iframe'></iframe>";
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
            showModel: showModel,
            updateDate:updateDate,
            exportData:exportData
        }
    })();


})();


$(document).ready(function () {
    BomManage.init();
});
 
 
	
