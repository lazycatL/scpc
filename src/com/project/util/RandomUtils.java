package com.project.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 随机数工具类
 * 
 * @author Trinea qfkong 2013.03.12 16:00
 * @copyright http://www.project.com (类来源于网络)
 * @version 1.0.1
 */

public class RandomUtils {

    public static final String NUMBERS_AND_LETTERS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String NUMBERS             = "0123456789";
    public static final String LETTERS             = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String CAPITAL_LETTERS     = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String LOWER_CASE_LETTERS  = "abcdefghijklmnopqrstuvwxyz";

    /**
     * 得到固定长度的随机字符串，字符串由数字和大小写字母混合组成
     * 
     * @param length 长度
     * @return
     * @see 见{@link StringUtils#getRandom(String source, int length)}
     */
    public static String getRandomNumbersAndLetters(int length) {
        return getRandom(NUMBERS_AND_LETTERS, length);
    }

    /**
     * 得到固定长度的随机字符串，字符串由数字混合组成
     * 
     * @param length 长度
     * @return
     * @see 见{@link StringUtils#getRandom(String source, int length)}
     */
    public static String getRandomNumbers(int length) {
        return getRandom(NUMBERS, length);
    }

    /**
     * 得到固定长度的随机字符串，字符串由大小写字母混合组成
     * 
     * @param length 长度
     * @return
     * @see 见{@link StringUtils#getRandom(String source, int length)}
     */
    public static String getRandomLetters(int length) {
        return getRandom(LETTERS, length);
    }

    /**
     * 得到固定长度的随机字符串，字符串由大写字母混合组成
     * 
     * @param length 长度
     * @return
     * @see 见{@link StringUtils#getRandom(String source, int length)}
     */
    public static String getRandomCapitalLetters(int length) {
        return getRandom(CAPITAL_LETTERS, length);
    }

    /**
     * 得到固定长度的随机字符串，字符串由小写字母混合组成
     * 
     * @param length 长度
     * @return
     * @see 见{@link StringUtils#getRandom(String source, int length)}
     */
    public static String getRandomLowerCaseLetters(int length) {
        return getRandom(LOWER_CASE_LETTERS, length);
    }

    /**
     * 得到固定长度的随机字符串，字符串由source中字符混合组成
     * 
     * @param source 源字符串
     * @param length 长度
     * @return
     *         <ul>
     *         <li>若source为null或为空字符串，返回null</li>
     *         <li>否则见{@link StringUtils#getRandom(char[] sourceChar, int length)}</li>
     *         </ul>
     */
    public static String getRandom(String source, int length) {
        return StringUtils.isEmpty(source) ? null : getRandom(source.toCharArray(), length);
    }
  /**
   * 获取指定范围的随机数
   * @param min 最小值
   * @param max 最大值
   * @return 指定范围内的随机数
   */
	public static int getRandom(int min,int max) {
	  int random = 0;
	  int _min = min;
	  int _max = max+1;
	  boolean flag = true;//是否满足条件
	  
	  while(flag) {
	      random = (int) Math.round(Math.floor(Math.random() * _max));
	      if(random >= _min) {
	       flag = false;
	      }
	  }
	  return random;
	 }

    /**
     * 得到固定长度的随机字符串，字符串由sourceChar中字符混合组成
     * 
     * @param sourceChar 源字符数组
     * @param length 长度
     * @return
     *         <ul>
     *         <li>若sourceChar为null或长度为0，返回null</li>
     *         <li>若length小于0，返回null</li>
     *         </ul>
     */
    public static String getRandom(char[] sourceChar, int length) {
        if (sourceChar == null || sourceChar.length == 0 || length < 0) {
            return null;
        }

        StringBuilder str = new StringBuilder(length);
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            str.append(sourceChar[random.nextInt(sourceChar.length)]);
        }
        return str.toString();
    }
    
    
}
