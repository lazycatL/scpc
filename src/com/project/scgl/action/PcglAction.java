package com.project.scgl.action;

import com.opensymphony.xwork2.ActionContext;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import java.util.List;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.support.rowset.SqlRowSet;

public class PcglAction
{
  private static Log log = LogFactory.getLog(PcglAction.class);
  private SelectDataService selectDataService;
  
  public SelectDataService getSelectDataService()
  {
    return this.selectDataService;
  }
  
  public void setSelectDataService(SelectDataService selectDataService)
  {
    this.selectDataService = selectDataService;
  }
  
  public void getBzList()
  {
    String sql = "select id,bzmc,bzfzr from scgl_gzbz_info";
    log.info("班组信息查询sql" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void getSbList()
  {
    String sql = "select id,bzmc,bzfzr from scgl_gzbz_info";
    log.info("班组信息查询sql" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void getRyList()
  {
    String sql = "select id,bzmc,bzfzr from scgl_gzbz_info";
    log.info("班组信息查询sql" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void getPcInfo()
  {
    String sql = "select 'A任务排产' title,cast(jhkssj as char)start,cast(jhwcsj as char) end,'red' color from scglxt_mk_scpc;";
    log.info("查询排产信息" + sql);
    
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public String addPcInfo()
  {
    return "addPcSuccess";
  }
  
  public void getPcSbTb()
  {
    String sql = "SELECT  CONCAT(k,'\n','已排产至：',DATE_FORMAT(TIMESTAMPADD(DAY,v,NOW()),'%Y-%m-%d'),' 日')k,v,c,id   FROM v_scglxt_pc_sb_tb";
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    log.info("请求班组图sql：" + sql);
    Response.write(json);
  }
  
  public void getPcRyTb()
  {
    log.info("请求人员图表");
    String sql = "select round(((sum(edgs*jgsl))/(select gzsj from scglxt_t_gzsj where sfqy = 1)),2) v,bzid c,ry k,ryid id from v_scglxt_pc_tb group by ryid order by kssj,ryid";
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void getSbTbInfo()
  {
    String sql = "select gygcid,zddmc,serial jgsx,jgsl,gymc,edgs,cast(jhkssj as char) jhkssj,cast(kssj as char) kssj,bzmc,sbmc from `v_scglxt_pc_tb_info` where sbid = '03'";
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    Response.write(json);
  }
  
  public void getRyTbInfo()
  {
    String sql = "select gygcid, zddmc,serial jgsx,jgsl,gymc,edgs,cast(jhkssj as char) jhkssj,cast(kssj as char) kssj,bzmc,sbmc from `v_scglxt_pc_tb_info` where ryid = '02'";
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    Response.write(json);
  }
  
  public void editGygcJhkssjById()
  {
    String id = Request.getParameter("gygcid");
    String jhkssj = Request.getParameter("jhkssj");
    String sql = "UPDATE `scpc`.`scglxt_t_gygc` SET `JHKSSJ`='" + jhkssj + "' WHERE `id`='" + id + "'";
    try
    {
      this.selectDataService.execute(sql);
    }
    catch (Exception e)
    {
      Response.write("error");
      e.printStackTrace();
    }
    Response.write("success");
  }
  
  public void getBomStatusList()
  {
    try
    {
      String sql = "select id ,zddmc,clxz,bmcl,date_format(starttime,'%Y-%m-%d') jhkssj,date_format(endtime,'%Y-%m-%d') jhjssj,gs,fun_dqgygc(id) ddtz from scglxt_t_bom  where 1=1 order by jhkssj";
      log.info("获取子订单当前状态供排产管理人员调整sql" + sql);
      List list = this.selectDataService.queryForList(sql);
      String json = JsonObjectUtil.list2Json(list);
      json = "{\"data\":" + json + "}";
      Response.write(json);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
  
  public void getBomGygcJg()
  {
    String sql = "SELECT gygc.id,bom.id bomid, bom.zddmc,bom.bmcl,dd.xmname,bom.ddtz,bom.jgsl,date_format(bom.starttime,'%Y-%m-%d') jhkssj,date_format(bom.endtime,'%Y-%m-%d') jhjssj,gygc.edgs gs,jggy.gymc,gygc.kjgjs,gygc.yjgjs,gygc.bfjs,gygc.kjgjs-gygc.yjgjs-gygc.bfjs-gygc.sjjs djgjs,gygc.sjjs FROM scpc.scglxt_t_gygc gygc,scpc.scglxt_t_bom bom,scglxt_t_jggy jggy,scglxt_t_dd dd where bom.ssdd=dd.id and gygc.bomid = bom.id and jggy.id = gygc.gynr and ((gygc.bfjs + gygc.yjgjs + gygc.sjjs < gygc.kjgjs) OR gygc.kjgjs='0') ";
    System.out.println(sql);
      String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
      if(!ssbz.equals("759007553955134000000"))//如果不是管理组就过滤所述班组权限
      {
          sql=sql+" and jggy.fzbz='"+ssbz+"'";
      }
      sql=sql + " ORDER BY gygc.kjgjs DESC,gygc.jhkssj";
      log.info("获取当前待加工的所有工序sql" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    Response.write(json);
  }
  
  public void getRyByBz()
  {
    String ssbz = Request.getParameter("ssbz");
    String sql = "SELECT id,rymc mc,ssbz bz FROM scglxt_t_ry WHERE ssbz = '" + ssbz + "'";
      //  String sql = "SELECT id,rymc mc,ssbz bz FROM scglxt_t_ry";
    log.info("根据班组获取该班组所有人员" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void getBomGygcJy()
  {
    String sql = "SELECT jggl.id, bom.zddmc,bom.bmcl,jggy.gymc,ry.rymc,sb.sbmc,jggl.jgjs,gygc.bomid,  gygc.serial  FROM scglxt_t_gygc gygc,scglxt_t_bom bom,scglxt_t_jggy jggy,scglxt_t_jggl jggl, scglxt_t_ry ry, scglxt_t_sb sb \twhere  gygc.bomid = bom.id and jggy.id = gygc.gynr  and jggl.gygcid = gygc.id and ry.id = jggl.jgryid and sb.id = jggl.sbid and jggl.sfjy='0' order by jgkssj";
    log.info("获取当前待检验的所有工作sql" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    
    log.info("json====================================" + json);
    Response.write(json);
  }

    /**
     * 检验人员检验
     */
  public void editJgglJy()
  {
    String jgglId = Request.getParameter("id");
    String bfjs = Request.getParameter("v");
    //String jyryid = "02";
      String jyryid= ActionContext.getContext().getSession().get("userid").toString();
    String sql = "update scglxt_t_jggl set jysj = now(), bfjs = " + bfjs + ",sfjy = '1',jyryid= '" + jyryid + "' where id = '" + jgglId + "'";
    
  //  String sql2 = "update scglxt_t_gygc a set yjgjs = yjgjs-" + bfjs + "+(select c.jgjs from scglxt_t_jggl c where c.id = '" + jgglId + "') ,bfjs = bfjs+" + bfjs + ",sjjs=sjjs-(" + bfjs + "+(select c.jgjs from scglxt_t_jggl c where c.id = '" + jgglId + "')) where id = (select gygcid from scglxt_t_jggl b where b.id = '" + jgglId + "' and a.id = b.gygcid)";
    String sql2 = "update scglxt_t_gygc a set yjgjs = yjgjs-" + bfjs + "+(select c.jgjs from scglxt_t_jggl c where c.id = '" + jgglId + "') ,bfjs = bfjs+" + bfjs + ",sjjs=0 where id = (select gygcid from scglxt_t_jggl b where b.id = '" + jgglId + "' and a.id = b.gygcid)";
    try
    {
      log.info("检验人员更新加工管理表" + sql);
      this.selectDataService.execute(sql);
      log.info("检验人员更新工艺过程表" + sql2);
      this.selectDataService.execute(sql2);
      
      SqlRowSet rs = getBomidAndSerial(jgglId);
      while (rs.next())
      {
        String bomId = rs.getString(1);
        int serial = rs.getInt(2);
        serial++;
        int kjgjs = rs.getInt(3);
        String serialSql="Select * from scglxt_t_gygc where `bomid` = '" + bomId + "' and serial = '" + serial + "'";

          List serialList=this.selectDataService.queryForList(serialSql);
          String sql3="";
          //判断是否还有下一道工序，如果该检验为最后一道工序则修改bom订单的状态为加工完成
          if(serialList.size()>0) {
              sql3 = "UPDATE scglxt_t_gygc  SET kjgjs = " + kjgjs + " WHERE `bomid` = '" + bomId + "' and serial = '" + serial + "'";
              this.selectDataService.execute(sql3);
          }else{
              //报废件数总和+最后一道工序已加工件数=第一道工序可加工件数
              String bfjsSql="SELECT SUM(bfjs) FROM scglxt_t_gygc WHERE bomid='"+bomId+"'";
              String bfjsCount=this.selectDataService.getString(bfjsSql);

              String lastCountSql="SELECT yjgjs FROM scglxt_t_gygc WHERE  bomid='"+bomId+"' ORDER BY SERIAL DESC";
              String lastCount=this.selectDataService.getString(lastCountSql);
              String firstCountSql="SELECT kjgjs FROM scglxt_t_gygc WHERE bomid='"+bomId+"'  AND SERIAL='0'";
              String firstCount=this.selectDataService.getString(firstCountSql);

              if(String.valueOf(Integer.parseInt(lastCount)+Integer.parseInt(lastCount)).equals(firstCount))
              {
                  sql3 = "UPDATE scglxt_t_bom  SET zddzt = " + kjgjs + " WHERE `id` = '" + bomId + "'";
                  this.selectDataService.execute(sql3);
              }
          }
        log.info("更新下一步可加工件数：" + sql3);
      }
    }
    catch (Exception e)
    {
      Response.write("error");
      e.printStackTrace();
    }
    Response.write("success");
  }
  
  public SqlRowSet getBomidAndSerial(String jgglId)
  {
    String sql = "SELECT a.bomid,a.serial,a.yjgjs FROM  scglxt_t_gygc a WHERE id = (SELECT gygcid FROM  scglxt_t_jggl b  WHERE b.id = '" + jgglId + "'  AND a.id = b.gygcid)";
    
    log.info("aaaaaa"+sql);
    return this.selectDataService.getSqlRowSet(sql);
  }
  
  public void jgryKs()
  {
    String gygcid = Request.getParameter("gygcid");
    String ryid = Request.getParameter("jgryid");
    String id = "F" + RandomStringUtils.randomNumeric(39);
    String sql = "insert into scglxt_t_jggl (id,jgryid,jgkssj,gygcid) values ('" + id + "','" + ryid + "',now(),'" + gygcid + "')";
    
    log.info("加工人员开始加工：" + sql);
    try
    {
      this.selectDataService.execute(sql);
    }
    catch (Exception e)
    {
      Response.write("error");
      e.printStackTrace();
    }
    Response.write("success");
  }
  
  public void getYksGyJgry()
  {
    String gygcid = Request.getParameter("gygcid");
    String sql = "SELECT jgryid id,ry.rymc mc FROM scglxt_t_jggl,scglxt_t_ry ry WHERE gygcid = '" + gygcid + "'  AND jgjssj IS NULL and jgryid = ry.id ";
    
    log.info("查询某工艺过程已经开始加工的人员:" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void jgryJs()
  {
    String ryid = Request.getParameter("jsjgry");
    String sbid = Request.getParameter("sbid");
    String wcjs = Request.getParameter("wcjs");
    String gygcid = Request.getParameter("gygcid");
    
    String sql = "update scglxt_t_jggl set jgjssj = now(),jgjs = " + wcjs + " ,sbid = '" + sbid + "' where jgryid = '" + ryid + "' and gygcid = '" + gygcid + "'";
    
    String sql2 = "update scglxt_t_gygc t set t.sjjs=sjjs+" + wcjs + " where id = '" + gygcid + "'";
    try
    {
      log.info("加工人员结束加工某产品" + sql);
      log.info("加工人员结束加工更新工艺过程表" + sql2);
      this.selectDataService.execute(sql);
      
      this.selectDataService.execute(sql2);
    }
    catch (Exception e)
    {
      Response.write("error");
      e.printStackTrace();
    }
    Response.write("success");
  }
  public void jgryJs1()
  {
    String sbid = Request.getParameter("sbid");
    String gygcid = Request.getParameter("gygcid");
    
    String sql = "UPDATE scglxt_t_gygc SET sbid = '"+sbid+"' WHERE id = '"+gygcid+"'";
    
    try
    {
      log.info("调整设备" + sql);
      this.selectDataService.execute(sql);
      
    }
    catch (Exception e)
    {
      Response.write("error");
      e.printStackTrace();
    }
    Response.write("success");
  }
  public void getJgSbInfo()
  {
    String sql = "SELECT id,sbmc FROM scpc.scglxt_t_sb";
    log.info("查询加工设备" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }
  
  public void updateJhkssj()
  {
    String bomid = Request.getParameter("bomid");
    String jhkssj = Request.getParameter("v");
    String sql = "update scglxt_t_bom set starttime = date_format('" + jhkssj + "','%Y-%m-%d') where id ='" + bomid + "'";
    log.info("调整开始时间" + sql);
    this.selectDataService.execute(sql);
    
    Response.write("sucess");
  }
  
  public void getZtJgQk()
  {
    String sql = "SELECT bom.`zddmc`,gygc.`gynr`,jg.`rymc` jgry,jggl.`jgjs`,sb.`sbmc` ,cast(jggl.`jgkssj` as char) jgkssj,cast(jggl.`jgjssj` as char) jgjssj ,jy.`rymc`jyry,cast(jggl.`jysj` as char)jysj,jggl.`bfjs` FROM scglxt_t_jggl jggl,scglxt_t_bom bom,scglxt_t_sb sb,scglxt_t_ry jg,scglxt_t_ry jy,scglxt_t_gygc gygc WHERE jg.`id` = jggl.`jgryid` AND jy.`id` = jggl.`jyryid` AND jggl.`sbid` = sb.`id` AND jggl.`gygcid` = gygc.`id` AND gygc.`bomid` = bom.`id` ORDER BY jggl.`jgjssj` DESC";
    log.info("排产管理查询总体加工情况: " + sql);
    
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    
    Response.write(json);
  }
}
