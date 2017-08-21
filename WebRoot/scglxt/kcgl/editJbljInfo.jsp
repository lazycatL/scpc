<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet"
      type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/util/validata.js" type="text/javascript"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/jsgl/editBomInfo.js"></script>--%>
<div id='wrapper'>
    <div class="row">
        <div class="col-sm-12">
            <div class="box">
                <div class="box-header">
                    <button id="form_return" class="btn btn-success btn-sm">
                        <i class="icon-add"></i> 返回
                    </button>
                    <div class="title">
                        <div class="icon-edit"></div>
                        材料管理
                    </div>

                </div>


                <div class="box-content box-no-padding">
                    <form id="form_bomInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
                        <div class='form-group'>
                            <input style="display:none;" id='form_lj_id' info="fromInfo" name='id'
                                   type='text'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_lx'>工具类型</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control required' id='form_lj_lx' info="fromInfo" name='lx'
                                       placeholder='类型' type='text'>
                                <label class="textInfo"></label>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_mc'>工具名称</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control' id='form_lj_mc' info="fromInfo" name='mc'
                                       placeholder='名称' type='text'>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_cc'>工具尺寸</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control' id='form_lj_cc' info="fromInfo" name='cc'
                                       placeholder='工具尺寸' type='text'>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_zsl'>总数量</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control' id='form_lj_zsl' info="fromInfo" name='zsl'
                                       placeholder='总数量' type='text'>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_kcsl'>库存数量</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control' id='form_lj_kcsl' info="fromInfo" name='kcsl'
                                       placeholder='库存数量' type='text'>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_dj'>单价</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control' id='form_lj_dj' info="fromInfo" name='dj'
                                       placeholder='单价' type='text'>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-3 col-sm-3' for='form_lj_ghs'>供货商</label>

                            <div class='col-sm-4 controls'>
                                <input class='form-control' id='form_lj_ghs' info="fromInfo" name='ghs'
                                       placeholder='供货商' type='text'>
                            </div>
                        </div>

                        <div class='modal-footer'>

                            <input id="btn_save" class="btn btn-primary" type="button" value="保存">
                            <button id="btn_saving" class='btn btn-default' style="display:none;" type='button'>
                                <i class="icon-1x icon-spinner icon-spin"></i>
                                保存中...
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    /**
     * 默认的配置js 用来初始化导入js以及其他初始化方法
     * 没有保存操作 ，每次保存时候对相应的bomid 进行删除 然后进行保存
     */
    (function () {
        this.ClEditManage = (function () {
            var _t = this,
                    _flag = "",//标志位 区分当前表单是add模式还是update模式
                    /**
                     * 初始化表单信息
                     */
                    init = function () {
                        var _this = this;
                        //返回按钮
                        $("#form_return").click(function () {
                            var $outFrame = $(window.parent.document.body);
                            var $iframe = $outFrame.find("#mainIframe");
                            var src = $iframe.attr("src");
                            $iframe.attr('src', "scglxt/kcgl/clManage.jsp");
                        });
                        $.addRequiredLabel();
                        $('#btn_save').on('click', function (e) {
                            e.stopPropagation();
                            var tips = validata();
                            if (tips == "") {
                                saveFormInfo(_this._flag);
                            }
                        });

                        registerEvent();
                        var urlParam = new Object();
                        urlParam = $.GetRequest();
                        if (urlParam && urlParam.id) {
                            _this._flag = "UPDATE";
                            //如果是update模式 则加载初始化信息
                            _this.initFormInfo(urlParam.id);
                        } else {
                            _this._flag = "ADD";
                        }

                    },
                    /**
                     * 注册事件
                     */
                    registerEvent = function () {
                        var that = this;
                        $("#form_return").on('click', function () {
                            Main.swapIframUrl('scglxt/kcgl/jbljManage.jsp');//跳转iframe页面
                        })

                    },
                    initFormInfo = function (id) {
                        var url = "jblj_getDetailInfo.action", successFun = function (data) {
                            if (data && data.length > 0) {
                                var select = $('#form_bomInfo input[info="fromInfo"]');
                                //循环给表单赋值
                                for (var i = 0; i < select.length; i++) {
                                    var s = select[i];
                                    var id = $(s).attr("id");
                                    id = id.split("_")[2];
                                    var key = id.toLowerCase();
                                    var value = eval("data[0]." + key);
                                    console.log(value);
                                    console.log(key);
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
                    saveFormInfo = function (flag) {
                        var formInfo = {
                            flag: flag
                        }
                        var JSON = $.toJsonString(formInfo);
                        var $save = $('#btn_save'), $saving = $('#btn_save');
                        var url = "jblj_updateInfo.action?flag=" + flag, successFun = function (resStr) {
                            if (resStr == "SUCCESS") {
                                Main.ShowSuccessMessage('保存成功！');
                                $("#form_return").click();
                            }
                        }
                        //$.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
                        $.asyncAjaxPost(url, $('#form_bomInfo').serialize(), successFun, true);

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
        ClEditManage.init();
    });


</script>