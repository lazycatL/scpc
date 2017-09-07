package com.project.xsgl.action;

import java.text.NumberFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.opensymphony.xwork2.ActionContext;
import com.project.util.Constants;
import com.project.util.StringUtil;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.struts2.ServletActionContext;

import com.project.base.ActionEnum;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.WebUtils;

/**
 * 合同管理类
 *
 * @author apple
 */
public class HtInfoManagerAction {
    private static Log log = org.apache.commons.logging.LogFactory.getLog(KhxxManagerAction.class);
    private SelectDataService selectDataService;

    public SelectDataService getSelectDataService() {
        return selectDataService;
    }

    public void setSelectDataService(SelectDataService selectDataService) {
        this.selectDataService = selectDataService;
    }

    /**
     * 获取合同信息数据
     *
     * @response : json
     */
    public void getTableData() {
        String khid = Request.getParameter("khid");
        String id = Request.getParameter("id");
        String sql = "select t1.id ,t1.htbh , t4.mc ywlx ,t1.htje,date_format(qssj,'%Y-%m-%d') qssj,date_format(jssj,'%Y-%m-%d') jssj,t5.mc fkzt, t3.mc fkztmc,t1.jkbfb,jkje,jscb,t1.hkzh,t1.hkkhh,t1.remark ,t1.htmx, t2.id khid,t2.mc khmc from scglxt_t_ht  t1 left join scglxt_t_kh t2 on t1.khid = t2.id  left join  scglxt_tyzd t3 on t1.fkzt= t3.id left join scglxt_tyzd t4 on t4.id = t1.ywlx left join scglxt_tyzd t5 on t5.id = t1.fkzt  where 1=1 ";
        if (khid != null && !khid.equals("")) {
            sql += " and  t1.khid = '" + khid + "'";
        }else if(id != null  &&  !id.equals("")){
            sql +=" and t1.id = '"+id+"' " ;
        }
        sql+=" ORDER BY id DESC";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        json = "{\"data\":" + json + "}";
        log.info("获取数据列表的sql==="+sql);
        Response.write(json);
    }

    public void getTableDataTest() {
        String limitStart = "";
        String limitEnd = "";
        String sql = "select id ,ssht, xmname , ddlevel,date_format(jhdate,'%Y-%m-%d') jhdate ,date_format(planstarttime,'%Y-%m-%d') planstarttime," +
                " date_format(planendtime,'%Y-%m-%d') planendtime,date_format(realstarttime,'%Y-%m-%d') realstarttime,date_format(realendtime,'%Y-%m-%d') realendtime, " +
                " zgs,tz,remark,xmlxr,xmfzr,ckzt,date_format(ckdate,'%Y-%m-%d') ckdate from xsgl_ddgl_info  ";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        json = "{\"data\":" + json + "}";
        Response.write(json);
    }

    /**
     * 增加客户信息
     */
    public void addUserInfo() {
        String JSON = Request.getParameter("JSON");
        String id = WebUtils.getRandomId();
        JSONObject json = JSONObject.fromObject(JSON);
        String mc = json.getString("mc");
        String lx = json.getString("lx");
        String dw = json.getString("dw");
        String gx = json.getString("gx");
        String iscj = json.getString("iscj");
        String remark = json.getString("remark");
        String msg = null;
        String sql = "insert into scglxt_t_kh(id,mc,lx,dw,dz,gx,iscj,remark) values(" + id + ",'1','1','1','1','1','1','1')";
        try {
            selectDataService.execute(sql);
            //	msg = ActionEnum.SUCCESS.toString();
            msg = "SUCCESS";
            log.info("insert " + sql);
        } catch (Exception e) {
            msg = "ERROR";
            log.info("错误的sql " + sql);
            e.printStackTrace();
        }
        Response.write(msg);
    }

    /**
     * 删除合同信息
     */
    public void deleteRow() {
        String id = Request.getParameter("id");
        String sql = "delete from scglxt_t_ht where id = '" + id + "'";
        try {

            //删除订单下所有BOM下所有工艺加工情况
            String deljgglSql="delete from scglxt_t_jggl where gygcid in (select id from scglxt_t_gygc where bomid in (select id from scglxt_t_bom where ssdd in (select id from scglxt_t_dd where ssht='"+id+"')))";
            selectDataService.execute(deljgglSql);

            //删除订单下所有BOM下所有工艺
            String delGygxSql="delete from scglxt_t_gygc where bomid in (select id from scglxt_t_bom where ssdd in (select id from scglxt_t_dd where ssht='"+id+"'))";
            selectDataService.execute(delGygxSql);


            //删除订单下所有BOM
            String delBomSql="delete from scglxt_t_bom where ssdd in  (select id from scglxt_t_dd where ssht='"+id+"')";
            selectDataService.execute(delBomSql);

            //删除该合同下的所有订单
            String delDdSql="delete from scglxt_t_dd where ssht='"+id+"'";
            selectDataService.execute(delDdSql);


            selectDataService.execute(sql);
            Response.write("SUCCESS");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            Response.write("ERROR");
        }

    }

    /**
     * 获取合同信息
     */
    public void getDetailInfo() {
        String id = Request.getParameter("id");
        String sql = " select id ,htbh , ywlx ,htje,date_format(qssj,'%Y-%m-%d')  qssj,date_format(jssj,'%Y-%m-%d')  jssj," +
                "fkzt,jkbfb,jkje,jscb,hkzh,hkkhh,htmx,khid,htjc,jgsl,dj,remark,CONCAT(htjc,'-',LPAD((SELECT  (RIGHT(xmname, 5) + 1)  FROM  scglxt_t_dd  ORDER BY id DESC   LIMIT 1),5,'0')) xmname from scglxt_t_ht where id = '" + id + "'";
        List list = null;
        String json = null;
        try {
            list = selectDataService.queryForList(sql);
            json = JsonObjectUtil.list2Json(list);
        } catch (Exception e) {
            json = "[]";
            e.printStackTrace();
        }
        log.info("获取合同信息info:============"+sql);
        Response.write(json);
    }

