/**
 * 订单信息
 * @author apple
 * @constructor
 * @date 20141024
 */
(function () {
    var operateFlag = "";
    window.GygcManage = (function () {
        var that = this,
            _operateFlag = "",
            _bomid = "";
        _showModel = "";
        /**
         * 初始化函数
         */
        init = function () {
            $("#gygc").tableDnD();
            //注册事件
            registerEvent();
            //获取参数

            that.urlParam = $.GetRequest();
            if (urlParam.sbid) {
                $("#btn-add").remove();
            }
            if(urlParam.type && urlParam.type=="read")
            {
                $("#btn-add").remove();
                $("#btn-save").remove();
                $("#div_cyy").remove();
            }
            _showModel = urlParam.showModel;
            tableInit();
            _bomid = urlParam.bomid;
            loadBomGybpList(_bomid);
            $("#a_addCyy").on('click', function (e) {
                $('#dlg_addCyy').dialog('open');
            });
        },

        /**
         * 注册事件
         */
            registerEvent = function () {

                $('#btn-add').on("click", function () {
                    GygcManage.addRow();
                });
                $('#btn-save').on("click", function () {
                    var flag = true;
                    $('#gygc td>input[info="edgs"]').each(function (e) {
                        if ($(this).val() == "" || $(this).val() == null) {
                            flag = false;
                        }
                    });
                    if (flag) {
                        if (that.urlParam.bomid) {
                            GygcManage.saveFormInfo();
                        } else if (that.urlParam.sbid) {
                            GygcManage.updateFormInfoBySbid();

                        }
                    } else {
                        Main.ShowErrorMessage("额定工时不能为空！");
                    }
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
                                $('#myModalImport').modal('hide');
                                Main.ShowSuccessMessage("导入成功！");
                                loadBomGybpList(_bomid);
                            }else{
                                Main.ShowSuccessMessage("导入失败，请联系管理员！");
                            }
                        };
                        if (confirm("确定导入上传的Excel？")) {
                            $.asyncAjaxPost(url, {"filepath": file,"importtype":importtype,"bomid":_bomid}, successFun, true);
                        }
                    }
                });

                $("#gygc tbody tr").on("click", function (e) {
                })
            },
        /**
         * 初始化表格函数
         */
            tableInit = function () {
                div=$("#cyyDiv").html("");
                var div=$("#cyyDiv");
                var url = "gxInfo_getCyyInfo.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            var xhspan=$("<span>"+eval(i+1)+".</span>");
                            var mspan=$("<span id='copySpan' style='margin-left: 15px;cursor:pointer;' onclick='copyInfo(this)' ></span>");
                            var images=$("<img style='cursor: pointer;' onclick='GygcManage.deleteCyy("+data[i].id+")' src='../../images/cha.gif'><br>");

                            mspan.append(data[i].mc);

                            div.append(xhspan).append(mspan).append(images);
                        }
                    }
                }
                $.asyncAjax(url, {}, successFun, true);
            },
            //添加常用语并保存到数据库
            addCyy= function()
            {
                var url = "gxInfo_addCyyInfo.action",successFun = function(resStr){
                    if (resStr == "SUCCESS") {
                        $('#dlg_addCyy').dialog('close');
                        tableInit();
                    }else{
                        Main.ShowErrorMessage("添加失败！");
                    }
                } ;
                $.asyncAjaxPost(url, {"mc": $("#cyy").val()}, successFun, true);
            },
            deleteCyy = function(id){
                var url = "gxInfo_deleteCyy.action",successFun = function(resStr){
                    if (resStr == "SUCCESS") {
                        tableInit();
                    }
                } ;
                if (confirm("确定删除该常用语？")) {
                    $.asyncAjaxPost(url, {"id": id}, successFun, true);
                }
            },
        /**
         * 删除信息
         */
            deleteRow = function (t) {
                if (confirm("确定删除？")) {
                    $(t).parent().parent().parent().remove();
                    GygcManage.changeRowSerialNum('gygc');
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
        /**
         * 保存表格信息
         * 算法：逐行保存表单信息
         */
            saveFormInfo = function (flag) {
                var rowNum = $("#gygc tbody tr").size();
                var url = "bomInfo_saveGxbpData.action", successFun = function (data) {
                    console.log(data);
                }
                if (that.urlParam.sbid) {
                    url = "bomInfo_saveGxbpData.action?sbid=" + that.urlParam.sbid;
                }
                var formInfo = {};
                //var bomid = $("#gygc tbody>tr").attr("bomid") ;
                deleteFormInfo(_bomid);
                var flag =  true ;
                for (var i = 0; i < rowNum; i++) {
                    formInfo.bomid = _bomid;
                    formInfo.gxnr = $($("#gygc tbody>tr")[i]).find('select[info="gxnr"]').attr('value');
                    formInfo.gxnrText = $($("#gygc tbody>tr")[i]).find('select[info="gxnr"]').find("option:selected").text();
                    formInfo.sysb = $($("#gygc tbody>tr")[i]).find('select[info="sysb"]').val();
                    formInfo.sysbText = $($("#gygc tbody>tr")[i]).find('select[info="sysb"]').find("option:selected").text();
                    formInfo.edgs = $($("#gygc tbody>tr")[i]).find('input[info="edgs"]').attr('value');
                    formInfo.bzgs = $($("#gygc tbody>tr")[i]).find('input[info="bzgs"]').attr('value');
                    formInfo.stsj = "";
                    formInfo.zysx = $($("#gygc tbody>tr")[i]).find('textarea').attr('value');
                    formInfo.serial = i;
                    var JSON = $.toJsonString(formInfo),
                        successFun = function (str) {
                            console.log(i);
                            console.log((rowNum ));
                            console.log(i == (rowNum ) && str == "1");
                            if (i == (rowNum - 1 ) && str == "1") {
                                Main.ShowSuccessMessage("保存成功！");
                            }
                        }
                    $.ajax({
                        async:false,
                        type:"POST",
                        url : url,
                        data:{"JSON": JSON},
                        success : successFun,
                        error : function(XMLHttpRequest, textStatus, errorThrown){
                            console.log(XMLHttpRequest);
                            flag = false ;
                        }
                    });
                }
                if(flag){
                    Main.ShowSuccessMessage("保存成功！");
                    var ssdd = null;
                    var request = $.GetRequest();
                    if (request.ssdd) {
                        ssdd = request.ssdd;
                    }
                    window.parent.parent.document.getElementById("mainIframe").src="scglxt/jsgl/bomManager.jsp?ssdd="+ssdd;
                }else{
                    Main.ShowErrorMessage("保存失败！");
                }
            },


            updateFormInfoBySbid = function () {
                var rowNum = $("#gygc tbody tr").size();
                var url, successFun = function (data) {
                    console.log(data);
                }
                url = "bomInfo_updateGxbpData.action?sbid=" + that.urlParam.sbid;
                var formInfo = {};
                //var bomid = $("#gygc tbody>tr").attr("bomid") ;
                for (var i = 0; i < rowNum; i++) {
                    formInfo.id = $($("#gygc tbody>tr")[i]).attr("id");
                    formInfo.bomid = $($("#gygc tbody>tr")[i]).attr("bomid");
                    formInfo.sysb = $($("#gygc tbody>tr")[i]).find('select[info="sysb"]').val();
                    formInfo.sysbText = $($("#gygc tbody>tr")[i]).find('select[info="sysb"]').find("option:selected").text();
                    formInfo.gxnr = $($("#gygc tbody>tr")[i]).find('select[info="gxnr"]').attr('value');
                    formInfo.gxnrText = $($("#gygc tbody>tr")[i]).find('select[info="gxnr"]').find("option:selected").text();
                    formInfo.edgs = $($("#gygc tbody>tr")[i]).find('input[info="edgs"]').attr('value');
                    formInfo.bzgs = $($("#gygc tbody>tr")[i]).find('input[info="bzgs"]').attr('value');
                    formInfo.stsj = "";
                    formInfo.zysx = $($("#gygc tbody>tr")[i]).find('textarea').attr('value');
                    formInfo.serial = i;
                    var JSON = $.toJsonString(formInfo),
                        successFun = function (str) {
                            console.log(i);
                            console.log((rowNum ));
                            console.log(i == (rowNum ) && str == "1");
                            if (i == (rowNum - 1 ) && str == "1") {
                                Main.ShowSuccessMessage("保存成功！");
                            }
                        }
                    $.syncAjaxPost(url, {"JSON": JSON}, successFun, true);
                }
            },
        /**
         *  删除跟bomid 相关的工序编排  然后重新排列
         */
            deleteFormInfo = function (bomid) {
                var url = "bomInfo_deleteGxbpData.action", successFun = function (data) {
                }
                $.asyncAjaxPost(url, {"bomid": bomid}, successFun, true);
            } ,
            initHtInfo = function (flag) {

            },
        /**
         * 点击复制常用语执行的操作
         */
            copyInfo= function(obj){

                clipboard.copy(obj.innerText)

                Main.ShowSuccessMessage("复制成功："+obj.innerText);
            },

        /**
         * 增加行
         */
            addRow = function () {
                var uuid = Math.uuid();
                var rowNum = $("#gygc tbody tr").size();
                var tab = document.getElementById("gygc");
                var num = tab.rows.length;
                var id = "";
                var domstr = '<tr id="' + uuid + '"  bomid="' + that.urlParam.bomid + '" > <td class="sorting_1">' + (rowNum+1) + '</td> ' +
                    '<td><div class=""> <a class="btn btn-danger btn-xs" href="#" title="删除" onclick="GygcManage.deleteRow(this)"><i class="icon-remove"></i> </a></div></td>' +
                    '<td> <select id="gxnr_'+ (rowNum+1)+'"  info= "gxnr"   linked＝"' + uuid + '"  class="form-control" style="width:100%" ></select> </td>' +
                    '<td>  ' +
                    ' <select  id="sysb_'+ (rowNum+1)+'"  info= "sysb"   linked＝"' + uuid + '" class="form-control" style="width:100%" >' +
                    '</select></td>' +
                    '<td><input class="form-control" info="edgs" type="text" style="width:100%" value=""></td>' +
                    '<td><input class="form-control" info="bzgs" type="text" style="width:100%" value=""></td>' +
                    '<td><textarea   rows="3" class="form-control" info="zysx" type="text" style="width:100%" value=""></textarea></td>' +
                    '</tr>';
                $("#gygc tbody").append(domstr);
                var selector = "#" + uuid + " select[info='sysb']";
                var gxnrSelector = "#" + uuid + " select[info='gxnr']";
                //  添加后重新对表格进行拖动初始化
                $("#gygc").tableDnD({
                    onDrop: function (table, row) {
                        var rows = table.tBodies[0].rows;
                        var debugStr = "Row dropped was " + row.id + ". New order: ";
                        for (var i = 0; i < rows.length; i++) {
                            debugStr += rows[i].id + " ";
                        }
//		            $(#debugArea).html(debugStr);
                        GygcManage.changeRowSerialNum("gygc");
                    }
                });
                loadGygcList(selector, "bomInfo_getJgSbLxData.action?gyid=0");
                loadGygcList(gxnrSelector, "bomInfo_getGxnrData.action");
                //根据工序内容过滤属于该工序的设备
                $("select[id*='gxnr']").on("change", function (e) {
                    var item=$(this);
                    var url="bomInfo_getJgSbLxData.action?gyid="+item.val();
                    var successFun = function (data) {
                        if (data && data.length > 0) {

                            selector=$("#sysb_"+item.attr("id").split('_')[1]).empty();
                            $.AddSelectItemBySelector("空", '', selector);
                            for (var i = 0; i < data.length; i++) {
                                $.AddSelectItemBySelector(data[i].name, data[i].id, selector);
                            }
                        }
                    }
                    $.syncAjax(url, {}, successFun, true);
                });
            },
        /**
         *  的那个拖动表格时候重新更改表格序号
         */
            changeRowSerialNum = function (id) {
                var $tr = $('#' + id + " tbody>tr");
                $tr.each(function (i) {
                    $(this).attr('sortnum', i);
                });
                $('#gygc tbody>tr>.sorting_1').each(function (i) {
                    $(this).html(i);
                });
            },

        /**
         *  加载加工工艺下啦列表
         */
            loadGygcList = function (selector, url) {
                var successFun = function (data) {
                    if (data && data.length > 0) {
                        $.AddSelectItemBySelector("空", '', selector);
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItemBySelector(data[i].name, data[i].id, selector);
                        }
                    }
                }
                $.syncAjax(url, {}, successFun, true);
            },

        /**
         * 加载工艺编排列表
         */
            loadBomGybpList = function (bomid) {
                var url = "bomInfo_loadBomGybpList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        var domstr = "";
                        $("#gygc tbody").empty();
                        for (var i = 0; i < data.length; i++) {
                            var selector = "#" + $.decodeEmptyValue(data[i].id);
                            domstr = '<tr id="' + $.decodeEmptyValue(data[i].id) + '"  bomid="' + data[i].bomid + '"> <td class="sorting_1">' + (i+1) + '</td> ' +
                            '<td><div class=""> <a class="btn btn-danger btn-xs" href="#" title="删除" onclick="GygcManage.deleteRow(this)"><i class="icon-remove"></i> </a></div></td>' +
                            '<td class=" starttime hide"><div > <a class="btn btn-success btn-xs" href="#" title="删除" onclick="GygcManage.updateStarttime(this)">开 始</a></div></td>' +
                            '<td class=" endtime hide"><div > <a class="btn btn-success btn-xs" href="#" title="删除" onclick="GygcManage.updateEndtime(this)">结 束</a></div></td>' +
                            '<td><select  id="gxnr_'+ (i+1)+'" info= "gxnr" type="text" linked＝"' + $.decodeEmptyValue(data[i].id) + '"  class="form-control" style="width:100%" ></select></td>' +
                            '<td>  ' +
                            ' <select  id="sysb_'+ (i+1)+'" info= "sysb" type="text" linked＝"' + $.decodeEmptyValue(data[i].id) + '"  class="form-control" style="width:100%" >' +
                            '</select></td>' +

                            '<td><input  class="form-control" info="edgs" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].edgs) + '"></td>' +
                            '<td><input  class="form-control" info="bzgs" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].bzgs) + '"></td>' +
                            '<td class="hide"><input  info="stsj" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].stsj) + '"></td>' +
                            '<td class="starttime hide"> <input  info="stsj" type="text" style="width:100%" value="2015/07/01 12:00"></td>' +
                            '<td class="endtime hide" > <input info="stsj" type="text" style="width:100%" value="2015/07/01 12:00"></td>' +
                            '<td><textarea   rows="3" class="form-control" info="zysx" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].zysx) + '">' + $.decodeEmptyValue(data[i].zysx) + '</textarea></td>' +
                            '</tr>';

                            $("#gygc tbody").append(domstr);

                            selector = selector.toString() + (" select[info='sysb']").toString();
                            //加载设备列表
                            loadGygcList(selector, "bomInfo_getJgSbLxData.action?gyid=0");
                            $(selector).find("option[value='" + $.decodeEmptyValue(data[i].sbid) + "']").attr("selected", true);

                            $("select[id*='gxnr']").on("change", function (e) {
                                var item=$(this);
                                var url="bomInfo_getJgSbLxData.action?gyid="+$(this).val();
                                var successFun = function (data) {
                                    if (data && data.length > 0) {
                                        var sysb=$("#sysb_"+item.attr("id").split('_')[1]);
                                        sysb.empty();
                                        $.AddSelectItemBySelector("空", '', sysb);
                                        for (var i = 0; i < data.length; i++) {
                                            $.AddSelectItemBySelector(data[i].name, data[i].id, sysb);
                                        }
                                    }
                                }
                                $.syncAjax(url, {}, successFun, true);
                            });

                            var gxnrSelector = "#" + $.decodeEmptyValue(data[i].id);
                            gxnrSelector = gxnrSelector.toString() + (" select[info='gxnr']").toString();
                            loadGygcList(gxnrSelector, "bomInfo_getGxnrData.action");
                            $(gxnrSelector).find("option[value='" + $.decodeEmptyValue(data[i].gynr) + "']").attr("selected", true);

                        }


                        //加载拖动程序
                        $("#gygc").tableDnD({
                            onDrop: function (table, row) {
                                var rows = table.tBodies[0].rows;
                                var debugStr = "Row dropped was " + row.id + ". New order: ";
                                for (var i = 0; i < rows.length; i++) {
                                    debugStr += rows[i].id + " ";
                                }
                                GygcManage.changeRowSerialNum("gygc");
                            }
                        });

                        if (_showModel == 1) {
                            $('.starttime').removeClass("hide");
                            $('.endtime').removeClass("hide");
                        }
                    }
                }
                var urlParam = new Object();
                urlParam = $.GetRequest();
                if (urlParam.sbid) {
                    $.asyncAjax(url, {sbid: urlParam.sbid}, successFun, true);
                } else {
                    $.asyncAjax(url, {bomid: bomid}, successFun, true);
                }


            }


        ;


        return {
            init: init,
            tableInit: tableInit,
            deleteRow: deleteRow,
            deleteCyy:deleteCyy,
            saveFormInfo: saveFormInfo,
            updateFormInfoBySbid: updateFormInfoBySbid,
            editRow: editRow,
            addRow: addRow,
            copyInfo:copyInfo,
            addCyy:addCyy,
            changeRowSerialNum: changeRowSerialNum,
            loadGygcList: loadGygcList
        }
    })();


})();


$(document).ready(function () {
    GygcManage.init();

});
 
 
	
 
 