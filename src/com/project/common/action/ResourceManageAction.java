package com.project.common.action;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.project.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.map.ListOrderedMap;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.base.service.SelectDataService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;

/**
 * 资源管理action,处理资源管理各请求
 */
public class ResourceManageAction extends ActionSupport {
	
	private SelectDataService selectDataService;
	private static final long serialVersionUID = 1L;

	public SelectDataService getSelectDataService() {
		return selectDataService;
	}

	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	/**
	 * 获取各资源数据列表对应资源表字段名称及属性.
	 */
	public void getTableColumns(){
		String tableId = Request.getParameter("tableId");//表格ID  0122
		String tableName = Request.getParameter("tableName");//表名 RES_JSZHXXW_T_WLSB
        String isFlag=Request.getParameter("flag")==null?"list":Request.getParameter("flag");
		String returnJson = "[]";
		String sql = "SELECT t.TABLE_ID,t.RESOURCE_NAME,LOWER(c.COLUMN_NAME) COLUMN_NAME,c.COLUMN_CNAME,c.PROPERTY_TYPE,c.DATA_TYPE,c.ISUNIQUE,c.COLUMNLENGTH FROM resource_table t,resource_table_column c WHERE t.TABLE_ID=c.TABLE_ID ";
		if(isFlag.equals("list"))
        {
            sql+="AND (islist = 1) AND t.TABLE_ID='"+tableId+"' ORDER BY c.LIST_ORDER";
        }else if(isFlag.equals("form")){
            sql+="AND (ISUPDATE = 1) AND t.TABLE_ID='"+tableId+"' ORDER BY c.UPDATE_ORDER";
        }else{
            sql+="AND (islist = 1 OR ISUNIQUE='1') AND t.TABLE_ID='"+tableId+"' ORDER BY c.LIST_ORDER";
        }
        List<ListOrderedMap> list = this.selectDataService.queryForList(sql);
		if(list.size()>0){
			returnJson = JsonObjectUtil.list2Json(list);
		}
		Response.write(returnJson);
	}
	/**
	 * 根据查询条件,查询先关资源表的数据
	 */
	public void queryTableData(){
		String tableId = Request.getParameter("tableId");//表格ID  0122
		String tableName = Request.getParameter("tableName");//表名 RES_JSZHXXW_T_WLSB
		String queryColumn = Request.getParameter("queryColumn")==null?"":Request.getParameter("queryColumn").toString();//查询字段
		String queryKey = Request.getParameter("queryKey")==null?"":Request.getParameter("queryKey").toString();//查询关键字
		String returnJson = "[]";
		String sql = "";
		String sqlColumnStr = "";
		String sqlFromTableStr = "";
		String sqlWhere = "";
        String getColumnMsgSql = "SELECT table_name,resource_name,LOWER(column_name) column_name,COLUMNLENGTH,column_cname,data_type,PROPERTY_TYPE,TYPESQL FROM resource_table t,resource_table_column c WHERE t.`TABLE_ID`=c.`TABLE_ID`  AND islist=1 AND c.table_id='"+tableId+"' ORDER BY LIST_ORDER";
        List columnMsgList = this.selectDataService.queryForList(getColumnMsgSql);
        String getPKSql="Select * from resource_table_column where ISUNIQUE='1' and table_id='"+tableId+"'";

        List columnPKList = this.selectDataService.queryForList(getPKSql);

        Map<String, String> mapName = (Map<String, String>)columnMsgList.get(0);
        tableName = tableName==null?mapName.get("TABLE_NAME").toString():tableName;//资源表名
        String resourceName=mapName.get("RESOURCE_NAME")==null?"":mapName.get("RESOURCE_NAME").toString();//资源中文名
        String[] headers = new String[columnMsgList.size()];
        if(columnMsgList.size()>0){
            for(int i=0;i<columnMsgList.size();i++){
                Map<String, String> map = (Map<String, String>)columnMsgList.get(i);
                String columnName = map.get("COLUMN_NAME")==null?"":map.get("COLUMN_NAME").toString();//列名
                String columnCName = map.get("COLUMN_CNAME")==null?"":map.get("COLUMN_CNAME").toString();//列名
                String dataType = map.get("DATA_TYPE")==null?"":map.get("DATA_TYPE").toString();//数据类型

                String PROPERTY_TYPE = map.get("PROPERTY_TYPE")==null?"":map.get("PROPERTY_TYPE").toString();//翻译字典表(即外键表)
                String typeSql = map.get("TYPESQL")==null?"":map.get("TYPESQL").toString();//字典表关联列

                //------处理查询列------------
                if(dataType.equals("3")){//日期
                   // sqlColumnStr += ",to_char(t."+columnName+",'yyyy-MM-dd hh24:mi:ss') "+columnName;
                    sqlColumnStr += ",DATE_FORMAT(t."+columnName+",'%Y-%m-%d') "+columnName;
                }else{
                    if(PROPERTY_TYPE.equals("1")){//文本框形式不需要翻译
                        sqlColumnStr += ",t."+columnName;
                    }else if(PROPERTY_TYPE.equals("2") || PROPERTY_TYPE.equals("4")){//有外键关系,需要翻译
                        sqlColumnStr += ",t."+columnName+" "+columnName+"_id,(SELECT NAME FROM ("+typeSql+") tras WHERE tras.id="+columnName+") "+columnName;
                    }
                }
                headers[i]=columnCName;
                //-----end处理查询列-----------
            }
            sqlColumnStr=sqlColumnStr.substring(1,sqlColumnStr.length());
            //增加查询条件过滤
            if(queryColumn!=null&&!queryColumn.equals("")){
                if(queryColumn.equals(",")){
                    for(int j=0;j<queryColumn.split(",").length;j++){
                        String queryColumnName = queryColumn.split(",")[j];
                        String queryColumnContext = queryKey;
                        sqlWhere += " and s."+queryColumnName+" like "+" '%"+queryColumnContext+"%' ";
                    }
                }else{
                    sqlWhere += " and s."+queryColumn+" like "+" '%"+queryKey+"%' ";
                }
            }
            if(columnPKList.size()>0)
            {
                sql = " select  CONCAT('<a href=javascript:$.ResMgr.delete(\\'',t.id,'\\')>删除<\\/a>') id,"+sqlColumnStr+" from "+tableName+" t"+sqlFromTableStr+" where 1=1 ";
            }else{
                sql = " select  "+sqlColumnStr+" from "+tableName+" t"+sqlFromTableStr+" where 1=1 ";
            }
        }else{
            sql = " select  t.* from "+tableName+" t where 1=1 ";
        }
        sql = "select * from ("+sql+") s where 1=1 "+sqlWhere;
        System.out.println(sql);
		List<ListOrderedMap> list = this.selectDataService.queryForList(sql);

		if(list.size()>0){
			returnJson = JsonObjectUtil.list2Json(list);
            returnJson = "{\"data\":" + returnJson + "}";
		}
		Response.write(returnJson);
	}
	/**
	 * 根据字段关联属性,查询combobox下拉菜单的数据
	 */
	public void getComboboxData(){
		//f.transtable,f.transcol,f.transedcol
		String type = Request.getParameter("type");//类型
		String tableId = Request.getParameter("tableId");//翻译字典表
		String columnName = Request.getParameter("columnName");//字典表关联列

		String sql = "select TYPESQL from resource_table_column where table_id='"+tableId+"' and column_name='"+columnName+"'";
		String typesql=selectDataService.getString(sql);
        String returnJson = "[]";
        if(typesql!=null && !typesql.equals("")) {

            List list = this.selectDataService.queryForList(sql);
            if (list.size() > 0) {
                returnJson = JsonObjectUtil.list2Json(list);
            }

        }
        Response.write(returnJson);
	}
	/**
	 * 根据字段关联属性,查询combotree下拉树的数据
	 */
	public void getCombotreeData(){
		String type = Request.getParameter("type");//类型
		String transTable = Request.getParameter("transTable");//翻译字典表
		String transCol = Request.getParameter("transCol");//字典表关联列
		String transedCol = Request.getParameter("transedCol");//字典表翻译后列
//		System.out.println("getCombotreeData");
		
	}
	/**
	 * 保存添加或编辑的资源数据
	 */
	public void saveResourceData(){
		String tableId = Request.getParameter("tableId");//表ID
		String tableName = Request.getParameter("tableName");//表名
		String resourceId = Request.getParameter("resourceId");//ID
		String keyColumn = Request.getParameter("keyColumn");//主键
		String flag = "";//操作类型
		String params = Request.getParameter("params");//
		JSONArray jay = JSONArray.fromObject(params);
		String sql = "";
		String columnsStr = "";
		Date date = new Date();
		if(flag!=null&&flag.equals("add")){//新增数据
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String dateStr = sdf.format(date);
			resourceId = dateStr + RandomUtils.getRandomNumbers(5);//资源ID
			//新增数据sql
			sql = " insert into "+tableName +"("+keyColumn;
			String values = " values ("+resourceId;
			for(int i=0;i<jay.size();i++){
				JSONObject job = (JSONObject)jay.get(i);
				String key = job.getString("key");
				String value = job.getString("value");
				sql += ","+key;
				values += ","+value;
			}
			values += ")";
			sql += ")";
			sql += values;
		}else{//编辑
			sql = " update "+tableName+" t set ";
			for(int i=0;i<jay.size();i++){
				JSONObject job = (JSONObject)jay.get(i);
				String key = job.getString("key");
				String value = job.getString("value");
				if(i==jay.size()-1){
					sql += key+"="+value;					
				}else{
					sql += key+"="+value+",";
				}
			}
			sql += " where t."+keyColumn+" = "+resourceId;
		}
		System.out.println(sql);
	}

