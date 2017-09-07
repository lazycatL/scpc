<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<head>
    <script type="text/javascript" src="../../js/util/commonFun.js"></script>
    <script>
        var flag = getValueOfURLParamter("flag");
        $(document).ready(function () {

            initRyZd();

            if (flag === 'edit') {
                var id = getValueOfURLParamter("id");
                initForm(id);
            }
            $("#rzsj").datepicker({format: 'yyyy-mm-dd hh:ii'});

        });

        function initForm(id) {

            $.ajax({
                type: "post",
                url: "scgl_getRyInfoById.action",
                dataType: "json",
                data: {
                    "id": id
                },
                success: function (dt) {

                    $('#rymc').val((dt[0].rymc));
                    $('#ssbz').val((dt[0].ssbz));
                    $('#dqgz').val((dt[0].dqgz));
                    $('#jsjb').val((dt[0].jsjb));
                    $('#rzsj').val((dt[0].rzsj));
                    $('#rynl').val((dt[0].rynl));

                }
            });
        }

        function saveRyInfo() {

            if (flag === 'edit') {

                var id = getValueOfURLParamter("id");
                $('#formAction').attr('action', 'scgl/scgl_updateRyInfo.action?id=' + id)
            }

            $("#formAction").submit();
            /*if(flag===''){
             //添加
             $.ajax({
             type: "post",
             url: "scgl_addRyInfo.action",
             dataType: "json",
             data:{
             "rymc":$('#rymc').val(),
             "ssbz":$('#ssbz').val(),
             "dqgz":$('#dqgz').val(),
             "jsjb":$('#jsjb').val(),
             "rzjs":$('#rzsj').val(),
             "rynl":$('#rynl').val()
             }

             });
             }else{//修正

             var id = getValueOfURLParamter("id");
             $.ajax({
             type: "post",
             url: "scgl_updateRyInfo.action",
             dataType: "json",
             data:{
             "id" : id,
             "rymc":$('#rymc').val(),
             "ssbz":$('#ssbz').val(),
             "dqgz":$('#dqgz').val(),
             "jsjb":$('#jsjb').val(),
             "rzjs":$('#rzsj').val(),
             "rynl":$('#rynl').val()
             }

             });
             }*/
        }

        function initRyZd() {

            $.ajax({
                type: "post",
                url: "scgl_getRyZdInfo.action",
                dataType: "json",
                data: {
                    "xh": '0201',
                },
                success: function (dt) {

                    for (var i = 0; i < dt.length; i++) {
                        var html = "<option value=" + dt[i].id + ">" + dt[i].mc + "</option>";
                        $("#jsjb").append(html);
                    }

                }
            });
            $.ajax({
                type: "post",
                url: "scgl_getRyBzInfo.action",
                dataType: "json",
                success: function (dt) {

                    for (var i = 0; i < dt.length; i++) {
                        var html = "<option value=" + dt[i].id + ">" + dt[i].bzmc + "</option>";
                        $("#ssbz").append(html);
                    }

                }
            });
        }
    </script>
</head>

<div id='wrapper'>
    <div class="row">
        <div class="col-sm-12">
            <div class="box">
                <div class="box-header blue-background">
                    <div class="title">
                        <div class="icon-edit"></div>
                        人员
                    </div>
                    <div class="actions">
                        <a class="btn box-remove btn-xs btn-link" href="#"><i class="icon-remove"></i>
                        </a>

                        <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                        </a>
                    </div>
                </div>
                <div class="box-content box-no-padding">
                    <form class="form form-horizontal " style="margin-bottom: 0;" method="post"
                          id="formAction" action="scpc/scgl_addRyInfo.action" accept-charset="UTF-8">
                        <input name="authenticity_token" type="hidden">

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="inputText2">姓名</label>

                            <div class="col-md-4">
                                <input class="form-control" name="rymc" id="rymc" placeholder="请输入姓名" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="inputPassword1">班组</label>

                            <div class="col-md-4">
                                <select class='form-control' name="ssbz" id='ssbz'>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="inputTextArea2">技术级别</label>

                            <div class="col-md-4">
                                <select class='form-control' name="jsjb" id='jsjb'>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="dqgz">工资</label>

                            <div class="col-md-4">
                                <input id="dqgz" name="dqgz" class='form-control' data-rule-number='true'
                                       data-rule-required='true' id='validation_numbers' name='validation_numbers'
                                       placeholder='请输入工资' type='text'>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="rynl">年龄</label>

                            <div class="col-md-4">
                                <input id="rynl" name="rynl" class='form-control' data-rule-number='true'
                                       data-rule-required='true' id='validation_numbers' name='validation_numbers'
                                       placeholder='请输入年龄' type='text'>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="rzsj">入职时间</label>
                            <%--<div class="col-md-4">--%>
                            <%--<div class="datepicker input-group">--%>
                            <%--<input class="form-control" name="rzsj" data-format="yyyy-MM-dd" placeholder="请选择入职时间" type="text" id="rzsj">--%>
                            <%--<span class="input-group-addon">--%>
                            <%--<span data-date-icon="icon-calendar" data-time-icon="icon-time" class="icon-calendar"></span>--%>
                            <%--</span>--%>
                            <%--</div>--%>
                            <div class="col-md-4">
                                <input class="form-control" readonly name="rzsj" placeholder="请选择入职时间" type="text"
                                       id="rzsj">

                                <%--<div class="datepicker input-group">--%>
                                <%--<div class="  input-group">--%>
                                <%--<input class="form-control" readonly name="rzsj"   placeholder="请选择入职时间" type="text" id="rzsj">--%>
                                <%--&lt;%&ndash;<span class="input-group-addon">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<span data-date-icon="icon-calendar" data-time-icon="icon-time" class="icon-calendar"></span>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;</span>&ndash;%&gt;--%>
                                <%--</div>--%>
                            </div>
                        </div>
                        <div class="form-actions" style="margin-bottom: 0;">
                            <div class="row">
                                <div class="col-md-4 col-md-offset-3">
                                    <div class="btn btn-primary " onclick="saveRyInfo()">
                                        <i class="icon-save"></i>
                                        保存
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>