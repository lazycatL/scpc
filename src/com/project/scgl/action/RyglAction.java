package com.project.scgl.action;

import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;

public class RyglAction {

	private static Log log = org.apache.commons.logging.LogFactory
			.getLog(RyglAction.class);
	private SelectDataService selectDataService;

	public SelectDataService getSelectDataService() {
		return selectDataService;
	}

	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}

	/**
	 * 获取人员信息列表
	 */
	public void getRyTableData() {

		String sql = "select b.bzmc ssbz,a.id,rymc,rynl,jb.mc jsjb,dqgz from scglxt_t_ry a,scglxt_t_bz b,scglxt_tyzd jb where a.id<>'01' and a.ssbz = b.id and jb.id = a.jsjb";
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		log.info("查询人员的sql是：===" + sql);
		json = "{\"data\":" + json + "}";
		log.info("查询人员列表结果是：" + json);
		Response.write(json);
	}
	/**
	 * 添加人员
	 */
	public String addRyInfo() {

		String ryid = RandomStringUtils.randomNumeric(20);
		String rymc = Request.getParameter("rymc");
		String rynl = Request.getParameter("rynl");

		String jsjb = Request.getParameter("jsjb");
		String rzsj = Request.getParameter("rzsj");
		String ssbz = Request.getParameter("ssbz");
		int dqgz = Integer.parseInt(Request.getParameter("dqgz"));
		String sql = "insert into scglxt_t_ry (id,rymc,rynl,jsjb,rzsj,ssbz,dqgz) values ('"
				+ ryid
				+ "'"
				+ ",'"
				+ rymc
				+ "','"
				+ rynl
				+ "','"
				+ jsjb
				+ "','"
				+ rzsj
				+ "','"
				+ ssbz
				+ "',"
				+ dqgz
				+ ")";
		log.info("设备信息添加sql" + sql);
		int i = this.selectDataService.update(sql);
		
		
		if(i>0){
			
			return "rysucess";
		}else{
			
			return "ryfualt";
		}
	}

	/**
	 * 修改人员
	 */
	public String updateRyInfo() {

		String ryid = Request.getParameter("id");
		String rymc = Request.getParameter("rymc");
		String rynl = Request.getParameter("rynl");

		String jsjb = Request.getParameter("jsjb");
		String rzsj = Request.getParameter("rzsj");
		rzsj = "2014-10-24";
		String ssbz = Request.getParameter("ssbz");
		int dqgz = Integer.parseInt(Request.getParameter("dqgz"));
		String sql = "update scglxt_t_ry set rymc='" + rymc + "',rynl='"
				+ rynl + "',jsjb = '" + jsjb + "',rzsj='" + rzsj
				+ "', " + "ssbz = '" + ssbz + "',dqgz = '" + dqgz
			
				+ "' where id = '" + ryid + "'";

		log.info("设备信息更新sql" + sql);
		int i = this.selectDataService.update(sql);

		if(i>0){
			
			return "rysucess";
		}else{
			
			return "ryfualt";
		}
	}

	/**
	 * 删除人员
	 */
	public String deleteRyInfo() {

		String ryid = Request.getParameter("id");
		String sql = "delete from  scglxt_t_ry  where id = '" + ryid
				+ "'";

		log.info("删除人员信息sql" + sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "rysucess";
		}else{
			
			return "ryfualt";
		}
	}

	/**
	 * 查询人员技术级别字典
	 */
	public void getRyZdInfo() {

		String xh = Request.getParameter("xh");
		String sbid = "";
		String sql = "select id ,mc from scglxt_tyzd where xh like  '" + xh
				+ "__%'";

		log.info("查询设备字典数据sql" + sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
	/**
	 * 获得人员班组字典
	 */
	public void getRyBzInfo() {

		String sql = "select id ,bzmc from scglxt_t_bz";
		log.info("查询人员班组" + sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
	/**
	 * 根据ID获得人员信息
	 */
	public void getRyInfoById() {

		String id = Request.getParameter("id");
		String sql = "select ssbz,id,rymc,rynl,jsjb,dqgz,cast(rzsj as char)rzsj from scglxt_t_ry a where id = '"+id+"'";

		log.info("查询人员信息BYID" + sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
}
