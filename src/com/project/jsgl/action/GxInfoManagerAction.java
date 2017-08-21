/**
 * 订单信息模块类
 */
package com.project.jsgl.action;

import java.util.ArrayList;
import java.util.List;

import com.project.util.Constants;
import com.project.util.StringUtil;
import net.sf.json.JSONObject;

import oracle.jdbc.driver.Const;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.logging.Log;

import com.project.base.ActionEnum;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.WebUtils;
import com.project.xsgl.action.KhxxManagerAction;

public class GxInfoManagerAction {
	private static Log log = org.apache.commons.logging.LogFactory.getLog(GxInfoManagerAction.class);
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
		String limitStart = "";
		String limitEnd = "";
		String sql = " SELECT  scglxt_t_jggy.id , gymc,gydh,scglxt_t_bz.`bzmc` fzbz ,sfwx FROM  scglxt_t_jggy INNER JOIN scglxt_t_bz ON scglxt_t_bz.`id` = fzbz";
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		Response.write(json);
	}
	/**
	 * 获取合同信息数据
	 * @response  : json 
	 */
	public void getTableData1(){
		String sbid = Request.getParameter("sbid");
		String limitEnd = "";
		String sql = "SELECT gc.yjgjs, gc.`id`,sb.`sbmc`,edgs ,bom.`zddmc` zdd,bom.`jgsl`,DATE_FORMAT(bom.`starttime`,'%Y-%m-%d')kssj,DATE_FORMAT(bom.`endtime`,'%Y-%m-%d') jssj,dd.`xmname` dd,jggy.`gymc`,ROUND(edgs*((`bom`.`jgsl` - `gc`.`yjgjs`))/(60*6),2) t FROM scglxt_t_gygc gc INNER JOIN scglxt_t_bom bom ON gc.`bomid` = bom.`id` INNER JOIN scglxt_t_dd dd ON dd.`id` = bom.`SSDD` LEFT JOIN scglxt_t_jggy jggy ON jggy.`id` = gc.`gynr` INNER JOIN scglxt_t_sb sb ON gc.`sbid` = sb.`id` WHERE sbid = '"+sbid+"'";
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
		String sql = "delete from scglxt_t_jggy where id = '"+id+"'";
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
		String sql = " select  id , gymc,gydh,fzbz ,sfwx from  scglxt_t_jggy   where id = '"+id+"' ";
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
		String gxmc = JSON.getString("gxmc");
		String fzbz = JSON.getString("fzbz");
		String sfwx = JSON.getString("sfwx");
		String flag = JSON.getString("flag") ;
		String sql = null;
//		String id = WebUtils.getRandomId();
		String id = StringUtil.returnNotEmpty(JSON.getString("id"));

		if(flag !=null && flag.equals("ADD")){
			id = WebUtils.getRandomId();
			sql = "insert into scglxt_t_jggy (id,gymc,fzbz,sfwx) values('"+id+"', '"+gxmc+"','"+fzbz+"','"+sfwx+"')";
		}else if(flag.equals("UPDATE")){
			sql = "update scglxt_t_jggy  set gymc='"+gxmc+"' ,  fzbz = '"+fzbz+"'  , sfwx = '"+sfwx+"'  where id = '"+id+"' ";
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
     * 添加常用语到数据库
     */
    public void addCyyInfo()
    {
        String mc=Request.getParameter("mc");
        String sql="SELECT  CONVERT(MAX(id)+1,SIGNED) id FROM scglxt_tyzd WHERE xh LIKE '90__';";
        String id="";
        String result="";
        List list = this.selectDataService.queryForList(sql);
        if (list.size() > 0) {
            ListOrderedMap lod=(ListOrderedMap)list.get(0);
            //if(!lod.get("id").toString().equals(""))
            if(lod.get("id")!=null)
            {
                id=lod.get("id").toString();
            }else{
                id="9001";
            }
        }else{
            id="9001";
        }

        String insertSql="insert into scglxt_tyzd(id,mc,xh) values('"+id+"','"+mc+"','"+id+"')";
        log.info("插入常用语SQL:"+insertSql);
        try {
            selectDataService.execute(insertSql);
            result="SUCCESS";
        } catch (Exception e) {
            result="ERROR";
            e.printStackTrace();
        }
        Response.write(result);
    }
    /**
     * 获取数据库中已存在的常用语列表
     */
    public void getCyyInfo()
    {
        String sql = " select  id ,mc from scglxt_tyzd where xh like '90__';";
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
    public void deleteCyy()
    {
        String id=Request.getParameter("id");
        String result="";
        String sql="Delete from scglxt_tyzd where id='"+id+"'";
        try {
           selectDataService.execute(sql);
            result="SUCCESS";
        } catch (Exception e) {
            result="ERROR";
            e.printStackTrace();
        }
        Response.write(result);
    }
	
}
