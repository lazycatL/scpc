//判断input后面的em元素是否存在
	function findEm(obj,str){
		if($(obj).next().length == 0){
			$(obj).after("<em>"+str+"</em>");
		}else{
			$(obj).next().html(str);
		}
	}

$(function(){

	//验证非空
	$(".required").blur(function(){
		if ($(this).val() == "" || $(this).val() == null) {
			 $(this).next().html('必填项不能为空');
		}else{
			$(this).next().html('');
		}
	});
	
	//密码6位限制
	$(".mustmima").blur(function() {
		if ($(this).val() == "" || $(this).val() == null) {
			$(this).next().html('密码不能为空');
		}else{
			if ($(this).val().length > 15) {
				 $(this).next().html('密码不能大于15位！');
			}else if($(this).val().length < 6) {
				 $(this).next().html('密码不能小于6位！');
			}else{
				$(this).next().html('');
			}
		}
	});
	
	//二次输入密码验证
	$(".repmima").blur(function() {
		if ($(this).val() == "" || $(this).val() == null) {
			$(this).next().html('确认密码不能为空！');
		}else{
			if ($(this).val().length > 15) {
				$(this).next().html('密码不能大于15位！');
			}else if ($(this).val().length < 6) {
				$(this).next().html('密码不能小于6位！');
			}else if($(".repmima").val()!=$(".mustmima").val()){
				$(this).next().html('登陆密码和确定密码要一致!');
			}else{
				$(this).next().html(''); 
			}
		}
	});
	
	//整形验证
	$(".requiredInteger").blur(function() {
					reg=/^[-+]?\d+$/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("数字格式不正确！");
					}else{
						$(this).next().html("");
					}
				});	
	//整形验证(必填)
	$(".mustrequiredInteger").blur(function() {
					reg=/^[-+]?\d+$/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("数字格式不正确！");
					}else{
						$(this).next().html("");
					}
					if($(this).val() == ""){
						$(this).next().html("数字不能为空！");
					}
				});	
	//小数点后一位验证
	$(".requiredDouble").blur(function() {
					if($(this).val().split(".").length-1==1 || $(this).val().split(".").length-1==0){
						var d=$(this).val().split(".");
						var d1=d[0];
						var d2=d[1];
						reg=/^[-+]?\d+$/;
						if(d2!=null){
							if((!reg.test(d1) || !reg.test(d2)) && $(this).val() != ""){
								$(this).next().html("数字格式不正确！");
							}
						}else{
							if(!reg.test(d1) && $(this).val() != ""){
							    $(this).next().html("数字格式不正确！");
							}
						}
					}else{
						$(this).next().html("数字格式不正确！");
					}
				});	
	
	//小数点后一位验证(必填)
	$(".mustrequiredDouble").blur(function() {
					if($(this).val().split(".").length-1==1 || $(this).val().split(".").length-1==0){
						var d=$(this).val().split(".");
						var d1=d[0];
						var d2=d[1];
						reg=/^[-+]?\d+$/;
						if(d2!=null){
							if((!reg.test(d1) || !reg.test(d2)) && $(this).val() != ""){
								$(this).next().html("数字格式不正确！");
							}
							if($(this).val() == ""){
								$(this).next().html("数字不能为空！");
							}
						}else{
							if(!reg.test(d1) && $(this).val() != ""){
							    $(this).next().html("数字格式不正确！");
							}
							if($(this).val() == ""){
								$(this).next().html("数字不能为空！");
							}
						}
					}else{
						$(this).next().html("数字格式不正确！");
					}
				});	
	//邮箱验证
	$(".requiredEmail").blur(function() {
					reg=/^\w{3,}@\w+(\.\w+)+$/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("邮箱地址不正确！");
					}else{
						$(this).next().html("");
					}
				});	
	//邮箱验证(必填)
	$(".mustrequiredEmail").blur(function() {
					reg=/^\w{3,}@\w+(\.\w+)+$/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("邮箱地址不正确！");
					}else{
						$(this).next().html("");
					}
					if($(this).val() == ""){
						$(this).next().html("邮箱地址不能为空！");
					}
				});	
	//电话验证
	$(".requiredPhone").blur(function() {   
					reg=/^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("电话号码不正确！");
					}else{
						$(this).next().html("");
					}
				});	
	//电话验证(必填)
	$(".mustrequiredPhone").blur(function() {
					reg=/^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("电话号码不正确！");
					}else{
						$(this).next().html("");
					}
					if($(this).val() == ""){
						$(this).next().html("电话号码不能为空！");
					}
				});
	//移动电话验证
	$(".requiredTel").blur(function() {
					reg=/^1[3|4|5|8|9][0-9]\d{4,8}$/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("移动号码不正确！");
					}else{
						$(this).next().html("");
					}
				});	
	//移动电话验证(必填)
	$(".mustrequiredTel").blur(function() {
					reg=/^1[3|4|5|8|9][0-9]\d{4,8}$/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("移动号码不正确！");
					}else{
						$(this).next().html("");
					}
					if($(this).val() == ""){
						$(this).next().html("移动号码不能为空！");
					}
				});	
	

	//身份证验证
	$(".requiredID").blur(function() {
					reg=/(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("身份证号码不正确！");
					}
					var d = new Date();
					var card=$(this).val();
					if(card.length == 18){
						  var year=card.substring(6,10);
						  if(parseInt(year)>=parseInt(d.getFullYear())){
					    	  $(this).next().html("身份证号码年份不正确！");
					      }
					      var month=card.substring(10,12);
					      if(parseInt(month)>12){
					    	  $(this).next().html("身份证号码月份不正确！");
					      }
					      var day=card.substring(12,14);
					      if(parseInt(day)>31){
					    	  $(this).next().html("身份证号码日期不正确！");
					      }
					  }
					  if(card.length == 15){
					      var month=card.substring(8,10);
					      if(parseInt(month)>12){
					    	  $(this).next().html("身份证号码月份不正确！");
					      }
					      var day=card.substring(10,12);
					      if(parseInt(day)>31){
					    	  $(this).next().html("身份证号码日期不正确！");
					      }
					  }
				});	
	//身份证验证(必填)
	$(".mustrequiredID").blur(function() {
					reg=/(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
					if(!reg.test($(this).val()) && $(this).val() != ""){
					    $(this).next().html("身份证号码不正确！");
					}
					if($(this).val() == ""){
						$(this).next().html("身份证号码不能为空！");
					}
					var d = new Date();
					var card=$(this).val();
					if(card.length == 18)
					  {
						var year=card.substring(6,10);
						  if(parseInt(year)>=parseInt(d.getFullYear())){
					    	  $(this).next().html("身份证号码年份不正确！");
					      }
					      var month=card.substring(10,12);
					      if(month*1>12 || month*1<1){
					    	  $(this).next().html("身份证号码月份不正确！");
					      }
					      var day=card.substring(12,14);
					      if(day*1>31 || day*1<1){
					    	  $(this).next().html("身份证号码日期不正确！");
					      }
					  }
					  if(card.length == 15)
					  {
					      var month=card.substring(8,10);
					      if(parseInt(month)>12 || parseInt(month)<1){
					    	  $(this).next().html("身份证号码月份不正确！");
					      }
					      var day=card.substring(10,12);
					      if(day*1>31 || day*1<1){
					    	  $(this).next().html("身份证号码日期不正确！");
					      }
					  }
				});
    //邮编验证
    $(".ziprequiredID").blur(function(){  
        reg= /^[0-9]{6}$/;
        if(!reg.test($(this).val()) && $(this).val() != ""){
			 $(this).next().html("邮编不正确！");
		}else{
			$(this).next().html("");
		}
    });
     //邮编验证(必填)
    $(".zipcodeID").blur(function(){
        reg= /^[0-9]{6}$/;
        if(!reg.test($(this).val()) && $(this).val() != ""){
			 $(this).next().html("邮编不正确！");
		}else{
			$(this).next().html("");
		}
		if($(this).val() == ""){
			$(this).next().html("邮编不能为空！");
		}
    });
    //网址验证
     $(".emailquiredID").blur(function(){  
        reg=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
        if(!reg.test($(this).val()) && $(this).val() != ""){
			 $(this).next().html("网址填写不正确！");
		}else{
			$(this).next().html("");
		}
    });
    //网址验证(必填)
      $(".emailID").blur(function(){  
        reg=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
        if(!reg.test($(this).val()) && $(this).val() != ""){
			 $(this).next().html("网址填写不正确！");
		}else{
			$(this).next().html("");
		}
		if($(this).val() == ""){
			$(this).next().html("网址不能为空！");
		}
    });
    //电话区号验证
    $(".telcodeID").blur(function(){
      reg=/0[1-9]{2,3}/;
      if(!reg.test($(this).val()) && $(this).val() != ""){
			 $(this).next().html("区号填写不正确！");
		}else{
			$(this).next().html("");
		}
    });
});

