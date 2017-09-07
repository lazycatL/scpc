package com.project.scgl.action;

import com.opensymphony.xwork2.ActionContext;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.project.util.WebUtils;
import jdk.internal.util.xml.impl.ReaderUTF16;
import org.apache.commons.collections.map.ListOrderedMap;
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
      String type = Request.getParameter("type");
      String sql="select * from (SELECT (@rownum := @rownum + 1) AS rownum,id,xmname name,CAST(starttime AS CHAR) start,CAST(endtime AS CHAR) end ,'#13bcd5'color,(SELECT zgs FROM v_scglxt_zgs_dd ddgs WHERE ddgs.ddid=dd.id) zgs,fun_yjggs(dd.id) yjggs FROM scglxt_t_dd dd,(SELECT   @rownum:=-1)   AS   it) t  WHERE (zgs <> yjggs OR yjggs=0) ";
      if(type.equals("bom"))
      {
          String ddid=Request.getParameter("ssdd");
          sql="SELECT (@rownum := @rownum + 1) AS rownum,id,zddmc name,CAST(starttime AS CHAR) start,CAST(endtime AS CHAR) end,'#13bcd5' color FROM scglxt_t_bom,(SELECT @rownum := - 1) AS it WHERE ssdd='"+ddid+"'";
      }
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

    String sql = "SELECT  k,CONCAT('已排产至：',DATE_FORMAT(TIMESTAMPADD(DAY,v,NOW()),'%Y-%m-%d'),'\\n',v,'天') v,c,id   FROM v_scglxt_pc_sb_tb sb where 1=1";
      String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
      String username=ActionContext.getContext().getSession().get("username").toString();

      if(username.equals("郑斌"))//如果不是管理组就过滤所述班组权限
      {
          sql=sql+" and sb.c in ('"+ssbz+"','759007553955134000012') ";
      }
      else if(!ssbz.equals("759007553955134000000"))//如果不是管理组就过滤所述班组权限
      {
          sql=sql+" and sb.c='"+ssbz+"'";
      }
      List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    log.info("请求班组图sql：" + sql);
    Response.write(json);
  }
    //获取设备类型排产信息
    public void getPcSbLx()
    {
        String sql = "SELECT  sblx.id,mc k,ssgy, DATE_FORMAT(TIMESTAMPADD(DAY, ROUND(zgs/bzcn,2), NOW()),'%Y-%m-%d') v,fzbz,ROUND(zgs/bzcn,2) t " +
                "FROM scglxt_t_sblx sblx,scglxt_t_jggy gy,v_scglxt_pc_sblx t WHERE sblx.ssgy=gy.id AND sblx.id = t.sbid";
        String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
        String username=ActionContext.getContext().getSession().get("username").toString();

        if(username.equals("郑斌"))//如果不是管理组就过滤所述班组权限
        {
            sql=sql+" and fzbz in ('"+ssbz+"','759007553955134000012') ";
        }
        else if(!ssbz.equals("759007553955134000000") && !ssbz.equals("97306232864841111168"))//如果不是管理组就过滤所述班组权限
        {
            sql=sql+" and fzbz='"+ssbz+"'";
        }
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        log.info("请求设备类型排产sql：" + sql);
        Response.write(json);
    }
    //获取工艺工序排产信息
    public void getPcGygx()
    {
        String sql = "SELECT gy.id,gy.gymc k,ssgy,fzbz,DATE_FORMAT(TIMESTAMPADD(DAY, ROUND(zgs / bzcn, 2), NOW()),'%Y-%m-%d') v,SUM(ROUND(zgs / bzcn, 2)) t " +
                "FROM scglxt_t_sblx sblx,scglxt_t_jggy gy,v_scglxt_pc_gygx t WHERE sblx.ssgy=gy.id AND gy.`id`=t.`gynr`";
        String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
        String username=ActionContext.getContext().getSession().get("username").toString();

        if(username.equals("郑斌"))//如果不是管理组就过滤所述班组权限
        {
            sql=sql+" and fzbz in ('"+ssbz+"','759007553955134000012') ";
        }
        else if(!ssbz.equals("759007553955134000000") && !ssbz.equals("97306232864841111168"))//如果不是管理组就过滤所述班组权限
        {
            sql=sql+" and fzbz='"+ssbz+"'";
        }
        sql = sql+ "  GROUP BY ssgy";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        log.info("请求工艺工序排产sql：" + sql);
        Response.write(json);
    }

    //vue-app访问数据处理
    public void getJgInfoByBzId()
    {
        String ssbz = Request.getParameter("bzid");
        String query=Request.getParameter("query");

        String sql = "SELECT gygc.id,bom.id bomid,dd.xmname ddmc,tz.tzlx,tz.url tzurl, bom.zddmc,bom.zddjb,zd.mc zddjbmc,bom.bmcl,dd.id ddid,bom.ddtz,bom.jgsl,DATE_FORMAT(dd.endtime, '%Y-%m-%d') ddjssj,gygc.serial,gygc.edgs gs,jggy.gymc,gygc.kjgjs,gygc.yjgjs,gygc.bfjs,gygc.kjgjs-gygc.yjgjs-gygc.bfjs-gygc.sjjs djgjs,gygc.sjjs,"+
                "(SELECT COUNT(*) FROM scglxt_t_jggl WHERE gygc.id=gygcid) yjgcount FROM scglxt_t_gygc gygc,scglxt_t_bom bom LEFT JOIN scglxt_t_dd_tz tz ON bom.ddtz LIKE CONCAT(tz.tzmc,\"%\"),scglxt_t_jggy jggy,scglxt_t_dd dd,scglxt_tyzd zd where bom.ssdd=dd.id AND bom.zddjb=zd.id AND zd.id LIKE '06%' and gygc.bomid = bom.id and jggy.id = gygc.gynr and ((gygc.bfjs + gygc.yjgjs + gygc.sjjs < gygc.kjgjs) ) ";
      if(!ssbz.equals("759007553955134000000") && !ssbz.equals("97306232864841111168"))//如果不是管理组就过滤所述班组权限
        {
            sql=sql+" and fzbz='"+ssbz+"'";
        }
        if(!query.equals(""))
        {
            sql+=" and (dd.xmname like '%"+query+"%' or bom.zddmc like '%"+query+"%') ";
        }
        sql=sql + " ORDER BY  zddjb,djgjs DESC,ddjssj ";
        //log.info("获取当前待加工的所有工序sql：" + sql);
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        json = "{\"data\":" + json + "}";
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
      String sql = "select t.id ,dd.xmname ddmc,zd2.mc zddztmc,zddmc,zddjb,date_format(dd.endtime,'%Y-%m-%d') ddendtime,zd.mc zddjbmc,clxz,bmcl,t.jgsl,date_format(t.starttime,'%Y-%m-%d') jhkssj,date_format(t.endtime,'%Y-%m-%d') jhjssj,gs,fun_dqgygc1(t.id) ddtz from scglxt_t_bom t,scglxt_t_dd dd,scglxt_tyzd zd,scglxt_tyzd zd2  where t.SSDD=dd.id  AND t.`zddjb`=zd.id AND zd.id LIKE '06%'AND t.zddzt=zd2.`ID` AND zd2.xh LIKE '05__' and t.zddzt<>'0505' order by dd.endtime,zddjb ";
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
      //
      String sql = "SELECT gygc.id,bom.id bomid,dd.xmname ddmc,tz.tzlx,tz.url tzurl, bom.zddmc,bom.zddjb,bom.cldx,cl.clmc,zd.mc zddjbmc,bom.bmcl,dd.id ddid,bom.ddtz,bom.jgsl,DATE_FORMAT(dd.endtime, '%Y-%m-%d') ddjssj,gygc.edgs gs,jggy.gymc,gygc.kjgjs,gygc.yjgjs,gygc.bfjs,gygc.kjgjs-gygc.yjgjs-gygc.bfjs-gygc.sjjs djgjs,gygc.sjjs,"+
              "(SELECT COUNT(*) FROM scglxt_t_jggl WHERE gygc.id=gygcid) yjgcount FROM scglxt_t_gygc gygc,scglxt_t_bom bom LEFT JOIN scglxt_t_dd_tz tz ON bom.ddtz LIKE tz.tzmc LEFT JOIN scglxt_t_cl cl  ON bom.zddcz =cl.id,scglxt_t_jggy jggy,scglxt_t_dd dd,scglxt_tyzd zd where bom.ssdd=dd.id AND bom.zddjb=zd.id AND zd.id LIKE '06%' and gygc.bomid = bom.id and jggy.id = gygc.gynr and ((gygc.bfjs + gygc.yjgjs + gygc.sjjs < gygc.kjgjs) OR gygc.kjgjs='0') ";
      String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();
      String username=ActionContext.getContext().getSession().get("username").toString();
      if(username.equals("郑斌"))//如果不是管理组就过滤所述班组权限
      {
          sql=sql+" and fzbz in ('"+ssbz+"','759007553955134000012') ";
      }
      else if(!ssbz.equals("759007553955134000000") && !ssbz.equals("97306232864841111168"))//如果不是管理组就过滤所述班组权限
      {
          sql=sql+" and fzbz='"+ssbz+"'";
      }

      sql=sql + " ORDER BY  zddjb,djgjs DESC,ddjssj ";
      //log.info("获取当前待加工的所有工序sql：" + sql);
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
    String sql = "SELECT jggl.id,dd.xmname ddmc, bom.zddmc,bom.zddjb,bom.bmcl,tz.`tzlx`,tz.url tzurl,jggy.gymc,ry.rymc,sb.sbmc,jggl.jgjs,gygc.bomid,date_format(dd.endtime,'%Y-%m-%d') ddjssj,gygc.serial  FROM scglxt_t_gygc gygc,scglxt_t_bom bom  LEFT JOIN scglxt_t_dd_tz tz ON bom.ddtz LIKE CONCAT(tz.tzmc, \"%\"),scglxt_t_jggy jggy,scglxt_t_jggl jggl LEFT JOIN scglxt_t_sb sb ON sb.id = jggl.sbid , scglxt_t_ry ry, scglxt_t_dd dd  where  bom.ssdd=dd.id AND gygc.bomid = bom.id and jggy.id = gygc.gynr  and jggl.gygcid = gygc.id and ry.id = jggl.jgryid and jggl.sfjy='0'  AND jggl.jgjs IS NOT NULL order by jgkssj";

    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";

    Response.write(json);
  }

    /**
     * 检验人员检验
     */
  public void editJgglJy()
  {
    String jgglId = Request.getParameter("id");
    String bfjs = Request.getParameter("bfjs");
    String sjzt=Request.getParameter("sjzt");
    String dhyy= Request.getParameter("dhyy");

    String jyryid= ActionContext.getContext().getSession().get("userid").toString();
      //第一步更新本条加工的检验结果\

      String updatejgglColumns="jysj = now(),sfjy = '1',jyryid= '" + jyryid + "' ";
      String updategygcColumns="yjgjs = yjgjs-" + bfjs + "+(select c.jgjs from scglxt_t_jggl c where c.id = '" + jgglId + "') ,sjjs=0";
      if(sjzt.equals("2202"))//2202是报废
      {
          updatejgglColumns+=",bfjs="+bfjs;
          updategygcColumns+=",bfjs = bfjs+" + bfjs;

      }else{//返工
          updategygcColumns+=",fgcs=(select count(*) from scglxt_t_jggl_tmp where jgglid='"+jgglId+"')+1";
      }
    String sql = "update scglxt_t_jggl set "+updatejgglColumns+" where id = '" + jgglId + "'";
    
    String sql2 = "update scglxt_t_gygc a set "+updategygcColumns+" where id = (select gygcid from scglxt_t_jggl b where b.id = '" + jgglId + "' and a.id = b.gygcid)";
    try
    {
      log.info("检验人员更新加工管理表" + sql);
      this.selectDataService.execute(sql);
      log.info("检验人员更新工艺过程表" + sql2);
      this.selectDataService.execute(sql2);
        //如果有报废，则需要重新生成报废订单重新领料重新排产

         String insertSql="insert into scglxt_t_jggl_tmp(id,jgglid,jgryid,jgjs,jyryid,jgkssj,jgjssj,jysj,sbid,gygcid,dhjs,sjzt,dhyy)  " +
            "SELECT '"+ WebUtils.getRandomId()+"' id,id jgglid,jgryid,jgjs,'"+jyryid+"' jyryid,jgkssj,jgjssj,NOW() jysj,sbid,gygcid,"+bfjs+",'2201' sjzt,'"+dhyy+"' dhyy FROM scglxt_t_jggl where id='"+jgglId+"'";
        log.info("生成返工报废日志信息" + insertSql);
        this.selectDataService.execute(insertSql);


      SqlRowSet rs = getBomidAndSerial(jgglId);//获取当前加工的BOMID，工艺顺序，和可加工数量
      while (rs.next())
      {
        String bomId = rs.getString(1);
        int serial = rs.getInt(2);
        int nextSerial=serial+1;
        int kjgjs = rs.getInt(3);

         if(sjzt.equals("2202"))
         {
              newBfdd(bomId,bfjs);
         }
        String serialSql="Select * from scglxt_t_gygc where `bomid` = '" + bomId + "' and serial = '" + nextSerial + "'";

          List serialList=this.selectDataService.queryForList(serialSql);
          String sql3="";
          //判断getgygx是否还有下一道工序，如果该检验为最后一道工序则修改bom订单的状态为加工完成
          if(serialList.size()>0) {
              sql3 = "UPDATE scglxt_t_gygc  SET kjgjs = " + kjgjs + " WHERE `bomid` = '" + bomId + "' and serial = '" +nextSerial + "'";
              this.selectDataService.execute(sql3);
          }else{
              //报废件数总和+最后一道工序已加工件数=第一道工序可加工件数
              String bfjsSql="SELECT SUM(bfjs) FROM scglxt_t_gygc WHERE bomid='"+bomId+"'";
              String bfjsCount=this.selectDataService.getString(bfjsSql);

              String lastCountSql="SELECT yjgjs FROM scglxt_t_gygc WHERE  bomid='"+bomId+"' and serial='"+serial+"'";
              String lastCount=this.selectDataService.getString(lastCountSql);
              String firstCountSql="SELECT kjgjs FROM scglxt_t_gygc WHERE bomid='"+bomId+"'  AND SERIAL='0'";
              String firstCount=this.selectDataService.getString(firstCountSql);

              if(String.valueOf(Integer.parseInt(lastCount)+Integer.parseInt(bfjsCount)).equals(firstCount))
              {
                  sql3 = "UPDATE scglxt_t_bom  SET zddzt = '0503',endtime=now() WHERE `id` = '" + bomId + "'";
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
    public void newBfdd(String bomid,String jgsl)
    {
        try {
          String newBomId=WebUtils.getRandomId();

            String bomSql="INSERT INTO scglxt_t_bom(id,zddmc,zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,starttime,endtime,gs,blkssj,bljssj,clzt,cgry,cgsj,ddtz,rksj,bfjs,bhgjs,gxnr,ssdd,zddzt,clzl,bljs) "+
                    "SELECT '"+newBomId+"',concat(zddmc,'_报废单'),zddcz,clxz,cldx,cltj,clje,"+jgsl+" jgsl,bmcl,NOW(),NOW(),gs,blkssj,NULL AS bljssj,null as clzt,cgry,cgsj,ddtz,NULL AS rksj,NULL AS bfjs,NULL AS bhgjs,gxnr,ssdd,'0501' zddzt,clzl,bljs FROM scglxt_t_bom,(SELECT   @i:=0)  t  WHERE id='"+bomid+"'";

            selectDataService.execute(bomSql);
            try {
                String gygcSql="INSERT INTO scglxt_t_gygc(id,bomid,gynr,edgs,bzgs,SERIAL,sbid,zysx) SELECT CONCAT(DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),ROUND(RAND() * 1000), @i := @i + 1) id,'"+
                        newBomId.trim()+"',gynr,edgs,bzgs,SERIAL,sbid,zysx FROM scglxt_t_gygc,(SELECT @i:=0) t WHERE bomid='"+bomid+"'";
                selectDataService.execute(gygcSql);

                String gynr=selectDataService.getString("SELECT gxnr FROM scglxt_t_bom  t WHERE t.id='"+newBomId+"'");

                String sql = "update  scglxt_t_bom set  gxnr='"+gynr+"' where id = '" + newBomId + "'";

                selectDataService.execute(sql);

                Response.write("SUCCESS") ;
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                Response.write("ERROR");
            }
            Response.write("SUCCESS") ;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            Response.write("ERROR");
        }
    }

  public SqlRowSet getBomidAndSerial(String jgglId)
  {
    String sql = "SELECT a.bomid,a.serial,a.yjgjs FROM  scglxt_t_gygc a WHERE id = (SELECT gygcid FROM  scglxt_t_jggl b  WHERE b.id = '" + jgglId + "'  AND a.id = b.gygcid)";
    
    log.info("aaaaaa"+sql);
    return this.selectDataService.getSqlRowSet(sql);
  }
   //检验全部通过
    public void jyqbtg(){
        String jgglId = Request.getParameter("id");
        String jyryid= ActionContext.getContext().getSession().get("userid").toString();

        String updatejgglColumns="jysj = now(),sfjy = '1',jyryid= '" + jyryid + "',bfjs=0,fgjs=0 ";
        String updategygcColumns="yjgjs =  yjgjs+(select c.jgjs from scglxt_t_jggl c where c.id = '" + jgglId + "') ,bfjs=0,sjjs=0";

        String sql = "update scglxt_t_jggl set "+updatejgglColumns+" where id = '" + jgglId + "'";

        String sql2 = "update scglxt_t_gygc a set "+updategygcColumns+" where id = (select gygcid from scglxt_t_jggl b where b.id = '" + jgglId + "' and a.id = b.gygcid)";
        try {
            log.info("检验人员更新加工管理表" + sql);
            this.selectDataService.execute(sql);
            log.info("检验人员更新工艺过程表" + sql2);
            this.selectDataService.execute(sql2);

            SqlRowSet rs = getBomidAndSerial(jgglId);//获取当前加工的BOMID，工艺顺序，和可加工数量
            while (rs.next()) {
                String bomId = rs.getString(1);
                int serial = rs.getInt(2);
                int nextSerial = serial + 1;
                int kjgjs = rs.getInt(3);

                String serialSql = "Select * from scglxt_t_gygc where `bomid` = '" + bomId + "' and serial = '" + nextSerial + "'";

                List serialList = this.selectDataService.queryForList(serialSql);
                String sql3 = "";
                //判断getgygx是否还有下一道工序，如果该检验为最后一道工序则修改bom订单的状态为加工完成
                if (serialList.size() > 0) {
                    sql3 = "UPDATE scglxt_t_gygc  SET kjgjs = " + kjgjs + " WHERE `bomid` = '" + bomId + "' and serial = '" + nextSerial + "'";
                    this.selectDataService.execute(sql3);
                } else {
                    //报废件数总和+最后一道工序已加工件数=第一道工序可加工件数
                    String bfjsSql = "SELECT SUM(bfjs) FROM scglxt_t_gygc WHERE bomid='" + bomId + "'";
                    String bfjsCount = this.selectDataService.getString(bfjsSql);

                    String lastCountSql = "SELECT yjgjs FROM scglxt_t_gygc WHERE  bomid='" + bomId + "' and serial='" + serial + "'";
                    String lastCount = this.selectDataService.getString(lastCountSql);
                    String firstCountSql = "SELECT kjgjs FROM scglxt_t_gygc WHERE bomid='" + bomId + "'  AND SERIAL='0'";
                    String firstCount = this.selectDataService.getString(firstCountSql);

                    if (String.valueOf(Integer.parseInt(lastCount) + Integer.parseInt(bfjsCount)).equals(firstCount)) {
                        sql3 = "UPDATE scglxt_t_bom  SET zddzt = '0503',endtime=now() WHERE `id` = '" + bomId + "'";
                        this.selectDataService.execute(sql3);
                    }
                }
                log.info("更新下一步可加工件数：" + sql3);
                Response.write("success");
            }
        }catch (Exception e)
        {
            e.printStackTrace();
        }
   }
    //检验人员检验后，发现不合格全部打回
  public void jyqbdh()
  {
      String jgglId = Request.getParameter("id");
      String dhyy= Request.getParameter("dhyy");//打回原因
      String jyryid= ActionContext.getContext().getSession().get("userid").toString();

      //打回第一步：先生成打回记录
      String insertSql="insert into scglxt_t_jggl_tmp(id,jgglid,jgryid,jgjs,jyryid,jgkssj,jgjssj,jysj,sbid,gygcid,dhjs,sjzt,dhyy)  " +
              "SELECT '"+ WebUtils.getRandomId()+"' id,id jgglid,jgryid,jgjs,'"+jyryid+"' jyryid,jgkssj,jgjssj,NOW() jysj,sbid,gygcid,jgjs,'2201' sjzt,'"+dhyy+"' dhyy FROM scglxt_t_jggl where id='"+jgglId+"'";

      //打回第三步：修改加工工艺的返工次数
      String updateJggySql="update scglxt_t_gygc a set sjjs=0,fgcs=(select count(*) from scglxt_t_jggl_tmp where jgglid='"+jgglId+"') where id=(select gygcid from scglxt_t_jggl b where b.id = '" + jgglId + "' and a.id = b.gygcid)";
        //打回第二步：删掉已加工的加工记录
      String deleteJgglSql="delete from  scglxt_t_jggl  where id='"+jgglId+"'";

      try {
          log.info("增加返工日志" + insertSql);
          this.selectDataService.execute(insertSql);

          log.info("检验人员更新工艺过程表" + updateJggySql);
          this.selectDataService.execute(updateJggySql);

          log.info("检验人员删除加工管理表" + deleteJgglSql);
          this.selectDataService.execute(deleteJgglSql);

            Response.write("success");
      }catch (Exception e)
      {
          e.printStackTrace();
      }
  }
    /***
     * 加工人员开始加工
     * 选择人员点击开始加工
     */
  public void jgryKs()
  {
    String gygcid = Request.getParameter("gygcid");
    String ryid = Request.getParameter("jgryid");
    String id = "F" + RandomStringUtils.randomNumeric(39);
    String sql = "insert into scglxt_t_jggl (id,jgryid,jgkssj,gygcid) values ('" + id + "','" + ryid + "',now(),'" + gygcid + "')";
    
    log.info("加工人员开始加工：" + sql);
    try
    {

        String getgygx="Select * from scglxt_t_gygc  where id='"+gygcid+"';";
        List getgygxList=this.selectDataService.queryForList(getgygx);
        ListOrderedMap lom=(ListOrderedMap)getgygxList.get(0);
        Iterator ksi = lom.keySet().iterator();
        //如果加工人员开始加工的是第一道工序则更新BOM的订单状态
       if(lom.get("serial").toString().equals("0")) {
           String sql3 = "UPDATE scglxt_t_bom  SET zddzt ='0502' WHERE id = '" + lom.get("bomid").toString() + "'";
           this.selectDataService.execute(sql3);
       }
        if(lom.get("yjgjs").toString().equals(lom.get("kjgjs")))
        {

        }else{
            this.selectDataService.execute(sql);
        }
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
    String sql = "SELECT id,sbmc FROM scpc.scglxt_t_sb t";
      String ssbz=ActionContext.getContext().getSession().get("userssbz").toString();

      String username=ActionContext.getContext().getSession().get("username").toString();
      if(username.equals("郑斌"))//如果不是管理组就过滤所述班组权限
  {
    sql=sql+" where t.bzid in ('"+ssbz+"','759007553955134000012') ";
  }
  else if(!ssbz.equals("759007553955134000000") && !ssbz.equals("97306232864841111168"))//如果不是管理组就过滤所述班组权限
  {
      sql=sql+" where t.bzid='"+ssbz+"'";
  }

    log.info("查询加工设备" + sql);
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    Response.write(json);
  }

  //调整子订单级别
    public void updateZddjb()
    {
        String bomid = Request.getParameter("bomid");
        String jhkssj = Request.getParameter("v");
        String sql = "update scglxt_t_bom set zddjb ='" + jhkssj + "' where id ='" + bomid + "'";
        log.info("调整BOM订单级别" + sql);
        this.selectDataService.execute(sql);

        Response.write("sucess");
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
    //String sql = "SELECT bom.`zddmc`,jggy.gymc gynr,jg.`rymc` jgry,jggl.`jgjs`,sb.`sbmc` ,cast(jggl.`jgkssj` as char) jgkssj,cast(jggl.`jgjssj` as char) jgjssj ,jy.`rymc`jyry,cast(jggl.`jysj` as char)jysj,jggl.`bfjs` FROM scglxt_t_jggl jggl,scglxt_t_bom bom,scglxt_t_sb sb,scglxt_t_ry jg,scglxt_t_ry jy,scglxt_t_gygc gygc,scglxt_t_jggy jggy WHERE jg.`id` = jggl.`jgryid` AND jy.`id` = jggl.`jyryid` AND jggl.`sbid` = sb.`id` AND jggl.`gygcid` = gygc.`id` AND gygc.`bomid` = bom.`id` AND gygc.`gynr`=jggy.`id` ORDER BY jggl.`jgjssj` DESC";
    String sql="SELECT  jggl.id,dd.`xmname` 'ddmc',bom.`zddmc`,jggy.gymc 'gynr',jg.`rymc` jgry,jggl.`jgjs`,jggl.`bfjs`,sb.`sbmc`,gygc.`edgs`,TIMESTAMPDIFF(MINUTE,jggl.jgkssj,jggl.jgjssj) sjgs," +
            "  CAST(jggl.`jgkssj` AS CHAR) jgkssj,CAST(jggl.`jgjssj` AS CHAR) jgjssj FROM scglxt_t_jggy jggy,scglxt_t_jggl jggl,scglxt_t_dd dd,scglxt_t_bom bom,scglxt_t_sb sb,scglxt_t_ry jg,scglxt_t_gygc gygc " +
            "WHERE  gygc.`gynr`=jggy.`id` AND jg.`id` = jggl.`jgryid`  AND dd.id=bom.ssdd  AND jggl.`sbid` = sb.`id`  AND jggl.`gygcid` = gygc.`id`  AND gygc.`bomid` = bom.`id` ORDER BY jggl.`jgjssj` DESC ";
      log.info("排产管理查询总体加工情况: " + sql);
    
    List list = this.selectDataService.queryForList(sql);
    String json = JsonObjectUtil.list2Json(list);
    json = "{\"data\":" + json + "}";
    
    Response.write(json);
  }
}
