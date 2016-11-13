/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法
 * @author mukun 20140507
 */
(function () {
    this.HtEditManage = (function () {
        var _t = this,
            /**
             * 初始化表单信息
             */
            init = function () {
                var that = this;
                var urlParam = new Object();
                urlParam = $.GetRequest();
                $.addRequiredLabel();
                $('#btn_save').on('click', function () {
                    //$("#btn_save").attr("disabled",true);
                    var tips = validata() ;
                    if(tips == ""){
                        saveFormInfo(that._flag, urlParam.id);
                    }
                    //$("#btn_save").removeAttr("disabled");
                });
                loadFzbzList();

                if (urlParam && urlParam.id) {
                    that._flag = "UPDATE";
                    //如果是update模式 则加载初始化信息
                    that.initFormInfo(urlParam.id);
                } else {
                    that._flag = "ADD";
                }
                $("#form_return").on('click', function () {
                    Main.swapIframUrl('scglxt/jsgl/gxManager.jsp');//跳转iframe页面
                })
            },

            initFormInfo = function (id) {
                var url = "gxInfo_getDetailInfo.action", successFun = function (data) {
                    console.log(data);
                    if (data && data.length > 0) {
                        var select = $('#form_gxInfo .form-control[info="fromInfo"]');
                        //循环给表单赋值
                        for (var i = 0; i < select.length; i++) {
                            var s = select[i];
                            var id = $(s).attr("id");
                            id = id.split("_")[2];
                            var key = id.toLowerCase();
                            var value = eval("data[0]." + key);
                            if (value == undefined) {
                                value = "";
                            }
                            for (var j in data[0]) {
                                if (id.toLowerCase() == j) {
                                    $(s).val(value);
                                    $(s).attr("title", value);
                                }
                            }
                        }
                    }

                }
                $.asyncAjax(url, {"id": id}, successFun, true);
            },
            /**
             * 保存或者更改表单信息
             */
            saveFormInfo = function (flag, id) {
                var formInfo = {
                    gxmc: $('#form_khxx_gymc').attr("value"),
                    fzbz: $('#form_khxx_fzbz').attr("value"),
                    sfwx: $('#form_khxx_sfwx').attr("value"),
                    id: $.decodeEmptyValue(id),
                    flag: flag
                }
                var JSON = $.toJsonString(formInfo);
                var $save = $('#btn_save'), $saving = $('#btn_save');
                var url = "gxInfo_updateInfo.action", successFun = function (resStr) {
                    if (resStr == "SUCCESS") {
                        alert('保存成功');
                        Main.swapIframUrl('scglxt/jsgl/gxManager.jsp');//跳转iframe页面
                    }
                }
                $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);

            },
            loadFzbzList = function () {
                var url = "scglbz_getBzTableData.action", successFun = function (data) {
                    if (data && data.data && data.data.length > 0) {
                        data = data.data;
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].bzmc, data[i].id, "form_khxx_fzbz");
                        }
                    }
                }
                $.syncAjax(url, {}, successFun, true);
            }
            ;
        return {
            init: init,
            initFormInfo: initFormInfo,
            saveFormInfo: saveFormInfo
        }
    })();
})();
$(document).ready(function () {
    HtEditManage.init();
});
