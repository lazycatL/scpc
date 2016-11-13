package com.project.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类,用于实现一些字符串的常用操作
 * <ul>
 * <li>继承自{@link org.apache.commons.lang3.StringUtils}</li>
 * </ul>
 *
 * @author Trinea qfkong 2013.03.12 16:00
 * @version 1.0.1
 * @copyright http://www.project.com (类来源于网络)
 */
//public class StringUtils extends org.apache.commons.lang3.StringUtils {
public class StringUtils {
    /**
     * 校验字符串是否为空
     *
     * @param str 需要校验的字符串
     * @return
     */
    public static Boolean isEmpty(String str) {
        if (str == null || str.isEmpty()) {
            return true;
        }
        return false;
    }

    /**
     * 是否为空白,包括null和""
     *
     * @param str
     * @return
     */
    public static boolean isBlank(String str) {
        return str == null || str.trim().length() == 0;
    }

    /**
     * null字符串转换为长度为0的字符串
     *
     * @param str 待转换字符串
     * @return
     * @see <pre>
     *  nullStrToEmpty(null)    =   "";
     *  nullStrToEmpty("")      =   "";
     *  nullStrToEmpty("aa")    =   "aa";
     * </pre>
     */
    public static String nullStrToEmpty(String str) {
        return (str == null ? "" : str);
    }

    /**
     * 将字符串首字母大写后返回
     *
     * @param str 原字符串
     * @return 首字母大写后的字符串
     * <p/>
     * <pre>
     *      capitalizeFirstLetter(null)     =   null;
     *      capitalizeFirstLetter("")       =   "";
     *      capitalizeFirstLetter("2ab")    =   "2ab"
     *      capitalizeFirstLetter("a")      =   "A"
     *      capitalizeFirstLetter("ab")     =   "Ab"
     *      capitalizeFirstLetter("Abc")    =   "Abc"
     * </pre>
     */
    public static String capitalizeFirstLetter(String str) {
        if (isEmpty(str)) {
            return str;
        }
        char c = str.charAt(0);
        return (!Character.isLetter(c) || Character.isUpperCase(c)) ? str : new StringBuilder(str.length()).append(Character.toUpperCase(c)).append(str.substring(1)).toString();
    }

