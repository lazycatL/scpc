/**
 * Created by Administrator on 2017/5/19.
 */
var _tableId = "";
var _tableName = "";//表名
var _queryColumn = "";
var _queryKey ="";//查询关键字
var _resURL="192.168.1.254:7003";
var _keyColumn = "";//主键列名key
var bodyWidth = 4000;
var bodyHeight = 650;
var urlParam = new Object();
urlParam = $.GetRequest();
jQuery.extend({
    ResMgr: {
        init: function () {
            if (urlParam != null && urlParam.tableId != "" && urlParam.tableId != undefined) {
                _tableId = urlParam.tableId;
                $.ResMgr.initDataGrid("resInfo");
            } else {
                console.log(_tableId + "缺少配置信息");
                return;
            }
            if (urlParam != null && urlParam.tableName != "" && urlParam.tableName != undefined) {
                _tableName = urlParam.tableName;
            }

            $("#form_add").on('click', function () {

                var srcUrl = _resURL + '/resource_toAddResourceData.action?SKIN=SCPC&ISIMPORT=1&ISSHOWDELETE=1&PAGEBEAN.CURRENTPAGE=1&ISEXPORT=1&PAGEBEAN.PAGESIZE=10&ISSHOWQUERY=1&ISSHOWDATA=1&LISTORDERRULE=&ISSHOWNO=1&ISSHOWLOG=1&TABLEID=' + _tableId + '&ISBATCHDELETE=1&LISTORDERCOLUMN=&ISSHOWMODIFY=1&ISSHOWPAGE=1&ISSHOWHEAD=1&ISBATCHMODIFY=1&ISSUPERQUERY=1&ISSHOWINSERT=1&ISSHOWTITLE=1&ISSHOWPROPERTY=1&';
                if (_tableId == "0103") {
                    srcUrl = "scglxt/xsgl/editLxrInfo.jsp";
                }
                var $outFrame = $(window.parent.document.body);
                var $iframe = $outFrame.find("#mainIframe");
                var src = $iframe.attr("src");
                $iframe.attr('src', srcUrl);

            });
            $("#form_export").on('click', function () {
                window.location.href = '../resmgr_exportResourceData.action?tableId=' + _tableId;
            });
            $("#form_import").on("click",function(){

                //在modalbody 中家在iframe 内容为 工序编排的内容
                $('#import_excel').ssi_uploader({url:'../ImageUploadServlet?type=excel',preview:false,dropZone:false,allowed:['xls'],ajaxOptions:{
                    success:function(file){
                        $('#import_excel').attr("filepath",file);
                        $.ResMgr.ShowSuccessMessage("上传成功！");
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
                            $('#resInfo').DataTable().ajax.reload(function(){},true);
                            $("#sorting-advanced").dataTable().fnPageChange('previous', true);
                            $('#myModalImport').modal('hide');
                            $.ResMgr.ShowSuccessMessage("导入成功！");

                        }else{
                            $.ResMgr.ShowSuccessMessage("导入失败，请联系管理员！");
                        }
                    };
                    if (confirm("确定导入上传的Excel？")) {
                        $.asyncAjaxPost(url, {"filepath": file,"importtype":importtype}, successFun, true);
                    }
                }
            });
        },
        /**
         * 根据查询条件查询数据
         */
        queryData: function () {
            if (urlParam != null && urlParam.queryColumn != "" && urlParam.queryKey != undefined) {
                _queryColumn += urlParam.queryColumn;
                _queryKey += urlParam.queryKey;
            }
        },
        /**
         * 初始化表格列内容
         */
        initDataGrid: function (tblid) {
            $.ResMgr.queryData();
            var args = {
                id: tblid,
                columnName: [
                    {"data": null}
                ],
                optUrl: "../resmgr_getTableColumns.action?tableId=" + _tableId + "&temp=" + Math.random(),
                loadDataUrl: "../resmgr_queryTableData.action?tableId=" + _tableId + "&queryColumn=" + _queryColumn + "&queryKey=" + _queryKey + "&temp=" + Math.random()
            };
            var data;
            var successFun = function (dataInfo) {
                if (dataInfo.length > 0) {
                    data = eval(dataInfo);
                } else {
                    console.log(_tableId + "缺少配置信息");
                }
            }
            $.syncAjax(args.optUrl, _tableId, successFun, true);

            //首先写table标题列内容
            var table = $('#' + tblid);
            var th = $("<thead></thead>");
            var tr = $("<tr></tr>");
            if (data.length > 0) {
                $(".title").text(data[0].RESOURCE_NAME);
                tr.append("<th></th>");

                for (var i =0; i < data.length; i++) {
                    tr.append("<th>" + data[i].COLUMN_CNAME + "</th>");
                    var column;
                    if (data[i].COLUMNLENGTH != null && data[i].COLUMNLENGTH.length > 0) {
                        column = {"data": data[i].COLUMN_NAME, "sWidth": data[i].COLUMNLENGTH + "px"};
                    } else {
                        column = {"data": data[i].COLUMN_NAME};
                    }
                    args.columnName.push(eval(column));
                }




                th.append(tr);
                table.append(th);
            }

            //开始丰富table数据内容
            table = $('#' + tblid).DataTable({
                "bLengthChange": false,
                "oLanguage": {
                    "sProcessing": "正在加载中......",
                    "sLengthMenu": "每页显示 _MENU_ 条记录",
                    "sZeroRecords": "对不起，查询不到相关数据！",
                    "sEmptyTable": "表中无数据存在！",
                    "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                    "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                    "sSearch": "搜索",
                    "oPaginate": {
                        "sFirst": "首页",
                        "sPrevious": "上一页",
                        "sNext": "下一页",
                        "sLast": "末页"
                    }
                },
                "aLengthMenu": [20, 30],
                "ajax": "../resmgr_queryTableData.action?tableId=" + _tableId + "&queryColumn=" + _queryColumn + "&queryKey=" + _queryKey + "&temp=" + Math.random(),
                "sScrollY": bodyHeight, //DataTables的高
                "sScrollX": bodyWidth, //DataTables的宽
                "bAutoWidth": true, //是否自适应宽度
                scrollY: true,
                scrollX: true,
                scrollCollapse: true,
                paging: true,
                "columns": args.columnName
            });
            /**加上序号**/
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
            new $.fn.dataTable.FixedColumns(table, {leftColumns: 4});

        },
        delete:function(id){
            var url = "resmgr_deleteRow.action",successFun = function(resStr){
                if (resStr == "SUCCESS") {
                    $('#resInfo').DataTable().ajax.reload(function(){},true);
                    $("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
                    $.ResMgr.ShowSuccessMessage("删除成功！");
                }
            }
            if(confirm("是否删除？")){
                $.asyncAjaxPost(url, {"tableId":_tableId,"id":id}, successFun, true);
            }
        },
        //提示成功信息
        ShowSuccessMessage:function(message, life) {
            var time = 3000;
            if (!life) {
                time = life;
            }
            if ($("#tip_message").text().length > 0) {
                var msg = "<span>" + message + "</span>";
                $("#tip_message").empty().append(msg);
            } else {
                var msg = "<div id='tip_message'><span>" + message + "</span></div>";
                $("body").append(msg);
            }
            $("#tip_message").show().delay(time).fadeOut(3000);
        },
            //提示错误信息
            ShowErrorMessage:function(message, life) {
                ShowSuccessMessage(message, life);
                $("#tip_message span").addClass("error");
            }
     }
  });
$(document).ready(function () {
    $.ResMgr.init();
});