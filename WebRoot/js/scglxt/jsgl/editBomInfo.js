/**
 * 默认的配置js 用来初始化导入js以及其他初始化方法
 * 没有保存操作 ，每次保存时候对相应的bomid 进行删除 然后进行保存
 * @author mukun 20140507
 */
(function () {
    this.BomEditManage = (function () {
        var _t = this,
            _flag = "",//标志位 区分当前表单是add模式还是update模式
            /**
             * 初始化表单信息
             */
            init = function () {

                $(".numkeyboard").numkeyboard({
                    keyboardRadix:300,//键盘大小基数
                    mainbackground:'#C8BFE7', //主背景色
                    menubackground:'#4A81B0', //头背景色
                    exitbackground:'#4376A0', //关闭按钮背景色
                    buttonbackground:'#ff730e', //键盘背景色
                    clickeve:true//是否绑定元素click事件
                });
                var _this = this;
                this.loadZddczList();
                this.loadSsddList();
                //返回按钮
                $("#form_return").click(function () {
                    returnAndLoad();
                });
                $.addRequiredLabel();

                registerEvent();
                var urlParam = new Object();
                urlParam = $.GetRequest();

                if (urlParam && urlParam.id) {
                    if(urlParam.copy)
                    {
                        _this._flag = "COPY" ;
                    }else{
                        _this._flag = "UPDATE";
                    }
                    _this.initFormInfo(urlParam.id);
                } else {
                    _this._flag = "ADD";
                }

                $('#btn_save').on('click', function (e) {
                    e.stopPropagation();
                    if($('#form_bomInfo_ssdd').select2('val')=="000" || $('#form_bomInfo_ssdd').select2('val')=="")
                    {
                        Main.ShowErrorMessage('请先选择一个订单！');
                        return;
                    }
//                    if($('#form_bomInfo_zddcz').select2('val')=="000" || $('#form_bomInfo_zddcz').select2('val')=="")
//                    {
//                        Main.ShowErrorMessage('请先选择一个材质！');
//                        return;
//                    }
                    var tips = validata();
                    if(tips == ""){
                        $(this).attr("disabled",true);
                        saveFormInfo(_this._flag);
                    }
                });

                $('#btn_saveadd').on('click', function (e) {
                    e.stopPropagation();
                    if($('#form_bomInfo_ssdd').select2('val')=="000" || $('#form_bomInfo_ssdd').select2('val')=="")
                    {
                        Main.ShowErrorMessage('请先选择一个订单！');
                        return;
                    }
//                    if($('#form_bomInfo_zddcz').select2('val')=="000" || $('#form_bomInfo_zddcz').select2('val')=="")
//                    {
//                        Main.ShowErrorMessage('请先选择一个材质！');
//                        return;
//                    }
                    var tips = validata();

                    if(tips == ""){
                        $(this).attr("disabled",true);
                        saveFormInfo(_this._flag);
                        var request = $.GetRequest();
                        var ssdd = null;
                        if (request.ssdd!="null" && request.ssdd!=null && request.ssdd!="undefined") {
                            ssdd = request.ssdd;
                            window.parent.parent.document.getElementById("mainIframe").src="scglxt/jsgl/editBomInfo.jsp?ssdd="+ssdd;
                        }else{
                            window.parent.parent.document.getElementById("mainIframe").src="scglxt/jsgl/editBomInfo.jsp";
                        }
                    }
                });
            },
            /**
             * 注册事件
             */
            registerEvent = function () {
                var that = this;

                //绑定选择图纸按钮事件
                $("#form_bom_tz").on("click",function(e){
                    if($('#form_bomInfo_ssdd').select2('val')=="000" || $('#form_bomInfo_ssdd').select2('val')=="")
                    {
                        Main.ShowErrorMessage('请先选择一个订单！');
                        return;
                    }else{
                        initImages();
                        $('#myModal').modal({
                            backdrop: false,
                            show: true
                        });
                    }
                });
                $("#form_return").on('click', function () {
                    Main.swapIframUrl('scglxt/jsgl/bomManager.jsp');//跳转iframe页面
                })
                $("#btn-calculateValume").on("click", function (e) {
                    calculateVolume();
                });
                $("#form_bomInfo_clxz").on("change", function (e) {
                    if ($(this).val() == 1) {
                        $("#form_bomInfo_jx").removeAttr("hidden");
                        $("#form_bomInfo_yx").attr("hidden", true);
                    } else {
                        $("#form_bomInfo_jx").attr("hidden", true);
                        $("#form_bomInfo_yx").removeAttr("hidden");
                    }
                });

                //输入高度后自动计算体积重量金额
                $("#form_bomInfo_jx input[name='height']").blur(function(){
                    if($("#form_bomInfo_jx input[name='length']").val()!="" && $("#form_bomInfo_jx input[name='width']").val()!="" && $("#form_bomInfo_jx input[name='height']").val()!="")
                    {
                        calculateVolume();
                    }
                });
                //输入高度后自动计算体积重量金额
                $("#form_bomInfo_yx input[name='height']").blur(function(){
                    if($("#form_bomInfo_yx input[name='length']").val()!=""  && $("#form_bomInfo_yx input[name='height']").val()!="")
                    {
                        calculateVolume();
                    }
                });
            },
            initFormInfo = function (id) {
                var url = "bomInfo_getDetailInfo.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        var select = $('#form_bomInfo input[info="fromInfo"]');
                        //循环给表单赋值
                        for (var i = 0; i < select.length; i++) {
                            var s = select[i];
                            var id = $(s).attr("id");
                            id = id.split("_")[2];

                            if (!id) {
                                continue;
                            }
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
                        var cldx = data[0].cldx;
                        if (cldx!=undefined && cldx.length > 0) {
                            cldx = data[0].cldx.split('*');
                            if (data[0].clxz == "1") {
                                $("#form_bomInfo_jx input[name='length']").val(cldx[0]);
                                $("#form_bomInfo_jx input[name='width']").val(cldx[1]);
                                $("#form_bomInfo_jx input[name='height']").val(cldx[2]);
                                $("#form_bomInfo_jx").removeAttr("hidden");
                                $("#form_bomInfo_yx").attr("hidden", true);
                            } else {
                                $("#form_bomInfo_yx input[name='length']").val(cldx[0].substring(1, cldx[0].length));
                                $("#form_bomInfo_yx input[name='height']").val(cldx[1]);
                                $("#form_bomInfo_jx").attr("hidden", true);
                                $("#form_bomInfo_yx").removeAttr("hidden");
                            }
                        }
                        if( data[0].clxz!=undefined){$('#form_bomInfo_clxz').select2('val', data[0].clxz);}
                        if( data[0].zddcz!=undefined){$('#form_bomInfo_zddcz').val(data[0].zddcz);}
                        //if( data[0].zddjb!=undefined){$('#form_bomInfo_zddjb').select2('val', data[0].zddjb);}
                        if( data[0].ssdd!=undefined){$('#form_bomInfo_ssdd').select2('val', data[0].ssdd);}
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
                if($("#form_bomInfo_jx input[name='length']").val()!="" || $("#form_bomInfo_yx input[name='length']").val()!="")
                {
                    calculateVolume();
                }
                var JSON = $.toJsonString(formInfo);
                var $save = $('#btn_save'), $saving = $('#btn_save');
                var url = "bomInfo_updateInfo.action?flag=" + flag, successFun = function (resStr) {
                    if (resStr == "SUCCESS") {
                        Main.ShowSuccessMessage('保存成功！');
                        returnAndLoad();
                        //$('#bomInfo').DataTable().ajax.reload(function(){},true);
                    }
                }
                //$.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
                $.asyncAjaxPost(url, $('#form_bomInfo').serialize(), successFun, true);

            },
            /**
             * 加载相应子订单的工艺过程
             */
            loadGygcList = function (bomid) {
                var url = "ddInfo_loadGygcList.action", successFun = function (resStr) {
                    if (resStr == "SUCCESS") {
                        Main.ShowSuccessMessage('保存成功！');
                    }
                }
                $.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
            },
            /**
             * 加载子订单材质列表
             */
            loadZddczList = function () {
                var url = "bomInfo_loadClInfoJson.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_bomInfo_zddcz").empty();
                        $.AddSelectItem("--请选择--","000", "form_bomInfo_zddcz");
                        for (var i = 0; i < data.length; i++) {
                            //$.AddSelectItem(data[i].clmc, data[i].id, "form_bomInfo_zddcz");
                            $("#form_bomInfo_zddcz").append('<option value="' + data[i].id + '" mi="' + data[i].mi + '" cldj="' + data[i].cldj + '" >' + data[i].clmc + '</option>');
                        }
                    }
                };
                $.asyncAjax(url, {}, successFun, true);
            },
            loadSsddList = function () {

                var url = "bomInfo_loadSsddList.action", successFun = function (data) {
                    if (data && data.length > 0) {
                        $("#form_bomInfo_ssdd").empty();
                        $.AddSelectItem("--请选择--","000", "form_bomInfo_ssdd");
                        for (var i = 0; i < data.length; i++) {
                            $.AddSelectItem(data[i].mc, data[i].id, "form_bomInfo_ssdd");
                        }
                        var request = $.GetRequest();
                        var ssdd = null;
                        if (request.ssdd!="null" && request.ssdd!=null && request.ssdd!="undefined") {
                            ssdd = request.ssdd;
                            $('#form_bomInfo_ssdd').select2('val', ssdd);
                        }else{
                            $('#form_bomInfo_ssdd').select2('val', "000");
                        }
                    }
                };
                $.asyncAjax(url, {"pid": "04"}, successFun, true);
            },
            calculateVolume = function () {
                var clxz = $("#form_bomInfo_clxz").val(), volume = 0,cldx="";
                if (clxz == 1) {
                    var l = $("#form_bomInfo_jx input[name=length]").val();
                    var w = $("#form_bomInfo_jx input[name=width]").val();
                    var h = $("#form_bomInfo_jx input[name=height]").val();
                    volume = l * w * h;
                    cldx=l+"*"+w+"*"+h;
                    volume=volume/1000;
                } else if (clxz == 2) {
                    var d = $("#form_bomInfo_yx input[name=length]").val();
                    var h = $("#form_bomInfo_yx input[name=height]").val();
                    volume = 3.1415926 * ((d / 2)*(d/2)) * h;
                    cldx="φ"+d+"*"+h ;
                    volume=volume/1000;
                }

                $("#cldx").attr("value",cldx);

                var clje = null;
                var density = $("#form_bomInfo_zddcz").find("option:selected").attr("mi");
                var price = $("#form_bomInfo_zddcz").find("option:selected").attr("cldj");
                clje = volume * density * price;
                var zl=0;
                if(volume=="0")
                {
                    clje =density * price;
                }else{
                    zl=volume*density;
                    $("#form_bomInfo_cltj").val(volume);
                }
                $("#form_bomInfo_clzl").val(zl);
                $("#form_bomInfo_clje").val(clje);
            },
            returnAndLoad = function(){
//                var $outFrame = $(window.parent.document.body);
//                var $iframe = $outFrame.find("#mainIframe");
//                var src = $iframe.attr("src");
//                var request = $.GetRequest();
//                var ssdd = null;
//                if (request.ssdd!="null" && request.ssdd!=null && request.ssdd!="undefined") {
//                    ssdd = request.ssdd;
//                    $iframe.attr('src', "scglxt/jsgl/bomManager.jsp?model=aa&ssdd="+ssdd);
//                }else{
//                    $iframe.attr('src', "scglxt/jsgl/bomManager.jsp");
//                }

                var request = $.GetRequest();
                var ssdd = null;
                if (request.ssdd!="null" && request.ssdd!=null && request.ssdd!="undefined") {
                    ssdd = request.ssdd;
                    var url='scglxt/jsgl/bomManager.jsp?model=aa&ssdd=' +ssdd;
                    Main.swapIframUrl(url);//跳转iframe页面
                    //window.open(url);
                   // window.parent.parent.document.getElementById("mainIframe").src="scglxt/jsgl/bomManager.jsp?ssdd="+ssdd;
                }else{
                    Main.swapIframUrl('scglxt/jsgl/bomManager.jsp');//跳转iframe页面
                }
            },
            /***
             * 加载图片
             */
            initImages = function(){
                $.ajax( {
                    async:false,
                    type:"POST",
                    url : "../../FolderReadServlet?ddid="+ $('#form_bomInfo_ssdd').select2('data').text,
                    dataType : "json",
                    success : function(data){
                        if (data && data.length > 0) {
                            var configUrl="../../uploadFile/";
                            var $div=$("#slider");
                            $div.html("");
                            for (var i=0;i<data.length;i++)
                            {
                                var url=(data[i].tpdz).replace(/#/g,"/");
                                var $divImg=$('<div class="spic"></div>');

                                var $img=$('<img style="width:150px;height:150px;cursor:pointer;"  ondblclick="BomEditManage.showWumaiPic(this);"/>');
                                $img.attr("src",configUrl+url);
                                $img.attr("name",data[i].tpdz.split("#")[1]);
                                var $a=$('<span>'+data[i].tpdz.split("#")[1]+'</span>');
                                $divImg.append($img);

                                $divImg.append($a);
                                $div.append($divImg);
                            }
                        }else{
                            Main.ShowErrorMessage('所选订单未上传图纸！');
                            return;
                        }
                    },
                    error : function(err){
                        Main.ShowErrorMessage('所选订单未上传图纸！');
                        $('#myModal').modal("close");
                        return;
                    }
                });

                $('#slider').slider({ speed: 500 });
            },

            showWumaiPic=function(img){
                $('#form_bomInfo_ddtz').val(img.name);
                $('#myModal').modal("hide");
            }
            ;
        return {
            init: init,
            initFormInfo: initFormInfo,
            saveFormInfo: saveFormInfo,
            loadZddczList: loadZddczList,
            loadSsddList:loadSsddList,
            showWumaiPic:showWumaiPic
        }

    })();
})();
$(document).ready(function () {
//	});
    BomEditManage.init();
});