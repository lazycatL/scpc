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
            _showModel = urlParam.showModel;
            tableInit(urlParam.bomid);
            _bomid = urlParam.bomid;
            loadBomGybpList(_bomid);


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
                        alert("额定工时不能为空！");
                    }
                });
                $("#gygc tbody tr").on("click", function (e) {
                })
            },
        /**
         * 初始化表格函数
         */
            tableInit = function (bomid) {
                /*var url = "bomInfo_getGygcData.action", successFun = function(data){
                 console.log(data);
                 }
                 $.asyncAjax(url, {"JSON": JSON}, successFun, true);	*/
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
                    //formInfo.stsj = $($("#gygc tbody>tr")[i]).find('input[info="stsj"]').attr('value');
                    formInfo.stsj = "";
                    formInfo.zysx = $($("#gygc tbody>tr")[i]).find('textarea').attr('value');
                    formInfo.serial = i;
                    var JSON = $.toJsonString(formInfo),
                        successFun = function (str) {
                            console.log(i);
                            console.log((rowNum ));
                            console.log(i == (rowNum ) && str == "1");
                            if (i == (rowNum - 1 ) && str == "1") {
                                alert("保存成功！");
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
                    alert("保存成功！");
                    window.parent.parent.document.getElementById("mainIframe").src="scglxt/jsgl/bomManager.jsp";
                }else{
                    alert("保存失败！");
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
                    //formInfo.stsj = $($("#gygc tbody>tr")[i]).find('input[info="stsj"]').attr('value');
                    formInfo.stsj = "";
                    formInfo.zysx = $($("#gygc tbody>tr")[i]).find('textarea').attr('value');
                    formInfo.serial = i;
                    var JSON = $.toJsonString(formInfo),
                        successFun = function (str) {
                            console.log(i);
                            console.log((rowNum ));
                            console.log(i == (rowNum ) && str == "1");
                            if (i == (rowNum - 1 ) && str == "1") {
                                alert("保存成功！");
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
                        //'<td><input class="" info="gxnr" type="text" style="width:100%" class="form-gxnr"  name="form-gxnr" ></td>' +
                    '<td> <select id="gxnr_'+ (rowNum+1)+'"  info= "gxnr"   linked＝"' + uuid + '"  class="form-control" style="width:100%" ></select> </td>' +
                    '<td>  ' +
                    ' <select  id="sysb_'+ (rowNum+1)+'"  info= "sysb"   linked＝"' + uuid + '" class="form-control" style="width:100%" >' +
                    '</select></td>' +
                    '<td><input class="form-control" info="edgs" type="text" style="width:100%" value=""></td>' +
                        //'<td><input class="" info="stsj" type="text" style="width:100%" value=""></td>' +
                   // '<td><input class="form-control" class="" info="zysx" type="text" style="width:100%" value=""></td>' +
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
                loadGygcList(selector, "bomInfo_getJggyData.action?gyid=0");
                loadGygcList(gxnrSelector, "bomInfo_getGxnrData.action");
                //根据工序内容过滤属于该工序的设备
                $("select[id*='gxnr']").on("change", function (e) {
                    var item=$(this);
                    var url="bomInfo_getJggyData.action?gyid="+item.val();
                    var successFun = function (data) {
                        if (data && data.length > 0) {
                            $("#sysb_"+item.attr("id").split('_')[1]).empty();
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
                    console.log(data);
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
                                //'<td><input class="" info="gxnr" type="text" style="width:100%" class="form-gxnr"  name="form-gxnr" value="' + $.decodeEmptyValue(data[i].gynr) + '"></td>' +

                            '<td><input  class="form-control" info="edgs" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].edgs) + '"></td>' +
                            '<td class="hide"><input  info="stsj" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].stsj) + '"></td>' +
                            '<td class="starttime hide"> <input  info="stsj" type="text" style="width:100%" value="2015/07/01 12:00"></td>' +
                            '<td class="endtime hide" > <input info="stsj" type="text" style="width:100%" value="2015/07/01 12:00"></td>' +
                            '<td><textarea   rows="3" class="form-control" info="zysx" type="text" style="width:100%" value="' + $.decodeEmptyValue(data[i].zysx) + '">' + $.decodeEmptyValue(data[i].zysx) + '</textarea></td>' +
                            '</tr>';

                            $("#gygc tbody").append(domstr);

                            selector = selector.toString() + (" select[info='sysb']").toString();
                            //加载设备列表
                            loadGygcList(selector, "bomInfo_getJggyData.action?gyid=0");
                            $(selector).find("option[value='" + $.decodeEmptyValue(data[i].sbid) + "']").attr("selected", true);

                            $("select[id*='gxnr']").on("change", function (e) {
                                var url="bomInfo_getJggyData.action?gyid="+$(this).val();
                                var successFun = function (data) {
                                    if (data && data.length > 0) {
                                        $("#sysb_"+item.attr("id").split('_')[1]).empty();
                                        $.AddSelectItemBySelector("空", '', selector);
                                        for (var i = 0; i < data.length; i++) {
                                            $.AddSelectItemBySelector(data[i].name, data[i].id, selector);
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
            saveFormInfo: saveFormInfo,
            updateFormInfoBySbid: updateFormInfoBySbid,
            editRow: editRow,
            addRow: addRow,
            changeRowSerialNum: changeRowSerialNum,
            loadGygcList: loadGygcList
        }
    })();


})();


$(document).ready(function () {
    GygcManage.init();

});
 
 
	
 
 