/**
 * 基本零件管理类
 */
package com.project.kcgl.action;

import java.util.List;

import com.project.util.*;
import net.sf.json.JSONObject;

import oracle.jdbc.driver.Const;
import org.apache.commons.logging.Log;

import com.project.base.ActionEnum;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.xsgl.action.KhxxManagerAction;

public class JbljAction {
    private static Log log = org.apache.commons.logging.LogFactory.getLog(JbljAction.class);
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
        String sql = "select id,mc,lx,cc,zsl,kcsl,dj,ghs from scglxt_t_lj ";
        List list = null;
        try {
            list = this.selectDataService.queryForList(sql);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        String json = JsonObjectUtil.list2Json(list);
        json = "{\"data\":" + json + "}";
        Response.write(json);
    }


    /**
     * 删除合同信息
     */
    public void deleteRow() {
        String id = Request.getParameter("id");
        String sql = "delete from scglxt_t_lj where id = '" + id + "'";
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
//		String id = "1" ;
        String id = Request.getParameter("id");
        String sql = " select * from scglxt_t_lj where id = '" + id + "' ";
        List list = null;
        String json = null;
        try {
            list = selectDataService.queryForList(sql);
            json = JsonObjectUtil.list2Json(list);
        } catch (Exception e) {
            json = "[]";
            e.printStackTrace();
        }
        Response.write(json);
    }

    /**
     * 保存操作  ，提供新增或者更新update操作
     */
    public void updateInfo() {
        String id = StringUtils.nullStrToEmpty(Request.getParameter("id"));
        String lx = Request.getParameter("lx");
        String mc = Request.getParameter("mc");
        String cc = Request.getParameter("cc");
        String zsl = Request.getParameter("zsl");
        String kcsl = Request.getParameter("kcsl");
        String dj = Request.getParameter("dj");
        String ghs = Request.getParameter("ghs");
        String flag = Request.getParameter("flag");
        String sql = null;
        if (flag != null && flag.equals("ADD")) {
            id = WebUtils.getRandomId();
            sql = " insert scglxt_t_lj (id,lx,mc,cc,zsl,kcsl,dj,ghs) " +
                    "values('"+id+"','"+lx+"','"+mc+"','"+cc+"','"+zsl+"','"+kcsl+"','"+dj+"','"+ghs+"') ";
        } else if (flag.equals("UPDATE")) {
            sql = " update scglxt_t_lj set lx = '"+lx+"' ,mc = '"+mc+"',cc='"+cc+"'," +
                    " zsl = '"+zsl+"', kcsl='"+kcsl+"', dj='"+dj+"',ghs='"+ghs+"' " +
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
