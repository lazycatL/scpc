/**
 * 订单信息模块类
 */
package com.project.jsgl.action;

import java.io.*;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import com.opensymphony.xwork2.ActionContext;
import com.project.util.Constants;
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
import com.project.util.JsonObjectUtil;
import com.project.util.StringUtil;
import com.project.util.WebUtils;
import com.project.xsgl.action.KhxxManagerAction;
import org.apache.struts2.ServletActionContext;

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
	 * 获取合同信息数据
	 * @response  : json 
	 */
	public void getTableData(){
		String ssht =  "";
		ssht = Request.getParameter("ssht") ;
		String limitStart = "";
		String limitEnd = "";
//		String sql ="select id ,mc,htbh , ywlx ,htje,date_format(qssj,'%Y-%m-%d') qssj,dqjd,fkzt,jkbfb,jkje,jscb,hkzh,hkkhh,remark from xsgl_hetong_info ";
		String sql = "select id ,ssht, xmname , ddlevel,date_format(jhdate,'%Y-%m-%d') jhdate ,date_format(planstarttime,'%Y-%m-%d') planstarttime," +
				" date_format(planendtime,'%Y-%m-%d') planendtime,date_format(realstarttime,'%Y-%m-%d') realstarttime,date_format(realendtime,'%Y-%m-%d') realendtime, "+
				" zgs,dqjd,tz,remark,xmlxr,xmfzr,ckzt,date_format(ckdate,'%Y-%m-%d') ckdate from scglxt_t_dd  where 1=1 ";
		if(ssht !=null &&!ssht.equals("")){
			sql +=" and ssht = '"+ssht+"'";
		}
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
			selectDataService.execute(sql);
			Response.write("SUCCESS") ;
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
		String sql = "select id ,ssht, xmname , ddlevel,date_format(jhdate,'%Y-%m-%d') jhdate ,date_format(planstarttime,'%Y-%m-%d') planstarttime," +
				" date_format(planendtime,'%Y-%m-%d') planendtime,date_format(realstarttime,'%Y-%m-%d') realstarttime,date_format(realendtime,'%Y-%m-%d') realendtime, "+
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
		String jhdate = StringUtil.returnNotEmpty(JSON.getString("jhdate"));
		String planstarttime =  StringUtil.returnNotEmpty(JSON.getString("planstarttime")) ;
		String planendtime = StringUtil.returnNotEmpty(JSON.getString("planendtime"));
//		String realstarttime = StringUtil.returnNotEmpty(JSON.getString("realstarttime"));
//		String realendtime = StringUtil.returnNotEmpty(JSON.getString("realendtime"));
//		String zgs = JSON.getString("zgs");
//		String dqjd = JSON.getString("dqjd");
		String tz = JSON.getString("tz");
		String remark = JSON.getString("remark");
		String xmlxr = JSON.getString("xmlxr");
		String xmfzr = JSON.getString("xmfzr");
//		String ckzt = JSON.getString("ckzt");
//		String ckdate = StringUtil.returnNotEmpty(JSON.getString("ckdate"));
//		if(ckdate != null ){
//			ckdate = "date_format('"+ckdate+"','%Y-%m-%d')" ;
//		}
		String flag = JSON.getString("flag") ;
		String sql = null;
		String id  = null ;  
		 
		if(flag !=null && flag.equals("ADD")){
			id = WebUtils.getRandomId(); 
//			sql = "INSERT INTO scglxt_t_dd (id, ssht, xmname,ddlevel,jhdate,planstarttime,planendtime,zgs,dqjd,tz,remark,xmlxr,xmfzr, ckzt, ckdate)" +
//					" VALUES ('"+id+"', '"+ssht+"', '"+xmname+"', '"+ddlevel+"', date_format('"+jhdate+"','%Y-%m-%d'), date_format('"+planstarttime+"','%Y-%m-%d'), " +
//					" date_format('"+planendtime+"','%Y-%m-%d') ,    " +
//					" '"+zgs+"', '"+dqjd+"', '"+tz+"', '"+remark+"', '"+xmlxr+"', '"+xmfzr+"', '"+ckzt+"'," + ckdate +")";
            			sql = "INSERT INTO scglxt_t_dd (id, ssht, xmname,ddlevel,jhdate,planstarttime,planendtime,tz,remark,xmlxr,xmfzr)" +
					" VALUES ('"+id+"', '"+ssht+"', '"+xmname+"', '"+ddlevel+"', date_format('"+jhdate+"','%Y-%m-%d'), date_format('"+planstarttime+"','%Y-%m-%d'), " +
					" date_format('"+planendtime+"','%Y-%m-%d') ,    " +
					" '"+tz+"', '"+remark+"', '"+xmlxr+"', '"+xmfzr+"')";
		}else if(flag.equals("UPDATE")){
			id = JSON.getString("id") ; 
//			sql = " update  scglxt_t_dd set ssht='"+ssht+"',xmname = '"+xmname+"' ,ddlevel='"+ddlevel+"',jhdate= date_format('"+jhdate+"','%Y-%m-%d'), " +
//					" planstarttime=  date_format('"+planstarttime+"','%Y-%m-%d') , planendtime=  date_format('"+planendtime+"','%Y-%m-%d') ," +
//					" zgs = '"+zgs+"',dqjd='"+dqjd+"',tz='"+remark+"',remark='"+remark+"',xmlxr='"+xmlxr+"',xmfzr='"+xmfzr+"' ,ckzt='"+ckzt+"' , " +
//					" ckdate=   " + ckdate +
//					" where id = '"+id+"' ";
            			sql = " update  scglxt_t_dd set ssht='"+ssht+"',xmname = '"+xmname+"' ,ddlevel='"+ddlevel+"',jhdate= date_format('"+jhdate+"','%Y-%m-%d'), " +
					" planstarttime=  date_format('"+planstarttime+"','%Y-%m-%d') , planendtime=  date_format('"+planendtime+"','%Y-%m-%d') ," +
					"tz='"+remark+"',remark='"+remark+"',xmlxr='"+xmlxr+"',xmfzr='"+xmfzr+"'  where id = '"+id+"' ";
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
        String sql="SELECT gc.gynr,gy.gymc,SUM(gc.edgs*bom.jgsl) gs,REPLACE(FORMAT(SUM(bom.clje*bom.jgsl),2),',','') je,bom.jgsl FROM scglxt_t_gygc gc,scglxt_t_bom bom,scglxt_t_dd dd,scglxt_t_jggy gy WHERE gc.bomid=bom.id AND bom.ssdd=dd.id AND gc.gynr=gy.id AND dd.id='"+id+"' GROUP BY gynr";
        List list = this.selectDataService.queryForList(sql);
        String json = JsonObjectUtil.list2Json(list);
        Response.write(json);
    }
}
