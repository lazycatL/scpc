package com.project.util;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.project.commonModel.util.DateUtil;

public class DataTranslateUtil {

public	static List<Object> getObjects(List list, Class clazz) throws SQLException, Exception, IllegalAccessException, InvocationTargetException {
		List<Object> objects =new ArrayList<Object>();
		if(list!=null&&list.size()>0){
			 Map mapObj=null;
			 Object object = null;
				for (int n = 0; n < list.size(); n++) {
						mapObj = (Map) list.get(n);
						object = getObject(mapObj, clazz);
						objects.add(object);
					}
				}
			return objects;
		} 

	public static Object getObject(Map mapObj, Class clazz) throws Exception {
			Object[] colNames =  mapObj.keySet().toArray();	
			Object object = null;
			Method[] ms = clazz.getMethods();
				object = clazz.newInstance();
				Constructor constructor = null;
				for (int i = 0; i < colNames.length; i++) {
					String colName = colNames[i].toString();
					String methodName = "SET" + colName;
					for (Method m : ms) {
						//通过列值拼凑成的方法名与反射获取到的方法名相同
						if (methodName.equals(m.getName().toUpperCase())) {
//							System.out.println(m.getName()+" "+(mapObj.get(colName)==null?"null":mapObj.get(colName)));
							//实例化调用方法参数的构造函数
							Class paramClass =  m.getParameterTypes()[0];
							//调用set方法，给对象赋值
							if(paramClass.equals(Date.class)){
								constructor =  paramClass.getConstructor(long.class);
								m.invoke(object, mapObj.get(colName)==null?null:constructor.newInstance(DateUtil.getStringToDateFull(mapObj.get(colName).toString()).getTime()));
							}else{
								constructor =  paramClass.getConstructor(String.class);
								m.invoke(object, mapObj.get(colName)==null?null:constructor.newInstance(mapObj.get(colName).toString()));
							}
							break;
						}
					}
				}
			return object;
	}
	
	public static void main(String[] args) throws Exception {
//		Method[] ms = Unit.class.getMethods();
//		String methodName = "SET" + "CREATETIME";
//		for (Method m : ms) {
//			if (methodName.equals(m.getName().toUpperCase())) {
//				System.out.println(m.getParameterTypes()[0].toString());
//			}
//		}
	}
}
