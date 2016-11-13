package com.project.scgl.action;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.xsgl.action.XsglAction;
public class SbglAction {

	private static Log log = org.apache.commons.logging.LogFactory.getLog(SbglAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	
	/**
	 * 获取设备列表
	 */
	public void getSbTableData(){
		String sql = "select sbbz.bzmc sbbz,sb.sbxh,sb.ccbh,sb.id,sblx.mc sblx,sbmc, cast(cgsj as char) cgsj, " +
				" cast(bxjssj as char) bxjssj,sbszd,sbzt.mc sbzt,wxjl,sb.sccj,sb.sccjdetail ,remark from " +
				" scglxt_t_sb sb, scglxt_tyzd sblx,scglxt_tyzd sbzt,scglxt_t_bz sbbz " +
				" where sbzt.id = dqzt and sblx.id = sblx and bzid = sbbz.id";
		log.info("设备信息查询sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		
		Response.write(json);
	}
	
	/**
	 * 添加设备
	 */
	public String addSbInfo(){
		String sbid = RandomStringUtils.randomNumeric(20);
		String sblx = Request.getParameter("sblx");
		String sbmc = Request.getParameter("sbmc");
		String sbcgsj = Request.getParameter("cgsj");
		String sbbxjssj = Request.getParameter("wbjz");
		String sbszd = Request.getParameter("cfdd");
		String sbzt = Request.getParameter("sbzt");
		String sbwxjl = Request.getParameter("wxjl");
		String sbremark = Request.getParameter("bz");
		String sbbz = Request.getParameter("sbbz");
		String sccj = Request.getParameter("sccj");
		String sccjdetail = Request.getParameter("sccjdetail");
        String sbxh=Request.getParameter("sbxh");
        String ccbh=Request.getParameter("ccbh");
        if ((sbcgsj == null) || ("".equals(sbcgsj))) {
            sbcgsj = "now()";
        }else{
            sbcgsj = "'"+sbcgsj+"'";
        }
        if ((sbbxjssj == null) || ("".equals(sbbxjssj))) {
            sbbxjssj = "now()";
        }else{
            sbbxjssj = "'"+sbbxjssj+"'";
        }
		String sql = "insert into scglxt_t_sb (id,sblx,sbmc,cgsj,bxjssj,sbszd,dqzt,wxjl,remark,bzid,sccj,sccjdetail,sbxh,ccbh) values ('"+sbid+"'" +
				",'"+sblx+"','"+sbmc+"',"+sbcgsj+","+sbbxjssj+",'"+sbszd+"','"+sbzt+"','"+sbwxjl+"','"+sbremark+"','"+sbbz+"','"+sccj+"','"+sccjdetail+"','"+sbxh+"','"+ccbh+"')";
		log.info("设备信息添加sql："+sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "sbsuccess";
		}else{
			
			return "sbfault";
		}
	}
	
	/**
	 * 添加设备
	 */
	public String updateSbInfo(){
		
		String sbid = Request.getParameter("id");
		String sblx = Request.getParameter("sblx");
		String sbmc = Request.getParameter("sbmc");
		String sbcgsj = Request.getParameter("cgsj");
		String sbbxjssj = Request.getParameter("wbjz");
		String sbszd = Request.getParameter("cfdd");
		String sbzt = Request.getParameter("sbzt");
		String sbwxjl = Request.getParameter("wxjl");
		String sbremark = Request.getParameter("bz");
		String sbbz = Request.getParameter("sbbz");
		String sccj = Request.getParameter("sccj");
		String sccjdetail = Request.getParameter("sccjdetail");
        String sbxh=Request.getParameter("sbxh");
        String ccbh=Request.getParameter("ccbh");

        if ((sbcgsj == null) || ("".equals(sbcgsj))) {
            sbcgsj = "now()";
        }else{
            sbcgsj = "'"+sbcgsj+"'";
        }
        if ((sbbxjssj == null) || ("".equals(sbbxjssj))) {
            sbbxjssj = "now()";
        }else{
            sbbxjssj = "'"+sbbxjssj+"'";
        }
		String sql = "update scglxt_t_sb set sblx='"+sblx+"',sbmc='"+sbmc+"',cgsj = "+sbcgsj+",bxjssj="+sbbxjssj+"," +
				"sbszd = '"+sbszd+"',dqzt = '"+sbzt+"',wxjl='"+sbwxjl+"',remark = '"+sbremark+"',bzid='"+sbbz+"',sccj='"+sccj+"',SCCJDETAIL='"+sccjdetail+"',sbxh='"+sbxh+"',ccbh='"+ccbh+"' where id = '"+sbid+"'";
		
		log.info("设备信息更新sql"+sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "sbsuccess";
		}else{
			
			return "sbfault";
		}
	}
	
	/**
	 * 删除设备
	 */
	public String deleteSbInfo(){
		
		String sbid = Request.getParameter("id");
		String sql = "delete from scglxt_t_sb  where id = '"+sbid+"'";
		
		log.info("删除设备信息sql"+sql);
		int i = this.selectDataService.update(sql);
		if(i>0){
			
			return "sbsuccess";
		}else{
			
			return "sbfault";
		}
	}
	
	/**
	 * 删除设备
	 */
	public void getSbZdInfo(){
		
		String xh = Request.getParameter("xh");
		String sbid = "";
		String sql = "select id ,mc from scglxt_tyzd where xh like  '"+xh+"__%'";
		
		log.info("查询设备字典数据sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
	/**
	 * 删除设备
	 */
	public void getSBzInfo(){
		
		String xh = Request.getParameter("xh");
		String sbid = "";
		String sql = "select id, bzmc mc from scglxt_t_bz";
		
		log.info("查询设备字典数据sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
	
	/**
	 * 删除设备
	 */
	public void getSbInfoById(){
		
		String id = Request.getParameter("id");
		String sbid = "";
		String sql = "select sb.id, sblx,sbmc,ccbh,sbxh, cast(cgsj as char) cgsj, cast(bxjssj as char) bxjssj,sbszd,dqzt sbzt,wxjl,remark bz,bzid sbbz,sccj,SCCJDETAIL from scglxt_t_sb sb where id = '"+id+"'";
		
		log.info("查询设备字典数据sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
}

