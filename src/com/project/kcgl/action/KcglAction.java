package com.project.kcgl.action;

import java.util.List;

import com.project.util.Constants;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;

import com.project.base.ActionEnum;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.WebUtils;
import com.project.xsgl.action.KhxxManagerAction;

public class KcglAction {
    private static Log log = org.apache.commons.logging.LogFactory.getLog(KcglAction.class);
    private SelectDataService selectDataService;

    public SelectDataService getSelectDataService() {
        return selectDataService;
    }

    public void setSelectDataService(SelectDataService selectDataService) {
        this.selectDataService = selectDataService;
    }

    /**
     * 生产材料管理
     *
     * @response : json
     */
    public void getTableData() {
        String limitStart = "";
        String limitEnd = "";
        String sql = "select id, clmc,clcz,clsl,cldj,cllx,ghs,mi,clxz,kd,gd,cd,clly from scglxt_t_cl ";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        json = "{\"data\":" + json + "}";
        Response.write(json);
    }


    public void deleteRow() {
        String id = Request.getParameter("id");
        String sql = "delete from scglxt_t_cl where id = '" + id + "'";
        try {
            selectDataService.execute(sql);
            Response.write(Constants.UPDATE_SUCCESS);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            Response.write("ERROR");
        }

    }

    /**
     * 获取客户信息
     */
    public void getDetailInfo() {
        String id = com.project.util.Request.getParameter("id");
        String sql = "  select * from scglxt_t_cl where id = '" + id + "' ";
        List list = null;
        String json = null;
        try {
            list = selectDataService.queryForList(sql);
            json = JsonObjectUtil.list2Json(list);
        } catch (Exception e) {
            json = "[]";
            e.printStackTrace();
        }
        log.info("获取材料信息sql===="+sql);
        Response.write(json);
    }

    /**
     * 保存操作  ，提供新增或者更新update操作
     */
    public void updateInfo() {
//
        String clmc = Request.getParameter("clmc");
        String clcz = Request.getParameter("clcz");
        String clsl = Request.getParameter("clsl");
        if(null==clsl||clsl.equals("")){
        	clsl = "0";
        }
        String cldj = Request.getParameter("cldj");
        String cllx = Request.getParameter("cllx");
        String ghs = Request.getParameter("ghs");
        String mi = Request.getParameter("mi");
        String clxz = Request.getParameter("clxz");
        String kd = Request.getParameter("kd");
        String gd = Request.getParameter("gd");
        String cd = Request.getParameter("cd");
        String clly = Request.getParameter("clly");
        String flag = Request.getParameter("flag");
        String id = Request.getParameter("id");

        if (null == id||"".equals(id)) {
            id = WebUtils.getRandomId();
        }
        if (null == kd||"".equals(kd)) {
            kd = "0";
        }
        if (null == gd||"".equals(gd)) {
            gd = "0";
        }
        if (null == cd||"".equals(cd)) {
            cd = "0";
        }
        String sql = null;
        if (flag != null && flag.equals("ADD")) {
            sql = "  insert into scglxt_t_cl(id,clmc,clcz,clsl,cldj,cllx,ghs,mi,clxz,kd,gd,cd,clly ) values"+
            " ('"+id+"','"+clmc+"','"+clcz+"','"+clsl+"','"+cldj+"','"+cllx+"','"+ghs+"','"+mi+"','"+clxz+"'," +
                    " '"+kd+"','"+gd+"','"+cd+"','"+clly+"')";
        } else if (flag.equals("UPDATE")) {
            sql = " update scglxt_t_cl set clmc = '"+clmc+"' ,clcz = '"+clcz+"' ,clsl = '"+clsl+"' ," +
                    " cldj = '"+cldj+"',cllx = '"+cllx+"' ,ghs='"+ghs+"' ,mi='"+mi+"' ,clxz='"+clxz+"' ," +
                    " cd = '"+cd+"',kd='"+kd+"',gd='"+gd+"' , clly='"+clly+"'  " +
                    "where id = '" + id + "' ";
        }
        try {
            selectDataService.execute(sql);
            Response.write(Constants.UPDATE_SUCCESS);
        } catch (Exception e) {
            Response.write(Constants.UPDATE_ERROR);
            e.printStackTrace();
        }
    }

    /**
     * 工序编排数据
     * 根据一个自订单id查询此bom的工序编排数据
     */
    public void getGxbpData() {
        String limitStart = "";
        String limitEnd = "";
        String sql = " ";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        json = "{\"data\":" + json + "}";
        Response.write(json);
    }

    /**
     * 获取一个bom的工艺过程数据
     */
    public void getGygcData() {
        String json;
        String sql = "select t2.bomid , t2.gyid ,t2.id , t2.gynr,t2.edgs,t2.stsj,t2.jhwcsj,t2.sjwcsj , t2.jyryid , t1.zddmc, t3.gymc " +
                " from scglxt_t_bom t1 ,  scglxt_t_gygc  t2 , scglxt_t_jggy  t3 " +
                " where t1.id = t2.bomid  and t2.gyid = t3.id ;  ";
        List list = this.selectDataService.queryForList(sql);
        if (list.size() >= 0) {
            json = JsonObjectUtil.list2Json(list);
            json = "{\"data\":" + json + "}";
            Response.write(json);
        } else {
            Response.write("");
        }
    }

    /**
     * 保存子订单的工序编排
     */
    public void saveGxbpData() {
        String json = Request.getParameter("JSON");
        JSONObject JSON = JSONObject.fromObject(json);
        String bomid = JSON.getString("bomid");
        String sysb = JSON.getString("sysb");
        String gxnr = JSON.getString("gxnr");
        String edgs = JSON.getString("edgs");
        String stsj = JSON.getString("stsj");
        String serial = JSON.getString("serial");
        String id = WebUtils.getRandomId();
        String sql = "insert into scglxt_t_gygc (bomid,id,sbid,gynr,edgs,stsj,serial) values ('" + bomid + "','" + id + "','" + sysb + "','" + gxnr + "','" + edgs + "','" + stsj + "','" + serial + "') ";
        try {
            this.selectDataService.execute(sql);
        } catch (Exception e) {
        }
    }

    /**
     * 加在加工工艺json数据列表
     */
    public void getJggyData() {
        String sql = "select id ,gymc name from scglxt_t_jggy ";
        String json = null;
        List list = this.selectDataService.queryForList(sql);
        if (list.size() >= 0) {
            json = JsonObjectUtil.list2Json(list);
//			json = "{\"data\":"+json+"}";
            Response.write(json);
        } else {
            Response.write("error");
        }

    }

    /**
     * 查询相应bomid 的工艺过程排序
     */
    public void loadBomGybpList() {
        String bomid = Request.getParameter("bomid");
        String sql = " select bomid ,gyid ,id ,gynr  ,edgs,serial    from   scglxt_t_gygc where bomid = '" + bomid + "'  order by serial asc ";
        String json = null;
        List list = this.selectDataService.queryForList(sql);
        if (list.size() >= 0) {
            json = JsonObjectUtil.list2Json(list);
            Response.write(json);
        } else {
            Response.write("error");
        }
    }
}
