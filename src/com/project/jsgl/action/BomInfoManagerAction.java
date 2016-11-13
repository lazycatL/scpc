package com.project.jsgl.action;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.ExcelExportUtil;
import com.project.util.JsonObjectUtil;
import com.project.util.StringUtil;
import com.project.util.WebUtils;
import com.project.xsgl.action.KhxxManagerAction;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.List;
import net.sf.json.JSONObject;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;

public class BomInfoManagerAction
{
  private static Log log = LogFactory.getLog(BomInfoManagerAction.class);
  private SelectDataService selectDataService;
  
  public SelectDataService getSelectDataService()
  {
    return this.selectDataService;
  }
  
  public void setSelectDataService(SelectDataService selectDataService)
  {
    this.selectDataService = selectDataService;
  }
  
  public void getTableData()
  {
    String limitStart = "";
    String limitEnd = "";
    String ssdd = Request.getParameter("ssdd");
    String cggl = Request.getParameter("cggl");
    String zddzt=Request.getParameter("zddzt");
    String sql = "select t.id ,t.zddmc,t2.clmc, t.zddcz,t.clxz,t.cldx,t.cltj,t.clje,t.jgsl,t.bmcl,date_format(starttime,'%Y-%m-%d') starttime, date_format(endtime,'%Y-%m-%d') endtime,gs,blqk,date_format(blkssj,'%Y-%m-%d') blkssj,date_format(bljssj,'%Y-%m-%d') bljssj, clzt, if(clzt='0','未采购','已采购')  clztformat ,cgry,cgsj,ddtz, date_format(rksj,'%Y-%m-%d') rksj,bfjs,bhgjs ,gxnr,zddzt, zd.mc ddztmc  from scglxt_t_bom t,scglxt_t_cl t2 ,scglxt_tyzd zd where t.zddcz = t2.id  AND t.zddzt=zd.id AND zd.xh LIKE '05%'  ";
    if ((ssdd != null) && (!ssdd.equals("")) && (!ssdd.equals("null"))) {
      sql = sql + "and ssdd = '" + ssdd + "'";
    }
    if ((cggl != null) && (cggl.equals("true"))) {
      sql = sql + " ";
    }
      if ((zddzt != null) && (!zddzt.equals(""))) {
          sql = sql + " and zddzt='"+zddzt+"' ";
      }
    sql = sql + " order by id asc ";
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    log.info("执行sql语句是：===="+sql);
    log.info(json);
    Response.write(json);
  }
  
  public void deleteRow()
  {
    String id = Request.getParameter("id");
    String sql = "delete from scglxt_t_bom where id = '" + id + "'";
    try
    {
      this.selectDataService.execute(sql);
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      e.printStackTrace();
      Response.write("ERROR");
    }
  }
  
  public void changeStatusClzt()
  {
    String id = Request.getParameter("id");
    String clzt = Request.getParameter("clzt");
    String sql = "update scglxt_t_bom set clzt ='" + clzt + "' where id = '" + id + "'";
    try
    {
      this.selectDataService.execute(sql);
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      e.printStackTrace();
      Response.write("ERROR");
    }
  }

