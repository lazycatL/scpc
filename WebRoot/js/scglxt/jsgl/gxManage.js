/**
 * 订单信息
 * @author apple
 * @constructor
 * @date 20141024
 */
(function () {
    var operateFlag = "";
    window.GyManage = (function () {
        var _t = this,
            _operateFlag = "",
            /**
             * 初始化函数
             */

            init = function () {
                tableInit();
                $("#form_add").on('click',function(){
                    skipToFormPage('scglxt/jsgl/editGxInfo.jsp');//跳转iframe页面
                })
            },
            /**
             * 初始化表格函数
             */
            tableInit = function () {
                var table = $('#gxInfo').DataTable({
//			"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    "bLengthChange": false,
                    //改变语言
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
                    "ajax": "gxInfo_getTableData.action",
                    "sScrollY": 450, //DataTables的高
                    "sScrollX": 820, //DataTables的宽
                    scrollY: true,
                    scrollX: true,
                    scrollCollapse: true,
                    paging: true,
                    columnDefs: [
                        {width: '20%', targets: 0}
                    ]
                    ,
                    "columnDefs": [
                        {
                            "render": function (data, type, row) {
                                return '<div class="">' +
                                    ' <a class=" " href="#" title＝"修改" onclick = "GyManage.editRow(\'' + data + '\')">修改 </a>' +
                                    ' <a class=" " href="#" title="删除" onclick = "GyManage.deleteRow(\'' + data + '\')"> 删除 </a>' +
                                    '</div>';
                            },
                            "targets": 1
                        },
                        {
                            "render": function (data, type, row) {
                                if(data=="1"){
                                    return "外协";
                                }else{
                                    return "否" ;
                                }
                            },
                            "targets": 6
                        },
                        {"visible": false, "targets": [2]}
                    ],
                    "columns": [
                        {"data": null},
                        {"data": 'id'},
                        {"data": "id"},
                        {"data": "gymc"},
                        {"data": "id"},
                        {"data": "fzbz"},
                        {"data": "sfwx"}
                    ]

                });

                /**加上序号**/
                table.on('order.dt search.dt', function () {
                    table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                        cell.innerHTML = i + 1;
                    });
                }).draw();

                //new $.fn.dataTable.FixedColumns(table);

            },
            /**
             * 删除信息
             */
            deleteRow = function (id) {
                var url = "gxInfo_deleteRow.action", successFun = function (resStr) {
                    if (resStr == "SUCCESS") {
                        window.location.reload();
                        $("#sorting-advanced").dataTable().fnPageChange('previous', true);
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
            /**
             * 更新合同信息
             */
                //跳转页面
            editRow = function(id){
                Main.swapIframUrl('scglxt/jsgl/editGxInfo.jsp?id='+id);//跳转iframe页面
            },
            saveHtInfo = function (flag) {

            },
            initHtInfo = function (flag) {

            },
            skipToFormPage = function(url,curPageNum,id,editModel){
            var $outFrame =  $(window.parent.document.body)  ;
            var $iframe = $outFrame.find("#mainIframe");
            var src = $iframe.attr("src");
            $iframe.attr('src',url)
        }

        ;


        return {
            init: init,
            editRow:editRow,
            deleteRow: deleteRow
        }
    })();


})();


$(document).ready(function () {
    GyManage.init();
});
 
 
	
 
 