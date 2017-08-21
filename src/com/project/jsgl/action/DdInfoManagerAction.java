/**
 * 订单信息模块类
 */
package com.project.jsgl.action;

import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigInteger;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

import com.opensymphony.xwork2.ActionContext;
import com.project.util.*;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;

import com.project.base.ActionEnum;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.xsgl.action.KhxxManagerAction;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.struts2.ServletActionContext;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DdInfoManagerAction  extends HttpServlet {
	private static Log log = org.apache.commons.logging.LogFactory.getLog(DdInfoManagerAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	/**
	 * 获取订单信息数据
	 * @response  : json 
	 */
	public void getTableData(){
		String ssht =  "";
		ssht = Request.getParameter("ssht") ;
        String wc = Request.getParameter("type") ;
		String limitStart = "";
		String limitEnd = "";
//		String sql = "select dd.id ,ssht, xmname , ddlevel,zd.mc ddlevelmc,date_format(starttime,'%Y-%m-%d') starttime," +
//				" date_format(endtime,'%Y-%m-%d') endtime, "+
//				" zgs,dqjd,tz,remark,xmlxr,xmfzr,ckzt,date_format(ckdate,'%Y-%m-%d') ckdate from scglxt_t_dd  dd,scglxt_tyzd zd WHERE 1 = 1 AND dd.`ddlevel`=zd.`ID` ";
		String sql="SELECT t.*,CAST(TRUNCATE((yjggs / zgs) * 100, 2) AS CHAR) bfb FROM (SELECT  dd.id, ssht, xmname, ddlevel, zd.mc ddlevelmc, DATE_FORMAT(dd.starttime, '%Y-%m-%d') starttime, DATE_FORMAT(dd.endtime, '%Y-%m-%d') endtime,\n" +
                "  (SELECT zgs FROM v_scglxt_zgs_dd ddgs WHERE ddgs.ddid=dd.id) zgs,fun_yjggs(dd.id) yjggs,\n" +
                "  '0' bfb,dqjd, tz,remark,xmlxr,xmfzr,ckzt,DATE_FORMAT(ckdate, '%Y-%m-%d') ckdate \n" +
                "FROM scglxt_t_dd dd LEFT JOIN scglxt_tyzd zd ON dd.`ddlevel` = zd.`ID`) t where 1=1  ";
        String username=ActionContext.getContext().getSession().get("username").toString();

        if(ssht !=null &&!ssht.equals("")){
			sql +=" and ssht = '"+ssht+"'";
		}
        if(wc !=null &&!wc.equals("")){
            sql+="AND (zgs = yjggs AND zgs<>0)";
        }else{
            sql+="AND (zgs <> yjggs OR yjggs=0)";
        }
        if(username.equals("李勇"))
        {
            sql+=" order by SUBSTRING_INDEX(xmname,'-',-1) DESC;";
        }else{
            sql+=" order by endtime;";
        }


        log.info("获得订单信息"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		Response.write(json);
	}
 
	 /**
	  * 删除合同信息
	  */
	public void  deleteRow(){
		String id = Request.getParameter("id");
		String sql = "delete from scglxt_t_dd where id = '"+id+"'";
		try {
            String jggxsql = "delete from scglxt_t_jggl where gygcid in (select id from scglxt_t_gygc where bomid in (select id from scglxt_t_bom where ssdd='"+id+"'))";
            this.selectDataService.execute(jggxsql);

            String gygxsql = "delete from scglxt_t_gygc where bomid in (select id from scglxt_t_bom where ssdd='"+id+"')";
            this.selectDataService.execute(gygxsql);

            String deletesql = "delete from scglxt_t_bom where ssdd in (select id from scglxt_t_dd where id='"+id+"')";

            selectDataService.execute(deletesql);

            this.selectDataService.execute(sql);
            Response.write("SUCCESS");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			Response.write("ERROR");
		}
		
	}
	/**
	 * 获取客户信息
	 */
	public void getDetailInfo(){
		String id = Request.getParameter("id");
		String sql = "select id ,ssht, xmname , ddlevel,date_format(starttime,'%Y-%m-%d') starttime," +
				" date_format(endtime,'%Y-%m-%d') endtime, "+
				" zgs,dqjd,tz,remark,xmlxr,xmfzr,ckzt,date_format(ckdate,'%Y-%m-%d') ckdate from scglxt_t_dd  where id = '"+id+"' ";
		List list = null ; 
		String json = null ;
		log.info("获得订单信息"+sql);
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
	 *  保存操作  ，提供新增或者更新update操作
	 */
	public void updateInfo(){
		String json = Request.getParameter("JSON");
		JSONObject JSON = JSONObject.fromObject(json);
		String ssht = JSON.getString("ssht");
		String xmname = JSON.getString("xmname");
		String ddlevel = JSON.getString("ddlevel");

		String starttime =  StringUtil.returnNotEmpty(JSON.getString("starttime")) ;
		String endtime = StringUtil.returnNotEmpty(JSON.getString("endtime"));

		String tz = JSON.getString("tz");
		String remark = JSON.getString("remark");
		String xmlxr = JSON.getString("xmlxr");
		String xmfzr = JSON.getString("xmfzr");

		String flag = JSON.getString("flag") ;
		String sql = null;
		String id  = null ;
        String nid =null;
		if(flag !=null && (flag.equals("ADD") || flag.equals("COPY"))){
			 nid = WebUtils.getRandomId();
            			sql = "INSERT INTO scglxt_t_dd (id, ssht, xmname,ddlevel,starttime,endtime,tz,remark,xmlxr,xmfzr)" +
					" VALUES ('"+nid+"', '"+ssht+"', '"+xmname+"', '"+ddlevel+"', date_format('"+starttime+"','%Y-%m-%d'), " +
					" date_format('"+endtime+"','%Y-%m-%d') ,    " +
					" '"+tz+"', '"+remark+"', '"+xmlxr+"', '"+xmfzr+"')";

		}else if(flag.equals("UPDATE")){
			id = JSON.getString("id") ; 

            			sql = " update  scglxt_t_dd set ssht='"+ssht+"',xmname = '"+xmname+"' ,ddlevel='"+ddlevel+"', " +
					" starttime=  date_format('"+starttime+"','%Y-%m-%d') , endtime=  date_format('"+endtime+"','%Y-%m-%d') ," +
					"tz='"+remark+"',remark='"+remark+"',xmlxr='"+xmlxr+"',xmfzr='"+xmfzr+"'  where id = '"+id+"' ";
		}
		try {
			selectDataService.execute(sql);
            if(flag.equals("COPY"))
            {
                id = JSON.getString("id") ;
                copyRow(id,nid);
            }
			Response.write(Constants.UPDATE_SUCCESS);
		} catch (Exception e) {
			Response.write(Constants.UPDATE_ERROR);
			e.printStackTrace();
		}
	}

	/**
	 * 加载订单列表
	 */
	public void loadDdList(){
		String pid =  Request.getParameter("pid") ;
		String sql = "SELECT  id  ,xmname mc   FROM scpc.scglxt_t_dd order by   xmname " ;
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}

    /**
     * 获取该订单工时，金额相关数据
     */
    public void getTjInfo(){
        String id=Request.getParameter("id");
       // String sql="SELECT gc.gynr,gy.gymc,SUM(gc.edgs*bom.jgsl) gs,REPLACE(FORMAT(SUM(bom.clje*bom.jgsl),2),',','') je,bom.jgsl FROM scglxt_t_gygc gc,scglxt_t_bom bom,scglxt_t_dd dd,scglxt_t_jggy gy WHERE gc.bomid=bom.id AND bom.ssdd=dd.id AND gc.gynr=gy.id AND dd.id='"+id+"' GROUP BY gynr";
        //String sql="SELECT dd.xmname ddmc,bom.zddmc,cl.clmc,bom.bljs, REPLACE(FORMAT(SUM(bom.clje * bom.bljs), 2),',','') je," +
        //        "  bom.jgsl FROM scglxt_t_cl cl, scglxt_t_bom bom, scglxt_t_dd dd WHERE cl.id=bom.zddcz AND bom.ssdd = dd.id  AND dd.id = '"+id+"'  GROUP BY zddcz";
        String sql=" SELECT bom.id,bom.`zddmc`,cl.clmc,bom.`cldx`,TRUNCATE(bom.`clzl`,2) clzl,cl.cldj,bom.clje,abs(bom.bljs) bljs FROM scglxt_t_bom bom,scglxt_t_cl cl,scglxt_t_dd dd  WHERE bom.zddcz=cl.id AND   bom.ssdd = dd.id \n" +
                "  AND dd.id = '"+id+"'";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        Response.write(json);
    }
    //订单复制功能
    public void copyRow(String yid,String nid)
    {
           try {

            //复制订单的同时也要复制订单下的所有BOM和工艺
//            String bomSql="INSERT INTO scglxt_t_bom(id,zddmc,zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,starttime,endtime,gs,blkssj,bljssj,clzt,cgry,cgsj,ddtz,rksj,bfjs,bhgjs,gxnr,ssdd,zddzt,clzl,bljs) "+
//            "SELECT CONCAT(DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),ROUND(RAND() * 1000), @i := @i + 1) id,zddmc,zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,NOW(),NOW(),gs,blkssj,NULL AS bljssj,clzt,cgry,cgsj,ddtz,NULL AS rksj,NULL AS bfjs,NULL AS bhgjs,gxnr,'"+nid+"' ssdd,'0501' zddzt,clzl,bljs FROM scglxt_t_bom,(SELECT   @i:=0)  t  WHERE ssdd='"+yid+"'";
//            selectDataService.execute(bomSql);

            String selectBomSql="SELECT id,zddmc,zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,NOW(),NOW(),gs,blkssj,NULL AS bljssj,clzt,cgry,cgsj,ddtz,NULL AS rksj,NULL AS bfjs,NULL AS bhgjs,gxnr,'"+nid+"' ssdd,'0501' zddzt,clzl,bljs FROM scglxt_t_bom,(SELECT   @i:=0)  t  WHERE ssdd='"+yid+"'";

            List bomList=selectDataService.queryForList(selectBomSql);

            for(int i=0;i<bomList.size();i++)
            {
                String newBomId=WebUtils.getRandomId();
                Map<String,Object> map = (Map<String, Object>) bomList.get(i);
                String bomSql="INSERT INTO scglxt_t_bom(id,zddmc,zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,starttime,endtime,gs,blkssj,bljssj,clzt,cgry,cgsj,ddtz,rksj,bfjs,bhgjs,gxnr,ssdd,zddzt,clzl,bljs) "+
                        "SELECT '"+newBomId+"',zddmc,zddcz,clxz,cldx,cltj,clje,jgsl,bmcl,NOW(),NOW(),gs,blkssj,NULL AS bljssj,null as clzt,cgry,cgsj,ddtz,NULL AS rksj,NULL AS bfjs,NULL AS bhgjs,gxnr,'"+nid+"' ssdd,'0501' zddzt,clzl,bljs FROM scglxt_t_bom,(SELECT   @i:=0)  t  WHERE id='"+map.get("id").toString()+"'";

                selectDataService.execute(bomSql);

                String gygcSql="INSERT INTO scglxt_t_gygc(id,bomid,gynr,edgs,SERIAL,sbid,zysx,bzgs) SELECT CONCAT(DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),ROUND(RAND() * 1000), @i := @i + 1) id,"+
                        "'"+newBomId+"' bomid,gynr,edgs,SERIAL,sbid,zysx,bzgs FROM scglxt_t_gygc,(SELECT @i:=0) t WHERE bomid='"+map.get("id").toString()+"'";
                selectDataService.execute(gygcSql);
            }
            Response.write("SUCCESS") ;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            Response.write("ERROR");
        }
    }
    //获取订单进度
    public void getDdjdInfo()
    {
        String sql="SELECT ddid,ddmc,CAST(dd.endtime AS CHAR) endtime,CAST(CONVERT(yjggs,DECIMAL) AS CHAR) yjggs,zgs,CAST(TRUNCATE((yjggs/zgs)*100,2) AS CHAR) bfb  FROM (\n" +
                "SELECT \n" +
                "  bom.SSDD,gx.bomid,gx.gynr,SUM(((gx.bzgs/gx.kjgjs)*gl.jgjs)) yjggs,\n" +
                "  gl.jgjs \n" +
                "FROM\n" +
                "  scglxt_t_bom bom,\n" +
                "  scglxt_t_gygc gx,\n" +
                "  scglxt_t_jggl gl \n" +
                "WHERE  bom.id = gx.bomid AND gl.SFJY='1' \n" +
                "  AND gx.id = gl.gygcid GROUP BY ssdd ) t,`v_scglxt_zgs_dd` dd\n" +
                "  WHERE t.ssdd =dd.ddid";
        try {
            List list = this.selectDataService.queryForList(sql);
            String json = JsonObjectUtil.list2Json(list);
            Response.write(json);
        }catch (Exception e)
        {
            e.printStackTrace();
        }
    }
    /**
     * 获取本日和本月新增合同和新增订单的信息
     */
    public void getVueTjData(){
        String sql="SELECT t.id,kh.mc,t.htbh FROM scglxt_t_ht t,scglxt_t_kh kh WHERE t.`khid`=kh.id AND  DATEDIFF(sjcjsj,NOW()) >-7";
        List htlist = this.selectDataService.queryForList(sql);
        String thjson = JsonObjectUtil.list2Json(htlist);
        String ddsql="SELECT t.id,kh.mc khmc,ht.`htbh`,t.`xmname` FROM scglxt_t_dd t,scglxt_t_ht ht,scglxt_t_kh kh WHERE t.ssht=ht.id AND ht.`khid`=kh.id AND  DATEDIFF(t.sjcjsj,NOW()) >-7";
        List ddlist = this.selectDataService.queryForList(ddsql);
        String ddjson = JsonObjectUtil.list2Json(ddlist);
        String json="[{\"ht\":"+thjson+",\"dd\":"+ddjson+"}]";
        Response.write(json);
    }
    //批量修改订单时间
    public void updateDdDate()
    {
        String json = Request.getParameter("infos");
        String type=Request.getParameter("type");
        String [] dates=json.split("#");
        if(type.equals("dd")) {
            for (int i = 0; i < dates.length; i++) {
                String[] info = dates[i].split(",");
                String sql = "Update scglxt_t_dd set starttime='" + info[1] + "',endtime='" + info[2] + "' where id='" + info[0] + "'";
                try {
                    selectDataService.execute(sql);
                } catch (Exception e) {
                    e.printStackTrace();
                    Response.write("ERROR");
                }
            }
        }else{
            for (int i = 0; i < dates.length; i++) {
                String[] info = dates[i].split(",");
                String sql = "Update scglxt_t_bom set starttime='" + info[1] + "',endtime='" + info[2] + "' where id='" + info[0] + "'";
                try {
                    selectDataService.execute(sql);
                } catch (Exception e) {
                    e.printStackTrace();
                    Response.write("ERROR");
                }
            }
        }
        Response.write("SUCCESS") ;
    }
    /***
     * 导出
     */
    public void exportData()
    {
        HttpServletResponse response= ServletActionContext.getResponse();
        String excelName = "";
        String ddid=Request.getParameter("ddid");
        String ddSql="SELECT ht.`htbh`,xmname,zd.mc ddjb,endtime,xmlxr,xmfzr,starttime FROM scglxt_t_dd dd,scglxt_t_ht ht,scglxt_tyzd zd WHERE dd.`ssht`=ht.`id` AND dd.`ddlevel`=zd.`ID` AND zd.xh LIKE '04__' and dd.id='"+ddid+"'";

        String tjSql="SELECT gymc,CEIL(SUM(bzgs)/60) zgs FROM scglxt_t_gygc gc,`scglxt_t_jggy` gy WHERE gc.`gynr`=gy.id AND bomid IN (SELECT id FROM scglxt_t_bom WHERE ssdd='"+ddid+"') GROUP BY gymc";

        String[] ddheaders = new String[]{"加工项目BOM表-","客户编号","项目联络人","项目名称","项目执行人","项目下单日期","交货日期","项目重要程度"};
        String[] headers = new String[]{"序号","名称/图号","材质","备料尺寸","加工数量","加工工序","表面处理","备注","实际完成时间"};
        try {
            String bomSql="SELECT  (@rownum := @rownum + 1) AS rownum, bom.id, zddmc,  t2.clmc, cldx, jgsl, gxnr, bmcl, '' AS bz, DATE_FORMAT(endtime, '%Y-%m-%d %h:%m') endtime \n" +
                    "FROM scglxt_t_bom bom  LEFT JOIN scglxt_t_cl t2   ON bom.zddcz = t2.id  WHERE ssdd = '"+ddid+"' ";
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
            sheet.setColumnWidth((short)3,(short)12*256);
            sheet.setColumnWidth((short)4,(short)7*256);
            sheet.setColumnWidth((short)5,(short)40*256);
            sheet.setColumnWidth((short)6,(short)20*256);
            sheet.setColumnWidth((short)7,(short)6*256);
            sheet.setColumnWidth((short)8,(short)15*256);
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
            HSSFRichTextString textKhbh = new HSSFRichTextString("组件");
            cellKhbh.setCellValue(textKhbh);
            row1.createCell(1).setCellStyle(style2);
            row1.createCell(3).setCellStyle(style2);
            row1.createCell(4).setCellStyle(style2);
            HSSFCell cellKhbhnr = row1.createCell(2);
            cellKhbhnr.setCellStyle(style3);
          //  HSSFRichTextString textKhbhnr = new HSSFRichTextString(ddmap.get("htbh").toString());
            cellKhbhnr.setCellValue("");

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
            row3.createCell(7).setCellStyle(style2);
            row3.createCell(8).setCellStyle(style2);
            celljhrqnr.setCellStyle(style3);
            HSSFRichTextString textjhrqnr = new HSSFRichTextString(ddmap.get("endtime").toString());
            celljhrqnr.setCellValue(textjhrqnr);

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

            row4.createCell(5).setCellStyle(style2);
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
            HSSFSheet sheet1=workbook.createSheet("工艺工序");

            sheet1.setColumnWidth((short)0,(short)3*256);
            sheet1.setColumnWidth((short)1,(short)10*256);
            sheet1.setColumnWidth((short)2,(short)16*256);
            sheet1.setColumnWidth((short)3,(short)12*256);
            sheet1.setColumnWidth((short)4,(short)10*256);
            sheet1.setColumnWidth((short)5,(short)10*256);
            sheet1.setColumnWidth((short)6,(short)10*256);
            sheet1.setColumnWidth((short)7,(short)10*256);
            sheet1.setColumnWidth((short)7,(short)10*256);

            int rownum=0;
            for (int i=0;i<mapList.size();i++) {
                Map<String,Object> map = (Map<String, Object>) mapList.get(i);
                row = sheet.createRow(i+7);
                int j = 0;
                int newRownum=ExcelExportUtil.exportGygx(Integer.toString(i),selectDataService,map.get("id").toString(),workbook,sheet1,style2,style3,rownum,map.get("bmcl")==null?"":map.get("bmcl").toString());
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
                        if (value == null) {
                            value = "";
                        }
                        HSSFCell hc = row.createCell(j++);
                        hc.setCellStyle(styleleft);
                        hc.setCellValue(String.valueOf(value));
                    }
                }
                rownum=rownum+newRownum;
            }
            //查询工艺工序统计结果并写入到订单最后一行中
            //合并第二行6-8单元格
            Region regiontj = new Region(7+mapList.size(), (short) 0, 7+mapList.size(), (short)7);
            sheet.addMergedRegion(regiontj);

            List tjList = this.selectDataService.queryForList(tjSql);
            HSSFRow tjrow = sheet.createRow(7+mapList.size());
            tjrow.setHeightInPoints(22);
            String tjInfo="工艺总工时统计：";
            int hj=0;
            if(tjList.size()>0) {
                for (int i = 0; i < tjList.size(); i++) {
                    Map<String, Object> map = (Map<String, Object>) tjList.get(i);
                    tjInfo+=map.get("gymc").toString()+"("+map.get("zgs").toString()+")-";
                    hj=hj+Integer.valueOf(map.get("zgs").toString());
                }
                tjInfo=tjInfo.substring(0,tjInfo.length()-1);
            }
            HSSFCell hc = tjrow.createCell(0);
            hc.setCellStyle(styleleft);
            hc.setCellValue(String.valueOf(tjInfo));
            tjrow.createCell(1).setCellStyle(style3);
            tjrow.createCell(2).setCellStyle(style3);
            tjrow.createCell(3).setCellStyle(style3);
            tjrow.createCell(4).setCellStyle(style3);
            tjrow.createCell(5).setCellStyle(style3);
            tjrow.createCell(6).setCellStyle(style3);
            tjrow.createCell(7).setCellStyle(style3);
            HSSFCell tj = tjrow.createCell(8);
            tj.setCellStyle(styleleft);
            tj.setCellValue(String.valueOf("合计："+String.valueOf(hj)+""));

            //打印设置
            HSSFPrintSetup ps = sheet1.getPrintSetup();
            ps.setLandscape(true); //打印方向，true:横向，false:纵向
            ps.setPaperSize(HSSFPrintSetup.A4_PAPERSIZE); //纸张

            sheet1.setMargin(HSSFSheet.TopMargin,(double)1);// 页边距（上）
            sheet1.setMargin(HSSFSheet.BottomMargin,(double)0.6);// 页边距（下）
            sheet1.setMargin(HSSFSheet.LeftMargin,(double)0.95 );// 页边距（左）
            sheet1.setMargin(HSSFSheet.RightMargin,(double)0.95);// 页边距（右）
            sheet1.setHorizontallyCenter(true); //设置打印页面为水平居中

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
