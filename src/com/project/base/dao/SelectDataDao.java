package com.project.base.dao;

import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

public interface SelectDataDao {
	public List queryForList(String sql);
	
	public int queryForInt(String sql);

	public boolean deletebyid(String sql);

	public String[] getColumnName(String sql);

	public int update(String sql);


	public void updateClob(String clobColumnName, String data, String idName, String idValue, String tableName);

	public String getClob(String clobColumnName, String idName, String idValue, String tableName);
	
	/**调用没有返回值的存储过程
	 * @author wgzx_106    @param callName 存储过程名称
	 * @author wgzx_106    @param args List集合，集合里面存放的字符串
	 *@version 5:16:39 PM
	 */
	public void callProceDureNoResult(String callName,List<String> args);
	
	/** 调用返回输出参数数据的存储过程
	 * @author wgzx_106    @param callName 存储过程名称
	 * @author wgzx_106    @param args List集合，集合里面存放表明参数类型的字符串 参数类型_参数值，如input_1 是输入参数，out_2  输出参数  
	 * @author wgzx_106    @return 返回输出参数返回值的集合
	 *@version 5:16:26 PM
	 */
	public  List<String> callProceDureByOut(String callName,List<String> args);
	public SqlRowSet getSqlRowSet(String sql);
	public void execute(String sql);
}
