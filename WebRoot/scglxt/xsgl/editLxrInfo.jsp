<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet"
      type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/util/validata.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/xsgl/editLxrInfo.js"></script>
<div class="row">
    <div class="col-sm-12">
        <div class="box">
            <div class="box-header">
                <button id="form_return" class="btn btn-success btn-sm">
                    <i class="icon-add"></i> 返回
                </button>
                <div class="title">
                    <div class="icon-edit"></div>
                    联系人信息
                </div>

            </div>

            <div class="box-content box-no-padding">
                <form id="form_lxr" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
                    <div class='form-group'>
                        <label class='control-label col-sm-3 col-sm-3  ' for='form_lxr_sjkh'>所属客户</label>

                        <div class='col-sm-4 controls'>
                            <!-- data-rule-minlength='1' -->
                            <select id="form_lxr_sjkh" class='select2 form-control'>
                            </select>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3 col-sm-3' for='form_lxr_mc'>联系人名称</label>

                        <div class='col-sm-4 controls'>
                            <input class="form-control  " id="form_lxr_mc" name="form_lxr_mc" type="text"
                                   placeholder='联系人名称'/>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3 ' for='form_lxr_sj'>联系人手机</label>

                        <div class='col-sm-4 controls'>
                            <input class="form-control  " id="form_lxr_sj" name="form_lxr_sj" type="text"
                                   placeholder='联系人手机'/>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_lxr_zj'>联系人座机</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_lxr_zj' name='form_lxr_zj' placeholder='联系人座机' type='text'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_lxr_yx'>联系人邮箱</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_lxr_yx' name='form_lxr_yx' placeholder='联系人邮箱'
                                   type='text'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_lxr_zw'>联系人职位</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_lxr_zw' name='form_lxr_zw' placeholder='联系人邮箱'
                                   type='text'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3  ' for='form_lxr_sfxmlxr'>是否项目联系人</label>

                        <div class='col-sm-4 controls'>
                            <select id="form_lxr_sfxmlxr" class='select2 form-control'>
                                <option value="0">否</option>
                                <option value="1">是</option>
                            </select>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_lxr_remark'>备注</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_lxr_remark' name='form_lxr_remark' placeholder='备注'
                                   type='text'>
                        </div>
                    </div>
                    <div class='form-group '>
                        <div class="col-md-4 col-md-offset-8">
                            <input id="btn_save" class="btn btn-primary" type="button" value="保存">

                            <div id="btn_saving" class='btn btn-default' style="display:none;" type='button'>
                                <i class="icon-1x icon-spinner icon-spin"></i>
                                保存中...
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
