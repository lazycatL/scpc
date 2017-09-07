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
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
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
      String kcgl = Request.getParameter("kcgl");
    String zddzt=Request.getParameter("zddzt");
    String sql = "select t.id ,dd.xmname ddmc,t.zddmc,t2.clmc, t.zddcz,t.zddjb,IF(t.clxz = '1','长方体','圆柱体') clxz,t.cldx,t.cltj,t.clje,t.jgsl,t.bmcl,Abs(t.bljs) bljs,gs, clzt, if(clzt='0','未采购','已采购')  clztformat ,cgry,cgsj,ddtz,tz.tzlx,tz.url tzurl,date_format(rksj,'%Y-%m-%d') rksj,"
        +"(SELECT SUM(bfjs) FROM scglxt_t_gygc gc WHERE t.id=gc.bomid) bfjs,bhgjs ,fun_dqgygc1(t.id) bomjd,date_format(t.starttime,'%Y-%m-%d') starttime,date_format(t.endtime,'%Y-%m-%d') endtime,date_format(dd.endtime,'%Y-%m-%d') ddendtime,gxnr,zddzt, zd.mc ddztmc,zd2.mc zddjbmc,zd2.BZ zddcolor  from scglxt_t_bom t  LEFT JOIN scglxt_t_dd_tz tz ON  t.ddtz=tz.tzmc LEFT JOIN  scglxt_t_cl t2 ON t.zddcz = t2.id ,scglxt_tyzd zd,scglxt_tyzd zd2,scglxt_t_dd dd where t.`SSDD`=dd.`id`  AND t.zddzt=zd.id AND t.zddjb = zd2.ID AND zd.xh LIKE '05%'  ";
    if ((ssdd != null) && (!ssdd.equals("")) && (!ssdd.equals("null"))) {
      sql = sql + "and t.ssdd = '" + ssdd + "'";
        sql = sql + " order by id ";
    }
    if ((cggl != null) && (cggl.equals("true"))) {
      sql = sql + " AND t.clzt='0'  and t.cldx IS NOT NULL ";
        sql = sql + " order by ddendtime,zddjb,zddzt,dd.xmname asc ";
    }
      if ((kcgl != null) && (kcgl.equals("true"))) {
          sql = sql + " AND (t.clzt IS NULL OR t.`clzt`=0 OR t.clzt='2') and t.bljs!='' ";
          sql = sql + " order by ddendtime,zddjb,zddzt,dd.xmname asc ";
      }
      if ((zddzt != null) && (!zddzt.equals(""))) {
          sql = sql + " and t.zddzt='"+zddzt+"' ";
          sql = sql + " order by ddendtime,zddjb,zddzt asc ";
      }

    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    //log.info("执行sql语句是：===="+sql);
   // log.info(json);
    Response.write(json);
  }

    /***
     * 删除BOM时，将BOM下的所有工序都删除
     */
  public void deleteRow()
  {
    String id = Request.getParameter("id");
    String sql = "delete from scglxt_t_bom where id = '" + id + "'";
    try
    {


       String jggxsql = "delete from scglxt_t_jggl where gygcid in (select id from scglxt_t_gygc where bomid = '" + id + "')";
       this.selectDataService.execute(jggxsql);

        String gygxsql = "delete from scglxt_t_gygc where bomid = '" + id + "'";
        this.selectDataService.execute(gygxsql);
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
        String updateGygcSl = " UPDATE scglxt_t_gygc gygc SET kjgjs= (SELECT bom.jgsl FROM  scglxt_t_bom bom  WHERE  bom.id = gygc.bomid)  WHERE gygc.bomid = '" +
                id + "' AND gygc.serial = '0'";
        this.selectDataService.execute(updateGygcSl);
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
          clzt=blqk;
      }
    String sql = " update scglxt_t_bom set clzt='"+clzt+"', " +
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
    String sql = " select id ,zddmc, zddcz,zddjb,clxz,cldx,cltj,clje,jgsl,bmcl,date_format(starttime,'%Y-%m-%d %H:%i') starttime, date_format(endtime,'%Y-%m-%d %H:%i') endtime,gs,date_format(blkssj,'%Y-%m-%d') blkssj,date_format(bljssj,'%Y-%m-%d') bljssj, clzt,cgry,cgsj,ddtz,rksj,bfjs,bhgjs,ssdd,bljs," +
            "  clzl from scglxt_t_bom where id = '" +
    
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
    String zddjb = "0603";
    String clxz = Request.getParameter("clxz");
    String cldx = Request.getParameter("cldx");
    String cltj = Request.getParameter("cltj");
    String clje = Request.getParameter("clje");
      String bljs=Request.getParameter("bljs");
      String blzt=Request.getParameter("blzt")==null?"":Request.getParameter("blzt");
      String clzl=Request.getParameter("clzl");
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
        " INSERT INTO  scglxt_t_bom  (id, zddmc, zddcz,zddjb, clxz, cldx, cltj,clje, jgsl, bmcl, gs,  ssdd,zddzt,ddtz,clzl,bljs,clzt)  VALUES ('" + randomId + "','" + zddmc + "', '" + zddcz + "', '" + zddjb + "', '" + clxz + "', '" + cldx + "', '" + cltj + "', '" + clje + "', '" + jgsl + "', '" + bmcl + "', '" + gs + "','" + ssdd + "','0501','"+ddtz+"','"+clzl+"','"+bljs+"','"+blzt+"');";
    } else if (flag.equals("UPDATE")) {
      sql = "update scglxt_t_bom  set ssdd='"+ssdd+"',clzt='"+blzt+"',jgsl='"+jgsl+"',zddmc = '" + zddmc + "', zddcz = '" + zddcz + "', clxz = '" + clxz + "' , cldx = '" + cldx + "' ,cltj ='" + cltj + "' , clje ='" + clje + "' ,bmcl='" + bmcl + "'," + "gs='" + gs + "',ddtz='"+ddtz+"',clzl='"+clzl+"',bljs='"+bljs+"' " + "where  id = '" + id + "'";
    }else if (flag.equals("COPY"))//复制BOM同时将该BOM下所有工艺复制
    {
        sql =" INSERT INTO  scglxt_t_bom  (id, zddmc, zddcz,zddjb, clxz, cldx, cltj, clje, jgsl, bmcl, gs,  ssdd,zddzt,ddtz,clzl,bljs)  VALUES ('" + randomId + "','" + zddmc + "', '" + zddcz + "', '" + zddjb + "', '" + clxz + "', '" + cldx + "', '" + cltj + "', '" + clje + "', '" + jgsl + "', '" + bmcl + "', '" + gs + "','" + ssdd + "','0501','"+ddtz+"','"+clzl+"','"+bljs+"');";
    }else{
        sql = "update scglxt_t_bom  set ssdd='"+ssdd+"',clzt='"+blzt+"',jgsl='"+jgsl+"',zddmc = '" + zddmc + "', zddcz = '" + zddcz + "', clxz = '" + clxz + "' , cldx = '" + cldx + "' ,cltj ='" + cltj + "' , clje ='" + clje + "' ,bmcl='" + bmcl + "'," + "gs='" + gs + "',ddtz='"+ddtz+"',clzl='"+clzl+"',bljs='"+bljs+"' " + "where  id = '" + id + "'";

    }
    try
    {
      this.selectDataService.execute(sql);
        if (flag.equals("COPY"))//复制BOM同时将该BOM下所有工艺复制
        {
            copyRow(id,randomId);
        }
      Response.write("SUCCESS");
    }
    catch (Exception e)
    {
      Response.write("ERROR");
      e.printStackTrace();
    }
  }
    //BOM复制功能
    public void copyRow(String yid,String nid)
    {
        try {
                String gygcSql="INSERT INTO scglxt_t_gygc(id,bomid,gynr,edgs,bzgs,SERIAL,sbid,zysx) SELECT CONCAT(DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),ROUND(RAND() * 1000), @i := @i + 1) id,'"+
                        nid.trim()+"',gynr,edgs,bzgs,SERIAL,sbid,zysx FROM scglxt_t_gygc,(SELECT @i:=0) t WHERE bomid='"+yid.trim()+"'";
                selectDataService.execute(gygcSql);

            String gynr=selectDataService.getString("SELECT gxnr FROM scglxt_t_bom  t WHERE t.id='"+yid+"'");

            String sql = "update  scglxt_t_bom set  gxnr='"+gynr+"' where id = '" + nid + "'";

            selectDataService.execute(sql);

            Response.write("SUCCESS") ;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            Response.write("ERROR");
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
    String sql = "select t2.bomid , t2.gyid ,t2.id , t2.gynr,t2.edgs,t2.bzgs,t2.stsj,t2.jhwcsj,t2.sjwcsj , t2.jyryid , t1.zddmc, t3.gymc  from scglxt_t_bom t1 ,  scglxt_t_gygc  t2 , scglxt_t_jggy  t3  where t1.id = t2.bomid  and t2.gyid = t3.id ;  ";
    
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
    String bzgs = JSON.getString("bzgs");
    String stsj = JSON.getString("stsj");
    String serial = JSON.getString("serial");
    String zysx = JSON.getString("zysx");
    String id = WebUtils.getRandomId();
      if(bzgs==null || bzgs=="")
      {
          bzgs="0";
      }
      if(edgs==null || edgs=="")
      {
          edgs="0";
      }
    String sql = "insert into scglxt_t_gygc (bomid,id,sbid,gynr,edgs,bzgs,serial,zysx) values ('" +
      bomid + "','" + id + "','" + sysb + "','" + gxnr + "'," + edgs + "," + bzgs + ",'" + serial + "','" + zysx + "') ";
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
    String bzgs = JSON.getString("bzgs");
    String stsj = JSON.getString("stsj");
    String serial = JSON.getString("serial");
    String zysx = JSON.getString("zysx");
    
    String sql = "update scglxt_t_gygc  set sbid = '" + sbid + "' ,gynr = '" + gxnr + "' ,edgs = '" + edgs + "',bzgs = '" + bzgs + "', "+
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
    //如果备料状态待采购则库管可添加采购建议
    public void updateBlzkCgjy()
    {
        String id = Request.getParameter("id");
        String cgjy = Request.getParameter("cgjy");

        String sql = " update scglxt_t_bom set cgsj ='"+cgjy+"'   where id = '" + id + "'";
        try
        {
            log.info("添加采购建议"+sql);
            this.selectDataService.execute(sql);
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
    String gygcSql = "select t.id ,t2.gymc gynr ,t.edgs,t.bzgs,bom.clzt,bom.jgsl from scglxt_t_bom bom,scglxt_t_gygc  t ,scglxt_t_jggy t2  where t.`bomid`=bom.id AND t.gynr = t2.id  and bomid = '" +
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
          gynr = gynr + lom.get("gynr").toString() + "(" + lom.get("bzgs").toString() + ")-";
        }
        gynr = gynr.substring(0, gynr.length() - 1);
      }
      sql = "update  scglxt_t_bom set gxnr =  '" + gynr + "' where id = '" + bomid + "'";

      this.selectDataService.execute(sql);
        ListOrderedMap lom = (ListOrderedMap)list.get(0);
        if( lom.get("clzt")!=null)
        {
            if( lom.get("clzt").toString().equals("1"))
            {
                sql = "update  scglxt_t_gygc set kjgjs =  '" +  lom.get("jgsl").toString() + "' where bomid = '" + bomid + "' and serial='0'";
                this.selectDataService.execute(sql);
            }
        }
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

    //获取加工设备类型
    public void getJgSbLxData()
    {
        String sql = "SELECT id,mc 'name',ssgy,bzcn FROM scglxt_t_sblx ";
        String id= Request.getParameter("gyid");
        if(!id.equals("0"))
        {
            sql+=" where ssgy='"+id+"'  ORDER BY id ";
        }else{
            sql+="  ORDER BY id ";
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
      sql = "select bomid ,sbid ,id ,gynr ,edgs,bzgs,serial ,zysx    from   scglxt_t_gygc where sbid = '" + sbid + "'  order by serial asc ";
    } else {
      sql = "select bomid ,sbid ,id ,gynr ,edgs,bzgs,serial ,zysx    from   scglxt_t_gygc where bomid = '" + bomid + "'  order by serial asc ";
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

        String sql = "UPDATE scglxt_t_bom SET zddzt = '"+zddzt+"',"+sjzd+" = DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s')  WHERE id = '"+id+"'";
        try
        {
            this.selectDataService.execute(sql);
            if(zddzt.equals("0506"))
            {
                String ddSql="update scglxt_t_dd set ckzt='完成',ckdate=DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') where id=(select ssdd from scglxt_t_bom where id='"+id+"')";
                this.selectDataService.execute(ddSql);
            }
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

    /**
     * 导出BOM表备料信息
     */
    public void exportBLData()
    {
        HttpServletResponse response= ServletActionContext.getResponse();
        String excelName = "";
        String ddid=Request.getParameter("ddid");
        String ddSql="SELECT ht.`htbh`,xmname,zd.mc ddjb,endtime,xmlxr,xmfzr,starttime FROM scglxt_t_dd dd,scglxt_t_ht ht,scglxt_tyzd zd WHERE dd.`ssht`=ht.`id` AND dd.`ddlevel`=zd.`ID` AND zd.xh LIKE '04__' and dd.id='"+ddid+"'";

        String[] ddheaders = new String[]{"BOM表备料单-","客户编号","项目联络人","项目名称","项目执行人","项目下单日期","交货日期","项目重要程度","备料下单日期"};
        String[] headers = new String[]{"序号","名称/图号","材质","备料尺寸","备料件数","加工数量","重量","单价","金额"};
        try {
            String bomSql="SELECT  (@rownum := @rownum + 1) AS rownum, bom.id, zddmc,  t2.clmc, cldx, bljs,jgsl,ROUND(clzl,2) clzl, cldj, ROUND(clje,2) clje " +
                    "FROM scglxt_t_bom bom  LEFT JOIN scglxt_t_cl t2   ON bom.zddcz = t2.id  WHERE ssdd = '"+ddid+"'";
            List ddlist = this.selectDataService.queryForList(ddSql);
            Map<String,Object> ddmap = (Map<String, Object>) ddlist.get(0);

            excelName=ddmap.get("xmname").toString();

            OutputStream out = response.getOutputStream();
            //声明一个工作簿
            HSSFWorkbook workbook = new HSSFWorkbook();
            //生成一个表格
            HSSFSheet sheet = workbook.createSheet(excelName);

            //设置表格默认列宽度为15个字符
            //sheet.setDefaultColumnWidth(20);
            sheet.setColumnWidth((short)0,(short)3*256);
            sheet.setColumnWidth((short)1,(short)20*256);
            sheet.setColumnWidth((short)2,(short)9*256);
            sheet.setColumnWidth((short)3,(short)16*256);
            sheet.setColumnWidth((short)4,(short)7*256);
            sheet.setColumnWidth((short)5,(short)10*256);
            sheet.setColumnWidth((short)6,(short)10*256);
            sheet.setColumnWidth((short)7,(short)10*256);
            //生成一个样式，用来设置标题样式
            HSSFCellStyle style = workbook.createCellStyle();
            //设置这些样式
            style.setFillForegroundColor(HSSFColor.WHITE.index);
            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

            //生成第一行字体
            HSSFFont font = workbook.createFont();
            font.setColor(HSSFColor.RED.index);//设置字体颜色
            //font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//设置字体加粗
            font.setFontHeightInPoints((short) 26);//设置第一行字体大小

            //把字体应用到当前的样式
            style.setFont(font);

            //生成一个样式，用来设置标题样式
            HSSFCellStyle styleleft = workbook.createCellStyle();
            //设置这些样式
            styleleft.setFillForegroundColor(HSSFColor.WHITE.index);
            styleleft.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            styleleft.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            styleleft.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            styleleft.setBorderRight(HSSFCellStyle.BORDER_THIN);
            styleleft.setBorderTop(HSSFCellStyle.BORDER_THIN);
            styleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);

            styleleft.setWrapText(true);
            //生成第一行字体
            HSSFFont fontleft = workbook.createFont();
            fontleft.setColor(HSSFColor.BLACK.index);//设置字体颜色
            //font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//设置字体加粗
            fontleft.setFontHeightInPoints((short) 11);//设置第一行字体大小

            //把字体应用到当前的样式
            styleleft.setFont(fontleft);

            //生成第一行显示订单标题
            HSSFRow row = sheet.createRow(0);
            row.setHeightInPoints(31);


            //合并第一行0-4单元格
            Region region1 = new Region(0, (short) 0, 0, (short)8);
            sheet.addMergedRegion(region1);
            //合并第一行5-8单元格
            //Region region2 = new Region(0, (short) 5, 0, (short)8);
            //sheet.addMergedRegion(region2);
            //合并第二行0-3单元格
            Region region11 = new Region(1, (short) 0, 1, (short)1);
            sheet.addMergedRegion(region11);
            //合并第二行0-3单元格
            Region region12 = new Region(1, (short)2, 1, (short)4);
            sheet.addMergedRegion(region12);
            //合并第二行6-8单元格
            Region region13 = new Region(1, (short) 6, 1, (short)8);
            sheet.addMergedRegion(region13);
            //合并第二行0-3单元格
            Region region21 = new Region(2, (short) 0, 2, (short)1);
            sheet.addMergedRegion(region21);
            //合并第二行0-3单元格
            Region region22 = new Region(2, (short)2, 2, (short)4);
            sheet.addMergedRegion(region22);
            //合并第二行6-8单元格
            Region region23 = new Region(2, (short) 6, 2, (short)8);
            sheet.addMergedRegion(region23);

            //合并第二行0-3单元格
            Region region31 = new Region(3, (short) 0, 3, (short)1);
            sheet.addMergedRegion(region31);
            //合并第二行0-3单元格
            Region region32 = new Region(3, (short)2, 3, (short)4);
            sheet.addMergedRegion(region32);
            //合并第二行6-8单元格
            Region region33 = new Region(3, (short) 6, 3, (short)8);
            sheet.addMergedRegion(region33);

            //合并第二行0-3单元格
            Region region41 = new Region(4, (short) 0, 4, (short)1);
            sheet.addMergedRegion(region41);
            //合并第二行0-3单元格
            Region region42 = new Region(4, (short)2, 4, (short)4);
            sheet.addMergedRegion(region42);
            //合并第二行6-8单元格
            Region region43 = new Region(4, (short) 6, 4, (short)8);
            sheet.addMergedRegion(region43);
            //合并第二行6-8单元格
            Region region5 = new Region(5, (short) 0, 5, (short)8);
            sheet.addMergedRegion(region5);

            row.createCell(1).setCellStyle(style);
            row.createCell(2).setCellStyle(style);
            row.createCell(3).setCellStyle(style);
            row.createCell(4).setCellStyle(style);

            HSSFCell cell = row.createCell(0);
            cell.setCellStyle(style);
            HSSFRichTextString text = new HSSFRichTextString(ddheaders[0]+"-"+ddmap.get("xmname").toString());
            cell.setCellValue(text);

            row.createCell(5).setCellStyle(style);
            row.createCell(6).setCellStyle(style);
            row.createCell(7).setCellStyle(style);
            row.createCell(8).setCellStyle(style);
            //******************第一行编写结束 ***********************************
            //生成第二行显示订单客户编号和项目联络人
            HSSFRow row1 = sheet.createRow(1);

            row1.setHeightInPoints(15);
            // 生成并设置另一个样式,用于设置内容样式
            HSSFCellStyle style2 = workbook.createCellStyle();
            style2.setFillForegroundColor(HSSFColor.WHITE.index);
            style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
            style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            // 生成另一个字体
            HSSFFont font2 = workbook.createFont();
            font2.setColor(HSSFColor.BLACK.index);//设置字体颜色
            font2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//设置字体加粗
            font2.setFontHeightInPoints((short) 11);//设置第一行字体大小

            // 把字体应用到当前的样式
            style2.setWrapText(true);
            style2.setFont(font2);

            // 生成并设置另一个样式,用于设置内容样式
            HSSFCellStyle style3 = workbook.createCellStyle();
            style3.setFillForegroundColor(HSSFColor.WHITE.index);
            style3.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style3.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style3.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style3.setAlignment(HSSFCellStyle.ALIGN_LEFT);
            style3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            // 生成另一个字体
            HSSFFont font3 = workbook.createFont();
            font3.setColor(HSSFColor.BLACK.index);//设置字体颜色
            font3.setFontHeightInPoints((short) 11);//设置第一行字体大小

            //设置Excel文本自动换行
            style3.setWrapText(true);
            // 把字体应用到当前的样式
            style3.setFont(font3);

            HSSFCell cellKhbh = row1.createCell(0);
            row1.setHeightInPoints(15);
            cellKhbh.setCellStyle(style2);
            HSSFRichTextString textKhbh = new HSSFRichTextString("客户编号");
            cellKhbh.setCellValue(textKhbh);
            row1.createCell(1).setCellStyle(style2);
            row1.createCell(3).setCellStyle(style2);
            row1.createCell(4).setCellStyle(style2);
            HSSFCell cellKhbhnr = row1.createCell(2);
            cellKhbhnr.setCellStyle(style3);
            HSSFRichTextString textKhbhnr = new HSSFRichTextString(ddmap.get("htbh").toString());
            cellKhbhnr.setCellValue(textKhbhnr);

            HSSFCell cellLlr = row1.createCell(5);
            cellLlr.setCellStyle(style2);
            HSSFRichTextString textLlr = new HSSFRichTextString("项目联络人");
            cellLlr.setCellValue(textLlr);
            HSSFCell cellLlrnr = row1.createCell(6);
            row1.createCell(7).setCellStyle(style2);
            row1.createCell(8).setCellStyle(style2);
            cellLlrnr.setCellStyle(style3);
            HSSFRichTextString textLlrnr = new HSSFRichTextString(ddmap.get("xmlxr").toString());
            cellLlrnr.setCellValue(textLlrnr);
            /*****第三行********************************/
            HSSFRow row2 = sheet.createRow(2);

            row2.setHeightInPoints(15);

            HSSFCell cellxmmc = row2.createCell(0);
            cellxmmc.setCellStyle(style2);
            HSSFRichTextString textXmmc = new HSSFRichTextString("项目名称");
            cellxmmc.setCellValue(textXmmc);
            row2.createCell(1).setCellStyle(style2);
            row2.createCell(3).setCellStyle(style2);
            row2.createCell(4).setCellStyle(style2);
            HSSFCell cellXmmcnr = row2.createCell(2);
            cellXmmcnr.setCellStyle(style3);
            HSSFRichTextString textXmmcnr = new HSSFRichTextString(ddmap.get("htbh").toString());
            cellXmmcnr.setCellValue(textXmmcnr);

            HSSFCell cellZxr = row2.createCell(5);
            cellZxr.setCellStyle(style2);
            HSSFRichTextString textZxr = new HSSFRichTextString("项目执行人");
            cellZxr.setCellValue(textZxr);
            HSSFCell cellZxrnr = row2.createCell(6);
            row2.createCell(7).setCellStyle(style2);
            row2.createCell(8).setCellStyle(style2);
            cellZxrnr.setCellStyle(style3);
            String xmfzr="";
            if(ddmap.get("xmfzr")==null || ddmap.get("xmfzr").equals(""))
            {
                cellZxrnr.setCellValue("");
            }else{
                HSSFRichTextString textZxrnr = new HSSFRichTextString(ddmap.get("xmfzr").toString());
                cellZxrnr.setCellValue(textZxrnr);
            }

            /*****第四行********************************/
            HSSFRow row3 = sheet.createRow(3);

            row3.setHeightInPoints(15);

            HSSFCell cellxdrq = row3.createCell(0);
            cellxdrq.setCellStyle(style2);
            HSSFRichTextString textxdrq = new HSSFRichTextString("项目下单日期");
            cellxdrq.setCellValue(textxdrq);
            row3.createCell(1).setCellStyle(style2);
            row3.createCell(3).setCellStyle(style2);
            row3.createCell(4).setCellStyle(style2);
            HSSFCell cellxdrqnr = row3.createCell(2);
            cellxdrqnr.setCellStyle(style3);
            HSSFRichTextString textxdrqnr = new HSSFRichTextString(ddmap.get("starttime").toString());
            cellxdrqnr.setCellValue(textxdrqnr);

            HSSFCell celljhrq = row3.createCell(5);
            celljhrq.setCellStyle(style2);
            HSSFRichTextString textjhrq = new HSSFRichTextString("交货日期");
            celljhrq.setCellValue(textjhrq);
            HSSFCell celljhrqnr = row3.createCell(6);
            celljhrqnr.setCellStyle(style3);
            HSSFRichTextString textjhrqnr = new HSSFRichTextString(ddmap.get("endtime").toString());
            celljhrqnr.setCellValue(textjhrqnr);
            row3.createCell(7).setCellStyle(style2);
            row3.createCell(8).setCellStyle(style2);
            /*****第四行********************************/
            HSSFRow row4 = sheet.createRow(4);

            row4.setHeightInPoints(15);

            HSSFCell cellzycd = row4.createCell(0);
            cellzycd.setCellStyle(style2);
            HSSFRichTextString textzycd = new HSSFRichTextString("项目重要程度");
            cellzycd.setCellValue(textzycd);
            row4.createCell(1).setCellStyle(style2);
            row4.createCell(3).setCellStyle(style2);
            row4.createCell(4).setCellStyle(style2);
            HSSFCell cellzycdnr = row4.createCell(2);
            cellzycdnr.setCellStyle(style3);
            HSSFRichTextString textzycdnr = new HSSFRichTextString(ddmap.get("ddjb").toString());
            cellzycdnr.setCellValue(textzycdnr);

            HSSFCell cellblrq =row4.createCell(5);
            cellblrq.setCellStyle(style2);
            HSSFRichTextString textblrq = new HSSFRichTextString("备料日期");
            cellblrq.setCellValue(textblrq);
            row4.createCell(6).setCellStyle(style2);
            row4.createCell(7).setCellStyle(style2);
            row4.createCell(8).setCellStyle(style2);

            // 生成黄色分割条样式
            HSSFCellStyle style4 = workbook.createCellStyle();
            style4.setFillForegroundColor(HSSFColor.YELLOW.index);
            style4.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style4.setBorderBottom(HSSFCellStyle.BORDER_THICK);
            style4.setBorderLeft(HSSFCellStyle.BORDER_THICK);
            style4.setBorderRight(HSSFCellStyle.BORDER_THICK);
            style4.setBorderTop(HSSFCellStyle.BORDER_THICK);
            style4.setAlignment(HSSFCellStyle.ALIGN_LEFT);
            style4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

            HSSFRow row5 =sheet.createRow(5);
            row5.setHeightInPoints(15);
            row5.createCell(0).setCellStyle(style4);
            row5.createCell(1).setCellStyle(style4);
            row5.createCell(2).setCellStyle(style4);
            row5.createCell(3).setCellStyle(style4);
            row5.createCell(4).setCellStyle(style4);
            row5.createCell(5).setCellStyle(style4);
            row5.createCell(6).setCellStyle(style4);
            row5.createCell(7).setCellStyle(style4);
            row5.createCell(8).setCellStyle(style4);
            //产生表格标题行
            HSSFRow row6 = sheet.createRow(6);
            row6.setHeightInPoints(28);
            for(int i = 0; i<headers.length;i++){
                HSSFCell cell5 = row6.createCell(i);
                cell5.setCellStyle(style2);
                HSSFRichTextString text5 = new HSSFRichTextString(headers[i]);
                cell5.setCellValue(text5);
            }

            //新建一个SHEET开始填写工艺工序内容
            List mapList = this.selectDataService.queryForList(bomSql);

            Double hj=0.0;
            for (int i=0;i<mapList.size();i++) {
                Map<String,Object> map = (Map<String, Object>) mapList.get(i);
                row = sheet.createRow(i+7);
                int j = 0;
                Object value = null;

                for(String key:map.keySet())
                {
                    if(key.equals("id"))
                    {
                    }else {
                        value = map.get(key);
                        if (key.equals("rownum")) {
                            value = i+1;
                        }
                        if(key.equals("clje"))
                        {
                            if (value != null)
                                hj=hj+(Double)value;
                        }
                        if (value == null) {
                            value = "";
                        }
                        HSSFCell hc = row.createCell(j++);
                        hc.setCellStyle(styleleft);
                        hc.setCellValue(String.valueOf(value));
                    }
                }
            }
            //查询工艺工序统计结果并写入到订单最后一行中
            //合并第二行6-8单元格
            Region regiontj = new Region(7+mapList.size(), (short) 0, 7+mapList.size(), (short)6);
            sheet.addMergedRegion(regiontj);

            HSSFRow tjrow = sheet.createRow(7+mapList.size());
            tjrow.setHeightInPoints(22);
            String tjInfo="领料人签字：";

            HSSFCell hc = tjrow.createCell(0);
            hc.setCellStyle(styleleft);
            hc.setCellValue(String.valueOf(tjInfo));
            tjrow.createCell(1).setCellStyle(style3);
            tjrow.createCell(2).setCellStyle(style3);
            tjrow.createCell(3).setCellStyle(style3);
            tjrow.createCell(4).setCellStyle(style3);
            tjrow.createCell(5).setCellStyle(style3);
            tjrow.createCell(6).setCellStyle(style3);
            HSSFCell tjje = tjrow.createCell(7);
            tjje.setCellStyle(styleleft);
            tjje.setCellValue("合计：");
            HSSFCell hcje = tjrow.createCell(8);
            hcje.setCellStyle(styleleft);
            BigDecimal b   =   new   BigDecimal(hj);
            double  f1  =   b.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
            hcje.setCellValue(String.valueOf(f1));

            //转码防止乱码
            response.setContentType("application/octet-stream;charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename="
                    + new String(excelName.getBytes(),"iso-8859-1") + ".xls");

            response.addHeader("Content-Disposition", "attachment;filename="+excelName+".xls");
            try {
                workbook.write(out);
            } catch (IOException e) {
                e.printStackTrace();
            }
            out.close();
            System.out.println("excel导出成功！");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
