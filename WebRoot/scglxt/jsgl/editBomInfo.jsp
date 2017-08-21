<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<link href="${pageContext.request.contextPath}/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet"
      type="text/css"/>
<link rel="stylesheet" href="../../stylesheets/preview.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plugin/select2/select2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/util/validata.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/util/validonblur.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scglxt/jsgl/editBomInfo.js"></script>
<script type="text/javascript" src="../../js/util/NumKeyBoard.js"></script>
<script src="../../js/util/slider.js"></script>

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
                        Bom表
                    </div>
                    <div class="actions">
                        <a class="btn box-remove btn-xs btn-link" href="#"><i class="icon-remove"></i>
                        </a>
                        <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                        </a>
                    </div>
                </div>
                <div class="box-content box-no-padding">
                    <form id="form_bomInfo" class='form form-horizontal ' method="post" style='margin-bottom: 0;'>
                        <input style="display: none;"  id='form_bomInfo_id' info="fromInfo" name='id'
                             type='text'>
                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_bomInfo_zddmc'>bom(子订单名称)</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required' id='form_bomInfo_zddmc' info="fromInfo" name='zddmc'
                                       placeholder='子订单名称' type='text'>
                                <label class="textInfo"></label>
                            </div>
                            <label class='control-label col-sm-2' for='form_bomInfo_ssdd'>所属订单</label>

                            <div class='col-sm-3 controls'>
                                <select  class='select2 form-control' id='form_bomInfo_ssdd' info="fromInfo" name='ssdd'>
                                </select>
                            </div>
                        </div>
                        <%--<div class='form-group'>--%>
                            <%--<label class='control-label col-sm-2' for='form_bomInfo_zddjb'>BOM级别</label>--%>
                            <%--<div class='col-sm-3 controls'>--%>
                                <%--<select  class='select2 form-control' id='form_bomInfo_zddjb' name='zddjb'>--%>
                                <%--</select>--%>
                                <%--<label class="textInfo"></label>--%>

                            <%--</div>--%>
                        <%--</div>--%>
                        <div class='form-group'>
                            <label class='control-label col-sm-2' for='form_bomInfo_zddcz'>材质</label>

                            <div class='col-sm-3 controls'>
                                <select class=' form-control' id='form_bomInfo_zddcz' info="fromInfo"
                                        name='zddcz'>
                                </select>
                            </div>
                            <label class='control-label col-sm-2' for='form_bomInfo_clxz'>材料形状</label>

                            <div class='col-sm-3 controls'>

                                <select  class='select2 form-control' id='form_bomInfo_clxz' name='clxz'>

                                    <option value="1">
                                        长方体
                                    </option>
                                    <option value="2">
                                        圆柱体
                                    </option>

                                </select>
                                <label class="textInfo"></label>

                            </div>
                        </div>

                        <div class='form-group'>
                            <label class='control-label col-sm-2'>加工数量</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control required requiredDecimal numkeyboard'  id='form_bomInfo_jgsl' info="fromInfo"
                                       name='jgsl' placeholder=' ' type='text'>
                                <label class="textInfo"></label>
                            </div>
                            <label class='control-label col-sm-2'>表面处理</label>

                            <div class='col-sm-3 controls'>
                                <input class='form-control' id='form_bomInfo_bmcl' info="fromInfo"
                                       name='bmcl' placeholder=' ' type='text'><label class="textInfo"></label>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-2'>材料大小</label>
                            <div class='col-sm-3 controls'>
                                <input  style="display: none;" id='cldx' info="fromInfo"
                                        name='cldx' placeholder=' ' type='text'>
                                <div class="row " id="form_bomInfo_jx" >
                                    <label>长度(mm)</label>
                                    <input class="requiredDecimal numkeyboard" style="border:1px solid lightgray;height:30px;width:50px;"  type="text" name="length" placeholder=""><span style="color:red;"></span>
                                    <label>宽度(mm)</label><input class="requiredDecimal numkeyboard"  style="border:1px solid lightgray;height:30px;width:50px;"  type="text" name="width"
                                                                 placeholder=""><span style="color:red;"></span>
                                    <label>高度(mm)</label><input class="requiredDecimal numkeyboard" style="border:1px solid lightgray;height:30px;width:50px;"  type="text" name="height"
                                                                 placeholder=""><span style="color:red;"></span>
                                </div>
                                <div class="row " id="form_bomInfo_yx"  hidden>
                                    <label>直径(mm)</label>
                                    <input  class="requiredDecimal numkeyboard" style="border:1px solid lightgray;height:30px;width:80px;" type="text" name="length" class=" " placeholder="">
                                    <span style="color:red;"></span>
                                    <label>高度(mm)</label><input style="border:1px solid lightgray;height:30px;width:80px;" type="text" name="height"
                                                                class="requiredDecimal numkeyboard" placeholder=""><span style="color:red;"></span>
                                </div>
                            </div>
                            <label class='control-label col-sm-2'>材料体积</label>

                            <div class='col-sm-2 controls '>
                                <input class='form-control ' id='form_bomInfo_cltj' info="fromInfo"
                                       name='cltj' placeholder=' ' type='text'  class="requiredDecimal">
                                <label class="textInfo"></label>
                            </div>
                            <div class='col-sm-2 controls '>
                                <span>cm<sup>3</sup></span>
                                <div id="btn-calculateValume" class="btn btn-primary">计算</div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-2'>材料重量</label>

                            <div class='col-sm-3 controls '>
                                <input class='form-control ' id='form_bomInfo_clzl' info="fromInfo" name='clzl'
                                       placeholder='材料重量'  class="requiredDecimal" type='text'>
                                <label class="textInfo"></label>
                            </div>

                            <label class='control-label col-sm-2'>材料金额</label>

                            <div class='col-sm-2 controls'>
                                <input class='form-control' id='form_bomInfo_clje' info="fromInfo"
                                       name='clje' placeholder=' ' class="requiredDecimal" type='text'>
                            </div>
                            <div class='col-sm-1 controls '>
                                <span>元</span>
                            </div>

                        </div>
                        <div class='form-group'>
                            <label class='control-label col-sm-2'>备料件数</label>

                            <div class='col-sm-3 controls '>
                                <input class='form-control mustrequiredInteger numkeyboard' id='form_bomInfo_bljs' info="fromInfo" name='bljs'
                                       placeholder='备料件数' type='text'>
                                <label class="textInfo"></label>
                            </div>
                            <label class='control-label col-sm-2'>图纸名称</label>

                            <div class='col-sm-3 controls '>
                                <input class='form-control' id='form_bomInfo_ddtz' info="fromInfo" name='ddtz'
                                       placeholder='图纸名称' readonly type='text'>
                                <input id="form_bom_tz" class="btn btn-primary" type="button" value="图片选择">
                                <label class="textInfo"></label>
                            </div>
                        </div>
                        <div class='modal-footer'>

                            <input id="btn_saveadd" class="btn btn-primary" type="button" value="保存并继续添加">
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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:950px;height:350px;">
        <div class="modal-content" style="height:90%;">
            <div class="modal-header">
                <button id="modalClose" type="button" class="close"
                        data-dismiss="modal" aria-hidden="true" style="margin-top:-10px">
                    &times;
                </button>
            </div>
            <div class="modal-body" id="modal-body">
                <div id="slider" class='box-content'>

                </div>
            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>