package com.project.base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.project.base.dao.SelectDataDao;
import com.project.base.service.SelectDataService;
import com.project.commonModel.util.PropertiesUtil;
import com.project.util.DataTranslateUtil;
import com.project.util.WebUtils;

public class SelectDataServiceImpl implements SelectDataService{
	private SelectDataDao selectDataDao;
	public void setSelectDataDao(SelectDataDao selectDataDao) {
		this.selectDataDao = selectDataDao;
	}
	@Override
	public Map getListForPage(HttpServletRequest request, String sql) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void setManage(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
	}
	public SelectDataDao getSelectDataDao() {
		return selectDataDao;
	}
	public List queryForList(String sql) {
		// TODO Auto-generated method stub
		List list=selectDataDao.queryForList(sql);
		return list;
	}
	
	public int queryForInt(String sql) {
		// TODO Auto-generated method stub
		return selectDataDao.queryForInt(sql);
	}
	
	public List getDataObjs(String sql,Class clazz){
		try {
			List list=selectDataDao.queryForList(sql);
			List<Object> objs =DataTranslateUtil.getObjects(list, clazz);
			return objs;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean remove(String sql) {
		// TODO Auto-generated method stub
		return selectDataDao.deletebyid(sql);
	}
	public String[] getColumnName(String sql) {
		// TODO Auto-generated method stub
		
		return selectDataDao.getColumnName(sql);
	}
	
	public int update(String sql) {
		return selectDataDao.update(sql);
	}
	public String getString(String sql) {
		List list=selectDataDao.queryForList(sql);
		String re = "";
		if(list.size()>0){
			Map map = (Map) list.get(0);
			String[] cols = this.getColumnName(sql);
			Object obj = map.get(cols[0]);
			if(obj!=null){
				re = obj.toString();
			}		
		}
		return re;
	}

	public void updateClob(String clobColumnName,final String data,String idName,String idValue,String tableName)
	{
		selectDataDao.updateClob(clobColumnName, data, idName, idValue, tableName);
	}
	public String getClob(String clobColumnName,String idName,String idValue,String tableName){
		return selectDataDao.getClob(clobColumnName, idName, idValue, tableName);
	}
	public boolean delete(String sql) {
		// TODO Auto-generated method stub
		return selectDataDao.deletebyid(sql);
	}
	
	/**调用没有返回值的存储过程
	 * @author wgzx_106    @param callName 存储过程名称
	 * @author wgzx_106    @param args List集合，集合里面存放的字符串
	 *@version 5:16:39 PM
	 */
	public void callProceDureNoResult(String callName,List<String> args){
		selectDataDao.callProceDureNoResult(callName, args);
	}
	
	/** 调用返回输出参数数据的存储过程
	 * @author wgzx_106    @param callName 存储过程名称
	 * @author wgzx_106    @param args List集合，集合里面存放表明参数类型的字符串 参数类型_参数值，如input_1 是输入参数，out_2  输出参数  
	 * @author wgzx_106    @return 返回输出参数返回值的集合
	 *@version 5:16:26 PM
	 */
	public  List<String> callProceDureByOut(String callName,List<String> args){
		return selectDataDao.callProceDureByOut(callName, args);
	}
	@Override
	public SqlRowSet getSqlRowSet(String sql) {
		return selectDataDao.getSqlRowSet(sql);
	}
	@Override
	public void execute(String sql) {
	 selectDataDao.execute(sql);
	}
}
