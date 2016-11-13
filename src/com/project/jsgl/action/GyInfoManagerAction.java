/**
 * 订单信息模块类
 */
package com.project.jsgl.action;

import java.util.List;

import com.project.util.Constants;
import net.sf.json.JSONObject;

import oracle.jdbc.driver.Const;
import org.apache.commons.logging.Log;

import com.project.base.ActionEnum;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.WebUtils;
import com.project.xsgl.action.KhxxManagerAction;

public class GyInfoManagerAction {
	private static Log log = org.apache.commons.logging.LogFactory.getLog(KhxxManagerAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	/**
	 * 获取表格信息
	 * @response  : json 
	 */
	public void getTableData(){
		String limitStart = "";
		String limitEnd = "";
		String sql = " select  id ,sszdd,gxbh,gxsx,gxsysb,jgjs,bzid ,ryid ,ghjgs, "+
				" 	date_format(jhstarttime,'%Y-%m-%d')  jhstarttime ,date_format(jhendtime,'%Y-%m-%d')  jhendtime ,"+
				" gzlsfbh,gxtz,jggy,sfyjwc,ywcjs,wcbfb,date_format(wcsj,'%Y-%m-%d')  wcsj,jgmx,pjjggs "+ 
				" from scgl_scpc_info  where 1=1 ";
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		Response.write(json);
	}
 
	 /**
	  * 删除条目
	  */
	public void  deleteRow(){
		String id = Request.getParameter("id");
		String sql = "delete from xsgl_jggx_info where id = '"+id+"'";
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
		String id = "1" ;
		String sql = " select  id ,sszdd,gxbh,gxsx,gxsysb,jgjs,bzid ,ryid ,ghjgs, "+
				" 	date_format(jhstarttime,'%Y-%m-%d')  jhstarttime ,date_format(jhendtime,'%Y-%m-%d')  jhendtime ,"+
				" gzlsfbh,gxtz,jggy,sfyjwc,ywcjs,wcbfb,date_format(wcsj,'%Y-%m-%d')  wcsj,jgmx,pjjggs "+ 
				" from scgl_scpc_info  where 1=1  and id = '1' ";
		List list = null ; 
		String json = null ;
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
		String sszdd = JSON.getString("sszdd");
		String gxbh = JSON.getString("gxbh");
		String gxsx = JSON.getString("gxsx");
		String gxsysb = JSON.getString("gxsysb");
		String jgjs = JSON.getString("jgjs");
		String bzid = JSON.getString("bzid");
		String ryid = JSON.getString("ryid");
		String ghjgs = JSON.getString("ghjgs");
		String jhstarttime = JSON.getString("jhstarttime");
		String jhendtime = JSON.getString("jhendtime");
		String gzlsfbh = JSON.getString("gzlsfbh");
		String gxtz = JSON.getString("gxtz");
		String jggy = JSON.getString("jggy");
		String sfyjwc = JSON.getString("sfyjwc");
		String ywcjs = JSON.getString("ywcjs");
		String wcbfb = JSON.getString("wcbfb");
		String wcsj = JSON.getString("wcsj");
		String jgmx = JSON.getString("jgmx");
		String pjjggs = JSON.getString("pjjggs");
		String flag = JSON.getString("flag") ;
		String sql = null;
		String id = WebUtils.getRandomId();
//		flag = "UPDATE";
		if(flag !=null && flag.equals("ADD")){
			sql = "INSERT INTO `scgl_scpc_info` (`id`, `sszdd`, `gxbh`, `gxsx`, `gxsysb`, `jgjs`, `bzid`, `ryid`, `ghjgs`, " +
					"`jhstarttime`, `jhendtime`, `gzlsfbh`, `gxtz`, `jggy`, `sfyjwc`, `ywcjs`, `wcbfb`, `wcsj`, `jgmx`, `pjjggs`) VALUES " +
					"('"+id+"', '"+sszdd+"', '"+gxbh+"', '"+gxsx+"', '"+gxsysb+"', '"+jgjs+"', '"+bzid+"', '"+ryid+"', '"+ghjgs+"', " +
					" date_format('"+jhstarttime+"','%Y-%m-%d'), date_format('"+jhendtime+"','%Y-%m-%d'), '"+gzlsfbh+"', '"+gxtz+"', '"+jggy+"', " +
					"'"+sfyjwc+"', '"+ywcjs+"', '"+wcbfb+"', date_format('"+wcsj+"','%Y-%m-%d') , '"+jgmx+"', '"+pjjggs+"');  ";
		}else if(flag.equals("UPDATE")){
			id = "1";
			sql = "update scgl_scpc_info set sszdd = '"+sszdd+"' ,gxbh = '"+gxbh+"' ,gxsx = '"+gxsx+"' ,gxsysb = '"+gxsysb+"' ,jgjs = '"+jgjs+"' ," +
					" bzid = '"+bzid+"' ,ryid = '"+ryid+"' ,ghjgs = '"+ghjgs+"' ,jhstarttime = date_format('"+jhstarttime+"','%Y-%m-%d') ," +
					" jhendtime = date_format('"+jhendtime+"','%Y-%m-%d') , gzlsfbh = '"+gzlsfbh+"' ,gxtz = '"+gxtz+"' ,jggy = '"+jggy+"' ," +
					" sfyjwc = '"+sfyjwc+"' ,ywcjs = '"+ywcjs+"' ,wcbfb = '"+wcbfb+"' ,wcsj =  date_format('"+wcsj+"','%Y-%m-%d') ," +
					" jgmx = '"+jgmx+"' ,pjjggs =  '"+pjjggs+"'" +
					" where 1=1  and id = '"+id+"'";
		}
		try {
			selectDataService.execute(sql);
			Response.write(Constants.UPDATE_SUCCESS);
		} catch (Exception e) {
			Response.write(Constants.UPDATE_ERROR);
			e.printStackTrace();
		}
	}
	
	
}
