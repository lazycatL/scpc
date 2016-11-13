package com.project.base.dao.impl;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleTypes;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.core.support.AbstractLobStreamingResultSetExtractor;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.util.FileCopyUtils;

import com.project.base.SqlRowSetOracleResultSetExtractor;
import com.project.base.dao.SelectDataDao;
import com.project.commonModel.util.CommonValues;

public class SelectDataDaoImpl extends JdbcDaoSupport implements SelectDataDao {

	public List queryForList(String sql) {
		// TODO Auto-generated method stub
		List list = this.getJdbcTemplate().queryForList(sql);
		return list;
	}
	
	public int queryForInt(String sql) {
		// TODO Auto-generated method stub
		return this.getJdbcTemplate().queryForInt("select count(*) from (" + sql + ") tablecount");
	}

	public boolean deletebyid(String sql) {
		try {
			this.getJdbcTemplate().execute(sql);
			return true;
		} catch (DataAccessException e) {
			e.printStackTrace();
			return false;
		}
		
	}

	public String[] getColumnName(String sql) {
		// TODO Auto-generated method stub
		SqlRowSet rowSet = (SqlRowSet)this.getJdbcTemplate().query(sql, new SqlRowSetOracleResultSetExtractor()); 
		String[] columnNames = rowSet.getMetaData().getColumnNames();
		return columnNames;
	}

	public int update(String sql) {
		return this.getJdbcTemplate().update(sql);
	}

	/**
	 * 更新Clob字段
	 * 
	 * @param clobColumnName
	 * @param data
	 * @param id
	 */
	public void updateClob(String clobColumnName, final String data, String idName, String idValue, String tableName) {
		LobHandler lobHandler = new DefaultLobHandler();
		String sql = "UPDATE " + tableName + " set " + clobColumnName + "=? WHERE " + idName + "='" + idValue + "'";
		this.getJdbcTemplate().execute(sql, new AbstractLobCreatingPreparedStatementCallback(lobHandler) {
			protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
				lobCreator.setClobAsString(ps, 1, data);
			}
		});
	}

	public String getClob(final String clobColumnName, String idName, String idValue, String tableName) {
		final Writer writer = new StringWriter();
		final LobHandler lobHandler = new DefaultLobHandler();
		this.getJdbcTemplate().query("SELECT " + clobColumnName + " from " + tableName + " where " + idName + "=" + idValue, new AbstractLobStreamingResultSetExtractor() {
			protected void streamData(ResultSet rs) throws SQLException, IOException, DataAccessException {
				// FileCopyUtils.copy(lobHandler.getClobAsCharacterStream(rs,1),writer);
				// FileCopyUtils.copy(lobHandler.getBlobAsBinaryStream(rs,2),os);
				FileCopyUtils.copy(lobHandler.getClobAsCharacterStream(rs, clobColumnName), writer);

			}
		});
		return writer.toString();
	}

	public void call(final String procedureName, final int year) {
		this.getJdbcTemplate().execute(new ConnectionCallback() {
			@Override
			public Object doInConnection(Connection conn) throws SQLException, DataAccessException {
				CallableStatement call = conn.prepareCall(procedureName);
				call.setInt(1, year);
				call.execute();
				return null;
			}
		});
	}
	
	//调用没有返回值的存储过程
	public void callProceDureNoResult(String callName,List<String> args){
		String callStr = "call "+callName+"(";
		if(args!=null){
		for (int i = 0; i < args.size(); i++) {
			callStr+="'"+args.get(i)+"'," ;
		}
		callStr = callStr.substring(0,callStr.length()-1);
		}
		callStr+=")";
		this.getJdbcTemplate().execute(callStr);
	}
	
	//调用返回输出参数数据的存储过程
	public  List<String> callProceDureByOut(String callName,List<String> args){
		CommonValues.callName = callName;
		CommonValues.proceDureParams = args;
		CallableStatementCreator statementCreator = new CallableStatementCreator(){
			@Override
			public CallableStatement createCallableStatement(Connection con) throws SQLException {
				String callStr = "{call "+CommonValues.callName+"(";
				if(CommonValues.proceDureParams!=null){
				for (int i = 0; i < CommonValues.proceDureParams.size(); i++) {
					callStr+="?," ;
				}
				callStr = callStr.substring(0,callStr.length()-1);
				}
				callStr+=")}";
				CallableStatement cs = con.prepareCall(callStr);
				String[] params;
				for (int i = 0; i < CommonValues.proceDureParams.size(); i++) {
					params = CommonValues.proceDureParams.get(i).split(",");
					if(params[0].equals("input")){
						cs.setString(i+1, params[1]);//设置输入参数值
					}else if(params[0].equals("out")){
						cs.registerOutParameter(i+1, OracleTypes.VARCHAR);//注册输出参数类型
					}
				}
				return cs;
			}
		};
		CallableStatementCallback statementCallback = new CallableStatementCallback(){
			@Override
			public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException {
				cs.execute();
				List<String> returnVals = new ArrayList<String>();
				String[] params;
				for (int i = 0; i < CommonValues.proceDureParams.size(); i++) {
					params = CommonValues.proceDureParams.get(i).split(",");
					if(params[0].equals("out")){
						returnVals.add(cs.getString(i+1));
					}
				}
				return returnVals;
			}
			
		};
		List<String> returnVals = (List<String>) this.getJdbcTemplate().execute(statementCreator , statementCallback);
		return returnVals;
	}
	@Override
	public SqlRowSet getSqlRowSet(String sql) {
		return this.getJdbcTemplate().queryForRowSet(sql);
	}

	@Override
	public void execute(String sql) {
		this.getJdbcTemplate().execute(sql);
	}
}
