package com.project.scgl.action;

import java.util.List;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;

public class BzglAction {

	private static Log log = org.apache.commons.logging.LogFactory.getLog(BzglAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	
	/**
	 * 获取班组列表
	 */
	public void getBzTableData(){
		String sql = "select id,bzmc,bzfzr from scglxt_t_bz";
		log.info("班组信息查询sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		
		Response.write(json);
	}
	
	/**
	 * 添加班组
	 */
	public String addBzInfo(){
		
		String bzid = RandomStringUtils.randomNumeric(20);
		String bzmc = Request.getParameter("bzmc");
		String bzfzr = Request.getParameter("bzfzr");
		
		String sql = "insert into scglxt_t_bz (id,bzmc,bzfzr) values ('"+bzid+"'" +
				",'"+bzmc+"','"+bzfzr+"')";
		log.info("班组添加sql"+sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "bzsuccess";
		}else{
			
			return "bzfault";
		}
		
	}
	
	/**
	 * 修改班组
	 */
	public String updateBzInfo(){
		
		String bzid = Request.getParameter("id");
		String bzmc = Request.getParameter("bzmc");
		String bzfzr = Request.getParameter("bzfzr");
		
		String sql = "update scglxt_t_bz set bzmc='"+bzmc+"',bzfzr='"+bzfzr+"' where id = '"+bzid+"'";
		
		log.info("班组信息更新sql======"+sql);
		int i = this.selectDataService.update(sql);
		if(i>0){
			
			return "bzsuccess";
		}else{
			
			return "bzfault";
		}
	}
	
	/**
	 * 删除班组
	 */
	public String deleteBzInfo(){
		
		String id = Request.getParameter("id");
		String sql = "delete from  scglxt_t_bz  where id = '"+id+"'";
		
		log.info("删除班组信息sql======"+sql);
		int i = this.selectDataService.update(sql);
		if(i>0){
			
			return "bzsuccess";
		}else{
			
			return "bzfault";
		}
	}
	
	
	/**
	 * 获得班组信息根据班组ID
	 */
	public void getBzInfoById(){
		
		String id = Request.getParameter("id");
		String sbid = "";
		String sql = "select id,bzmc,bzfzr from scglxt_t_bz where id = '"+id+"'";
		
		log.info("获得班组信息根据班组ID的sql=============="+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
}
