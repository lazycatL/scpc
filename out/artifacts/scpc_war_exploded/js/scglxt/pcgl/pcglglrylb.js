(function () {
    var operateFlag = "";
    window.BomPcManage = (function () {
        var _t = this, _operateFlag = "",

            /** 初始化函数 */
            init = function () {
                var request = $.GetRequest() ;
                var ssdd = null ;
                if(request.ssdd){
                    ssdd=request.ssdd ;
                }
                tableInit(ssdd);
                registerEvent();
                $("#")
            },

            /** 注册事件 */
            registerEvent = function () {
                $("#form_add").on('click', function () {
                  //  Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp');
                    /*跳转iframe页面*/
                })
            },
            /** 初始化表格函数 */
            tableInit = function () {

                var table = $('#pcglBomStatus').DataTable({
                	
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
                    "ajax": "pcgl_getBomStatusList.action",
                    scrollY: "disabled",
                    scrollX: true,
                    paging: true,
                    columnDefs: [],
                    "columnDefs": [{
	                        
                    	"render": function (data, type, row) {
	                            return '<div class="">' + ' <a class="btn btn-primary btn-xs" href="#" title="时间安排" onclick = "BomManage.showModel(\'' + data + '\')"><i class="icon-ok" ></i>工艺编排</a>' + ' <a class="btn btn-info btn-xs" href="#" title＝"修改" onclick = "BomManage.editRow(\'' + data + '\')"><i class="icon-edit" ></i></a>' + ' <a class="btn btn-danger btn-xs" href="#" title="删除"><i class="icon-remove" onclick = "BomManage.deleteRow(\'' + data + '\')"></i></a></div>';
	                        }, "targets": 1
                    	}, 
                    	{"visible": false, "targets": [2]} /*是否显示列*/
                    ],
                    "columns": [
                                
                        {"data": null},
                        {"data": 'id',"sWidth": "200px"}, 
                        {"data": "zddmc", "sWidth": "120px"}, 
                        {"data": "ddtz","sWidth": "300px"},
                        {"data": "bmcl"},
                        {"data": "jhkssj","sWidth": "120px"}, 
                        {"data": "jhjssj", "sWidth": "120px"},
                        {"data": "gs", "sWidth": "120px"},
                        
                    ]

                });

                /**加上序号**/
                table.on('order.dt search.dt', function () {
                    table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                        cell.innerHTML = i + 1;
                    });
                }).draw();
                new $.fn.dataTable.FixedColumns(table, {leftColumns: 3});

            },
            /**
             * 删除信息
             */
            deleteRow = function (id) {
                var url = "bomInfo_deleteRow.action", successFun = function (resStr) {
                    if (resStr == "SUCCESS") {
                        window.location.reload();
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
            }

            ;

        return {
            init: init,
            deleteRow: deleteRow,
            editRow: editRow,
            showModel: showModel
        }
    })();


})();


$(document).ready(function () {
	BomPcManage.init();
});
 
 
	
