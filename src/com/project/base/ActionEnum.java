/**
 *  枚举类，  用来处理action结果
 *  @author  mukun
 */
package com.project.base;
import java.util.EnumMap;
import java.util.EnumSet;
public enum ActionEnum {
  // 1. 定义枚举类型
     // 利用构造函数传参
     SUCCESS (1), ERROR (0), OTHER (2);
     // 定义私有变量
     private int nCode ;
     // 构造函数，枚举类型只能为私有
     private ActionEnum( int _nCode) {
         this.nCode = _nCode;
     }

     @Override
     public String toString() {
         return String.valueOf ( this.nCode );
     }
}
