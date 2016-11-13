package com.project.commonModel.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

public class Request {
	public static String getParameter(String arg0){
		HttpServletRequest request = ServletActionContext.getRequest();		
		return request.getParameter(arg0);
	}
	public static String getRealPath(String url){
		HttpServletRequest request = ServletActionContext.getRequest();
		return request.getSession().getServletContext().getRealPath(url);
	}
}
