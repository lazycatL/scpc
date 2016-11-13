package com.project.base.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.support.rowset.SqlRowSet;


public interface SelectDataService {
	public List queryForList(String sql);

	public int queryForInt(String sql);
	
	public List getDataObjs(String sql,Class clazz);
	
	public boolean remove(String sql);

	public String[] getColumnName(String sql);


	public int update(String sql);
	 public void setManage(HttpServletRequest request);
	// public void setAdminManage(HttpServletRequest request);
	public Map getListForPage(HttpServletRequest request, String sql);



	public String getString(String sql);


	public void updateClob(String string, String content, String string2, String id, String string3);

	public String getClob(String string, String string2, String id, String string3);

	public boolean delete(String sql);

	public void execute(String sql) ; 
	
	/**
	 * 调用没有返回值的存储过程
	 * 
	 * @author wgzx_106
	 * @param callName
	 *            存储过程名称
	 * @author wgzx_106
	 * @param args
	 *            List集合，集合里面存放的字符串
	 * @version 5:16:39 PM
	 */
	public void callProceDureNoResult(String callName, List<String> args);

	/**
	 * 调用返回输出参数数据的存储过程
	 * 
	 * @author wgzx_106
	 * @param callName
	 *            存储过程名称
	 * @author wgzx_106
	 * @param args
	 *            List集合，集合里面存放表明参数类型的字符串 参数类型_参数值，如input_1 是输入参数，out_2 输出参数
	 * @author wgzx_106
	 * @return 返回输出参数返回值的集合
	 * @version 5:16:26 PM
	 */
	public List<String> callProceDureByOut(String callName, List<String> args);
	
	/**
	 * 获得sqlRowSet对象
	 * 
	 * @param sql
	 * 			要执行的目标sql
	 *           
	 * @return 返回SqlRowSet
	 */
	public SqlRowSet getSqlRowSet(String sql);
}
