package com.project.cggl.action;

import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.scgl.action.RyglAction;
import com.project.util.JsonObjectUtil;
import com.project.xsgl.action.XsglAction;

public class GhsglAction {

	private static Log log = org.apache.commons.logging.LogFactory.getLog(GhsglAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	
	/**
	 * 获得供货商列表
	 */
	public void getGhsTableData(){
		String sql = "select id,spmc,gsmc,gsdz,lxr,lxfs from scglxt_t_ghs";
		log.info("供货商列表sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		
		Response.write(json);
	}
	
	/**
	 * 添加供货商
	 */
	public String addGhsInfo(){
		
		String ghsid = RandomStringUtils.randomNumeric(20);
		String spmc = Request.getParameter("spms");
		String gsmc = Request.getParameter("gsmc");
		
		String gsdz = Request.getParameter("gsdz");
		String lxr = Request.getParameter("lxr");
		String lxfs = Request.getParameter("lxfs");
		
		String sql = "insert into scglxt_t_ghs (id,spmc,gsmc,gsdz,lxr,lxfs) values ('"+ghsid+"'" +
				",'"+spmc+"','"+gsmc+"','"+gsdz+"','"+lxr+"','"+lxfs+"')";
		log.info("供货商信息添加sql"+sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "ghssuccess";
		}else{
			
			return "ghsfault";
		}
	}
	
	/**
	 * 修改供货商
	 */
	public String updateGhsInfo(){
		
		String id = Request.getParameter("id");
		String spmc = Request.getParameter("spms");
		String gsmc = Request.getParameter("gsmc");
		
		String gsdz = Request.getParameter("gsdz");
		String lxr = Request.getParameter("lxr");
		String lxfs = Request.getParameter("lxfs");
		
		
		String sql = "update scglxt_t_ghs set spmc='"+spmc+"',gsmc='"+gsmc+"',gsdz = '"+gsdz+"',lxr='"+lxr+"', " +
				"lxfs = '"+lxfs+"' where id = '"+id+"'";
		
		log.info("供货商更新sql"+sql);
		
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "ghssuccess";
		}else{
			
			return "ghsfault";
		}
	}
	
	/**
	 * 删除供货商
	 */
	public String deleteGhsInfo(){
		
		String id = Request.getParameter("id");
		String sql = "delete from  scglxt_t_ghs where id = '"+id+"'";
		
		log.info("删除供货商信息sql"+sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "ghssuccess";
		}else{
			
			return "ghsfault";
		}
	}
	
	/**
	 * 获得供货商信息BYID
	 */
	public void getGhsInfoById(){
		
		String id = Request.getParameter("id");
		String sbid = "";
		String sql = "select id,spmc,gsmc,gsdz,lxr,lxfs from scglxt_t_ghs where id = '"+id+"'";
		
		log.info("获得供货商信息BYIDsql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
}
