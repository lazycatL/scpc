<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet"
      type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/ImgInput/css/ssi-uploader.css"/>
<script src="${pageContext.request.contextPath}/js/plugin/ImgInput/js/ssi-uploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/util/validata.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/xsgl/editHtInfo.js"></script>
<div id='wrapper'>
    <div class="row">
        <div class="col-sm-12">
            <div class="box">
                <div class="box-header">

                    <div class="title">
                        <div class="icon-edit"></div>
                        合同信息
                    </div>
                    <div id="form_return" class="btn btn-success btn-sm">
                        <i class="icon-add"></i> 返回
                    </div>
                </div>
                <div class="box-content box-no-padding">
                    <form id="form_htInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_khxx_htkh'>客户名称</label>
                            <div class='col-sm-3 controls'>
                                <select id='form_khxx_htkh' class='select2 form-control' info="fromInfo" name='form_khxx_htkh'>
                                </select>
                            </div>

                            <label class='control-label col-sm-2' for='form_khxx_htbh'>合同编号</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required' id='form_khxx_htbh' info="fromInfo"
                                       name='form_khxx_htbh'
                                       placeholder='合同编号' type='text'>
                                <label class="error"></label>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_khxx_htjc'>合同简称</label>
                            <div class='col-sm-2 controls'>
                                <input class='form-control required' id='form_khxx_htjc' info="fromInfo"
                                       name='form_khxx_htjc'
                                       placeholder='合同简称' type='text'>
                            </div>
                            <div class='col-sm-1 controls'>
                                       <label class="textInfo">生成订单编号</label>
                            </div>
                            <label class='control-label col-sm-2' for='form_khxx_htfj'>合同附件</label>
                            <div class='col-sm-3 controls '>
                                <input id="form_khxx_htfj" onclick="HtEditManage.showUploadModel();" class="btn btn-primary" type="button" value="上传附件">
                                <label class="textInfo"></label>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_htInfo_ywlx'>业务类型</label>

                            <div class='col-sm-3 controls'>
                                <select id="form_htInfo_ywlx" class='select2 form-control'>
                                </select>
                            </div>
                            <label class='control-label col-sm-2' for='form_khxx_htje'>合同金额</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required mustrequiredDecimal' id='form_khxx_htje'
                                       info="fromInfo" name='form_khxx_htje'
                                       placeholder='合同金额' type='text'>
                            </div>
                        </div>

                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_khxx_qssj'>签署时间</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required' id='form_khxx_qssj' style="cursor:pointer;"
                                       info="fromInfo"
                                       name='form_khxx_qssj' placeholder='签署时间' readonly type='text'>
                                <label class="error"></label>
                            </div>
                            <label class='control-label col-sm-2' for='form_khxx_qssj'>交货工期</label>

                            <div class='col-sm-3 controls'>
                                <%--<input class='form-control required' id='form_khxx_jssj' style="cursor:pointer;"--%>
                                       <%--info="fromInfo"  name='form_khxx_jssj' placeholder='交货时间' readonly type='text'>--%>
                                    <input class='form-control requiredDecimal' id='form_khxx_gq' info="fromInfo"
                                           name='form_khxx_gq'  placeholder='交货工期' type='text'>
                                <label class="error"></label>
                            </div>
                        </div>

                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_khxx_fkzt'>付款状态</label>

                            <div class='col-sm-3 controls'>
                                <select id='form_khxx_fkzt' class='select2 form-control' info="fromInfo" name='form_khxx_fkzt'>
                                </select>
                            </div>
                            <label class='control-label col-sm-2' for='form_khxx_jkje'>结款金额</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control requiredDecimal' id='form_khxx_jkje' info="fromInfo"
                                       name='form_khxx_jkje'
                                       placeholder='结款金额' type='text'>
                                <label class="error"></label>
                            </div>
                        </div>
                        <%--<div class='form-group'>--%>
                            <%--<label class='control-label col-sm-2' for='form_khxx_jkje'>汇款开户行</label>--%>

                            <%--<div class='col-sm-3 controls'>--%>
                                <%--<input class='form-control' id='form_khxx_hkkhh' info="fromInfo"--%>
                                       <%--name='form_khxx_hkkhh' placeholder='汇款开户行' type='text'>--%>
                            <%--</div>--%>
                            <%--<label class='control-label col-sm-2' for='form_khxx_hkzh'>汇款账户</label>--%>

                            <%--<div class='col-sm-3 controls'>--%>
                                <%--<input class='form-control' id='form_khxx_hkzh' info="fromInfo" name='form_khxx_hkzh'--%>
                                       <%--placeholder='汇款账户' type='text'>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <div class='form-group'>

                            <label class='control-label col-sm-2' for='form_khxx_jkje'>合同细节</label>

                            <div class='col-sm-8 controls'>
                                <input class='form-control' id='form_khxx_htmx' info="fromInfo" name='form_khxx_htmx'
                                       placeholder='合同细节' type='text'>
                            </div>

                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_khxx_remark'>备注</label>

                            <div class='col-sm-8 controls'>
                                <textarea rows="4" class='form-control' id='form_khxx_remark' info="fromInfo"
                                          name='form_khxx_remark'>
                                </textarea>
                            </div>
                        </div>
                        <div class='modal-footer'>

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
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModalUpload" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:950px;height:500px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <button id="modalClose" type="button" class="close"
                        data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body2">
                <iframe id="uploadFile" name="ajaxUpload" style="display:none;"></iframe>
                <form enctype="multipart/form-data" method="post" target="ajaxUpload">
                    <input type="file" multiple id="ssi-upload"  name="ssi-upload"/>
                </form>

            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>