//验证方法
function validata() {

    var tips = "";
    //验证非空
    $(".required").each(function () {
        if($(this).hasClass("select2")){
            return ;
        }
        if ($(this).val() == "" || $(this).val() == null) {
            tips = " 必填项不能为空！";
                $(this).next().html("必填项不能为空！");
        }
    });

    //密码6位限制
    $(".mustmima").each(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            tips = "密码不能为空！";
            $(this).next().html("密码不能为空！");
        } else {
            if ($(this).val().length > 15) {
                tips = "密码不能大于6位！";
                $(this).next().html("密码不能大于6位！");
            }
            if ($(this).val().length < 6) {
                tips = "密码不能小于6位！";
                $(this).next().html("密码不能小于6位！");
            }
        }

    });
    $(".repmima").each(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            tips = "确认密码不能为空！";
            $(this).next().html("确认密码不能为空！");
        } else {
            if ($(this).val().length > 15) {
                tips = "密码不能大于6位！";
                $(this).next().html("密码不能大于6位！");
            }
            if ($(this).val().length < 6) {
                tips = "密码不能小于6位！";
                $(this).next().html("密码不能小于6位！");
            }
            if ($(this).val().length > 6 || $(this).val().length < 15) {
                if ($(".repmima").val().trim() == $(".mustmima").val().trim()) {
                } else {
                    tips = ("登陆密码和确定密码要一致");
                    $(this).next().html("登陆密码和确定密码要一致");
                }
            }
        }
    });

    //整形验证
    $(".requiredInteger").each(function () {
        reg = /^[-+]?\d+$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 数字格式不正确！";
            $(this).next().html("数字格式不正确！");
        }
    });
    //整形验证(必填)
    $(".mustrequiredInteger").each(function () {
        reg = /^[-+]?\d+$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 数字格式不正确！";
            $(this).next().html("数字格式不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + " 数字不能为空！";
            $(this).next().html("数字不能为空！");
        }
    });
    //数字验证(必填)
    $(".mustrequiredDecimal").each(function () {
        reg = /([1-9]+[0-9]*|0)(\\.[\\d]+)?/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 数字格式不正确！";
            $(this).next().html("数字格式不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + " 数字不能为空！";
            $(this).next().html("数字不能为空！");
        }
    });
    //数字验证
    $(".requiredDecimal").each(function () {
        reg = /([1-9]+[0-9]*|0)(\\.[\\d]+)?/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 数字格式不正确！";
            $(this).next().html("数字格式不正确！");
        }

    });
    //小数点后一位验证
    $(".requiredDouble").each(function () {
        if ($(this).val().split(".").length - 1 == 1 || $(this).val().split(".").length - 1 == 0) {
            var d = $(this).val().split(".");
            var d1 = d[0];
            var d2 = d[1];
            reg = /^[-+]?\d+$/;
            if (d2 != null) {
                if ((!reg.test(d1) || !reg.test(d2)) && $(this).val() != "") {
                    tips = $(this).val() + " 数字格式不正确！";
                    $(this).next().html("数字格式不正确！");
                }
            } else {
                if (!reg.test(d1) && $(this).val() != "") {
                    tips = $(this).val() + " 数字格式不正确！";
                    $(this).next().html("数字格式不正确！");
                }
            }
        } else {
            tips = $(this).val() + " 数字格式不正确！";
            $(this).next().html("数字格式不正确！");
        }
    });

    //小数点后一位验证(必填)
    $(".mustrequiredDouble").each(function () {
        if ($(this).val().split(".").length - 1 == 1 || $(this).val().split(".").length - 1 == 0) {
            var d = $(this).val().split(".");
            var d1 = d[0];
            var d2 = d[1];
            reg = /^[-+]?\d+$/;
            if (d2 != null) {
                if ((!reg.test(d1) || !reg.test(d2)) && $(this).val() != "") {
                    tips = $(this).val() + " 数字格式不正确！";
                    $(this).next().html("数字格式不正确！");
                }
                if ($(this).val() == "") {
                    tips = $(this).val() + "数字不能为空！";
                    $(this).next().html("数字不能为空！");
                }
            } else {
                if (!reg.test(d1) && $(this).val() != "") {
                    tips = $(this).val() + "数字格式不正确！";
                    $(this).next().html("数字格式不正确！");
                }
                if ($(this).val() == "") {
                    tips = $(this).val() + "数字不能为空！";
                    $(this).next().html("数字不能为空！");
                }
            }
        } else {
            tips = $(this).val() + " 数字格式不正确！";
            $(this).next().html("数字格式不正确！");
        }
    });
    //邮箱验证
    $(".requiredEmail").each(function () {
        reg = /^\w{3,}@\w+(\.\w+)+$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 邮箱地址不正确！";
            $(this).next().html("邮箱地址不正确！");
        }
    });
    //邮箱验证(必填)
    $(".mustrequiredEmail").each(function () {
        reg = /^\w{3,}@\w+(\.\w+)+$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 邮箱地址不正确！";
            $(this).next().html("邮箱地址不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + " 邮箱地址不能为空！";
            $(this).next().html("邮箱地址不能为空！");
        }
    });
    //电话验证
    $(".requiredPhone").each(function () {
        reg = /^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 电话号码不正确！";
            $(this).next().html("电话号码不正确！");
        }
    });
    //电话验证(必填)
    $(".mustrequiredPhone").each(function () {
        reg = /^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 电话号码不正确！";
            $(this).next().html("电话号码不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + " 电话号码不能为空！";
            $(this).next().html("电话号码不能为空！");
        }
    });
    //移动电话验证
    $(".requiredTel").each(function () {
        reg = /^1[3|4|5|8|9][0-9]\d{4,8}$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 移动号码不正确！";
            $(this).next().html("移动号码不正确！");
        }
    });
    //移动电话验证(必填)
    $(".mustrequiredTel").each(function () {
//							reg=/^1[3|4|5|8|9][0-9]\d{4,8}$/;
//							reg=/^0{0,1}(1[4-9]|15[1-9]|15[0-5]|18[7-8])[0-9]{8}$/;
//							reg=/^0{0,1}(1[1-9][1-9])[0-9]{8}$/;
        reg = /^1[3|4|5|7|8|9][0-9]\d{8}$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 移动号码不正确！";
            $(this).next().html("移动号码不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + " 移动号码不能为空！";
            $(this).next().html("移动号码不能为空！");
        }
    });


    //身份证验证
    $(".requiredID").each(function () {
        reg = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + " 身份证号码不正确！";
            $(this).next().html("身份证号码不正确！");
        }
        var d = new Date();
        var card = $(this).val();
        if (card.length == 18) {
            var year = card.substring(6, 10);
            if (parseInt(year) >= parseInt(d.getFullYear())) {
                tips = $(this).val() + " 身份证号码年份不正确！";
                $(this).next().html("身份证号码年份不正确！");
            }
            var month = card.substring(10, 12);
            if (parseInt(month) > 12) {
                tips = $(this).val() + " 身份证号码月份不正确！";
                $(this).next().html("身份证号码月份不正确！");
            }
            var day = card.substring(12, 14);
            if (parseInt(day) > 31) {
                tips = $(this).val() + " 身份证号码日期不正确！";
                $(this).next().html("身份证号码日期不正确！");
            }
        }
        if (card.length == 15) {
            var month = card.substring(8, 10);
            if (parseInt(month) > 12) {
                tips = $(this).val() + " 身份证号码月份不正确！";
                $(this).next().html("身份证号码月份不正确！");
            }
            var day = card.substring(10, 12);
            if (parseInt(day) > 31) {
                tips = $(this).val() + " 身份证号码日期不正确！";
                $(this).next().html("身份证号码日期不正确！");
            }
        }
    });
    //身份证验证(必填)
    $(".mustrequiredID").each(function () {
        reg = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + "身份证号码不正确！";
            $(this).next().html("身份证号码不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + "身份证号码不能为空！";
            $(this).next().html("身份证号码不能为空！");
        }
        var d = new Date();
        var card = $(this).val();
        if (card.length == 18) {
            var year = card.substring(6, 10);
            if (parseInt(year) >= parseInt(d.getFullYear())) {
                tips = $(this).val() + "身份证号码年份不正确！";
                $(this).next().html("身份证号码年份不正确！");
            }
            var month = card.substring(10, 12);
            if (month * 1 > 12 || month * 1 < 1) {
                tips = $(this).val() + "身份证号码月份不正确！";
                $(this).next().html("身份证号码月份不正确！");
            }
            var day = card.substring(12, 14);
            if (day * 1 > 31 || day * 1 < 1) {
                tips = $(this).val() + "身份证号码日期不正确！";
                $(this).next().html("身份证号码日期不正确！");
            }
        }
        if (card.length == 15) {
            var month = card.substring(8, 10);
            if (parseInt(month) > 12 || parseInt(month) < 1) {
                tips = $(this).val() + "身份证号码月份不正确！";
                $(this).next().html("身份证号码月份不正确！");
            }
            var day = card.substring(10, 12);
            if (day * 1 > 31 || day * 1 < 1) {
                tips = $(this).val() + "身份证号码日期不正确！";
                $(this).next().html("身份证号码日期不正确！");
            }
        }
    });
    //邮编验证
    $(".ziprequiredID").each(function () {
        reg = /^[0-9]{6}$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + "邮编不正确！";
            $(this).next().html("邮编不正确！");
        }
    });
    //邮编验证(必填)
    $(".zipcodeID").each(function () {
        reg = /^[0-9]{6}$/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + "邮编不正确！";
            $(this).next().html("邮编不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + "邮编不能为空！";
            $(this).next().html("邮编不能为空！");
        }
    });
    //网址验证
    $(".emailquiredID").each(function () {
        reg = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + "网址填写不正确！";
            $(this).next().html("网址填写不正确！");
        }
    });
    //网址验证(必填)
    $(".emailID").each(function () {
        reg = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + "网址填写不正确！";
            $(this).next().html("网址填写不正确！");
        }
        if ($(this).val() == "") {
            tips = $(this).val() + "网址不能为空！";
            $(this).next().html("网址不能为空！");
        }
    });
    //电话区号验证
    $(".telcodeID").each(function () {
        reg = /0[1-9]{2,3}/;
        if (!reg.test($(this).val()) && $(this).val() != "") {
            tips = $(this).val() + "区号填写不正确！";
            $(this).next().html("区号填写不正确！");
        }
    });
    //小数点后一位验证
    $(".vserion1").each(function () {
        if ($(this).val().split(".").length - 1 == 1 || $(this).val().split(".").length - 1 == 0) {
            var d = $(this).val().split(".");
            var d1 = d[0];
            var d2 = d[1];
            reg = /^[-+]?\d+$/;
            if (d2 != null) {
                if ((!reg.test(d1) || !reg.test(d2)) && $(this).val() != "") {
                    tips = $(this).val() + " 版本号格式不正确！";
                    $(this).next().html("版本号格式不正确！");
                }
            } else {
                if (!reg.test(d1) && $(this).val() != "") {
                    tips = $(this).val() + " 版本号格式不正确！";
                    $(this).next().html("版本号格式不正确！");
                }
            }
        } else {
            tips = $(this).val() + " 版本号格式不正确！";
            $(this).next().html("版本号格式不正确！");
        }
    });
    //必须要上传图片
    $(".requiredImg").each(function () {
        if ($(this).attr("src") == "") {
            tips = $(this).val() + "必须上传图片！";
            $(this).next().html("必须上传图片！");
        }
    });


    return tips;
}