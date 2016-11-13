package com.project;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.project.base.ContextHolder;
import com.project.base.service.BaseService;
import com.project.util.Logs;

/**
 *@author hwli
 *@version 创建时间:Jun 12, 20124:28:30 PM
 */
public class LogsInterceptor implements Interceptor {

	private BaseService baseService = (BaseService) ContextHolder.getBean("baseService");
	@Override
	public void destroy() {

	}

	@Override
	public void init() {

	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Method method = invocation.getAction().getClass().getMethod(invocation.getProxy().getMethod(), null);
		if(method.isAnnotationPresent(Logs.class)){
			ActionContext actionContext = invocation.getInvocationContext();
			HttpServletRequest request = (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST);
			baseService.saveSysTemUserLog(request, method.getAnnotation(Logs.class).description(),method.getAnnotation(Logs.class).type());
		}
		return invocation.invoke();
	}
}
