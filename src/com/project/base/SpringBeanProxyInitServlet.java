package com.project.base;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;



public class SpringBeanProxyInitServlet extends HttpServlet {
private static final long serialVersionUID = -3754547957057400569L;
	
	private static ApplicationContext context = null;
	private static ServletContext application = null;
	
	@Override
	public void init() throws ServletException {
		
		super.init();
		
		application = getServletContext();
		System.out.println("=============="+application.getContext("/log4jCfg.properties"));
		context = WebApplicationContextUtils.getWebApplicationContext(application);
		if(context==null){
			throw new RuntimeException("Application environment initialization error!");
		}
		SpringBeanProxy.setApplicationContext(context);
		
	}
	
	public static ServletContext  getWebServletContext(){
		return application;
	}
	
	public static ApplicationContext getApplicationContext(){
		return context;
	}
	
}
