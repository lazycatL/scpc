/**
 * 订单信息
 * @author apple
 * @constructor
 * @date 20141024
 */
(function () {
    var operateFlag = "";
    window.DdManage = (function () {
        var _t = this,
            _operateFlag = "",
            /**
             * 初始化函数
             */


            init = function () {
                var urlParam = new Object();
                urlParam = $.GetRequest();
                tableInit(urlParam);
                registerEvent();

            },
            /**
             * 注册事件
             */
            registerEvent = function () {
                $("#form_add").on('click', function () {
                    var urlParam = new Object();
                    urlParam = $.GetRequest();
                    var ssht = "";
                    if (urlParam != null && urlParam.ssht != "" && urlParam.ssht != undefined) {
                        ssht = urlParam.ssht;
                    }

                    Main.swapIframUrl('scglxt/jsgl/editDdInfo.jsp?ssht='+ssht);//跳转iframe页面

                });

            },
            /**
             * 初始化表格函数
             */
            tableInit = function (urlParam) {
                var ssht = "";
                if (urlParam != null && urlParam.ssht != "" && urlParam.ssht != undefined) {
                    ssht = urlParam.ssht;
                }
                var table = $('#ddInfo').DataTable({
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
                    "ajax": "ddInfo_getTableData.action?ssht=" + ssht,
                    "sScrollY": 650, //DataTables的高
                    "sScrollX": 4000, //DataTables的宽
                    "bAutoWidth": true, //是否自适应宽度
                    scrollY: true,
                    scrollX: true,
                    scrollCollapse: true,
                    paging: true,
                    "columnDefs": [
                        {

                        },
                        {
                            "render": function (data, type, row) {
                                var str = "";
                                var bfb="0";
                                if(row.bfb !=null)
                                {
                                    bfb=row.bfb;
                                }
                                str='<div class="progress">'
                                    +'<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="'
                                    +row.yjggs  + '" aria-valuemin="0" aria-valuemax="'+row.zgs+'" style="color:black;width:'+bfb+'%">'+bfb+'%</div>'
                                    +'</div>';
                                return str ;
                            }, "targets": 7
                        },
		        { "visible": false,  "targets": [ 2 ] }
                    ],
                    "createdRow": function ( row, data, index ) {
                        var date = new Date();
                        var now="";
                        now = date.getFullYear() + "/";
                        now = now + (date.getMonth() + 1) + "/";  //取月的时候取的是当前月-1如果想取当前月+1就可以了
                        now = now + date.getDate() + " ";
                        var cha = Math.round(( Date.parse(data['endtime'])-Date.parse(now) ) / 86400000)+1;

                        if( cha<=0)
                        {
                        }
                        else if ( cha<=3 ) {
                            $('td', row).eq(2).css('font-weight',"bold").css("background","red").css("color","#FFF");
                        }else if(cha <7)
                        {
                            $('td', row).eq(2).css('font-weight',"bold").css("background","#E48A07").css("color","#FFF");
                        }
                    },
                    "columns": [
                        {"data": null},
                        {"data": "id","sWidth": "250px","render": function (data, type, row) {
                            return '<div id="menu'+row.id+'">' +
                                ' <a class=" " href="#"   onclick = "DdManage.showUploadModel(\'' + row.id + '\')" title＝"图纸上传"> 图纸上传</a> ' +
                                ' <a class=" " href="../ddInfo_exportData.action?ddid=' + data + '"   onclick = "" title＝"导出"> 导出</a> ' +
                                ' <a class="" href="#" title＝"BOM" onclick = "DdManage.showModel(\'' + data + '\')" >BOM</a> ' +
                                //' <span onclick="DdManage.menuShow(\''+row.id+'\');">>></span>' +
                                ' <div id="menuBar'+row.id+'" style="display: block;"><a class=" " href="#"   onclick = "DdManage.editRow(\'' + data + '\')" title＝"修改"> 修改</a> ' +
                                ' <a class=" " href="#" onclick = "DdManage.deleteRow(\'' + data + '\')" title="删除"> 删除</a>' +
                                ' <a class=" " href="#"   onclick = "DdManage.copyRow(\'' + data + '\')" title＝"复制"> 复制</a> ' +
                                ' <a class="" href="#" title＝"统计" onclick = "DdManage.showTjInfo(\'' + data + '\')" >备料统计</a> ' +
                                ' <a class="" href="#"  onclick = "DdManage.showHtInfo(\'' + row.ssht + '\')" >合同</a></div> ' +
                                ' </div>';
                        },
                            "targets": 1},
                        {"data": "id","sWidth": "190px"},
                        {"data": "xmname"},
                        {"data": "ddlevelmc","sWidth": "60px"},
                        {"data": "starttime"},
                        {"data": "endtime"},
                        {"data": "dqjd","sWidth": "200px"},
                        {"data": "zgs","sWidth": "80px"},
                        {"data": "tz"},
                        {"data": "remark"},
                        {"data": "xmlxr"},
                        {"data": "xmfzr"},
                        {"data": "ckzt"},
                        {"data": "ckdate"}
                    ]
                });
                /**加上序号**/
                table.on('order.dt search.dt', function () {
                    table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                        cell.innerHTML = i + 1;
                    });
                }).draw();
                table.on( 'click', 'tr', function () {
                    if ( $(this).hasClass('selected') ) {
                        $(this).removeClass('selected');
                    }
                    else {
                        table.$('tr.selected').removeClass('selected');
                        $(this).addClass('selected');
                    }
                } );
                new $.fn.dataTable.FixedColumns( table, {leftColumns:4});
            },
            /**
             * 删除信息
             */
            deleteRow = function (id) {
                var url = "ddInfo_deleteRow.action", successFun = function (resStr) {
                    if (resStr == "SUCCESS") {

                        Main.ShowSuccessMessage( "删除成功！");
                        $('#ddInfo').DataTable().ajax.reload(function(){},true);
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
             * @description 点击编辑按钮时候跳转到编辑页面，通过url传参
             */
            editRow = function (id) {
                Main.swapIframUrl('scglxt/jsgl/editDdInfo.jsp?id=' + id);//跳转iframe页面
            },
            /***
             * 显示图纸上传框
             * @param data
             */
            showUploadModel=function(data){
                $('#myModalUpload').modal({
                    backdrop: false,
                    show: true
                });
                $('#ssi-upload').ssi_uploader({url:'../../ImageUploadServlet?type=tz&ddbh='+ data,dropZone:false,allowed:['jpg','gif','png','pdf']});

                // $('#ssi-upload').ssi_uploader({url:'upload_uploadTz.action?type=tz&ddbh='+ data,dropZone:false,allowed:['jpg','gif','txt','png','pdf']});
            },
            /**
             * 显示model框
             */
            showModel = function (data) {
//                $('#myModal').modal({
//                    backdrop: false,
//                    show: true
//                });
//                //在modalbody 中家在iframe 内容为 工序编排的内容
//                $content = "<iframe src='bomManager.jsp?model=linked&ssdd=" + data + "' class='modal_iframe'></iframe>";
//                $container = $('#modal-body');
//                $container.empty().append($content);
                window.location.href="bomManager.jsp?model=aa&ssdd="+data;
            },
            showHtInfo = function (id) {
                var url = "htInfo_getTableData.action?id=" + id, successFun = function (data) {
                    console.log(data);
                    if (data) {
                        var obj = data.data[0];

                        $("#myModal .modal-body").html(str);

                        var str = '<h4>合同信息</h4>' +
                            '<table id="previewHt" class="table table-bordered table-striped table-hover " style="font-size:14px"> ' +
                            '<tr>' +
                            '<td>客户名称</td>' +
                            '<td>' + $.decodeEmptyValue(obj.khmc)  + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>合同编号</td>' +
                            '<td>' + $.decodeEmptyValue(obj.htbh) + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>合同金额</td>' +
                            '<td>' + $.decodeEmptyValue(obj.htje) + '</td>' +
                            '</tr>' +
                            '<tr>' +

                            '<td>签署时间</td>' +
                            '<td>' + $.decodeEmptyValue(obj.qssj) + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>付款状态</td>' +
                            '<td>' + $.decodeEmptyValue(obj.fkzt) + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>汇款账号</td>' +
                            '<td>' + $.decodeEmptyValue(obj.hkzh) + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>汇款开户行</td>' +
                            '<td>' + $.decodeEmptyValue(obj.hkkhh) + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>合同明细</td>' +
                            '<td>' + $.decodeEmptyValue(obj.htmx) + '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>预计完成时间</td>' +
                            '<td>' + $.decodeEmptyValue(obj.htmx) + '</td>' +
                            '</table>';
                        $("#myModal .modal-body").html(str);
                    }
                };
                $.asyncAjax(url, {"id": id}, successFun, true);
                $('#myModal').modal({
                    backdrop: false,
                    show: true
                });
            },
            showTjInfo = function (id) {
                var url = "ddInfo_getTjInfo.action?id=" + id, successFun = function (data) {

                    if (data) {

                        $("#myModal .modal-body").html(str);

                        var zgs= 0;
                        var zje=0;
                        var str = '<h4>统计信息</h4>' +
                            '<table id="previewHt" class="table table-bordered table-striped table-hover " style="font-size:14px"> ' +
                            '<tr style="font-weight: 900;">' +
                            '<td>零件名称</td>' +
                            '<td>材料名称</td>' +
                            '<td>材料大小</td>' +
                            '<td>材料质量</td>' +
                            '<td>材料单价</td>' +
                            '<td>备料件数</td>' +
                            '<td>材料金额</td>' +
                          //  '<td>' + $.decodeEmptyValue(obj.gymc)  + '</td>' +
                            '</tr>' ;
                            for(var i=0;i<data.length;i++)
                            {
                                str+= '<tr>' +
                                     '<td>' + $.decodeEmptyValue(data[i].zddmc)  + '</td>' +
                                    '<td>' + $.decodeEmptyValue(data[i].clmc)  + '</td>' +
                                    '<td>' + $.decodeEmptyValue(data[i].cldx)  + '</td>' +
                                    '<td>' + $.decodeEmptyValue(data[i].clzl)  + '</td>' +
                                    '<td>' + $.decodeEmptyValue(data[i].cldj)  + '</td>' +
                                    '<td>' + $.decodeEmptyValue(data[i].bljs)  + '</td>' +
                                    '<td>' + $.decodeEmptyValue(data[i].clje)  + '</td>' +
                                    '</tr>' ;
                                zgs+=data[i].bljs;
                                zje=eval(zje+eval(data[i].clje));
                            }
                        str+= '<tr>' +
                            '<td>总计</td>' +
                         //   '<td>' + $.decodeEmptyValue(zgs)  + '</td>' +
                            '<td>' + ""  + '</td>' +
                            '<td>' + ""  + '</td>' +
                            '<td>' + ""  + '</td>' +
                            '<td>' + ""  + '</td>' +
                            '<td>' +  $.decodeEmptyValue(zgs)  + '</td>' +
                            '<td>' + $.decodeEmptyValue(zje)  + '</td>' +
                            '</tr>' ;
                            str+='</table>';
                        $("#myModal .modal-body").html(str);
                    }
                };
                $.asyncAjax(url, {"id": id}, successFun, true);
                $('#myModal').modal({
                    backdrop: false,
                    show: true
                });
            },
            /**复制订单**/
            copyRow=function(id){
//                var url = "ddInfo_copyRow.action", successFun = function (resStr) {
//                    if (resStr == "SUCCESS") {
//                        window.location.reload();
//                        $("#sorting-advanced").dataTable().fnPageChange('previous', true);
//                        Main.ShowSuccessMessage("复制订单成功！");
//                    }
//                };
                if (confirm("确定复制该订单？")) {
                    //$.asyncAjaxPost(url, {"id": id}, successFun, true);
                    Main.swapIframUrl('scglxt/jsgl/editDdInfo.jsp?copy=copy&id=' + id);//跳转iframe页面
                }
            },
            //显示菜单
            menuShow=function(id){
                //$("#menuBar"+id).toggle();
               document.getElementById("menuBar"+id).style.display='block';
                /*
                var display =$("#menuBar"+id).css('display');
                if(display == 'none'){
                    //$("#menuBar"+id).css("display","block");
                    document.getElementById("menuBar20170405201333573").style.display="block";
                }else{
                    //$("#menuBar"+id).css("display","none");
                    document.getElementById("menuBar20170405201333573").style.display="none";
                }*/

            }
            ;
        return {
            init: init,
            copyRow:copyRow,
            deleteRow: deleteRow,
            editRow: editRow,
            showModel: showModel,
            showUploadModel:showUploadModel,
            showHtInfo: showHtInfo,
            showTjInfo:showTjInfo,
            menuShow:menuShow
        }
    })();


})();


$(document).ready(function () {
    DdManage.init();
});
 
 
	
 
 