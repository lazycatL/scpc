		//初始化用户表单的单位树
		var userUnitFormTree = {
			 setting : {
	 	        async: {
		          	type:'POST',
					enable: true,
		//			contentType: "application/x-www-form-urlencoded",
					url: "",
					autoParam: ['ID']
        		},
				check: {
					enable: true,
					chkStyle: "radio",
					radioType: "all"
				},
				view: {
					dblClickExpand: false
				},
				data: {
		            key: {
		                name: "NAME"
		            },
		            simpleData: {
		                enable: true,
		                idKey: "ID",
		                pIdKey: "PID",
		                root: null
		            }
				},
				callback: {
					onClick: onClick,
					onCheck: onCheck,
				}
			},
			zNodes :[]
		}
		function onClick(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("userUnitTree");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}

		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("userUnitTree"),
			nodes = zTree.getCheckedNodes(true),
			v = "",unitisn="";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].NAME + ",";
			}
			unitisn = nodes[0].ID ;
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#validation_unitname");
			cityObj.attr("value", v);
			cityObj.attr("unitisn", unitisn);
		}
		function showMenu(id,treecontent) {
//			var cityObj = $("#unitSel");
//			var cityOffset = $("#unitSel").offset();
			var cityObj = $("#"+id);
			var cityOffset = $("#"+id).offset();
			$("#"+treecontent).css({left:0 + "px", top: 40 + "px","z-index":"1001",width:"100%","overflow":"auto"}).slideDown("fast");
			$("#"+treecontent).css({"overflow":"auto"});
			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#unitTreeContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "unitTreeContent" || $(event.target).parents("#unitTreeContent").length>0)) {
				hideMenu();
			}
		}