    /***
     * 更新BOM表备料情况
     * 同时开始第一道工序
     */
  public void updateBlzk()
  {
    String id = Request.getParameter("id");
    String blqk = Request.getParameter("blqk");
    String clzt="0";
      if ((blqk.equals("1")) || (blqk.equals("2")))//如果备料情况是已完成或者自备料则材料状态修改为采购完成
      {
          clzt="1";
      }
    String sql = " update scglxt_t_bom set blqk ='" + blqk + "' ,clzt='"+clzt+"', " +
      " bljssj =  date_format(now(),'%Y-%m-%d %H:%i:%s') ," + 
      " starttime =date_format(now(),'%Y-%m-%d %H:%i:%s')     where id = '" + id + "'";
   // String updateGygcSl = " UPDATE scglxt_t_gygc gygc SET kjgjs= (SELECT bom.jgsl FROM  scglxt_t_bom bom  WHERE  bom.id = gygc.bomid) ,gygc.yjgjs=  (SELECT jgsl FROM  scglxt_t_bom bom WHERE  bom.id = gygc.bomid)WHERE gygc.bomid = '" +
      String updateGygcSl = " UPDATE scglxt_t_gygc gygc SET kjgjs= (SELECT bom.jgsl FROM  scglxt_t_bom bom  WHERE  bom.id = gygc.bomid)  WHERE gygc.bomid = '" +
      id + "' AND gygc.serial = '0'";
    
    //String updateGygcSl2 = " UPDATE scglxt_t_gygc gygc SET kjgjs= (SELECT bom.jgsl FROM  scglxt_t_bom bom  WHERE  bom.id = gygc.bomid) WHERE gygc.bomid = '" +
    
   //   id + "' AND gygc.serial = '1'";
    try
    {
      this.selectDataService.execute(sql);
        log.info("执行sql语句是：===="+sql);
      if ((blqk.equals("1")) || (blqk.equals("2")))
      {
        this.selectDataService.execute(updateGygcSl);
          log.info("执行sql语句是：===="+updateGygcSl);
       // this.selectDataService.execute(updateGygcSl2);
      }
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      e.printStackTrace();
      Response.write("ERROR");
    }
  }
  
  public void getDetailInfo()
  {
    String id = Request.getParameter("id");
    String sql = " select id ,zddmc, zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,date_format(starttime,'%Y-%m-%d %H:%i') starttime, date_format(endtime,'%Y-%m-%d %H:%i') endtime,gs,blqk,date_format(blkssj,'%Y-%m-%d') blkssj,date_format(bljssj,'%Y-%m-%d') bljssj, clzt,cgry,cgsj,ddtz,rksj,bfjs,bhgjs,ssdd from scglxt_t_bom where id = '" +
    
      id + "' ";
    List list = null;
    String json = null;
    try
    {
      list = this.selectDataService.queryForList(sql);
      json = JsonObjectUtil.list2Json(list);
    }
    catch (Exception e)
    {
      json = "[]";
      e.printStackTrace();
    }
    Response.write(json);
  }
  
  public void updateInfo()
    throws ParseException
  {
    String flag = Request.getParameter("flag");
    String sql = null;
    String randomId = WebUtils.getRandomId();
    String zddmc = Request.getParameter("zddmc");
    String zddcz = Request.getParameter("zddcz");
    String clxz = Request.getParameter("clxz");
    String cldx = Request.getParameter("cldx");
    String cltj = Request.getParameter("cltj");
    String clje = Request.getParameter("clje");
    String jgsl = Request.getParameter("jgsl");
    String bmcl = Request.getParameter("bmcl");
    String starttime = Request.getParameter("starttime");
    String endtime = Request.getParameter("endtime");
    String gs = Request.getParameter("gs");
    String ssdd = Request.getParameter("ssdd");
    String ddtz=Request.getParameter("ddtz");
    String id = Request.getParameter("id");
    if ((starttime == null) || ("".equals(starttime))) {
      starttime = "now()";
    }else{
        starttime = "'"+starttime+"'";
    }
    if ((endtime == null) || ("".equals(endtime))) {
      endtime = "now()";
    }
    if ((flag != null) && (flag.equals("ADD"))) {
      sql =
        " INSERT INTO  scglxt_t_bom  (id, zddmc, zddcz, clxz, cldx, cltj, clje, jgsl, bmcl, gs, blqk,  ssdd,zddzt,ddtz)  VALUES ('" + randomId + "','" + zddmc + "', '" + zddcz + "', '" + clxz + "', '" + cldx + "', '" + cltj + "', '" + clje + "', '" + jgsl + "', '" + bmcl + "', '" + gs + "', '',   '" + ssdd + "','0501','"+ddtz+"');";
    } else if (flag.equals("UPDATE")) {
      sql =

        "update scglxt_t_bom  set zddmc = '" + zddmc + "', zddcz = '" + zddcz + "' , clxz = '" + clxz + "' , cldx = '" + cldx + "' ,cltj ='" + cltj + "' , clje ='" + clje + "' ,bmcl='" + bmcl + "'," + "gs='" + gs + "',ddtz='"+ddtz+"' " + "where  id = '" + id + "'";
    }
    try
    {
      this.selectDataService.execute(sql);
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      Response.write("ERROR");
      e.printStackTrace();
    }
  }
  
