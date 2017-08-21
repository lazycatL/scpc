<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet"
      type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/ImgInput/css/ssi-uploader.css"/>
<script src="${pageContext.request.contextPath}/js/plugin/ImgInput/js/ssi-uploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/util/validata.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/jsgl/editDdInfo.js"></script>
<div id='wrapper'>
    <div class="row">
        <div class="col-sm-12">
            <div class="box">
                <div class="box-header">
                    <button id="form_return" class="btn btn-success btn-sm">
                        <i class="icon-add"></i> 返回
                    </button>
                    <div class="title">
                        <div class="icon-edit"></div>
                        订单信息
                    </div>

                </div>
                <div class="box-content box-no-padding">
                    <form id="form_ddInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
                        <div class='form-group'>
                            <label class='col-sm-2 control-label' for='form_khxx_ssht'>所属合同</label>

                            <div class='col-sm-3 controls'>
                                <select class='select2 form-control' id='form_khxx_ssht' info="fromInfo" name='form_khxx_ssht'>
                                </select>
                            </div>
                            <label class='col-sm-2 control-label' for='form_khxx_xmname'>订单编号</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required' id='form_khxx_xmname' info="fromInfo"
                                       name='form_khxx_xmname' placeholder='订单编号' type='text'>
                                <label class="error"></label>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='col-sm-2 control-label' for='form_khxx_ddlevel'>订单级别</label>

                            <div class='col-sm-3 controls'>
                                <%--<input class='form-control' id='form_khxx_ddlevel' info="fromInfo"--%>
                                       <%--name='form_khxx_ddlevel' placeholder='订单级别' type='text'>--%>
                                <select info="fromInfo" class='form-control' name="form_khxx_ddlevel" id='form_khxx_ddlevel'>
                                </select>
                            </div>
                            <label class='col-sm-2 control-label' for='form_khxx_starttime'>开始时间</label>

                            <div class='col-sm-3 controls'>
                                <%--<input class='form-control'  id='form_khxx_planstarttime'   style="cursor:pointer;" info="fromInfo" name='form_khxx_planstarttime' placeholder='计划开始时间' type='text'>--%>
                                <input class='form-control required' id='form_khxx_starttime' placeholder='开始时间'
                                       type="text" value="" readonly  style="cursor:pointer;"  info="fromInfo"
                                       class="form_datetime">
                                <label class="textInfo"></label>
                            </div>

                        </div>
                        <div class='form-group'>

                            <label class='col-sm-2 control-label' for='form_khxx_endtime'>结束时间</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required' readonly id='form_khxx_endtime' style="cursor:pointer;"
                                       info="fromInfo" name='form_khxx_endtime' placeholder='结束时间' type='text'>
                                <label class="textInfo"></label>
                            </div>
                            <label class='col-sm-2 control-label' for='form_khxx_xmlxr'>项目联系人</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control' id='form_khxx_xmlxr' info="fromInfo" name='form_khxx_xmlxr'
                                       placeholder='项目联系人' type='text'>
                                <label class="textInfo"></label>
                            </div>
                        </div>
                        <div class='form-group'>


                            <label class='col-sm-2 control-label' for='form_khxx_xmfzr'>项目负责人</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control' id='form_khxx_xmfzr' info="fromInfo" name='form_khxx_xmfzr'
                                       placeholder='项目负责人' type='text'>
                                <label class="textInfo"></label>
                            </div>
                            <label class='col-sm-2 control-label' for='form_khxx_remark'>备注</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control' id='form_khxx_remark' info="fromInfo"
                                       name='form_khxx_remark' placeholder='备注' type='text'>
                            </div>
                        </div>

                        <div class='modal-footer col-md-7'>

                            <input id="btn_save" class="btn btn-primary" type="button" value="保存">
                            <button id="btn_saving" class='btn btn-default' style="display:none;" type='button'>
                                <i class="icon-1x icon-spinner icon-spin"></i>
                                保存中...
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
