package com.blandal.app.util;

import android.annotation.SuppressLint;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串操作工具包
 *
 * @author liux (http://my.oschina.net/liux)
 * @version 1.0
 * @created 2012-3-21
 */
@SuppressLint("SimpleDateFormat")
public class StringUtils {
    private final static Pattern emailer = Pattern
            .compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
    // private final static SimpleDateFormat dateFormater = new
    // SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    // private final static SimpleDateFormat dateFormater2 = new
    // SimpleDateFormat("yyyy-MM-dd");

    private final static ThreadLocal<SimpleDateFormat> dateFormater = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }
    };

    private final static ThreadLocal<SimpleDateFormat> dateFormater2 = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd");
        }
    };
    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * 将字符串转位日期类型
     *
     * @param sdate
     * @return
     */
    public static Date toDate(String sdate) {
        try {
            return dateFormater.get().parse(sdate);
        } catch (ParseException e) {
            return null;
        }
    }

    /**
     * 以友好的方式显示时间
     *
     * @param sdate
     * @return
     */
    public static String friendly_time(String sdate) {
        Date time = toDate(sdate);
        if (time == null) {
            return "Unknown";
        }
        String ftime = "";
        Calendar cal = Calendar.getInstance();

        // 判断是否是同一天
        String curDate = dateFormater2.get().format(cal.getTime());
        String paramDate = dateFormater2.get().format(time);
        if (curDate.equals(paramDate)) {
            int hour = (int) ((cal.getTimeInMillis() - time.getTime()) / 3600000);
            if (hour == 0)
                ftime = Math.max(
                        (cal.getTimeInMillis() - time.getTime()) / 60000, 1)
                        + "分钟前";
            else
                ftime = hour + "小时前";
            return ftime;
        }

        long lt = time.getTime() / 86400000;
        long ct = cal.getTimeInMillis() / 86400000;
        int days = (int) (ct - lt);
        if (days == 0) {
            int hour = (int) ((cal.getTimeInMillis() - time.getTime()) / 3600000);
            if (hour == 0)
                ftime = Math.max(
                        (cal.getTimeInMillis() - time.getTime()) / 60000, 1)
                        + "分钟前";
            else
                ftime = hour + "小时前";
        } else if (days == 1) {
            ftime = "昨天";
        } else if (days == 2) {
            ftime = "前天";
        } else if (days > 2 && days <= 10) {
            ftime = days + "天前";
        } else if (days > 10) {
            ftime = dateFormater2.get().format(time);
        }
        return ftime;
    }

    @SuppressWarnings("deprecation")
    private static String getDayDateStr(long time) {
        Date today = new Date(time);
        int hours = today.getHours();
        if (hours > 2 && hours < 6) {
            return "凌晨 " + getHourAndMin(time);
        } else if (hours < 8) {
            return "早晨 " + getHourAndMin(time);
        } else if (hours < 11) {
            return "上午 " + getHourAndMin(time);
        } else if (hours < 13) {
            return "中午 " + getHourAndMin(time);
        } else if (hours < 17) {
            return "下午 " + getHourAndMin(time);
        } else if (hours < 19) {
            return "傍晚 " + getHourAndMin(time);
        } else if (hours < 23) {
            return "晚上 " + getHourAndMin(time);
        } else {
            return "深夜 " + getHourAndMin(time);
        }
    }

    private static String getHourAndMin(long time) {
        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
        return format.format(new Date(time));
    }

    private static String getTime(long time) {
        SimpleDateFormat format = new SimpleDateFormat("MM-dd HH:mm");
        return format.format(new Date(time));
    }

    /**
     * 判断给定字符串时间是否为今日
     *
     * @param sdate
     * @return boolean
     */
    public static boolean isToday(String sdate) {
        boolean b = false;
        Date time = toDate(sdate);
        Date today = new Date();
        if (time != null) {
            String nowDate = dateFormater2.get().format(today);
            String timeDate = dateFormater2.get().format(time);
            if (nowDate.equals(timeDate)) {
                b = true;
            }
        }
        return b;
    }

    /**
     * 判断字符串空
     *
     * @param val
     * @return
     */
    public static boolean isNullOrEmpty(String val) {
        if (val == null)
            return true;
        if (val.trim().length() < 1)
            return true;
        return false;
    }

    /**
     * 判断数字是否大于0
     *
     * @param val
     * @return
     */
    public static boolean isBig2Zero(long val) {
        if (val > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 判断数字是否小等于0
     *
     * @param val
     * @return
     */
    public static boolean isSmall2Zero(long val) {
        if (val > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 判断数字是否小等于0
     *
     * @param val
     * @return
     */
    public static boolean isSmall2Zero(float val) {
        if (val > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 判断字符串非等于空
     *
     * @param val
     * @return
     */
    public static boolean isNotNullOrEmpty(String val) {
        if (val == null)
            return false;
        if (val.trim().length() > 0)
            return true;
        return false;
    }

    /**
     * 判断字符串非等于空
     *
     * @param val
     * @return
     */
    public static boolean isNotNullOrEmpty(Object val) {
        if (val == null)
            return false;
        if (val.toString().trim().length() > 0)
            return true;
        return false;
    }

    /**
     * 判断给定字符串是否空白串。 空白串是指由空格、制表符、回车符、换行符组成的字符串 若输入字符串为null或空字符串，返回true
     *
     * @param input
     * @return boolean
     */
    public static boolean isBlankEmpty(String input) {
        if (input == null || "".equals(input))
            return true;

        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (c != ' ' && c != '\t' && c != '\r' && c != '\n') {
                return false;
            }
        }
        return true;
    }

    /**
     * 判断是不是一个合法的电子邮件地址
     *
     * @param email
     * @return
     */
    public static boolean isEmail(String email) {
        if (email == null || email.trim().length() == 0)
            return false;
        return emailer.matcher(email).matches();
    }

    /**
     * 获取年龄
     *
     * @param date
     * @return
     */
    public static int getAge(String date) {

        Date beginDate = null;
        try {
            // 出生年月
            beginDate = sdf.parse(date);
        } catch (Exception e) {
            return 0;
        }
        long day = (new Date().getTime() - beginDate.getTime()) / 1000;
        int result = (int) (day / (60 * 60 * 24 * 365));
        return result;
    }

    /**
     * @param m 自1970开始的毫秒数
     * @return
     */
    public static String getDate(long m) {

        Date d = new Date(m);
        return sdf.format(d);
    }

    public static String getYMD(String date) {
        String result;
        result = date.replaceFirst("-", "年");
        result = result.replaceFirst("-", "月");
        result += "日";
        return result;
    }

    /**
     * 电话号码验证
     *
     * @param str
     * @return 验证通过返回true
     */
    public static boolean isTel(String str) {
        Pattern p1 = null, p2 = null;
        Matcher m = null;
        boolean b = false;
        p1 = Pattern.compile("^[0][1-9]{1,2}[0-9]{0,1}-[0-9]{5,10}$"); // 验证带区号的
        p2 = Pattern.compile("^[1-9]{1}[0-9]{5,8}$"); // 验证没有区号的
        if (str.length() > 9) {
            m = p1.matcher(str);
            b = m.matches();
        } else {
            m = p2.matcher(str);
            b = m.matches();
        }
        return b;
    }

    /**
     * 电话号码验证 中间无-
     *
     * @param str
     * @return 验证通过返回true
     */
    public static boolean isTelNoDeliver(String str) {
        Pattern p1 = null, p2 = null;
        Matcher m = null;
        boolean b = false;
        p1 = Pattern.compile("^[0][1-9]{1,2}[0-9]{0,1}[0-9]{5,10}$"); // 验证带区号的
        p2 = Pattern.compile("^[1-9]{1}[0-9]{5,8}$"); // 验证没有区号的
        if (str.length() > 9) {
            m = p1.matcher(str);
            b = m.matches();
        } else {
            m = p2.matcher(str);
            b = m.matches();
        }
        return b;
    }

    /**
     * 字符串转整数
     *
     * @param str
     * @param defValue
     * @return
     */
    public static int toInt(String str, int defValue) {
        try {
            return Integer.parseInt(str);
        } catch (Exception e) {
        }
        return defValue;
    }

    /**
     * 对象转整数
     *
     * @param obj
     * @return 转换异常返回 0
     */
    public static int toInt(Object obj) {
        if (obj == null)
            return 0;
        return toInt(obj.toString(), 0);
    }

    /**
     * 对象转整数
     *
     * @param obj
     * @return 转换异常返回 0
     */
    public static long toLong(String obj) {
        try {
            return Long.parseLong(obj);
        } catch (Exception e) {
        }
        return 0;
    }

    /**
     * 对象转整数
     *
     * @param obj
     * @return 转换异常返回 0.00
     */
    public static Double toDouble(Object obj) {
        if (obj == null)
            return 0.00;
        try {
            return Double.parseDouble(obj.toString());
        } catch (Exception e) {
        }
        return 0.00;
    }

    /**
     * 字符串转布尔值
     *
     * @param b
     * @return 转换异常返回 false
     */
    public static boolean toBool(String b) {
        try {
            return Boolean.parseBoolean(b);
        } catch (Exception e) {
        }
        return false;
    }

    public static int f2IntFen(float money) {
        //最后转成整形
        int moneyI = (int) (money * 100);

        return moneyI;
    }

    public static float str2Float(String moneyStr) {
        //把输入的金额转成浮点型
        float moneyF = Float.valueOf(moneyStr);
        //截取小数点后2位的数据
        DecimalFormat fnum = new DecimalFormat("##0.00");
        String moneyStr2F = fnum.format(moneyF);

        return Float.valueOf(moneyStr2F);
    }

}