  public void getGxbpData()
  {
    String limitStart = "";
    String limitEnd = "";
    String sql = " ";
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    Response.write(json);
  }
  
  public void getGygcData()
  {
    String sql = "select t2.bomid , t2.gyid ,t2.id , t2.gynr,t2.edgs,t2.stsj,t2.jhwcsj,t2.sjwcsj , t2.jyryid , t1.zddmc, t3.gymc  from scglxt_t_bom t1 ,  scglxt_t_gygc  t2 , scglxt_t_jggy  t3  where t1.id = t2.bomid  and t2.gyid = t3.id ;  ";
    
    List list = this.selectDataService.queryForList(sql);
    if (list.size() >= 0)
    {
      String json = JsonObjectUtil.list2Json(list);
      json = "{\"data\":" + json + "}";
      Response.write(json);
    }
    else
    {
      Response.write("");
    }
  }
  
  public void saveGxbpData()
  {
    String sbid = Request.getParameter("sbid");
    String json = Request.getParameter("JSON");
    JSONObject JSON = JSONObject.fromObject(json);
    
    String bomid = JSON.getString("bomid");
    String sysb = JSON.getString("sysb");
    String sysbText = JSON.getString("sysbText");
    String gxnr = JSON.getString("gxnr");
    String gxnrText = JSON.getString("gxnrText");
    String edgs = JSON.getString("edgs");
    String stsj = JSON.getString("stsj");
    String serial = JSON.getString("serial");
    String zysx = JSON.getString("zysx");
    String id = WebUtils.getRandomId();
    String sql = "insert into scglxt_t_gygc (bomid,id,sbid,gynr,edgs,serial,zysx) values ('" + 
      bomid + "','" + id + "','" + sysb + "','" + gxnr + "','" + edgs + "','" + serial + "','" + zysx + "') ";
    try
    {
      log.info(sql);
      this.selectDataService.execute(sql);
      updateBomGynrByGxbp(bomid);
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
   //修改时间和状态
  public void  updateTime()
  {
      String id = Request.getParameter("id");
      String starttime = Request.getParameter("starttime");
      String endtime = Request.getParameter("endtime");
      String zddzt="0502";


      List list = null;
      String gygcSql = "select starttime  from scglxt_t_bom where id = '" + id + "' ";
      list = this.selectDataService.queryForList(gygcSql);
      if (list.size() > 0) {
         ListOrderedMap lod=(ListOrderedMap)list.get(0);
         if(!lod.get(0).toString().equals(""))
         {
             zddzt="0503";
         }
      }
      try
      {
          String sql = " update scglxt_t_bom set zddzt ='"+zddzt+"' , " +
                  " starttime =  date_format('"+starttime+"','%Y-%m-%d %H:%i:%s') ," +
                  " endtime =date_format('"+endtime+"','%Y-%m-%d %H:%i:%s')   where id = '" + id + "'";
          if(endtime.equals(""))
          {
              sql = " update scglxt_t_bom set zddzt ='"+zddzt+"' , " +
                      " starttime =  date_format('"+starttime+"','%Y-%m-%d %H:%i:%s') " +
                      "   where id = '" + id + "'";
          }
          this.selectDataService.execute(sql);
          log.info("执行sql语句是：===="+sql);
          Response.write("SUCCESS");
      }
      catch (Exception e)
      {
          e.printStackTrace();
          Response.write("ERROR");
      }
  }
  public void updateGxbpData()
  {
    String sbid = Request.getParameter("sbid");
    String json = Request.getParameter("JSON");
    JSONObject JSON = JSONObject.fromObject(json);
    
    String id = JSON.getString("id");
    String bomid = JSON.getString("bomid");
    String sysb = JSON.getString("sysb");
    String sysbText = JSON.getString("sysbText");
    String gxnr = JSON.getString("gxnr");
    String gxnrText = JSON.getString("gxnrText");
    String edgs = JSON.getString("edgs");
    String stsj = JSON.getString("stsj");
    String serial = JSON.getString("serial");
    String zysx = JSON.getString("zysx");
    
    String sql = "update scglxt_t_gygc  set sbid = '" + sbid + "' ,gynr = '" + gxnr + "' ,edgs = '" + edgs + "' ," + 
      " serial = '" + serial + "' , zysx = '" + zysx + "'" + 
      " where id = '" + id + "'";
    try
    {
      log.info(sql);
      this.selectDataService.execute(sql);
      updateBomGynrByGxbp(bomid);
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
  
  public void deleteGxbpData()
  {
    String bomid = Request.getParameter("bomid");
    if ((bomid == null) || (bomid.equals(""))) {
      return;
    }
    String sql = "delete from scglxt_t_gygc where bomid = '" + bomid + "'";
    try
    {
      this.selectDataService.execute(sql);
    }
    catch (Exception localException) {}
  }
  
  public void deleteGygcById()
  {
    String id = Request.getParameter("bomid");
  }
  
  public void updateStrattime()
  {
    String sql = "update scglxt_t_gygc set starttime = curtime()";
    try
    {
      this.selectDataService.execute(sql);
      Response.write("success");
    }
    catch (Exception e)
    {
      Response.write("error");
    }
  }
  
  public void updateEndtime()
  {
    String sql = "update scglxt_t_gygc set endtime = curtime()";
    try
    {
      this.selectDataService.execute(sql);
    }
    catch (Exception localException) {}
  }
  
  public void updateBomGynrByGxbp(String bomid)
  {
    if ((bomid == null) || (bomid.equals(""))) {
      return;
    }
    List list = null;
    String gygcSql = "select t.id ,t2.gymc gynr ,t.edgs from scglxt_t_gygc  t ,scglxt_t_jggy t2  where  t.gynr = t2.id  and bomid = '" + 
      bomid + "'  order by serial ";
    String gynr = "";
    String sql = "";
    try
    {
      list = this.selectDataService.queryForList(gygcSql);
      if (list.size() > 0)
      {
        for (int i = 0; i < list.size(); i++)
        {
          ListOrderedMap lom = (ListOrderedMap)list.get(i);
          gynr = gynr + lom.get("gynr").toString() + "(" + lom.get("edgs").toString() + ")-";
        }
        gynr = gynr.substring(0, gynr.length() - 1);
      }
      sql = "update  scglxt_t_bom set gxnr =  '" + gynr + "' where id = '" + bomid + "'";
      this.selectDataService.execute(sql);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
  
  public int getBomInfoByBomid(String bomid)
  {
    List list = null;
    int jgsl = 0;
    String sql = "select jgsl from scglxt_t_bom where id = '" + bomid + "'";
    try
    {
      list = this.selectDataService.queryForList(sql);
      jgsl = Integer.valueOf(list.get(0).toString()).intValue();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return jgsl;
  }
  
  public void getJggyData()
  {
    String sql = "select sb.id  , sbmc name   from scglxt_t_sb sb, scglxt_t_jggy jg  WHERE sb.BZID = jg.fzbz ";
    String id= Request.getParameter("gyid");
      if(!id.equals("0"))
      {
          sql+=" AND jg.`id`='"+id+"'  ORDER BY sbmc ";
      }else{
          sql+="  ORDER BY sbmc ";
      }
    String json = null;
     System.out.println(sql);
    List list = this.selectDataService.queryForList(sql);
    if (list.size() >= 0)
    {
      json = JsonObjectUtil.list2Json(list);
      
      Response.write(json);
    }
    else
    {
      Response.write("error");
    }
  }
  
  public void getGxnrData()
  {
    String sql = " select  id , gymc name ,gydh,fzbz ,sfwx from  scglxt_t_jggy ";
    String json = null;
    List list = this.selectDataService.queryForList(sql);
    if (list.size() >= 0)
    {
      json = JsonObjectUtil.list2Json(list);
      Response.write(json);
    }
    else
    {
      Response.write("error");
    }
  }
  
  public void calculateTimeLength()
  {
    String ssdd = Request.getParameter("ssdd");
    String sql = "select t2.bomid, sum(t1.jgsl*t2.edgs) timelength,t2.gynr from scglxt_t_bom t1 ,scglxt_t_gygc t2 where t2.bomid = t1.id and  t1.ssdd  =   " + ssdd + 
      " group by t2.gynr";
    String json = null;
    List list = this.selectDataService.queryForList(sql);
    if (list.size() >= 0)
    {
      json = JsonObjectUtil.list2Json(list);
      Response.write(json);
    }
    else
    {
      Response.write("error");
    }
  }
  
  public void loadBomGybpList()
  {
    String bomid = Request.getParameter("bomid");
    String sql = "";
    String sbid = Request.getParameter("sbid");
    if (StringUtil.returnNotEmpty(sbid) != null) {
      sql = "select bomid ,sbid,gyid ,id ,gynr  ,edgs,serial ,zysx    from   scglxt_t_gygc where sbid = '" + sbid + "'  order by serial asc ";
    } else {
      sql = "select bomid ,sbid,gyid ,id ,gynr  ,edgs,serial ,zysx    from   scglxt_t_gygc where bomid = '" + bomid + "'  order by serial asc ";
    }
    String json = null;
    List list = this.selectDataService.queryForList(sql);
    if (list.size() >= 0)
    {
      json = JsonObjectUtil.list2Json(list);
      Response.write(json);
    }
    else
    {
      Response.write("error");
    }
  }
  
  public void loadSsddList()
  {
    String sql = "select id , xmname mc  from  scglxt_t_dd ";
    List list = this.selectDataService.queryForList(sql);
    String json = null;
    if (list.size() >= 0)
    {
      json = JsonObjectUtil.list2Json(list);
      Response.write(json);
    }
    else
    {
      Response.write("error");
    }
  }
  
  public void loadClInfoJson()
  {
    String sql = "select  id ,clmc ,clsl ,clcz ,cldj,cllx , mi, clxz,kd,gd,cd,clly  from  scglxt_t_cl ";
    List list = this.selectDataService.queryForList(sql);
    String json = null;
    if (list.size() >= 0)
    {
      json = JsonObjectUtil.list2Json(list);
      Response.write(json);
    }
    else
    {
      Response.write("error");
    }
  }

    /***
     * 根据BOMID和子订单状态参数修改该条BOM的子订单状态
     */
    public void updateZddzt()
    {
        String id=Request.getParameter("id");
        String zddzt=Request.getParameter("zddzt");
        String sjzd=Request.getParameter("date");

        String sql = "update scglxt_t_bom set zddzt = '"+zddzt+"',set "+sjzd+"=now() where id='"+id+"'";
        try
        {
            this.selectDataService.execute(sql);
            Response.write("success");
        }
        catch (Exception e)
        {
            Response.write("error");
        }
    }
    /***
     * 导出
     */
    public void exportData()
    {
        HttpServletResponse response= ServletActionContext.getResponse();
        String excelName = "BOM信息表";
        //转码防止乱码
        response.addHeader("Content-Disposition", "attachment;filename="+excelName+".xls");

        String[] headers = new String[]{"子订单名称","子订单材质","工序内容","加工数量","材料形状","材料大小","材料体积","材料金额","表面处理"};
        try {
            String sql="SELECT zddmc,t2.clmc, gxnr,jgsl, IF(bom.clxz='1','长方体','圆柱体')  clxz ,cldx,cltj,clje,bmcl FROM scglxt_t_bom bom LEFT JOIN scglxt_t_cl t2 ON  bom.zddcz = t2.id  ";
            List list = this.selectDataService.queryForList(sql);
            OutputStream out = response.getOutputStream();
            ExcelExportUtil.exportExcel(excelName,headers,list, out,"yyyy-MM-dd");
            out.close();
            System.out.println("excel导出成功！");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
