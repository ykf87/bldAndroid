package com.jiankang.gouqi.util;


import com.jiankang.gouqi.app.MyApplication;

/**
 * Created by niuchong on 2019/4/7.
 */

public class ContentUtil {

    //用户id
    public static final String PUBLIC_ID = "HE2010281145031386";
    //用户key
    public static final String APK_KEY = "de1a212e28e34ec8bfcfc55a220f395b";
    //当前所在位置
    public static Double NOW_LON = 0.0;
    public static Double NOW_LAT = 0.0;
    public static String NOW_AOI_NAME = "";

    //当前城市
    public static String NOW_CITY_ID = SpUtils.getString(MyApplication.getContext(), "lastLocation", "CN101010100");
    public static String NOW_CITY_NAME = SpUtils.getString(MyApplication.getContext(), "nowCityName", "北京");
    //最低温
    public static String NOW_CITY_MIN_TEMPERATURE = "12";
    //最高温
    public static String NOW_CITY_MAX_TEMPERATURE = "15";
    //早晚天气图标
    public static String NOW_CITY_ICON_DAY = "0";
    public static String NOW_CITY_ICON_NIGHT = "0";

    //设置的默认城市ID,为空则取定位城市
    public static String DEFAULT_CITY_ID = "";

    public static boolean FIRST_OPEN = SpUtils.getBoolean(MyApplication.getContext(), "first_open", true);

    //应用设置里的文字
    public static String SYS_LANG = "zh";
    public static String APP_SETTING_LANG = SpUtils.getString(MyApplication.getContext(), "language", "sys");
    public static String APP_SETTING_UNIT = SpUtils.getString(MyApplication.getContext(), "unit", "she");
    public static String APP_SETTING_TESI = SpUtils.getString(MyApplication.getContext(), "size", "mid");
    public static String APP_PRI_TESI = SpUtils.getString(MyApplication.getContext(), "size", "mid");
    public static String APP_SETTING_THEME = SpUtils.getString(MyApplication.getContext(), "theme", "浅色");


    public static boolean UNIT_CHANGE = false;
    public static boolean CHANGE_LANG = false;
    public static boolean CITY_CHANGE = false;

}