/**
 * 单位管理模块相关的js
 * @author mukun@20140507
 */

	$(document).ready(function(){
        $.fn.zTree.init($("#userUnitTree"), userUnitFormTree.setting, userUnitFormTree.zNodes);
        userUnitFormTree.setting.async.url = "unit_getUnitTreeJson.action";
        var url = "unit_getUnitTreeJson.action", fun = function(data){
            _navMenuTree.zNodes = data;
            $.fn.zTree.init($("#userUnitTree"), userUnitFormTree.setting, userUnitFormTree.zNodes);
        };
    	$.CommonFun.asyncAjax(url, {}, fun, true);
		//btn 保存按钮事件
//		$("#btn_save").live('click',function(){
//			UserManage.panelSavaEvent(UserManage._curr_userisn);
//		});
		$("#tab_userManage > ul li").live('click',function(){
			var $a = $(this).children("a");
			var href = $a.attr('href') ;
			//用户管理的panel事件
			UserManage.clickUserManagePanelHead(href);
//			UserManage.zyfwPanelsClick(UserManage._curr_userisn);
		});
		$("#tab_zyfw .box-content .panels-group .panels .panels-heading").live('click',function(){
			var wxisn = $(this).find('a').attr('href');
			UserManage._curr_tab_wxjd_tree = "wxjd_tree_"+wxisn.split("_")[1];
			UserManage.zyfwPanelsClick(UserManage._curr_userisn);
		});
		$("#tab_xtqx .box-content .panels-group .panels .panels-heading").live('click',function(){
			var wgxtisn = $(this).find('> a').attr('href');
			UserManage._curr_tab_xtqx_tree = "xtqx_tree_"+wgxtisn.split("_")[1];
			UserManage.checkUserXtqxTreeNode(UserManage._curr_userisn);
		});
		//
		$('.user-wx-accordion-save').live('click',function(e){
			var wxisn = $(this).attr('wxisn');
			UserManage.panelSavaEvent(UserManage._curr_userisn);
		})
		$('.user-xtqx-accordion-save').live('click',function(e){
			UserManage.panelSavaEvent(UserManage._curr_userisn);
		});
		var validator = $('#form-userInfo').validate({
			rules :{
				validation_userisn:"required",
				validation_username:"required",
				validation_unitname:"required",
				validation_password:{
					required:true,
					minlength:1
				} ,
				validation_password_confirmation:{
					required:true,
					equalTo:"#validation_password"					
				},
				validation_ipsection:{
					required:true,
				},
			},
			messages:{
				validation_password:{
					required:"请输入密码",
					minlength:"请输入密码"
				},
				validation_password_confirmation:{
					required:"请输入确认密码",
					equalTo:"两次输入密码不一致"
				},
				validation_ipsection:{
					required:"请输入ip地址"
				}
			},
			submitHandler:function(form){
				UserManage.saveUserInfo(UserManage._operateFlag);	
			}			
			
		});
	    $('#btn_save').click(function(e){
			validator.form();
	    });		
		
		
	if(typeof(window.UserManage) ==undefined ||window.UserManage==null){
		window.UserManage = {
			_t : this ,
			column : [
					{field : 'USERISN',title : '登录名',width : 120},
					{field : 'USERNAME',title : '用户姓名',width : 120},
					{field : 'UNITNAME',title : '单位',width : 120},
					{field : 'TEL',title : '电话',width : 120},
//					{field : 'MAC',title : 'MAC地址',width : 120},
					{field : 'IPSECTION',title : 'ip地址',width : 120},
			],
			_SELECTEDISN:"",
			_operateFlag:"",
			_curr_tab_wxjd_tree:"",
			_curr_tab_xtqx_tree:"",
			_curr_userisn :"",
			init:function(){
				this.getUserPositionList();
			},
			/**
			 * 异步加载树的对象，用来对其他树进行初始化
			 */
			asyncZTreeObj:function(){
				    this.zNodes = "";
				    this.setting = {
				        async: {
				          	type:'POST',
							enable: true,
				//			contentType: "application/x-www-form-urlencoded",
							url: "",
							autoParam: ['ID']
				        },
						check: {
							enable: true,
							chkStyle: "checkbox",
							chkboxType: { "Y": "", "N": "ps" }, 
							radioType: "all"
						},
				        data: {
				            key: {
				                name: "NAME"
				            },
				            simpleData: {
				                enable: true,
				                idKey: "ID",
				                pIdKey: "PID",
				                root: null
				            }
				        },
				        callback: {
							onCheck: UserManage.zTreeOnCheckEvent,
							onExpand :""
						}
				    }
			},
			/**
			 * 获得加载用户表格数据
			 * @param {Object} treeNode
			 */
			getUserDataGrid :function(treeNode){
//				var buttonStr = '<input id="" class="btn btn-primary btn-sm" data-toggle="modal" hrefs="#qxgl-modal" style="margin-bottom:2px"  onclick="UserManage.getOperateFlag(\'ADD\');" value="增加" type="button">' ;
//				$('#detail_searchbar').empty().append(buttonStr);
				var nodeid,flag ;
				if(treeNode && treeNode.NODEID){
					nodeid = treeNode.NODEID;
					flag = treeNode.FLAG;
					id = treeNode.ID   ;
				}else{
					flag = "";
					nodeid = "" ;
					id="";
				}
				$('#detail_grid').datagrid({
						url : 'user_getUserGridJson.action',
						width:Main.getSingalGridWidth(),
						height:(document.body.clientHeight - 250),
						method : 'post',
						loadMsg : '加载数据中...',
						singleSelect : true,
						queryParams : {
							nodeid : nodeid,
							flag :flag,
							id:id 
						},
						fitColumns: true,
						frozenColumns : [[
							{
								field: 'CZ',
								title: '操作',
								width: 140,
								align: 'center',
								formatter: function(value, rec){
									// hrefs 用来弹出表单页面，详情参照bootstrap.js
									var str = '<div style="padding:6px;"><a  class="btn btn-success btn-xs userinfo_add" data-toggle="modal" hrefs="#qxgl-modal" onclick=\"UserManage.getOperateFlag(\'UPDATE\');\" title="修改" ><i class="icon-edit"></i></a>&nbsp;&nbsp;'+
									'<a class="btn btn-danger btn-xs userinfo_delete" title="删除" onclick=\"UserManage.getOperateFlag(\'DELETE\');\"><i class="icon-remove"></i></a>&nbsp;&nbsp;'+
									'<a class="btn btn-info btn-xs"  title="详情" data-toggle="modal" hrefs="#qxgl-modal" onclick=\"UserManage.getOperateFlag(\'DETAILE\');\"><i class="icon-trello"></i></a></div>';
									return str;
								}
							}
							]],
						columns:[
							 UserManage.column
						],
						toolbar:[{
	                        text: '增加',
	                        iconCls: 'qxgl-icon-add',
	                        handler: function(e){
							//显示修改表单
    						var $this   = $(this);							
						   	$this.attr('hrefs','#qxgl-modal');
							var href = $this.attr('hrefs');
						    var $target = $($this.attr('data-target') || (href && href.replace(/.*(?=#[^\s]+$)/, ''))) //strip for ie7
						    var option  = $target.data('modal') ? 'toggle' : $.extend({ remote: !/#/.test(href) && href }, $target.data(), $this.data())
						    e.preventDefault()
						    $target
						      .modal(option, this)
						      .one('hide', function () {
						        $this.is(':visible') && $this.focus()
						      })							
							UserManage.getOperateFlag('ADD');
								
								
	                        }
                    	},'-'
						],
						pagination:true,
						pageList:[20,40,60,80,100],
						onClickCell :function(rowIndex,field,value){
							var jlbm = "";			
							UserManage._curr_userisn = null;
							if(field =="CZ"){
								jlbm = $('#detail_grid').datagrid("getRows")[rowIndex].USERISN;
								UserManage._curr_userisn = jlbm ;
								UserManage.showOperateWindow(UserManage._operateFlag,jlbm);
							}				
						}

				});

			},
			getOperateFlag :function(flag){
				flag = flag.toUpperCase() ;
				UserManage._operateFlag = "";
				var str ="";
                switch (flag) {
                    case "DETAILE":
                        str = "DETAILE";
						$('#validation_userisn').attr("readonly");
						$('#UserManage-modal-content >.modal-footer').css('display','none');
                        break;
                    case "DELETE":
						$('#validation_userisn').attr("readonly");
                        str = "DELETE";
                        break;
                    case "UPDATE":
						$('#validation_userisn').attr("readonly");
                        str = "UPDATE";
						$('#UserManage-modal-content >.modal-footer').css('display','block');
                        break;
                    case "ADD":
                        str = "ADD";
						$('#validation_userisn').removeAttr("readonly");
                        break;
                    default:
                        str = "";
                        break;
                }
				UserManage._operateFlag = str;
			},
			/**
			 * 展示操作窗口，根据传入的flag变量判断是还是删除等操作
			 * @param {Object} flag 标志位变量
			 */
			showOperateWindow :function(flag,userisn){
                if (flag.toUpperCase() == "DELETE") {
					UserManage.deleteUserInfo(userisn);
                }else if(flag.toUpperCase() == "UPDATE"){
					UserManage.loadUserInfo(userisn);
					UserManage.getUserWxAndXtinfo();					
				}else if(flag.toUpperCase() =="DETAILE"){
					UserManage.loadUserInfo(userisn);
					UserManage.getUserWxAndXtinfo();					
				}else if(flag.toUpperCase() =="ADD"){
					UserManage.addUserInfo();
				}
				
			},
					/**
			 * 点击用户管理面板头部导航的切换事件
			 */
			clickUserManagePanelHead :function(href){
				$('#btn_save').css('display','inline');
				switch(href){
					case "#tab_jbxx":
						UserManage.loadUserInfo(UserManage._curr_userisn);
					break;
					case "#tab_zyfw":
						$('#btn_save').css('display','none');
						UserManage.zyfwPanelsClick(UserManage._curr_userisn);
					break;				
					case "#tab_xtqx":
						$('#btn_save').css('display','none');
						UserManage.checkUserXtqxTreeNode(UserManage._curr_userisn);
					break;				
					
					
				}
			},
			/**
			 * 用户管理模块下的弹框保存事件 btn-primary
			 */
			panelSavaEvent :function(userisn){
				if(!userisn){	
					userisn = null;
				}
				var $id = $("#tab_userManage .tab-content .active").attr('id');
				switch($id){
					case "tab_jbxx":
						UserManage.toggleSaveButton(true);
						UserManage.saveUserInfo(UserManage._operateFlag);
					break ;
					//资源范围
					case "tab_zyfw":
						this.saveZyfw(userisn);
					break;
					case "tab_xtqx":
						this.saveXtqx(userisn);
					break;
					default:
						alert("出错！");
					break;
				}
				
			},
			/**
			 * 加载用户职位信息列表
			 */
			getUserPositionList :function(){
                var url = "user_getUserPositionList.action", successFun = function(dt){
					console.log(dt);
					if(dt && dt.rows){
						$('#validation_position').empty();
						for(var i = 0; i < dt.rows.length ; i++){
							$.CommonFun.AddSelectItem(dt.rows[i].TEXT,dt.rows[i].TEXT,'validation_position');
						}
					}
                }
                $.CommonFun.asyncAjax(url,{}, successFun, true);		
			}
			,
			/**
			 * 用户panel的切换事件
			 * @param {Object} href
			 */
			switchUserPanelOperate :function(href){
				switch(href){
					case "#tab_jbxx":
					break;
					case "#tab_zyfw":
					
					break;
					case "#tab_xtqx":
					break;
				}
			},
			/**
			 * 加载用户信息
			 * @param {Object} userisn 用户id
			 * @author ：mk@20140609
			 */
			loadUserInfo :function(userisn){
				 var url = "user_getUserInfo.action",successFun = function(data){
					if(data && data.rows && data.rows.length >0 ){
						var select =$('#tab_jbxx input[type="text"]');
						//循环给表单赋值
						for(var i = 0;i<select.length ; i++){
							var s = select[i];
							var id = $(s).attr("id");
							id = id.split("_")[1];
							var key =id.toUpperCase();
							var value = eval("data.rows[0]."+key);
							for(var j in data.rows[0]){
								if(id.toUpperCase() == j){
									$(s).attr("value",value);
								}
							}
						}
						var tempValue = (data.rows[0].UNITISN ==null ? "": data.rows[0].UNITISN);
						$('#validation_unitname').attr('unitisn',tempValue);
					}
					
                }
                $.CommonFun.asyncAjax(url,{"userisn":userisn}, successFun, true);
				
			},
			/**
			 * 删除用户操作，删除的过程中将删除与用户相关的所有数据
			 * @param {Object} userisn
			 */
			deleteUserInfo :function(userisn){
                    $.messager.confirm($.ResMS.Messages.sysNotice, $.ResMS.Messages.sureDelete, function(r){
                        if (r) {
                            var url = "user_deleteGridItem.action", successFun = function(resStr){
                                if (resStr == "Success") {
                                    $('#detail_grid').datagrid("reload");
                                }
                            }
                            $.CommonFun.asyncAjaxPost(url, {"userisn": userisn}, successFun, true);
                        }
                    });
			},
			/**
			 * 保存用户信息
			 * @param {Object} flag
			 */
			saveUserInfo :function(flag){
				var userinfo = {
					userisn  :$('#validation_userisn').attr('value'),
					username :$('#validation_username').attr('value'),
					unitisn  :$('#validation_unitname').attr('unitisn'),
					unitname :$('#validation_unitname').attr('value'),
					password :$('#validation_password').attr('value'),
					position :$('#validation_position').attr('value'),
					tel      :$('#validation_tel').attr('value'),
					email    :$('#validation_email').attr('value'),
					ipsection :$('#validation_ipsection').attr('value')
				}
				var JSON = $.toJsonString(userinfo);
				if(flag == "UPDATE"){
					this.updateUserInfo(JSON);
				}else if(flag == "ADD"){
					this.checkUserIsn(userinfo.userisn);
					this.addUserInfo(JSON);
				}
				UserManage.toggleSaveButton();
			},
			/**
			 * 更新用户信息
			 * @param {Object} userInfo object类型的用户信息
			 */
			updateUserInfo :function(jsonstr){
				 var url = "user_updateUserInfo.action", JSON=jsonstr,successFun = function(resStr){
                        if (resStr == "SUCCESS") {
							alert("保存成功！");
                            $('#detail_grid').datagrid("reload");
                        }
                } ;
                $.CommonFun.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
			},
			/**
			 * 新增用户
			 * @param {Object} jsonStr
			 */
			addUserInfo :function(jsonstr){
				 var url = "user_addUserInfo.action", JSON=jsonstr,successFun = function(resStr){
                        if (resStr == "SUCCESS") {
							alert("保存成功！");
                            $('#detail_grid').datagrid("reload");
                        }
                } ;
                $.CommonFun.asyncAjaxPost(url, {"JSON": JSON}, successFun, true);
			},
			/**
			 * 较检用户
			 * @param {Object} userisn
			 */
			checkUserIsn :function(userisn){
				 var url = "user_checkUserIsn.action", successFun = function(resStr){
                        if (resStr == "REPEAT") {
                            alert("用户名已存在！");
                        }
                } ;
                $.CommonFun.asyncAjaxPost(url, {"userisn": userisn}, successFun, true);
			},
			/**
			 * 生成网系列表以及列表下的树结构
			 * @param {Object} userisn 用户isn
			 */
			getWxList :function(userisn){ 
//				<ul id="nav_menu_tree" class="ztree"></ul>
				 var url = "user_getWxList.action", successFun = function(data){
						if(data && data.rows && data.rows.length >0){
							var domStr = "<div class='panels panels-default'> "+
										"<div class='panels-heading'>"+
										"<a class='accordion-toggle' data-parent='#zyfw_accordion' "+
										"data-toggle='collapse' href='#collapse-accordion_common'> 全部网系"+
										"</a> </div>"; 
										domStr +="<div class='panels-collapse in '";
										domStr +=" id='collapse-accordion_common'> "+
										" <div class='panels-body'> "+
										"<input type='button' wxisn='common' class='user-wx-accordion-save btn btn-primary btn-sm' style='position:absolute;right:50px;' value='保存'/> "+
										 "<ul id='wxjd_tree_common' class='ztree'></ul></div></div></div>";
							$('#tab_userManage #tab_zyfw #zyfw_accordion').append(domStr);
							UserManage.getWxjdTree('','common');
							
							for(var i = 0;i<data.rows.length;i++){
								var domStr = "<div class='panels panels-default'> "+
											"<div class='panels-heading'>"+
											"<a class='accordion-toggle' data-parent='#zyfw_accordion' "+
											"data-toggle='collapse' href='#collapse-accordion_"+data.rows[i].WXISN+"'> "+data.rows[i].WXNAME +
											"</a> </div>"; 
									if(i==0){
//										domStr +="<div class='panels-collapse in '";
										domStr +="<div class='panels-collapse collapse '";
									}else{
										domStr +="<div class='panels-collapse collapse '";
									}		
										domStr +=" id='collapse-accordion_"+data.rows[i].WXISN+"'> "+
										" <div class='panels-body'>"+
										"<input type='button' wxisn='"+data.rows[i].WXISN+"' class='user-wx-accordion-save btn btn-primary btn-sm' style='position:absolute;right:50px;' value='保存'/> "+
										" <ul id='wxjd_tree_"+data.rows[i].WXISN+"' class='ztree'></ul></div></div></div>";
										$('#tab_userManage #tab_zyfw #zyfw_accordion').append(domStr);
								UserManage.getWxjdTree('',data.rows[i].WXISN);
							}
						}
                } ;
                $.CommonFun.asyncAjax(url, {"userisn": userisn}, successFun, true);
			},
			/**
			 * 生成网系节点树
			 * @param {Object} userisn
			 */
			getWxjdTree :function(userisn,wxisn){
				var wxjdTree  = new UserManage.asyncZTreeObj();
				wxjdTree.setting.async.url = "user_getWxjdTreeJson.action?wxisn="+wxisn;
				wxjdTree.setting.check.chkStyle = "checkbox";
				wxjdTree.setting.callback.onExpand = this.wxjdTreeOnExpand;
				var url = "user_getWxjdTreeJson.action", successFun = function(data){
					 wxjdTree.zNodes = data;
					$.fn.zTree.init($("#wxjd_tree_"+wxisn), wxjdTree.setting, wxjdTree.zNodes);
                } ;
                $.CommonFun.asyncAjax(url, {"userisn": userisn,"wxisn":wxisn}, successFun, true);
			},
			/**
			 * 资源范围保存
			 * @param {Object} userisn
			 */
			saveZyfw :function(userisn){
				var active = $("#tab_zyfw .box-content .panels-group .panels .in ul").attr("id");
				UserManage._curr_tab_wxjd_tree = active ;
				var wxisn = active.split("_")[2];
				//获取当前树的节点
				var treeObj = $.fn.zTree.getZTreeObj(UserManage._curr_tab_wxjd_tree);
				var nodes = treeObj.getCheckedNodes(true);
				var node = new Array();
				for(var i in nodes){
					var obj = {
						FLAG :	nodes[i].FLAG,
						ID: nodes[i].ID,
						NAME: nodes[i].NAME,
						NODEID: nodes[i].NODEID,
						PID: nodes[i].PID
					}
					node.push(obj);
				}
				var jsonStr = $.toJsonString(node);
				var url = "user_getCheckWxjdNode.action", successFun = function(str){
					if(str == "SUCCESS"){
						alert("保存成功!");
					}else{
						alert("保存失败!");
					}
                } ;
                $.CommonFun.asyncAjaxPost(url,{"nodes":jsonStr,"userisn":userisn,"wxisn":wxisn}, successFun, true);
				
			},
			/**
			 * 当选中或者取消时候 取消勾选的父节点
			 * 当节点中含有子节点时候， 子节点勾选的情况下，在父节点勾选的动作时候取消勾选子节点
			 * 父节点勾选的情况下，勾选子节点则取下勾选父节点
			 * 原因：避免冗余数据以及后台程序的处理效率
			 * @param {Object} event
			 * @param {Object} treeId  
			 * @param {Object} treeNode 树节点信息
			 */
			zTreeOnCheckEvent :function(event, treeId, treeNode){
				var active = UserManage.getCurrentZyfwTreeId();
				var treeObj = $.fn.zTree.getZTreeObj(active);				
				var treeNodeChildren = treeNode.children ;
				if(treeNodeChildren){
					for(var i = 0 ; i < treeNodeChildren.length ; i++){
						treeObj.checkNode(treeNodeChildren[i], false, false);
					}
				}
				var checkStatus = treeNode.getCheckStatus();
				var parentNode = treeNode.getParentNode();
//				if(checkStatus.checked == false){
					treeObj.checkNode(parentNode, false, false);
//				}
			},

			/**
			 * 勾选当前树的资源
			 */
			zyfwPanelsClick :function(userisn){
				if(!userisn){
					userisn = this._curr_userisn;
				}
				var active = $("#tab_zyfw .box-content .panels-group .panels .in").attr("id");
				var activeTree = $("#tab_zyfw .box-content .panels-group .panels .in ul").attr("id");
				if(activeTree){
				UserManage._curr_tab_wxjd_tree = activeTree ;
				}
				var wxisn = UserManage._curr_tab_wxjd_tree.split("_")[2];
				var url = "user_getUserWxzyNodes.action", successFun = function(data){
					//选中树节点
				 	var treeObj = $.fn.zTree.getZTreeObj(UserManage._curr_tab_wxjd_tree);
					var nodes =  treeObj.transformToArray(treeObj.getNodes());
					if(data && data.rows && data.rows.length>0){
						for (var i=0, l=nodes.length; i < l; i++) {
								for(var j=0;j<data.rows.length;j++){
									if(nodes[i].ID == data.rows[j].CJGX){
										treeObj.checkNode(nodes[i], true, true);
									}								
								}
						}
					}
                } ;
                $.CommonFun.asyncAjax(url,{"userisn":userisn,"wxisn":wxisn}, successFun, true);		
			},
			/**
			 * 展开树的事件：{
			 *		如果父节点勾选 则子节点加载后勾选,
			 *		如果父节未勾选,则查找需要勾选的子节点
			 * }
			 * @param {Object} event
			 * @param {Object} treeId
			 * @param {Object} treeNode
			 */
			wxjdTreeOnExpand :function(event, treeId, treeNode) {
				var activeTree = UserManage._curr_tab_wxjd_tree ;
				var wxisn = activeTree.split("_")[2];
				var checkStatus = treeNode.getCheckStatus(); 
				var treeObj = $.fn.zTree.getZTreeObj(activeTree);
				var nodes = treeObj.transformToArray(treeNode);
				if(checkStatus.checked == true){
					treeObj.checkNode(treeNode, true, true);
				}else{
                    var url = "user_getUserWxzyNodesChildren.action", successFun = function(data){
                        //选中树节点
					 	var treeObj = $.fn.zTree.getZTreeObj(UserManage._curr_tab_wxjd_tree);
						var childNode = treeNode.children;
						for (var i=0, l=childNode.length; i < l; i++) {
								for(var j=0;j<data.rows.length;j++){
									if(childNode[i].NODEID == data.rows[j].NODEID){
//										20140623注释掉
//										treeObj.checkNode(childNode[i], true, false);
									}								
								}
						}
                    };
                    $.CommonFun.asyncAjax(url, {"userisn": UserManage._curr_userisn,"wxisn": wxisn,"nodeid":treeNode.NODEID}, successFun, true);
				}
			},
			/**
			 * 获取用户的网系和系统角色信息
			 */
			getUserWxAndXtinfo :function(){
				this.getUserAllWxzyNodes();
				this.getUserAllXtRoles();				
			},
			/**
			 * 获取所有用户的网系资源节点
			 */
			getUserAllWxzyNodes:function(){				
				var url = "user_getUserAllWxzyNodes.action", successFun = function(data){
					var zyfwStr = "", xtqxStr = "";
					console.log(data);
					if(data && data.length > 0 ){
						var tempStr = "" ; 
						for(var i = 0 ; i < data.length ; i++){
							for( attr in data[i]){
								zyfwStr += attr+":("+data[i][attr] +");" ;							
							}
						}
						console.log(zyfwStr);
						$('#userjbxx-zyfw-content').html(zyfwStr).attr('title',zyfwStr); 
					}
                } ;
                $.CommonFun.asyncAjax(url,{"userisn":UserManage._curr_userisn}, successFun, true);		
			},
			/**
			 * 获取所有用户的系统角色
			 */
			getUserAllXtRoles :function(){
				var url = "user_getUserAllXtRoles.action", successFun = function(data){
					console.log(data);
					var zyfwStr = "", xtqxStr = "";
					if(data && data.length > 0 ){
 						var tempStr = "" ; 
						for(var i = 0 ; i < data.length ; i++){
							for( attr in data[i]){
								zyfwStr += attr+":("+data[i][attr] +");" ;							
							}
						}
						$('#userjbxx-xtqx-content').html(zyfwStr).attr('title',zyfwStr); 
					}
                } ;
                $.CommonFun.asyncAjax(url,{"userisn":UserManage._curr_userisn}, successFun, true);					
			},
/////////////////////////////////////////////////////////// 用户管理模块下的操作管理/////////////////////////////////////////////////////////////////////
			/**
			 * 获取网管系统列表
			 * 加载到panel面板中
			 */
			getWgxtList :function(){ 
				 var url = "user_getWgxtList.action", successFun = function(data){
						if(data && data.rows && data.rows.length >0){
							var domStr = "<div class='panels panels-default'> "+
										"<div class='panels-heading'>"+
										"<a class='accordion-toggle' data-parent='#xtqx_accordion' "+
										"data-toggle='collapse' href='#xtqx-collapse-accordion_common'> 复合角色"+
										"</a> </div>"; 
										domStr +="<div class='panels-collapse in '";
										domStr +=" id='xtqx-collapse-accordion_common'> "+
										" <div class='panels-body'> "+
										"<input type='button' wxisn='common' class='user-xtqx-accordion-save btn btn-primary btn-sm' style='position:absolute;right:50px;' value='保存'/> "+
										"<ul id='xtqx_tree_common' class='ztree'></ul></div></div></div>";
							$('#tab_userManage #tab_xtqx #xtqx_accordion').append(domStr);
							UserManage.createXtRoleTree("",'common')
							for(var i = 0;i<data.rows.length;i++){
							 var domStr = "<div class='panels panels-default'> "+
											"<div class='panels-heading'>"+
											"<a class='accordion-toggle' data-parent='#xtqx_accordion' "+
											"data-toggle='collapse' href='#collapse-accordion_"+data.rows[i].WGXTISN+"'> "+data.rows[i].XTNAME +
											"角色</a></div>"; 
									if(i==0){
										domStr +="<div class='panels-collapse collapse '";
									}else{
										domStr +="<div class='panels-collapse collapse '";
									}		
										domStr +=" id='collapse-accordion_"+data.rows[i].WGXTISN+"'> "+
										" <div class='panels-body'> "+
										"<input type='button' wxisn='"+data.rows[i].WGXTISN+"' class='user-xtqx-accordion-save btn btn-primary btn-sm' style='position:absolute;right:50px;' value='保存'/> "+
										"<ul id='xtqx_tree_"+data.rows[i].WGXTISN+"' class='ztree'></ul></div></div></div>";
							$('#tab_userManage #tab_xtqx #xtqx_accordion').append(domStr);
							UserManage.createXtRoleTree("",data.rows[i].WGXTISN);
							}
						}
                } ;
                $.CommonFun.asyncAjax(url, {"userisn": UserManage._curr_userisn}, successFun, true);
			},
			/**
			 * 生成网管系统角色树
			 * @param {Object} userisn
			 * @param {Object} wgxtisn 网管系统内码
			 */
			createXtRoleTree :function(userisn,wgxtisn){
				var xtqxTree  = new UserManage.asyncZTreeObj();
				xtqxTree.setting.async.url = "user_getXtRoleJson.action?wxisn="+wgxtisn;
//不能使用radio 因为一个用户在网管系统中可以属于多个角色
//				xtqxTree.setting.check.chkStyle = "radio";
//				xtqxTree.setting.callback.onExpand = this.wxjdTreeOnExpand;
				var url = "user_getXtRoleJson.action", successFun = function(data){
					 xtqxTree.zNodes = data;
					$.fn.zTree.init($("#xtqx_tree_"+wgxtisn), xtqxTree.setting, xtqxTree.zNodes);
                } ;
                $.CommonFun.asyncAjax(url, {"userisn": userisn,"wgxtisn":wgxtisn}, successFun, true);
			},
			/**
			 * 保存系统权限
			 * @param {Object} userisn
			 * @param {Object} wgxtisn
			 */
			saveXtqx :function(userisn){
				var active = $("#tab_xtqx #xtqx_accordion .panels > .in ul").attr("id");
				UserManage._curr_tab_xtqx_tree = active ;
				var wgxtisn = active.split("_")[2];
//				//获取当前树的节点
				var treeObj = $.fn.zTree.getZTreeObj(UserManage._curr_tab_xtqx_tree);
				var nodes = treeObj.getCheckedNodes(true);
				var node ; 
				var nodeArr = new Array();
				var nodesLength = nodes.length ;
				if(nodesLength == 0 ){
					var obj = {
						FLAG :"",
						ID: "",
						NAME:"",
						NODEID:""
					}
					nodeArr.push(obj);			
					node = {
						USERISN:userisn,
						WGXTISN :wgxtisn,
						FLAG :	"",
						ID: "",
						NAME: "",
						NODEID: "",
						PID: ""
					}							
				} else{
					for(var n in nodes){
						var obj = {
							FLAG :	nodes[n].FLAG,
							ID: nodes[n].ID,
							NAME: nodes[n].NAME,
							NODEID: nodes[n].NODEID
						}
						nodeArr.push(obj);
					}
					node = {
						USERISN:userisn,
						WGXTISN :wgxtisn,
						FLAG :	nodes[0].FLAG,
						ID: nodes[0].ID,
						NAME: nodes[0].NAME,
						NODEID: nodes[0].NODEID,
						PID: nodes[0].PID
					}
				}
				
//				var jsonStr = $.toJsonString(node);
				var jsonStr = $.toJsonString(nodeArr);
				var url = "user_saveUserWgxtRole.action", successFun = function(str){
					if(str == "SUCCESS"){
						alert("保存成功!");
					}else{
						alert("保存失败!");
					}
                } ;
                $.CommonFun.asyncAjaxPost(url,{"json":jsonStr,"userisn":userisn,"wgxtisn":wgxtisn}, successFun, true);				
			},
			/**
			 * 初始化勾选用户系统角色
			 */
			checkUserXtqxTreeNode :function(userisn){
				if(!userisn){
					userisn = UserManage._curr_userisn ; 
				}
//				var active = $("#tab_xtqx #xtqx_accordion .panels > .in ul").attr("id");
//				UserManage._curr_tab_xtqx_tree = active ;
				activeTree = UserManage.getCurrentXtqxTreeId();
				var wgxtisn = activeTree.split("_")[2];
				var url = "user_getUserRole.action", successFun = function(data){
					//选中树节点
				 	var treeObj = $.fn.zTree.getZTreeObj(UserManage._curr_tab_xtqx_tree);
					var nodes =  treeObj.transformToArray(treeObj.getNodes());
					//先取消勾选全部在勾选
					if(data && data.rows && data.rows.length > 0){
						for (var i=0, l=nodes.length; i < l; i++) {
							treeObj.checkNode(nodes[i], false, false);
						}					
						for (var i=0, l=nodes.length; i < l; i++) {
								for(var j=0;j<data.rows.length;j++){
									if(nodes[i].NODEID == data.rows[j].ROLEISN){
										treeObj.checkNode(nodes[i], true, true);
									}								
								}
						}
					}
                } ;
                $.CommonFun.asyncAjax(url,{"userisn":userisn,"wgxtisn":wgxtisn}, successFun, true);				
			},
			/**
			 * 获取当前的用户系统权限树id
			 * 返回全局变量
			 */
			getCurrentXtqxTreeId :function(){
				var active = $("#tab_xtqx #xtqx_accordion .panels > .in ul").attr("id");
				var currentXtqxTree = null;
				if(typeof active != "undefined"){
					currentXtqxTree = active ;
					UserManage._curr_tab_xtqx_tree = active;
				}else{
					currentXtqxTree = UserManage._curr_tab_xtqx_tree;
				}
				return currentXtqxTree ;
			},
			/**
			 * 获得当前的用户资源范围树
			 */
			getCurrentZyfwTreeId :function(){
				var active = $("#tab_zyfw #accordion .panels > .in ul").attr("id");
				var currentXtqxTree = null;
				if(typeof active != "undefined"){
					currentXtqxTree = active ;
					UserManage._curr_tab_wxjd_tree = active;
				}else{
					currentXtqxTree = UserManage._curr_tab_wxjd_tree ; 
				}
				return currentXtqxTree ;				
			},
			/**
			 * 切换保存按钮效果
			 */
			toggleSaveButton :function(flag){
				if(flag){
					$('#btn_save').css("display","none");
					$('#btn_saving').css("display","inline");
				}else{
					$('#btn_save').css("display","inline");
					$('#btn_saving').css("display","none");
				}
			}
			
		}
	}
	//加载网系资源和系统角色
	UserManage.getWxList();
	UserManage.getWgxtList();

	});
