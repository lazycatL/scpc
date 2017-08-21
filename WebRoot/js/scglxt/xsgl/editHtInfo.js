/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法
 * @author mukun 20140507
 */
(function () {
    this.HtEditManage = (function () {
        var _t = this,
            _flag = "",//标志位 区分当前表单是add模式还是update模式
            _id = "";
        /**
         * 初始化表单信息
         */
        init = function () {
            var _this = this;
            //判断当前表单是新增还是更新模式
            var urlParam = new Object();
            urlParam = $.GetRequest();
            //返回按钮
            $("#form_return").click(function () {
                var $outFrame = $(window.parent.document.body);
                var $iframe = $outFrame.find("#mainIframe");
                var src = $iframe.attr("src");
                $iframe.attr('src', "scglxt/xsgl/htManager.jsp");
            });

            $.addRequiredLabel();
            $('#btn_save').live('click', function () {
                var tips = validata();
                if (tips == ""){
                    saveFormInfo(_this._flag, urlParam.id);
                }
            });
            $('#form_khxx_qssj').datetimepicker({
                "format":"yyyy-mm-dd",
                "minView":2,
                "autoclose":true

            });
//            $('#form_khxx_jssj').datetimepicker({
//                "format":"yyyy-mm-dd",
//                "minView":2,
//                "autoclose":true
//            });
            registerEvent();
            loadYwlxList();//加载业务类型列表
            loadFkztList();//加载付款状态列表
            loadHtkhList();//加载合同客户
           // $.loadSelectList("#form_khxx_fkzt",'14');
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
                $("#form_return").on('click', function () {
                    Main.swapIframUrl('scglxt/xsgl/htManager.jsp');//跳转iframe页面
                })
            },
        /**
         * 初始化业务类型列表
         * @author apple
         */
            loadYwlxList = function () {
                var url = "htInfo_loadYwlxList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_htInfo_ywlx").empty();
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].mc, data[i].id, "form_htInfo_ywlx");
                        }
                    }
                };
                
                $.asyncAjax(url, {"id": "id"}, successFun, true);
            },
        /**
         * 初始化合同客户列表
         * @author apple
         */
            loadHtkhList = function () {
                var url = "htInfo_loadKhxxList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_khxx_htkh").empty();
                        $.AddSelectItem("","", "form_khxx_htkh");
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].mc, data[i].id, "form_khxx_htkh");
                        }
                    }
                };

                $.asyncAjax(url, {"id": "id"}, successFun, true);
            },
            loadFkztList = function (){
                var url = "htInfo_loadFkztList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_khxx_fkzt").empty();
                        $.AddSelectItem("","-请选择-", "form_khxx_fkzt");
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].mc, data[i].id, "form_khxx_fkzt");
                        }
                    }
                };
                $.asyncAjax(url, {"id": "id"}, successFun, true);
            },
        /**
         * 初始化表单系信息
         */
            initFormInfo = function (id) {
                var url = "htInfo_getDetailInfo.action", successFun = function (data) {
                    console.log(data);
                    if (data && data.length > 0) {
                        var select = $('#form_htInfo input[info="fromInfo"]');
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
                                    $(s).attr("value", value);
                                    $(s).attr("title", value);
                                }
                            }
                        }
                        if(''!=data[0].qssj && null!=data[0].qssj && ''!=data[0].jssj && null!=data[0].jssj)
                        {
                            $('#form_khxx_gq').val($.DateDiff(data[0].qssj,data[0].jssj));
                        }
                        if(''!=data[0].ywlx && null!=data[0].ywlx){
                        	 $('#form_htInfo_ywlx').select2('val', data[0].ywlx);
                        }
                        if(''!=data[0].khid && null!=data[0].khid && '-请选择-'!=data[0].khid){
                            $('#form_khxx_htkh').select2('val', data[0].khid);
                        }
                        if(''!=data[0].fkzt && null!=data[0].fkzt){
                       	 	 $('#form_khxx_fkzt').select2('val', data[0].fkzt);
                       }
                        if(''!=data[0].htmx){
                      	 	 $('#form_khxx_htmx').val(data[0].htmx);
                      }
                        if(''!=data[0].remark){
                            $('#form_khxx_remark').val(data[0].remark);
                        }
                        
                       
                       // $('#form_khxx_fkzt').select2('val', data[0].fkzt);
                    }

                }
                $.asyncAjax(url, {"id": id}, successFun, true);
            },
        /**
         * 保存或者更改表单信息
         */
            saveFormInfo = function (flag, id) {
                var gq=$('#form_khxx_gq').attr("value");
                if(gq==null || gq=="")
                {
                    Main.ShowErrorMessage("必须填写合同工期！");
                    return;
                }
                var kssj=$('#form_khxx_qssj').attr("value");
                var jssj= $.dateAddDays(kssj,eval(gq));
                var jkje=$('#form_khxx_jkje').attr("value");
                var htje=$('#form_khxx_htje').attr("value");
                console.log(jssj);
                var formInfo = {
                    htbh: $('#form_khxx_htbh').attr("value"),
                    ywlx: $('#form_htInfo_ywlx').attr("value"),
                    khid: $('#form_khxx_htkh').attr("value"),
                    htje:htje,
                    qssj:kssj,
                    jssj: jssj,
                    fkzt: $('#form_khxx_fkzt').attr("value"),
                    jkbfb: eval(jkje/htje*100).toFixed(2),
                    jkje: jkje,
                    jscb:"",
                    hkzh: '',
                    hkkhh: '',
                    remark: $('#form_khxx_remark').attr("value"),
                    htmx: $('#form_khxx_htmx').attr("value"),
                    htjc: $('#form_khxx_htjc').attr("value"),

                    flag: flag,
                    id: $.decodeEmptyValue(id)
                }
                var JSON = $.toJsonString(formInfo);
                var $save = $('#btn_save'), $saving = $('#btn_save');
                if((parseInt(formInfo.htje)<parseInt(formInfo.jkje)) && (parseInt(formInfo.htje)!=parseInt(formInfo.jkje)))
                {
                    Main.ShowErrorMessage("结款金额不能大于合同金额！");
                    return;
                }
                var url = "htInfo_updateInfo.action", successFun = function (resStr) {
                    if (resStr.toUpperCase() == "SUCCESS") {

                        Main.swapIframUrl('scglxt/xsgl/htManager.jsp');//跳转iframe页面
                        Main.ShowSuccessMessage('保存成功');
                    }
                }
                $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);

            },
        /***
         * 显示图纸上传框
         * @param data
         */
            showUploadModel=function(data){
                var htbh= $('#form_khxx_htbh').val();
                if(htbh!=null && htbh!="")
                {
                    $('#myModalUpload').modal({
                        backdrop: false,
                        show: true
                    });
                    $('#ssi-upload').ssi_uploader({url:'../../ImageUploadServlet?type=htfj&htbh='+ $('#form_khxx_htbh').val(),dropZone:false,allowed:['jpg','gif','png','pdf','xls']});
                }else{
                    Main.ShowErrorMessage("必须填写合同编号！");
                    return;
                }
            }
        ;
        return {
            init: init,
            initFormInfo: initFormInfo,
            saveFormInfo: saveFormInfo,
            showUploadModel:showUploadModel
        }

    })();
})();


$(document).ready(function () {
    HtEditManage.init();
});