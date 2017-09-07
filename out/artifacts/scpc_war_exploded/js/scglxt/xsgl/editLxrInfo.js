/**
 * 单位管理模块相关的js
 * @author mukun@20140507
 */

$(document).ready(function () {

    $.addRequiredLabel();
    //保存按钮事件

    //定义全局的模块变量
    if (typeof(window.LxrInfoManage) == undefined || window.LxrInfoManage == null) {
        window.LxrInfoManage = {
            _t: this,
            _flag: "", //标志位 区分当前表单是add模式还是update模式
            init: function () {
                _this = this;
                this.loadHtkhList();
                //判断当前表单是新增还是更新模式
                var urlParam = new Object();
                urlParam = $.GetRequest();
                if (urlParam && urlParam.id) {
                    _this._flag = "UPDATE";
                    //如果是update模式 则加载初始化信息
                    _this.loadKhInfo(urlParam.id);
                } else {
                    _this._flag = "ADD";
                }
                //注册表单返回按钮事件 。点击返回查询表格页面
                $("#form_return").click(function () {
                    var $outFrame = $(window.parent.document.body);
                    var $iframe = $outFrame.find("#mainIframe");
                    var src = $iframe.attr("src");
                    $iframe.attr('src', "resmgr/resView.html?tableId=0103");
                });
                $('#btn_save').on('click', function (e) {
                    e.stopPropagation();
                    var tips = validata();
                    if(tips == ""){
                        $(this).attr("disabled",true);
                        LxrInfoManage.addKhInfo(_this._flag);
                    }
                });


            },
            /**
             * 初始化客户信息
             * @param  id  : 客户唯一标识
             */
            loadKhInfo: function (id) {
                var Param = new Object();
                Param = $.GetRequest();
                if (id == null || id == undefined) {
                    id = Param.id;
                }
                var url = "khInfo_getLxrInfo.action", successFun = function (data) {
                    console.log(data);
                    if (data && data.length > 0) {
                        var select = $('#form_lxr .controls >[type="text"]');
                        //循环给表单赋值
                        for (var i = 0; i < select.length; i++) {
                            var s = select[i];
                            var id = $(s).attr("id");
                            id = id.split("_")[2];
//									var key =id.toLowerCase() ; 
                            var key = id;
                            var value = eval("data[0]." + key);
                            for (var j in data[0]) {
                                if (id == j) {
//										   	if(id.toLowerCase() == j){
                                    $(s).attr("value", value);
                                }
                            }
                        }
                        $('#form_lxr_sjkh').select2('val', data[0].sjkh);
                    }

                }
                $.asyncAjax(url, {"id": id}, successFun, true);

            },
            loadHtkhList: function () {
                var url = "htInfo_loadKhxxList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_lxr_sjkh").empty();
                        $.AddSelectItem("","", "form_lxr_sjkh");
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].mc, data[i].id, "form_lxr_sjkh");
                        }
                    }
                };

                $.asyncAjax(url, {"id": "id"}, successFun, true);
            },
            /**
             * 新增客户信息
             * @param {Object} jsonStr
             */
            addKhInfo: function (flag) {
                if (flag == "UPDATE") {
                    id = $.GetRequest().id;
                } else {
                    id = "";
                }
                var khInfo = {
                    id: id,
                    mc: $('#form_lxr_mc').val()==undefined?"":$('#form_lxr_mc').val(),
                    sj: $('#form_lxr_sj').val()==undefined?"":$('#form_lxr_sj').val(),
                    zj: $('#form_lxr_zj').val()==undefined?"":$('#form_lxr_zj').val(),
                    yx: $('#form_lxr_yx').val()==undefined?"":$('#form_lxr_yx').val(),
                    zw: $('#form_lxr_zw').val()==undefined?"":$('#form_lxr_zw').val(),
                    sjkh: $('#form_lxr_sjkh').val(),
                    sfxmlxr: $('#form_lxr_sfxmlxr').val(),
                    remark: $('#form_khxx_remark').val()==undefined?"":$('#form_khxx_remark').val(),
                    flag: flag
                }
                var JSON = $.toJsonString(khInfo);
                var url = "khInfo_addLxrInfo.action", successFun = function (resStr) {
                    if (resStr.toUpperCase() == "SUCCESS") {
                        Main.ShowSuccessMessage("保存成功！");
                        $("#form_return").click();
                    }
                };
                $.asyncAjaxPost(url,{"JSON": JSON}, successFun, true);
            }
        }

    }
    LxrInfoManage.init();

});