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
                
                var request = $.GetRequest();
                var sbid = null;
                if (request.sbid) {
                	tableInit(request.sbid);
                }
            },
            /**
             * 初始化表格函数
             */
            tableInit = function (sbid) {
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
                    "ajax": "gxInfo_getTableData1.action?sbid="+sbid,
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
                                    ' <a class=" " href="#" title＝"修改" onclick = "jgryksjgWindowOpen(\'' + data + '\')">调整</a>' +
                                    '</div>';
                            },
                            "targets": 1
                        }
                    ],
                    "columns": [
                        {"data": null},
                        {"data": 'id'},
                        {"data": "sbmc"},
                        {"data": "gymc"},
                        {"data": "dd"},
                        {"data": "zdd"},
                        {"data": "edgs"},
                        {"data": "jgsl"},
                        {"data": "yjgjs"},
                        {"data": "t"},
                        {"data": "kssj"},
                        {"data": "jssj"}
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
            editRow:editRow
        }
    })();


})();


$(document).ready(function () {
    GyManage.init();
    initSbzd();
});
function initSbzd(){
	
	$.ajax({
        type: "post",
        url: "pcgl_getJgSbInfo.action",
        dataType: "json",
        success: function (dt) {

            for (var i = 0; i < dt.length; i++) {
                var html = "<option value=" + dt[i].id + ">" + dt[i].sbmc + "</option>";
                $("#jgsb").append(html);
            }

        }
    });
}
var gcid = null;
	
function jgryksjgWindowOpen(data){
	
	$('#ksjg').dialog('open');
	gcid = data;
} 
 
function saveSj(){
	var jgsb = $('#jgsb').val();
	$.ajax({
        type: "post",
        url: "pcgl_jgryJs1.action",
        dataType: "text",
        data: {
            "gygcid": gcid,
            "sbid":jgsb
            
        },
        success: function (dt) {
              	
        	$('#ksjg').dialog('close');
        	$('#gxInfo').DataTable().ajax.reload(function(){},true);
        }
    });
}