    /**
     * 删除某表资源数据
     */
    public void deleteRow()
    {
        String tableId = Request.getParameter("tableId");//表ID
        String deleteID=Request.getParameter("id");//表ID

        String tableName=selectDataService.getString("SELECT table_name FROM `resource_table` WHERE table_id='"+tableId+"'");
        String sql = "delete from "+tableName+" where id = '"+deleteID+"'";
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
     * 导出资源数据
     */
    public void exportResourceData(){

        String tableId = Request.getParameter("tableId");//表格ID  0122
        String queryColumn = Request.getParameter("queryColumn")==null?"":Request.getParameter("queryColumn").toString();//查询字段
        String queryKey = Request.getParameter("queryKey")==null?"":Request.getParameter("queryKey").toString();//查询关键字
        String sql = "";
        String sqlColumnStr = "";
        String sqlFromTableStr = "";
        String sqlWhere = "";

        String getColumnMsgSql = "SELECT table_name,resource_name,where_sql,column_name,column_cname,data_type,PROPERTY_TYPE,TYPESQL FROM resource_table t,resource_table_column c WHERE t.`TABLE_ID`=c.`TABLE_ID` AND c.table_id='"+tableId+"' AND ISEXPORT='1' ORDER BY export_order";
        List columnMsgList = this.selectDataService.queryForList(getColumnMsgSql);

        if(columnMsgList.size()>0) {
            Map<String, String> mapName = (Map<String, String>) columnMsgList.get(0);
            String tableName = mapName.get("TABLE_NAME") == null ? "" : mapName.get("TABLE_NAME").toString();//资源表名
            String resourceName = mapName.get("RESOURCE_NAME") == null ? "" : mapName.get("RESOURCE_NAME").toString();//资源中文名
            String resourceWhere = mapName.get("WHERE_SQL") == null ? "" : mapName.get("WHERE_SQL").toString();//资源过滤条件
            String[] headers = new String[columnMsgList.size()];
            if (resourceWhere != null && resourceWhere != "") {
                sqlWhere = " and " + resourceWhere;
            }
            if (columnMsgList.size() > 0) {
                for (int i = 0; i < columnMsgList.size(); i++) {
                    Map<String, String> map = (Map<String, String>) columnMsgList.get(i);
                    String columnName = map.get("COLUMN_NAME") == null ? "" : map.get("COLUMN_NAME").toString();//列名
                    String columnCName = map.get("COLUMN_CNAME") == null ? "" : map.get("COLUMN_CNAME").toString();//列名
                    String dataType = map.get("DATA_TYPE") == null ? "" : map.get("DATA_TYPE").toString();//数据类型
                    //------处理查询列------------
                    if (dataType.equals("3")) {//日期
                        sqlColumnStr += ",DATE_FORMAT(t." + columnName + ",'%Y-%m-%d') " + columnName;
                    } else {
                        String PROPERTY_TYPE = map.get("PROPERTY_TYPE") == null ? "" : map.get("PROPERTY_TYPE").toString();//翻译字典表(即外键表)
                        String typeSql = map.get("TYPESQL") == null ? "" : map.get("TYPESQL").toString();//字典表关联列

                        if (PROPERTY_TYPE.equals("1")) {//文本框形式不需要翻译
                            sqlColumnStr += ",t." + columnName;
                        } else if (PROPERTY_TYPE.equals("2")) {//有外键关系,需要翻译
                            sqlColumnStr += ",(SELECT NAME FROM (" + typeSql + ") tras WHERE tras.id=" + columnName + ") " + columnName;
                        }
                    }
                    headers[i] = columnCName;
                    //-----end处理查询列-----------
                }
                sqlColumnStr = sqlColumnStr.substring(1, sqlColumnStr.length());

                //增加查询条件过滤
                if (queryColumn != null && !queryColumn.equals("")) {
                    if (queryColumn.equals(",")) {
                        for (int j = 0; j < queryColumn.split(",").length; j++) {
                            String queryColumnName = queryColumn.split(",")[j];
                            String queryColumnContext = queryKey;
                            sqlWhere += " and t." + queryColumnName + " like " + " '%" + queryColumnContext + "%' ";
                        }
                    } else {
                        sqlWhere += " and t." + queryColumn + " like " + " '%" + queryKey + "%' ";
                    }
                }

                sql = " select  " + sqlColumnStr + " from " + tableName + " t" + sqlFromTableStr + " where 1=1 " + sqlWhere;
            } else {
                sql = " select  t.* from " + tableName + " t where 1=1 ";
            }
            sql = "select * from (" + sql + ") s where 1=1 ";
            System.out.println(sql);

            HttpServletResponse response = ServletActionContext.getResponse();
            //转码防止乱码
            response.setContentType("application/octet-stream;charset=utf-8");

            //response.addHeader("Content-Disposition", "attachment;filename="+resourceName+".xls");

            try {
                response.setHeader("Content-Disposition", "attachment;filename=" + new String(resourceName.getBytes(), "iso-8859-1") + ".xls");

                List list = this.selectDataService.queryForList(sql);
                OutputStream out = response.getOutputStream();
                ExcelExportUtil.exportExcel(resourceName, headers, list, out, "yyyy-MM-dd");
                out.close();
                System.out.println("excel导出成功！");
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                System.out.println("excel导出失败！");
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("excel导出失败！");
            }
        }else{
            System.out.println("数据库中没有该表的配置信息"+tableId);
        }
    }
}
