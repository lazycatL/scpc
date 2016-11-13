package com.project.util;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 *@author wgzx_106
 *@version 创建时间:Jun 12, 201211:19:43 AM
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface Logs {
	public static String LOGIN ="登陆操作";
	public static String BUSINESS ="业务操作";
	public String type() default "业务操作";
	public String description() default "无";
}