    /**
     * 加载业务类型列表
     */
    public void loadYwlxList() {
        String sql = "select  id ,mc  from scglxt_tyzd where id like '31_%' order by mc ";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        Response.write(json);
    }
    /**
    * 加载结款状态
    */
   public void loadFkztList() {
       String sql = "select  id ,mc  from scglxt_tyzd where id like '32_%' order by mc ";
       List list = this.selectDataService.queryForList(sql);
       String json = JsonObjectUtil.list2Json(list);
       Response.write(json);
   }
    /**
     * 加载客户信息
     */
    public void loadKhxxList() {
        String sql = "select  id ,mc  from scglxt_t_kh order by mc ";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        Response.write(json);
    }
    /**
     * 保存操作  ，提供新增或者更新update操作
     */
    public void updateInfo() {
        String json = Request.getParameter("JSON");
        JSONObject JSON = JSONObject.fromObject(json);

        String htbh = JSON.getString("htbh");
        String ywlx = JSON.getString("ywlx");
        String htje = JSON.getString("htje");
        String qssj = JSON.getString("qssj");
        String jssj = JSON.getString("jssj");
        String fkzt = JSON.getString("fkzt");
        String jkbfb = JSON.getString("jkbfb");

        String htjc = JSON.getString("htjc")==null?"":JSON.getString("htjc");

        String jkje = StringUtil.returnNotEmpty(JSON.getString("jkje"));
//        if(jkje != null  && htje != null ){
//        	 NumberFormat numberFormat = NumberFormat.getNumberInstance();
//             numberFormat.setMaximumFractionDigits(2);
//            jkbfb = String.valueOf(numberFormat.format(((double)Long.parseLong(jkje)/Long.parseLong(htje))*100));
//        }

        String jscb = JSON.getString("jscb");
        if(null==jscb||"".equals(jscb)){
        	
        	jscb = "0";
        }
        String hkzh = JSON.getString("hkzh");
        String hkkhh = JSON.getString("hkkhh");
        String remark = JSON.getString("remark");
        String htmx = JSON.getString("htmx") ;
        String khid=JSON.getString("khid");
        String flag = JSON.getString("flag");
        String sql = null;
        String id = null;
        String czr= ActionContext.getContext().getSession().get("userid").toString();

        if (flag != null && flag.equals("ADD")) {
            id = WebUtils.getRandomId();
            sql = " insert into scglxt_t_ht (`id`, `htbh`, `ywlx`, `htje`, `qssj`, `jssj`, `fkzt`, `jkbfb`, `jkje`, `jscb`, `hkzh`, `hkkhh`,`remark`,`htmx`,`khid`,htjc,sjcjry) VALUES ('" + id + "',  '" + htbh + "', '" + ywlx + "', '" + htje + "',  DATE_FORMAT( '"+qssj+"', '%Y-%m-%d') ,DATE_FORMAT( '"+jssj+"', '%Y-%m-%d') ,  '" + fkzt + "', '" + jkbfb + "',  '" + jkje + "', '" + jscb + "','" + hkzh + "','" + hkkhh + "','" + remark + "' ,'"+htmx+"','"+khid+"','"+htjc+"','"+czr+"');";

        } else if (flag.equals("UPDATE")) {
            id = JSON.getString("id");

            sql = " update scglxt_t_ht set khid = '" + khid + "' , htbh = '" + htbh + "', ywlx = '" + ywlx + "' , htje = '" + htje + "',qssj = DATE_FORMAT('" + qssj + "','%Y-%m-%d'),jssj = DATE_FORMAT('"+jssj+"','%Y-%m-%d'), " +
                    "fkzt = '" + fkzt + "' , jkbfb='" + jkbfb + "' ,jkje='" + jkje + "',hkzh='" + hkzh + "' , hkkhh='" + hkkhh + "', remark='" + remark + "' ,htmx = '"+htmx+"', " +
                    "htjc='"+htjc+"'"+
                    "WHERE id = '" + id + "'";
            
        }
        try {
            selectDataService.execute(sql);
            if (flag != null && flag.equals("ADD")) {//如果是新增合同，则直接增加订单信息
                String nid = WebUtils.getRandomId();

                sql = "INSERT INTO scglxt_t_dd (id, ssht, xmname,ddlevel,starttime,endtime,tz,xmlxr,xmfzr,sjcjry)" +
                        " SELECT '"+nid+"' id,'"+id+"' ssht,CONCAT(htjc,'-',LPAD((SELECT  (RIGHT(xmname,5) + 1)  FROM scglxt_t_dd  ORDER BY id DESC  LIMIT 1),5,'0')) xmname,'0403' ddlevel,qssj,jssj,'"+nid+"','李勇' xmlxr,'李勇' xmfzr,sjcjry FROM scglxt_t_ht WHERE id='"+id+"'";
                selectDataService.execute(sql);
            }
            Response.write(Constants.UPDATE_SUCCESS);
        } catch (Exception e) {
            selectDataService.execute("Delete from scglxt_t_ht where id='"+id+"'");
            Response.write(Constants.UPDATE_ERROR);
            e.printStackTrace();
        }
    }


}
