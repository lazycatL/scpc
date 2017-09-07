/**
 * 单位管理模块相关的js
 * @author mukun@20140507
 */

$(document).ready(function () {

    $.addRequiredLabel();
    //保存按钮事件
    $('#btn_save').click(function (e) {
        var tips = validata();
        if (tips == "") {
            KhInfoManage.saveKhInfo(KhInfoManage._flag);
        }
    });

    //定义全局的模块变量
    if (typeof(window.KhInfoManage) == undefined || window.KhInfoManage == null) {
        window.KhInfoManage = {
            _t: this,
            _flag: "", //标志位 区分当前表单是add模式还是update模式
            init: function () {
                _this = this;
                //初始化时间控件
                //$('#form_khxx_starttime').datetimepicker({format: 'yyyy-mm-dd hh:ii'});
                $('#form_khxx_starttime').datepicker();
                //注册表单返回按钮事件 。点击返回查询表格页面
                $("#form_return").click(function () {
                    var $outFrame = $(window.parent.document.body);
                    var $iframe = $outFrame.find("#mainIframe");
                    var src = $iframe.attr("src");
                    $iframe.attr('src', "scglxt/xsgl/khxxManager.jsp");
                });
                this.loadKhlxList();
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
                var url = "khInfo_getKhInfo.action", successFun = function (data) {
                    console.log(data);
                    if (data && data.length > 0) {
                        var select = $('#form_khxx .controls >[type="text"]');
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
                        $('#form_khxx_lx').select2('val', data[0].lx);
                        $('#form_khxx_iscj').select2('val', data[0].iscj);
                        if( data[0].starttime!=null)
                            $('#form_khxx_starttime').datepicker("setDate", data[0].starttime);
                    }

                }
                $.asyncAjax(url, {"id": id}, successFun, true);

            },
            /**
             * 保存用户信息
             * @param {Object} flag
             */
            saveKhInfo: function (flag) {
                flag = this._flag;
                if (flag == "UPDATE") {
                    id = $.GetRequest().id;
                } else {
                    id = "";
                }
                var khInfo = {
                    id: id,
                    mc: $('#form_khxx_mc').attr('value'),
                    lx: $('#form_khxx_lx').attr('value'),
                    dw: $('#form_khxx_dw').attr('value'),
                    dz: $('#form_khxx_dz').attr('value'),
                    gx: $('#form_khxx_gx').attr('value'),
                    lxr: $('#form_khxx_lxr').attr('value'),
                    lxdh: $('#form_khxx_lxdh').attr('value'),
                    starttime: $('#form_khxx_starttime').attr('value'),
                    iscj: $('#form_khxx_iscj').attr('value'),
                    remark: $('#form_khxx_remark').attr('value'),
                    flag: flag
                }
                var JSON = $.toJsonString(khInfo);
                this.addKhInfo(JSON);

            },
            //加载客户类型列表
            loadKhlxList: function () {
                var url = "khInfo_loadKhlxList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_khxx_lx").empty();
//								 $("#form_khxx_lx").select2({
//									  placeholder: "请选择客户类型" ,
//									  data:[data]
//								 });
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].mc, data[i].id, "form_khxx_lx");
                        }
                    }
                };
                $.asyncAjax(url, {"id": "id"}, successFun, true);
            },
            /**
             * 新增客户信息
             * @param {Object} jsonStr
             */
            addKhInfo: function (jsonstr) {
                var url = "khInfo_addUserInfo.action", JSON = jsonstr, successFun = function (resStr) {
                    if (resStr.toUpperCase() == "SUCCESS") {
                        Main.ShowSuccessMessage("保存成功！");
                        $("#form_return").click();
                    }
                };
                $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
            },
            /**
             * 删除客户信息
             */
            editRow: function () {
                var url = "khInfo_addUserInfo.action", JSON = jsonstr, successFun = function (resStr) {
                    if (resStr.toUpperCase() == "SUCCESS") {
                        Main.ShowSuccessMessage("保存成功！");
                    }
                };
            }
        }

    }
    KhInfoManage.init();

});