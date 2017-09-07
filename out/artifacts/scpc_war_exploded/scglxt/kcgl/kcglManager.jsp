<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>备料库存管理</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <%--<script type    ="text/javascript" src="../../js/scglxt/jsgl/CgglManager.js"></script>--%>
</head>
<body>
<div class='container-fluid'>
    <div  id='content-wrapper'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'> 备料库存管理</div>
                    <button id="form_export" class="btn btn-success btn-sm"><i class="icon-add"></i> 导出</button>
                    <div class='actions'><a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                    </a> <a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a></div>
                </div>
                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="bomInfo" class='table table-striped table-bordered tableGrid cell-border'
                                   style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th class="serial">序号</th>
                                    <th style="width:180px;"> 备料情况</th>
                                    <th> 订单名称</th>
                                    <th> 零件名称</th>
                                    <th> 材料名称</th>
                                    <th>备料件数</th>
                                    <th> 料的大小</th>
                                    <th> 料的形状</th>
                                    <th> 料的体积</th>
                                    <th> 料的金额</th>
                                    <th> 加工数量</th>
                                    </th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:400px;height:240px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel"><b>填写采购建议</b></h5>
                <button type="button" class="close"data-dismiss="modal" aria-hidden="true" style="margin-top:-25px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body">
                <textarea id="cgjy" cols="55" rows="5"></textarea>
                <input id="btn_saveCyy" style="margin-left: 200px;" onclick="CgglManager.addCgjy();" class="btn" type="button" value="保存">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>

</body>
<script>
    /** 订单信息 @author apple @constructor @date 20141024 */ (function () {
        var operateFlag = "";
        window.CgglManager = (function () {
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

                    },

                    /** 注册事件 */
                    registerEvent = function () {
                        $("#form_add").on('click', function () {
                            Main.swapIframUrl('scglxt/jsgl/editBomInfo.jsp');
                            /*跳转iframe页面*/
                        });
                        $("#form_export").on('click', function () {
                            CgglManager.exportData();
                        });
                        $(".blqk input[type='radio']").live("change",function(e){
                            e.stopPropagation();
                            var rowid = $(this).attr("name") ;
                            var blqk = $(this).attr("value") ;
                            changeBlqk(rowid,blqk) ;
                        })
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
                            "ajax": "bomInfo_getTableData.action?ssdd=" + ssdd + "&kcgl=true",
                            scrollY: "disabled",
                            scrollX: true, /*scrollCollapse: false,*/
                            paging: true,

                            "columnDefs": [{
                                "render": function (data, type, row) {
                                   if (row.clzt == null ||row.clzt=="") {
                                        return ' <div class="blqk text-center"><input type="radio" value=1    name="'+row.id+'"/> 完成' +
                                                '<input type="radio" value=0  name="'+row.id+'"/>待采购  '  +
                                                '<input type="radio" value=2   name="'+row.id+'"/>自备料 </div>';
                                    }else if (row.clzt=='0')
                                   {
                                       return ' <div class="blqk text-center"><input type="radio" value=1    name="'+row.id+'"/> 完成' +
                                               '<div class="blqk text-center" style="color:green">待采购,<a href="javascript:CgglManager.stock(\''+row.id+'\')">填写采购建议</a></div>' ;
                                   }else if (row.clzt == "1") {
                                        return '<div class="blqk text-center" style="color:green">已完成</div>' ;
                                    }else if(row.clzt == "2"){
                                        return ' <div class="blqk text-center" style="color:green">自备料 <input type="radio" value=1 name="'+row.id+'"/><span  style="color:green"> 完成</span></div>' ;
                                    }else{
                                       return ' <div class="blqk text-center"><input type="radio" value=2 name="'+row.id+'"/> 完成 <span style="color:#fff;" class="label-default" style="color:green">自带料 </span></div>' ;
                                   }

                                }, "targets": [1]

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
                            ],
                            "columns": [
                                {"data": null, "sWidth": "60px"},
                                {"data": "clzt" ,"sWidth": "160px"},
                                {"data": "ddmc", "sWidth": "120px"},
                                {"data": "zddmc", "sWidth": "130px"},
                                {"data": "clmc", "sWidth": "120px"},
                                {"data": "bljs", "sWidth": "60px"},
                                {"data": "cldx"},
                                {"data": "clxz"},
                                {"data": "cltj"},
                                {"data": "clje"},
                                {"data": "jgsl"}
                            ]
                            ,"drawCallback": function(settings) {
                                var api = this.api();
                                var rows = api.rows({
                                    page: 'current'
                                }).nodes();
                                var last = null;

                                api.column(2, {
                                    page: 'current'
                                }).data().each(function(group, i) {
//                                    if (last !== group) {
//                                        $(rows).eq(i).before('<tr class="group"><td colspan="11">' + group + '</td></tr>');
//                                        last = group;
//                                    }
                                });
                            }

                        });

                        /**加上序号**/
                        table.on('order.dt search.dt', function () {
                            table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                                cell.innerHTML = i + 1;
                            });
                        }).draw();
                        new $.fn.dataTable.FixedColumns(table, {leftColumns: 3});

                    },
                    stock = function (id) {
                        $("#cgjy").attr("bomid",id);
                        $('#myModal').modal({
                            backdrop: false,
                            show: true
                        });
                    },
                    //添加采购建议
                    addCgjy=function()
                    {
                        var cgjy=$("#cgjy").val();
                        var id=$("#cgjy").attr("bomid");
                        if(cgjy=="" || cgjy == null)
                        {
                            Main.ShowErrorMessage("采购意见不能为空！");
                            return;
                        }
                        var url = "../jsgl/bomInfo_updateBlzkCgjy.action", successFun = function (resStr) {
                            if (resStr == "SUCCESS") {
                                Main.ShowSuccessMessage("添加采购建议成功！");
                                $('#myModal').modal('hide');
                            }
                        };
                        $.asyncAjaxPost(url, {"id": id ,"cgjy" :cgjy}, successFun, true);
                    },
                    changeBlqk = function(rowid ,blqk ){
                        var url = "../jsgl/bomInfo_updateBlzk.action", successFun = function (resStr) {
                            if (resStr == "SUCCESS") {
                                Main.ShowSuccessMessage("更新库存成功！");
                                //$('#bomInfo').dataTable().fnDraw(true);
                                $('#bomInfo').DataTable().ajax.reload(function(){},true);
                            }
                        };
                        $.asyncAjaxPost(url, {"id": rowid ,"blqk" :blqk}, successFun, true);
                    }
                        /**数据导出*/
                        exportData = function(){
                            var params="tableId=010404";
                            window.location.href='../../resmgr_exportResourceData.action?'+params;
                        } ;
                    ;

            return {
                init: init,
                stock: stock,
                addCgjy:addCgjy,
                exportData:exportData
            }
        })();


    })();


    $(document).ready(function () {
        CgglManager.init();
        //定时器每10秒刷新table如果有新的工作自动更新
        setInterval(function(){
            //$('#bomInfo').DataTable().ajax.reload(function(){},true);
            $('#bomInfo').dataTable().fnDraw(true);
        },10000);
    });


</script>
</html>
