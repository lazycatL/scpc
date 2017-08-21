
package com.project.xsgl.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.util.WebUtils;

import org.apache.commons.logging.Log;

public class KhxxManagerAction {
	private static Log log = org.apache.commons.logging.LogFactory.getLog(KhxxManagerAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	/**
	 * 获取客户信息数据
	 * @response  : json 
	 */
	public void getKhxxData(){
		String sql ="  select t.id,t.mc,t.lx lxnm ,DATE_FORMAT(starttime,'%Y-%m-%d') starttime, t2.MC lx ,t.dw,t.dz,t.gx, " +
					" case  when t.iscj='1' then '是'   when t.iscj='0'  then '否'  end  as iscj , "+
					" t.remark from scglxt_t_kh t , scglxt_tyzd t2 "+ 
					" where t.lx = t2.id   and t2.id like '30%'";
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		log.info("客户信息表格sql"+sql);
		Response.write(json);
	}
	
	/**
	 * 新增用户信息
	 */
	public void addUserInfo(){
		String JSON = Request.getParameter("JSON");
		String randomId = WebUtils.getRandomId();
		JSONObject json = JSONObject.fromObject(JSON);
		String id = json.getString("id");
		String mc = json.getString("mc");
		String lx = json.getString("lx");
		String dw = json.getString("dw");
		String gx = json.getString("gx");
		String dz = json.getString("dz");
		String starttime = json.getString("starttime");
		String iscj = json.getString("iscj");
		String remark = json.getString("remark");
		String flag = json.getString("flag");
		String msg = null;
		String sql = "";
		if(flag.equals("UPDATE")){
			sql = "update scglxt_t_kh  set mc = '"+mc+"' ,lx = '"+lx+"',dw = '"+dw+"',dz = '"+dz+"',gx = '"+gx+"'," +
					"iscj = '"+iscj+"',remark = '"+remark+"',starttime='"+starttime+"' " +
					"where id = '"+id+"'";
		}else if(flag.equals("ADD")){
			sql = "insert into scglxt_t_kh(id,mc,lx,dw,dz,gx,iscj,remark,starttime) " +
					"values("+randomId+",'"+mc+"','"+lx+"','"+dw+"','"+dz+"','"+gx+"','"+iscj+"','"+remark+"','"+starttime+"')";
		}
		try {
			selectDataService.execute(sql);
		//	msg = ActionEnum.SUCCESS.toString();
			msg = "SUCCESS";
			log.info("insert "+sql);
		} catch (Exception e) {
	//		msg = ActionEnum.ERROR.toString();
			msg = "ERROR";
			log.info("错误的sql " +sql);
			e.printStackTrace();
		}
		Response.write(msg);
	} 
	 /**
	  * 删除客户信息
	  */
	public void  deleteKhInfo(){
		String id = Request.getParameter("id");
		String sql = "delete from scglxt_t_kh where id = '"+id+"'";
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
	public void getKhInfo(){
		String id = Request.getParameter("id");
		String sql = "";
		if(id != null && !id.equals("")){
			sql = "select id ,mc ,lx,dw,dz,gx,iscj,date_format(starttime,'%Y-%m-%d') starttime,remark from scglxt_t_kh where id = '"+id+"'";
		}
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
	 * 获取合同列表
	 */
	public void getHeTongData(){
		String sql = "select * from scglxt_t_ht";
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
	/**
	 * 查询客户类型列表
	 */
	public void loadKhlxList(){
		String sql = "select  id ,mc  from scglxt_tyzd where id like '30_%' order by mc ";
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}

    //添加联系人
    public void addLxrInfo()
    {
        String JSON = Request.getParameter("JSON");
        String randomId = WebUtils.getRandomId();
        JSONObject json = JSONObject.fromObject(JSON);
        String flag = json.getString("flag");
        String id = json.getString("id");
        String mc = json.getString("mc");
        String sj = json.getString("sj");
        String zj = json.getString("zj");
        String yx =  json.getString("yx");
        String zw =  json.getString("zw");
        String sjkh =  json.getString("sjkh");
        String sfxmlxr =  json.getString("sfxmlxr");
        String remark =  json.getString("remark");


        String msg = null;
        String sql = "";
        if(flag.equals("UPDATE")){
//            sql = "update scglxt_t_kh  set mc = '"+mc+"' ,lx = '"+lx+"',dw = '"+dw+"',dz = '"+dz+"',gx = '"+gx+"'," +
//                    "iscj = '"+iscj+"',remark = '"+remark+"',starttime='"+starttime+"' " +
//                    "where id = '"+id+"'";
        }else if(flag.equals("ADD")){
            sql = "insert into scglxt_t_lxr(id,mc,sj,zj,yx,zw,sjkh,sfxmlxr,remark) " +
                    "values("+randomId+",'"+mc+"','"+sj+"','"+zj+"','"+yx+"','"+zw+"','"+sjkh+"','"+sfxmlxr+"','"+remark+"')";
        }
        try {
            selectDataService.execute(sql);
            //	msg = ActionEnum.SUCCESS.toString();
            msg = "SUCCESS";
            log.info("insert "+sql);
        } catch (Exception e) {
            //		msg = ActionEnum.ERROR.toString();
            msg = "ERROR";
            log.info("错误的sql " +sql);
            e.printStackTrace();
        }
        Response.write(msg);
    }
	
}
