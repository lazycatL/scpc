var resUrl='http://192.168.1.254:7003';
//var resUrl='http://127.0.0.1:7003';
/**
 * 订单信息
 * @author apple
 * @constructor
 * @date 20141024
 */
(function () {
    var operateFlag = "";
    window.Main = (function () {
        var _t = this,show= 0,
            _operateFlag = "",
            /**
             * 初始化函数
             */
            init = function () {
                var headHeight = $("body > header").height();
                var height = document.body.clientHeight;
                $("#wrapper").css("height", height - headHeight + "px");


                $("#user").text("当前用户：【"+decodeURI(GetCookie("userName"))+"】");
                setInterval(function(){
                    getDate();
                },1000);

                //点击工作流程连接
                $("#gzlc").click(function() {
                    //$("#mainIframe").attr('src',"scglxt/lctImg.html");
                    if (show == 0) {
                        $("#gzlctImg").fadeIn();
                        show=1;
                    }else{
                        $("#gzlctImg").fadeOut();
                        show=0;
                    }

                });
                //changeNavUrl("");
                //addNavEvent();
            },
            menuInit= function(){
//                var menu=$("#main_Menu");
//                var url = "common_loadMenuTree.action", successFun = function (data) {
//                        if (data && data.length > 0) {
//                            for (var i = 0; i < data.length; i++) {
//                                var mli=$("<li class></li>");
//                                var link=$("<a class='dropdown-collapse' href='#'></a>");
//                                var icons=$("<i class='"+data[i].cdtb+"'></i>");
//                                var mspan=$("<span id='"+data[i].cddz+"'>"+data[i].cdmc+"</span>");
//                                var dli=$("<i class='icon-angle-down angle-down'></i>");
//                                link.append(icons);
//                                link.append(mspan);
//                                link.append(dli);
//                                mli.append(link);
//                                if(data[i].children.length>0) {
//                                    var pul = $("<ul id='ul_"+ data[i].cddz +"' class='nav nav-stacked in' style='display:block;'></ul>");
//                                    for (var j = 0; j < data[i].children.length; j++) {
//                                        var pli = $("<li onclick='Main.changeNavUrl(\""+  data[i].children[j].url +"\");' id='"+  data[i].children[j].url +"'></li>");
//                                        var plink = $("<a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>");
//                                        var picons = $("<i class='" +  data[i].children[j].cdtb + "'></i>");
//                                        var pspan = $("<span class='menu-text' id='" +  data[i].children[j].cddz + "'>" +  data[i].children[j].cdmc + "</span>");
//
//                                        plink.append(picons);
//                                        plink.append(pspan);
//                                        pli.append(plink);
//                                        pul.append(pli);
//                                    }
//                                    mli.append(pul);
//                                }
//                                menu.append(mli);
//                            }
//                            if($("#main_Menu > li > ul > li").length!=0)
//                            {
//                                Main.changeNavUrl($("#main_Menu > li > ul > li")[0].id);
//                            }
//                        }
//
//                };
//                $.asyncAjax(url, {"pid": 0}, successFun, true);
            },
            /**
             * 改变导航iframe的 url
             */
            changeNavUrl = function (url) {

                $('#mainIframe').attr('src', url);
            },
            getDate = function(){
                var info="";
                var today=new Date();
                function initArray(){
                    this.length=initArray.arguments.length
                    for(var i=0;i<this.length;i++)
                        this[i+1]=initArray.arguments[i] }
//                var d=new initArray(
//                    "星期日",
//                    "星期一",
//                    "星期二",
//                    "星期三",
//                    "星期四",
//                    "星期五",
//                    "星期六");
                info=today.getFullYear()+"年"+eval(today.getMonth()+1)+"月"+today.getDate()+"日 ";


                    var now = new Date();
                    var hours = now.getHours();
                    var minutes = now.getMinutes();
                    var seconds = now.getSeconds()
                    var timeValue = "" +((hours >= 12) ? "下午 " : "上午 " )
                    timeValue += ((hours >12) ? hours -12 :hours)
                    timeValue += ((minutes < 10) ? ":0" : ":") + minutes
                    timeValue += ((seconds < 10) ? ":0" : ":") + seconds
                    info+=timeValue;
                    $("#datetime").text(info);

            },

            /**
             *
             * @param curPageNum跳转之前所在的页面页数
             * @id 编辑的页面数据id （当为update时候有效）
             * @editmodel 编辑模式，判定是add还是update
             */
            swapIframUrl = function (url, curPageNum, id, editModel) {
                var $outFrame = $(window.parent.document.body);
                var $iframe = $outFrame.find("#mainIframe");
                var src = $iframe.attr("src");
                $iframe.attr('src', url)
            },
            disableSaveButton = function () {
                $("#btn_save").attr("disabled", true);
            },
        //提示成功信息
            ShowSuccessMessage = function(message, life) {
                var time = 3000;
                if (!life) {
                    time = life;
                }

                if ($("#tip_message").text().length > 0) {
                    var msg = "<span>" + message + "</span>";
                    $("#tip_message").empty().append(msg);
                } else {
                    var msg = "<div id='tip_message'><span>" + message + "</span></div>";
                    $("body").append(msg);
                }
                $("#tip_message").show().delay(time).fadeOut(3000);
                //$("#tip_message").fadeIn(time);
                //setTimeout($("#tip_message").fadeOut(time), time);
            },

        //提示错误信息
        ShowErrorMessage = function(message, life) {
            ShowSuccessMessage(message, life);
            $("#tip_message span").addClass("error");
        },
         resetSaveButton = function () {
                $("#btn_save").removeAttr("disabled");
            }
            ;
        return {
            init: init,
            changeNavUrl: changeNavUrl,
            swapIframUrl: swapIframUrl,
            ShowSuccessMessage:ShowSuccessMessage,
            ShowErrorMessage:ShowErrorMessage,
            disableSaveButton:disableSaveButton,
            resetSaveButton:resetSaveButton,
            getDate:getDate
        }
    })();


})();

$(document).ready(function () {
    Main.init();
});
 
	