    /**
     * 如果不是普通字符，则按照utf8进行编码
     * <p/>
     * <pre>
     * utf8Encode(null)        =   null
     * utf8Encode("")          =   "";
     * utf8Encode("aa")        =   "aa";
     * utf8Encode("啊啊啊啊")   = "%E5%95%8A%E5%95%8A%E5%95%8A%E5%95%8A";
     * </pre>
     *
     * @param str 原字符
     * @return 编码后字符，若编码异常抛出异常
     */
    public static String utf8Encode(String str) {
        if (!isEmpty(str) && str.getBytes().length != str.length()) {
            try {
                return URLEncoder.encode(str, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException("UnsupportedEncodingException occurred. ", e);
            }
        }
        return str;
    }

    /**
     * 如果不是普通字符，则按照utf8进行编码，编码异常则返回defultReturn
     *
     * @param str          源字符串
     * @param defultReturn 出现异常默认返回
     * @return
     */
    public static String utf8Encode(String str, String defultReturn) {
        if (!isEmpty(str) && str.getBytes().length != str.length()) {
            try {
                return URLEncoder.encode(str, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                if (isEmpty(defultReturn)) {//校验返回字符串是否为空,否则返回原字符串
                    defultReturn = str;
                }
                return defultReturn;
            }
        }
        return str;
    }

    /**
     * 得到href链接的innerHtml
     *
     * @param href href内容
     * @return href的innerHtml
     * <ul>
     * <li>空字符串返回""</li>
     * <li>若字符串不为空，且不符合链接正则的返回原内容</li>
     * <li>若字符串不为空，且符合链接正则的返回最后一个innerHtml</li>
     * </ul>
     * @see <pre>
     *      getHrefInnerHtml(null)                                  = ""
     *      getHrefInnerHtml("")                                    = ""
     *      getHrefInnerHtml("mp3")                                 = "mp3";
     *      getHrefInnerHtml("&lt;a innerHtml&lt;/a&gt;")                    = "&lt;a innerHtml&lt;/a&gt;";
     *      getHrefInnerHtml("&lt;a&gt;innerHtml&lt;/a&gt;")                    = "innerHtml";
     *      getHrefInnerHtml("&lt;a&lt;a&gt;innerHtml&lt;/a&gt;")                    = "innerHtml";
     *      getHrefInnerHtml("&lt;a href="baidu.com"&gt;innerHtml&lt;/a&gt;")               = "innerHtml";
     *      getHrefInnerHtml("&lt;a href="baidu.com" title="baidu"&gt;innerHtml&lt;/a&gt;") = "innerHtml";
     *      getHrefInnerHtml("   &lt;a&gt;innerHtml&lt;/a&gt;  ")                           = "innerHtml";
     *      getHrefInnerHtml("&lt;a&gt;innerHtml&lt;/a&gt;&lt;/a&gt;")                      = "innerHtml";
     *      getHrefInnerHtml("jack&lt;a&gt;innerHtml&lt;/a&gt;&lt;/a&gt;")                  = "innerHtml";
     *      getHrefInnerHtml("&lt;a&gt;innerHtml1&lt;/a&gt;&lt;a&gt;innerHtml2&lt;/a&gt;")        = "innerHtml2";
     * </pre>
     */
    public static String getHrefInnerHtml(String href) {
        if (isEmpty(href)) {
            return "";
        }
        String hrefReg = ".*<[\\s]*a[\\s]*.*>(.+?)<[\\s]*/a[\\s]*>.*";
        Pattern hrefPattern = Pattern.compile(hrefReg, Pattern.CASE_INSENSITIVE);
        Matcher hrefMatcher = hrefPattern.matcher(href);
        if (hrefMatcher.matches()) {
            return hrefMatcher.group(1);
        }
        return href;
    }

    /**
     * html的转义字符转换成正常的字符串
     * <p/>
     * <pre>
     * htmlEscapeCharsToString(null) = null;
     * htmlEscapeCharsToString("") = "";
     * htmlEscapeCharsToString("mp3") = "mp3";
     * htmlEscapeCharsToString("mp3&lt;") = "mp3<";
     * htmlEscapeCharsToString("mp3&gt;") = "mp3\>";
     * htmlEscapeCharsToString("mp3&amp;mp4") = "mp3&mp4";
     * htmlEscapeCharsToString("mp3&quot;mp4") = "mp3\"mp4";
     * htmlEscapeCharsToString("mp3&lt;&gt;&amp;&quot;mp4") = "mp3\<\>&\"mp4";
     * </pre>
     *
     * @param source
     * @return
     */
    public static String htmlEscapeCharsToString(String source) {
        if (isEmpty(source)) {
            return source;
        } else {
            return source.replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("&amp;", "&").replaceAll("&quot;",
                    "\"");
        }
    }

    /**
     * 半角字符转换为全角字符
     * <p/>
     * <pre>
     * fullWidthToHalfWidth(null) = null;
     * fullWidthToHalfWidth("") = "";
     * fullWidthToHalfWidth(new String(new char[] {12288})) = " ";
     * fullWidthToHalfWidth("！＂＃＄％＆) = "!\"#$%&";
     * </pre>
     *
     * @param s
     * @return
     */
    public static String fullWidthToHalfWidth(String s) {
        if (isEmpty(s)) {
            return s;
        }

        char[] source = s.toCharArray();
        for (int i = 0; i < source.length; i++) {
            if (source[i] == 12288) {
                source[i] = ' ';
                // } else if (source[i] == 12290) {
                // source[i] = '.';
            } else if (source[i] >= 65281 && source[i] <= 65374) {
                source[i] = (char) (source[i] - 65248);
            } else {
                source[i] = source[i];
            }
        }
        return new String(source);
    }

    /**
     * 全角字符转换为半角字符
     * <p/>
     * <pre>
     * halfWidthToFullWidth(null) = null;
     * halfWidthToFullWidth("") = "";
     * halfWidthToFullWidth(" ") = new String(new char[] {12288});
     * halfWidthToFullWidth("!\"#$%&) = "！＂＃＄％＆";
     * </pre>
     *
     * @param s
     * @return
     */
    public static String halfWidthToFullWidth(String s) {
        if (isEmpty(s)) {
            return s;
        }


        char[] source = s.toCharArray();
        for (int i = 0; i < source.length; i++) {
            if (source[i] == ' ') {
                source[i] = (char) 12288;
                // } else if (source[i] == '.') {
                // source[i] = (char)12290;
            } else if (source[i] >= 33 && source[i] <= 126) {
                source[i] = (char) (source[i] + 65248);
            } else {
                source[i] = source[i];
            }
        }
        return new String(source);
    }

    /**
     * 判断是否为整数
     *
     * @param str 传入的字符串
     * @return 是整数返回true, 否则返回false
     */
    public static boolean isInteger(String str) {
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断是否为浮点数，包括double和float
     *
     * @param str 传入的字符串
     * @return 是浮点数返回true, 否则返回false
     */
    public static boolean isDouble(String str) {
        Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断输入的字符串是否符合Email样式.
     *
     * @param str 传入的字符串
     * @return 是Email样式返回true, 否则返回false
     */
    public static boolean isEmail(String str) {
        Pattern pattern = Pattern.compile("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断输入的字符串是否为纯汉字
     *
     * @param str 传入的字符窜
     * @return 如果是纯汉字返回true, 否则返回false
     */
    public static boolean isChinese(String str) {
        Pattern pattern = Pattern.compile("[\u0391-\uFFE5]+$");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断是不是合法字符(a-zA-Z0-9.-_)
     *
     * @param c 要判断的字符
     * @return 返回判断结果
     */
    public static boolean isLetter(String c) {
        boolean result = false;

        if (c == null || c.length() < 0) {
            return false;
        }
        //a-z
        if (c.compareToIgnoreCase("a") >= 0 && c.compareToIgnoreCase("z") <= 0) {
            return true;
        }
        //0-9
        if (c.compareToIgnoreCase("0") >= 0 && c.compareToIgnoreCase("9") <= 0) {
            return true;
        }
        //. - _
        if (c.equals(".") || c.equals("-") || c.equals("_")) {
            return true;
        }
        return result;
    }

    /**
     * 将HTML特殊字符转换成&符号
     *
     * @param src 原始字符串
     * @return 过滤后的字符串
     */
    public static String encodingHtml(String src) {
        if (isBlank(src) || isEmpty(src))
            return "";
        StringBuilder result = new StringBuilder();
        if (src != null) {
            src = src.trim();
            for (int pos = 0; pos < src.length(); pos++) {
                switch (src.charAt(pos)) {
                    case '\"':
                        result.append("&quot;");
                        break;
                    case '<':
                        result.append("&lt;");
                        break;
                    case '>':
                        result.append("&gt;");
                        break;
                    case '\'':
                        result.append("&apos;");
                        break;
                    case '&':
                        result.append("&amp;");
                        break;
                    case '%':
                        result.append("&pc;");
                        break;
                    case '_':
                        result.append("&ul;");
                        break;
                    case '#':
                        result.append("&shap;");
                        break;
                    case '?':
                        result.append("&ques;");
                        break;
                    default:
                        result.append(src.charAt(pos));
                        break;
                }
            }
        }
        return result.toString();
    }

    /**
     * 将HTML &符号转换成HTML符号
     *
     * @param src 原始字符串
     * @return 过滤后的字符串
     */
    public static String decodingHtml(String src) {
        if (isBlank(src) || isEmpty(src))
            return "";
        String result = src;
        result = result.replace("&quot;", "\"").replace("&apos;", "\'");
        result = result.replace("&lt;", "<").replace("&gt;", ">");
        result = result.replace("&amp;", "&");
        result = result.replace("&pc;", "%").replace("&ul", "_");
        result = result.replace("&shap;", "#").replace("&ques", "?");
        return result;
    }

    /**
     * 利用反射调用一个继承层次上的函数族，
     * 比如安装程序，有安装数据库的，安装文件系统的等，
     * 命名均已“install”开始，你就可以将参数part设为“install”，
     * src是其实类实例，root是终止父类
     *
     * @param <T>
     * @param part 设为“install”
     * @param src  类实例
     * @param root 终止父类
     * @throws ExceptionManager
     */
    public static <T> void invokeMethods(String part, T src, Class root) throws Exception {
        if (root != null) {
            if (!root.isInstance(src)) return;
            root = (Class) root.getGenericSuperclass();
        }
        HashMap<String, Method> invokees = new HashMap<String, Method>();
        Class target = src.getClass();
        do {
            Method[] methods = target.getDeclaredMethods();
            for (Method method : methods) {
                String mn = method.getName();
                Boolean isPass = mn.startsWith(part);
                if (isPass) {
                    Integer nopt = method.getParameterTypes().length;
                    Boolean isStatic = Modifier.isStatic(method.getModifiers());
                    if ((nopt == 0) && (!isStatic)) {
                        if (!invokees.containsKey(mn))
                            invokees.put(mn, method);
                    }
                }
            }
            target = (Class) target.getGenericSuperclass();
        } while (target != root);
        Iterator<String> methods = invokees.keySet().iterator();
        while (methods.hasNext()) {
            Method invokee = invokees.get(methods.next());
            Boolean access = invokee.isAccessible();
            invokee.setAccessible(true);
            try {
                invokee.invoke(src);
            } catch (InvocationTargetException e) {
                throw new Exception(e);//.wrap(e.getTargetException());
            } catch (Exception e) {
            }
            invokee.setAccessible(access);
        }
    }

    /**
     * 去掉字符串中重复的子字符串
     *
     * @param str
     * @return String
     */
    private static String removeSameString(String str) {
        Set<String> mLinkedSet = new LinkedHashSet<String>();
        String[] strArray = str.split(" ");
        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < strArray.length; i++) {
            if (!mLinkedSet.contains(strArray[i])) {
                mLinkedSet.add(strArray[i]);
                sb.append(strArray[i] + " ");
            }
        }
        //System.out.println(mLinkedSet);
        return sb.toString().substring(0, sb.toString().length() - 1);
    }

    /**
     * 根据指定方法的参数去构造一个新的对象的拷贝并将他返回
     *
     * @param obj 原始对象
     * @return 新对象
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws InstantiationException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    @SuppressWarnings("unchecked")
    public static Object copy(Object obj) throws IllegalArgumentException, SecurityException, InstantiationException, IllegalAccessException,
            InvocationTargetException, NoSuchMethodException {
        //获得对象的类型
        Class classType = obj.getClass();

        //通过默认构造方法去创建一个新的对象，getConstructor的视其参数决定调用哪个构造方法
        Object objectCopy = classType.getConstructor(new Class[]{}).newInstance();

        //获得对象的所有属性
        Field[] fields = classType.getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {
            //获取数组中对应的属性
            Field field = fields[i];

            String fieldName = field.getName();
            String stringLetter = fieldName.substring(0, 1).toUpperCase();

            //获得相应属性的getXXX和setXXX方法名称
            String getName = "get" + stringLetter + fieldName.substring(1);
            String setName = "set" + stringLetter + fieldName.substring(1);

            //获取相应的方法
            Method getMethod = classType.getMethod(getName);
            Method setMethod = classType.getMethod(setName, field.getType());

            //调用源对象的getXXX（）方法
            Object value = getMethod.invoke(obj);

            //调用拷贝对象的setXXX（）方法
            setMethod.invoke(objectCopy, value);
        }

        return objectCopy;
    }

    /**
     * 参数：多组关键词--之间有一个或多个空格 结果：分析成每组关键词中用一个空格隔开 并且过滤掉非中文、非数字、非英文字符
     */
    public String splitKeyWords(String content) {
        String keywords = "";
        if (content == null || "".equals(content)) {
            return "";
        }
        keywords = content.replaceAll("[\\pP|~|$|^|<|>|\\||\\+|=]*", "");
        StringBuilder result = new StringBuilder();
        boolean space = false;// 前一个是否为空格，默认第一个不是
        for (int i = 0; i < keywords.length(); i++) {
            if (keywords.charAt(i) != ' ') {
                space = false;
                result.append(keywords.charAt(i));
            } // end 当前不是空格
            else if (!space) {
                space = true;
                result.append(keywords.charAt(i));
            }// end 当前是空格，但前一个不是空格

            // 没有else了，省略了当前是空格，前一个也是空格，当然不用理它了
        }
        //System.out.println(result.toString());
        return result.toString();
    }

    /**
     * 通过网址 获取该网址的主域名
     */
    public static String queryDoMainUrl(String url) {
        if (null == url || "".equals(url)) {
            return null;
        }
        String patternString1 = "aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel";
        String patternString2 = "ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw";
        String pattern = "[\\w-]+(\\.(" + patternString1 + ")(\\.("
                + patternString2 + "))|\\.(" + patternString1 + "|"
                + patternString2 + "))$";
        Pattern p = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
        String s = analyseFirstHost(url);
        if (s == null || "".equals(s)) {
            return null;
        }
        Matcher matcher = p.matcher(s);
        if (matcher.find()) {
            return matcher.group();
        } else {
            return null;
        }
    }

    private static String analyseFirstHost(String url) {
        String p = "(?<=://)([\\w-]+\\.)+[\\w-]+(?<=/?)";
        Pattern pattern = Pattern.compile(p, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(url);
        if (matcher.find()) {
            return matcher.group();
        } else {
            return null;
        }
    }

}
