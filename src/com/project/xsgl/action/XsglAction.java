package com.project.xsgl.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import org.apache.commons.logging.Log;

public class XsglAction {
	
	private static Log log = org.apache.commons.logging.LogFactory.getLog(XsglAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	
	/**
	 * 获取合同列表
	 */
	public void getHeTongData(){
		String sql = "select * from xsgl_hetong_info";
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
	
	/**
	 * 添加合同
	 */
	public void addHeTong(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String htbh = request.getParameter("validation_htbh");
		String mc = request.getParameter("validation_mc");
		String ywlx = request.getParameter("validation_ywlx");
		String htje = request.getParameter("validation_htje");
		String qssj = request.getParameter("validation_qssj");
		String dqjd = request.getParameter("validation_dgjd");
		String fkzt = request.getParameter("validation_fkzt");
		String jkbfb = request.getParameter("validation_jkbfb");
		String jkje = request.getParameter("validation_jkje");
		String jscb = request.getParameter("validation_jscb");
		String hkzh = request.getParameter("validation_hkzt");
		String hkkhh = request.getParameter("validation_hkkhh");
		String remark = request.getParameter("validation_remark");
		System.out.println(htbh);
	}
}
