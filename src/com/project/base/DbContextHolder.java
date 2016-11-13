package com.project.base;


public class DbContextHolder {
	public static final String DATA_SOURCE_A = "dataSourceA";  
    
    public static final String DATA_SOURCE_B = "dataSourceB";  
	 private static final ThreadLocal contextHolder = new ThreadLocal();   
	   
	    public static void setDbType(String dbType) {   
	        contextHolder.set(dbType);   
	    }   
	  
	    public static String getDbType() {   
	        return (String) contextHolder.get();   
	    }   
	  
	    public static void clearDbType() {   
	        contextHolder.remove();   
	    } 
//	    当需要切换数据源时，只要调用一行代码就可以了,但是目前测试情况来看，无法在同一个方法内部同时往不同的数据库中插入值，需要重新写一个方法调用即可。
		
//		public void saveOtherDB(){
//			DbContextHolder.setDbType(DbContextHolder.DATA_SOURCE_B);
//			MainTable maintable = new MainTable();
//			maintable = mainTableService.saveMainTable(maintable);
//		}
//
	}
