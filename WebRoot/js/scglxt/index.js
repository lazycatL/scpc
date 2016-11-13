/**
 * 订单信息
 * @author apple
 * @constructor
 * @date 20141024
 */
(function () {
    var operateFlag = "";
    window.Main = (function () {
        var _t = this,
            _operateFlag = "",
            /**
             * 初始化函数
             */
            init = function () {
                var headHeight = $("body > header").height();
                var height = document.body.clientHeight;
                $("#wrapper").css("height", height - headHeight + "px");
                menuInit();
                $("#user").text("当前用户："+decodeURI(GetCookie("userName")));
                setInterval(function(){getDate()},1000);

                //changeNavUrl("");
                //addNavEvent();
            },
            displaychildren=function(id){
                var ul=("#ul_"+id);
                ul.attr("class","nav nav-stacked in");
                ul.css("display","block");
            },
            menuInit= function(){
                var menu=$("#main_Menu");
                var url = "common_loadMenuTree.action", successFun = function (data) {
                        if (data && data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                var mli=$("<li class></li>");
                                var link=$("<a class='dropdown-collapse in' href='#'></a>");
                                var icons=$("<i class='"+data[i].cdtb+"'></i>");
                                var mspan=$("<span id='"+data[i].cddz+"'>"+data[i].cdmc+"</span>");
                                var dli=$("<i class='icon-angle-down angle-down'></i>");
                                link.append(icons);
                                link.append(mspan);
                                link.append(dli);
                                mli.append(link);
                                if(data[i].children.length>0) {
                                    var pul = $("<ul id='ul_"+ data[i].cddz +"' class='nav nav-stacked' style='display:block;'></ul>");
                                    for (var j = 0; j < data[i].children.length; j++) {
                                        var pli = $("<li onclick='Main.changeNavUrl(\""+  data[i].children[j].cddz +"\");' id='"+  data[i].children[j].cddz +"'></li>");
                                        var plink = $("<a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>");
                                        var picons = $("<i class='" +  data[i].children[j].cdtb + "'></i>");
                                        var pspan = $("<span id='" +  data[i].children[j].cddz + "'>" +  data[i].children[j].cdmc + "</span>");
                                        plink.append(picons);
                                        plink.append(pspan);
                                        pli.append(plink);
                                        pul.append(pli);
                                    }
                                    mli.append(pul);
                                }
                                menu.append(mli);
                            }
                            if($("#main_Menu > li > ul > li").length!=0)
                            {
                                Main.changeNavUrl($("#main_Menu > li > ul > li")[0].id);
                            }
                        }
                };
                $.asyncAjax(url, {"pid": 0}, successFun, true);
            },
            addNavEvent = function () {
                //  客户信息管理
                $.addEvent('khxxgl', 'click', function () {
                    Main.changeNavUrl('khxxgl');
                });
                //  合同管理
                $.addEvent('htgl', 'click', function () {
                    Main.changeNavUrl('htgl');
                });
                //订单管理
                $.addEvent('ddgl', 'click', function () {
                    Main.changeNavUrl('ddgl');
                });
                //bom表管理
                $.addEvent('bomgl', 'click', function () {
                    Main.changeNavUrl('bomgl');
                });
                //工序管理
                $.addEvent('gxgl', 'click', function () {
                    Main.changeNavUrl('gxgl');
                });
                //工艺管理
                $.addEvent('gygl', 'click', function () {
                    Main.changeNavUrl('gygl');
                });
                //设备管理
                $.addEvent('sbgl', 'click', function () {
                    Main.changeNavUrl('sbgl');
                });
                //班组管理
                $.addEvent('bzgl', 'click', function () {
                    Main.changeNavUrl('bzgl');
                });
                //人员管理
                $.addEvent('rygl', 'click', function () {
                    Main.changeNavUrl('rygl');
                });
                //排产管理
                $.addEvent('scgl-pcgl', 'click', function () {
                    Main.changeNavUrl('scgl-pcgl');
                });

                //排产管理 管理人员组
                $.addEvent('scgl-glry-ry', 'click', function () {

                    Main.changeNavUrl('scgl-glry-ry');
                });
                //排产管理 生产人员组
                $.addEvent('scgl-glry-sb', 'click', function () {

                    Main.changeNavUrl('scgl-glry-sb');
                });
                //生产绩效管理
                $.addEvent('scjxgl', 'click', function () {
                    Main.changeNavUrl('scjxgl');
                });
                //订单采购管理
                $.addEvent('ddcggl', 'click', function () {
                    Main.changeNavUrl('ddcggl');
                });
                //供货商管理
                $.addEvent('ghsgl', 'click', function () {
                    Main.changeNavUrl('gygl');
                });
                //外协管理
                $.addEvent('wxgl', 'click', function () {
                    Main.changeNavUrl('gygl');
                });
                //质量管理
                $.addEvent('zlgl', 'click', function () {
                    Main.changeNavUrl('zlgl');
                });
                //基本零件管理
                $.addEvent('jbljgl', 'click', function () {
                    Main.changeNavUrl('jbljgl');
                });
                //生产材料管理
                $.addEvent('scclgl', 'click', function () {
                    Main.changeNavUrl('scclgl');
                });
                //库存管理
                $.addEvent('kcgl', 'click', function () {
                    Main.changeNavUrl('kcgl');
                });
                //采购管理
                $.addEvent('cggl', 'click', function () {
                    Main.changeNavUrl('cggl');
                });

                //产品管理
                $.addEvent('cpgl', 'click', function () {
                    Main.changeNavUrl('cpgl');
                });
                //业务类型管理
                $.addEvent('ywlxgl', 'click', function () {
                    Main.changeNavUrl('ywlxgl');
                });
                //bom表管理
                $.addEvent('bomgl', 'click', function () {
                    Main.changeNavUrl('bomgl');
                });
                //供货商管理
                $.addEvent('ghsgl', 'click', function () {
                    Main.changeNavUrl('ghsgl');
                });
                //产品质量管理
                $.addEvent('cpzlgl', 'click', function () {
                    Main.changeNavUrl('cpzlgl');
                });
                //检验人员检验
                $.addEvent('jyryjy', 'click', function () {
                    Main.changeNavUrl('jyryjy');
                });
                //检验人员检验
                $.addEvent('jgryjg', 'click', function () {
                    Main.changeNavUrl('jgryjg');
                });
                //加工人员加工
                $.addEvent('jgryjg', 'click', function () {
                    Main.changeNavUrl('jgryjg');
                });
                //生产情况跟踪
                $.addEvent('jgqkhz', 'click', function () {
                    Main.changeNavUrl('jgqkhz');
                });

            },
            /**
             * 改变导航iframe的 url
             */
            changeNavUrl = function (key) {
                var url = "";
                switch (key) {
                    case "khxxgl":
                        url = "scglxt/xsgl/khxxManager.jsp";
                        break;
                    case "htgl":
                        url = "scglxt/xsgl/htManager.jsp";
                        break;
                    case "ddgl":
                        url = "scglxt/jsgl/ddManager.jsp";
                        break;
                    case "bomgl":
                        url = "scglxt/jsgl/bomManager.jsp";
                        break;
                    case "sbgl":
                        url = "scglxt/scgl/sbxxIndex.jsp";
                        break;
                    case "bzgl":
                        url = "scglxt/scgl/bzxxIndex.jsp";
                        break;
                    case "rygl":
                        url = "scglxt/scgl/ryxxIndex.jsp";
                        break;
                    case "ghsgl":
                        url = "scglxt/cggl/ghsManager.jsp";
                        break;
                    case "gxgl":
                        url = "scglxt/jsgl/gxManager.jsp";
                        break;
                    case "gygl":
                        url = "scglxt/jsgl/gyManager.jsp";
                        break;
                    //班组管理
                    case "bzgl":
                        url = "scglxt/scgl/bzxxIndex.jsp";
                        break;
                    //排产管理
                    case "scgl-pcgl":
                        url = "scglxt/scgl/pcglglry.jsp";
                        break;
                    //排产任务管理
                    case "pcrwgl":
                        url = "scglxt/scgl/pcglIndex.jsp";
                        break;
                    //排产任务管理 生产人员组
                    case "scgl-glry-sb":
                        url = "scglxt/scgl/pcGlSb.html";
                        break;
                    //排产任务管理 生产人员组
                    case "scgl-glry-ry":
                        url = "scglxt/scgl/pcGlRy.html";
                        break;
                    case "jgqkhz":

                        url = "scglxt/scgl/scglJgqk.jsp";
                        break;
                    //排产任务管理

                    case "ghsgl":
                        url = "scglxt/scgl/ghsManager.jsp";
                        break;
                    //基本零件管理
                    case "jbljgl":
//				url = "scglxt/kcgl/clManage.jsp";
                        url = "scglxt/kcgl/jbljManage.jsp";
                        break;
                    //生产材料
                    case "scclgl":
                        url = "scglxt/kcgl/clManage.jsp";
                        break;
                    //库存管理
                    case "kcgl":
                        url = "scglxt/kcgl/kcglManager.jsp";
                        break;
                    case "ddcggl":
                        url = "scglxt/cggl/cgglManager.jsp";
                        break;
                    //产品管理
                    case "cpgl":
                        url = "scglxt/kcgl/cpManage.jsp";
                        break;
                    //产品质量管理
                    case "cpzlgl":
                        url = "scglxt/zlgl/zlManager.jsp";
                        break;
                    //检验人员检验
                    case "jyryjy":
                        url = "scglxt/scgl/pcglJyRyJy.jsp";
                        break;
                    //加工人员加工
                    case "jgryjg":
                        url = "scglxt/scgl/pcglJgryJg.jsp";
                        break;
                    //终检检验管理
                    case "zjjy":
                        url="scglxt/zlgl/zljyManager.jsp";
                        break;
                    //成品入库管理
                    case "cprkgl":
                        url="scglxt/kcgl/cprkManager.jsp";
                        break;
                    //成品出库管理
                    case "cpckgl":
                        url="scglxt/kcgl/cpckManager.jsp";
                        break;
                    default:
                        break;
                }
                $('#mainIframe').attr('src', url);
            },
            /**
             * 初始化表格函数
             */
            tableInit = function () {
            },
            /**
             * 删除信息
             */
            deleteRow = function (id) {
            },
            /**
             * 更新合同信息
             */
            saveHtInfo = function (flag) {

            },
            initHtInfo = function (flag) {

            },
            getDate = function(){
                var info="";
                var today=new Date();
                function initArray(){
                    this.length=initArray.arguments.length
                    for(var i=0;i<this.length;i++)
                        this[i+1]=initArray.arguments[i] }
                var d=new initArray(
                    "星期日",
                    "星期一",
                    "星期二",
                    "星期三",
                    "星期四",
                    "星期五",
                    "星期六");
                info=today.getFullYear()+"年"+eval(today.getMonth()+1)+"月"+today.getDate()+"日"+d[today.getDay()+1]+" ";


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
            resetSaveButton = function () {
                $("#btn_save").removeAttr("disabled");
            }
            ;
        return {
            init: init,
            changeNavUrl: changeNavUrl,
            swapIframUrl: swapIframUrl,
            disableSaveButton:disableSaveButton,
            resetSaveButton:resetSaveButton,
            getDate:getDate,
            displaychildren:displaychildren
        }
    })();


})();

$(document).ready(function () {
    Main.init();
});
 
	
