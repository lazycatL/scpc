/**
 * Created by Administrator on 2017/5/19.
 */
var _tableId = "";
var _tableName = "";//表名
var _keyColumn = "";//主键列名key
var bodyWidth = 4000;
var bodyHeight = 650;
var _flag = "";//标示当前是新增还是修改复制
jQuery.extend({
    ResMgr:{
        init:function(){
            var urlParam = new Object();
            urlParam = $.GetRequest();
            if (urlParam != null && urlParam.tableId != "" && urlParam.tableId != undefined) {
                _tableId = urlParam.tableId;
                $.ResMgr.initDataGrid("resInfo");
            }else{
                console.log(_tableId+"缺少配置信息");
                return;
            }
            if (urlParam != null && urlParam.tableName != "" && urlParam.tableName != undefined) {
                _tableName = urlParam.tableName;
            }

            $("#form_export").on('click', function () {
                //window.location.href='../resmgr_exportResourceData.action?tableId='+_tableId;
                $('#customers2').tableExport({type:'excel',escape:'false'});
            });
        },
        /**
         * 初始化表格列内容
         */
        initDataGrid:function(tblid){

            var args={
                id:tblid,
                columnName:[{"data": null}],
                optUrl:"../resmgr_getTableColumns.action?tableId="+_tableId,
                loadDataUrl:"../resmgr_queryTableData.action?tableId="+_tableId
            };
            var data;
            var successFun = function (dataInfo) {
                if (dataInfo.length >0) {
                    data=eval(dataInfo);
                }else{
                    console.log(_tableId+"缺少配置信息");
                }
            }
            $.syncAjax(args.optUrl,_tableId, successFun, true);

            //首先写table标题列内容
            var table = $('#'+tblid);
            var th=$("<thead></thead>");
            var tr=$("<tr></tr>");
            if(data.length>0)
            {
                $(".title").text(data[0].RESOURCE_NAME);
                tr.append("<th></th>");
                for(var i=0;i<data.length;i++) {
                    tr.append("<th>" + data[i].COLUMN_CNAME + "</th>");
                    var column;
                    if(data[i].COLUMNLENGTH!=null && data[i].COLUMNLENGTH.length>0)
                    {
                        column= {"data":data[i].COLUMN_NAME,"sWidth":data[i].COLUMNLENGTH + "px"};
                    }else{
                        column= {"data":data[i].COLUMN_NAME};
                    }
                    args.columnName[i+1]=eval(column);
                }
                th.append(tr);
                table.append(th);
            }

            //开始丰富table数据内容
            table = $('#'+tblid).DataTable({
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
                "ajax": "../resmgr_queryTableData.action?tableId="+_tableId,
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
            new $.fn.dataTable.FixedColumns( table, {leftColumns:4});

        }
    }

});
$(document).ready(function () {
    $.ResMgr.init();
});