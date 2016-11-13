package com.project.commonModel.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Properties;

import org.apache.struts2.ServletActionContext;



/**
 * 作者： hwli
 * 修改日期：2014-3-5
 * 配置文件读取类
 */
public class PropertiesUtil {

	// 属性文件的路径
//	static String classPath = ClassLoader.getSystemResource("").getPath()+"/";
	static String allFilePath = "";
	static String fileName = "WEB-INF\\classes\\ApplicationResources.properties";
	static File file = null;
	
	static{
		allFilePath =ServletActionContext.getServletContext().getRealPath(fileName);
//		classPath =ClassLoader.getSystemResource("").getPath()+"/";
		file = new File(allFilePath);
	}
	
	public static PropertiesUtil getInstance(){
		file = new File(allFilePath);
		return new PropertiesUtil();
	}
	
	public static PropertiesUtil getInstance(String filePath){
		file = new File(filePath);
		return new PropertiesUtil();
	}
	
	public static String getProperties(String key){
		InputStream fis = null;
		try {
			Properties prop = new Properties();
			if(file==null){
				file = new File(allFilePath);
			}
			fis = new FileInputStream(file.getAbsolutePath());
			prop.load(fis);
			
			return prop.getProperty(key);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{if(fis != null){fis.close();}}catch(Exception e){}
		}
		
		return "";
	}
	
	public static String getProperties(String key,String defaultVal){
		InputStream fis = null;
		try {
			Properties prop = new Properties();
			if(file==null){
				file = new File(allFilePath);
			}
			fis = new FileInputStream(file.getAbsolutePath());
			prop.load(fis);
			
			return prop.getProperty(key)==null?defaultVal:prop.getProperty(key);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{if(fis != null){fis.close();}}catch(Exception e){}
		}
		
		return defaultVal;
	}
	
	public static String getEncryptKey(){
		try {
			String s =getProperties("encrypt");
			DES des = new DES();
			return des.decrypt(s);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public static String getPropertiesByPath(String filePath,String key){
		InputStream fis = null;
		try {
			Properties prop = new Properties();
			if(filePath!=null){
				file = new File(filePath);
			}
			fis = new FileInputStream(file.getAbsolutePath());
			
			prop.load(fis);
			
			return prop.getProperty(key);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{if(fis != null){fis.close();}}catch(Exception e){}
		}
		
		return "";
	}
	
	public static void setProperties(String key,String value){
		Properties prop = new Properties();
		
		FileOutputStream outputFile = null;
		InputStream fis = null;
		try {
			if(file==null){
				file = new File(allFilePath);
			}
			//输入流和输出流要分开处理， 放一起会造成写入时覆盖以前的属性
			fis = new FileInputStream(file.getAbsolutePath());
			//先载入已经有的属性文件
			prop.load(fis);
			
			//追加新的属性
			prop.setProperty(key, value);
			
			//写入属性
			outputFile = new FileOutputStream(file.getAbsolutePath()); 
			prop.store(outputFile, "");
			
			outputFile.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{if(fis != null){fis.close();}}catch(Exception e){}
			try{if(outputFile != null){outputFile.close();}}catch(Exception e){}
		}
	}

	
	public static void setProperties(String filePath,String key,String value){
		Properties prop = new Properties();
		
		
		FileOutputStream outputFile = null;
		InputStream fis = null;
		try {
			if(filePath!=null){
				file = new File(filePath);
			}
			//输入流和输出流要分开处理， 放一起会造成写入时覆盖以前的属性
			fis = new FileInputStream(file.getAbsolutePath());
			//先载入已经有的属性文件
			prop.load(fis);
			
			//追加新的属性
			prop.setProperty(key, value);
			
			//写入属性
			outputFile = new FileOutputStream(file.getAbsolutePath()); 
			prop.store(outputFile, "");
			
			outputFile.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{if(fis != null){fis.close();}}catch(Exception e){}
			try{if(outputFile != null){outputFile.close();}}catch(Exception e){}
		}
	}
		// 测试代码
		public static void main(String[] args) {
			//读取默认配置文件
			System.out.println(PropertiesUtil.getProperties("jdbc.username"));
			//修改默认配置文件
			PropertiesUtil.getInstance().setProperties("5555", "327@qq.com");
		}

}
