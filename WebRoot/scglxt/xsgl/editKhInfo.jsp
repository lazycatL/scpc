<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet"
      type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/util/validata.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/xsgl/editKhInfo.js"></script>
<div class="row">
    <div class="col-sm-12">
        <div class="box">
            <div class="box-header">
                <button id="form_return" class="btn btn-success btn-sm">
                    <i class="icon-add"></i> 返回
                </button>
                <div class="title">
                    <div class="icon-edit"></div>
                    客户信息
                </div>

            </div>

            <div class="box-content box-no-padding">
                <form id="form_khxx" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
                    <div class='form-group'>
                        <label class='control-label col-sm-3 col-sm-3  ' for='form_khxx_mc'>客户名称</label>

                        <div class='col-sm-4 controls'>
                            <!-- data-rule-minlength='1' -->
                            <input class='form-control required' id='form_khxx_mc' name='form_khxx_mc'
                                   placeholder='客户名称'
                                   type='text'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3 col-sm-3' for='form_khxx_lx'>客户类型</label>

                        <div class='col-sm-4 controls'>
                            <select id="form_khxx_lx" class='select2 form-control'>
                            </select>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3 ' for='form_khxx_dw'>客户单位</label>

                        <div class='col-sm-4 controls'>
                            <!-- 		                            <input class="form-control" id="form_khxx_dw" name="form_khxx_dw" type="text" placeholder='客户单位'  onclick="showMenu('unitSel','unitTreeContent');" /> -->
                            <input class="form-control  " id="form_khxx_dw" name="form_khxx_dw" type="text"
                                   placeholder='客户单位'/>
                            <!--  单位树-->
                            <!-- 		                            <div id="unitTreeContent" class="unitTreeContent" style="display:none; position: absolute;z-index:1001;overflow:auto;background:#eeeeee;padding:6px 12px;"> -->
                            <!-- 										<ul id="userUnitTree" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul> -->
                            <!-- 									</div> -->
                            <!-- end 单位树 -->
                        </div>

                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_khxx_dz'>客户地址</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_khxx_dz' name='form_khxx_dz' placeholder='客户地址'
                                   type='text'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_khxx_gx'>合作关系</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_khxx_gx' name='form_khxx_gx' placeholder='合作关系'
                                   type='text'>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_khxx_iscj'>是否成交</label>

                        <div class='col-sm-4 controls'>
                            <select id="form_khxx_iscj" class='select2 form-control'>
                                <option value="0">否</option>
                                <option value="1">是</option>
                            </select>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3  ' for='form_khxx_starttime'>开始合作时间</label>

                        <div class='col-sm-4 controls'>
                            <input class="form-control required" readonly style="cursor:pointer;" name="form_khxx_starttime"
                                   placeholder="开始合作时间" type="text" id="form_khxx_starttime">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label class='control-label col-sm-3' for='form_khxx_remark'>备注</label>

                        <div class='col-sm-4 controls'>
                            <input class='form-control' id='form_khxx_remark' name='form_khxx_remark' placeholder='备注'
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
