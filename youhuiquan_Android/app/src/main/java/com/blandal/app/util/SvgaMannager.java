package com.blandal.app.util;

import android.annotation.SuppressLint;
import android.text.TextUtils;

import java.util.HashMap;
import java.util.Map;

import com.blandal.app.R;

/**
 * Description:获取SVGA动画
 * author:ljx
 * time  :2020/10/15 17 15
 */
public class SvgaMannager {

    private Map<String, String> savgList = new HashMap<>();

    private static volatile SvgaMannager mInstance;

    private SvgaMannager() {
        savgList.put("cold", "cold.svga");
        savgList.put("coloud", "coloud.svga");
        savgList.put("flyash", "flyash.svga");
        savgList.put("fog", "fog.svga");
        savgList.put("haze", "haze.svga");
        savgList.put("hot", "hot.svga");
        savgList.put("rains", "rains.svga");
        savgList.put("ray", "ray.svga");
        savgList.put("sand", "sand.svga");
        savgList.put("snow", "snow.svga");
        savgList.put("storms", "storms.svga");
        savgList.put("sunny", "sunny.svga");
    }

    public static SvgaMannager getInstance() {
        if (mInstance == null) {
            synchronized (SvgaMannager.class) {
                if (mInstance == null) {
                    mInstance = new SvgaMannager();
                }
            }
        }
        return mInstance;
    }


    public String getBackSavg(String key) {
        switch (key) {
            case "100":
            case "150":
                //晴
                return savgList.get("sunny");
            case "104":
            case "154":
                //阴天
                return savgList.get("coloud");
            case "103":
            case "153":
            case "101":
            case "102":
                //云
                return savgList.get("coloud");
            case "300":
            case "301":
            case "305":
            case "306":
            case "307":
            case "308":
            case "309":
            case "310":
            case "311":
            case "312":
            case "313":
            case "314":
            case "315":
            case "316":
            case "317":
            case "318":
            case "399":
            case "350":
            case "351":
            case "406":
            case "456":
                //雨
                return savgList.get("rains");
            case "302":
            case "303":
            case "304":
                //雷阵雨
                return savgList.get("ray");
            case "400":
            case "401":
            case "402":
            case "403":
            case "404":
            case "405":
            case "407":
            case "408":
            case "409":
            case "410":
            case "499":
            case "457":
                //雪
                return savgList.get("snow");
            case "900":
                //热
                return savgList.get("hot");
            case "901":
                //冷
                return savgList.get("cold");
            case "500":
            case "501":
            case "509":
            case "510":
            case "514":
            case "515":
                //雾
                return savgList.get("fog");
            case "502":
            case "511":
            case "512":
            case "513":
                //霾
                return savgList.get("haze");
            case "504":
                //浮尘
                return savgList.get("flyash");
            case "503":
                //扬沙
                return savgList.get("sand");
            case "507":
            case "508":
                //沙尘暴
                return savgList.get("storms");
            default:
                return "coloud.svga";
        }


    }

    @SuppressLint("ResourceAsColor")
    public
    int getBackColor(String key) {
        if (TextUtils.isEmpty(key)){
            return R.color.color_gray_d1d1d1;
        }
        switch (key) {
            case "100":
            case "150":
                //晴
                return R.color.color_yellow_ffe207;
            case "104":
            case "154":
                //阴天
                return R.color.color_gray_d1d1d1;
            case "103":
            case "153":
            case "101":
            case "102":
                //云
                return R.color.color_yellow_ffe207;
            case "300":
            case "301":
            case "305":
            case "306":
            case "307":
            case "308":
            case "309":
            case "310":
            case "311":
            case "312":
            case "313":
            case "314":
            case "315":
            case "316":
            case "317":
            case "318":
            case "399":
            case "350":
            case "351":
            case "406":
            case "456":
                //雨
                return R.color.color_blue_4dc5ff;
            case "302":
            case "303":
            case "304":
                //雷阵雨
                return R.color.color_blue_4dc5ff;
            case "400":
            case "401":
            case "402":
            case "403":
            case "404":
            case "405":
            case "407":
            case "408":
            case "409":
            case "410":
            case "499":
            case "457":
                //雪
                return R.color.color_blue_4dc5ff;
            case "900":
                //热
                return R.color.color_red_ff8566;
            case "901":
                //冷
                return R.color.color_red_4ab6f5;
            case "500":
            case "501":
            case "509":
            case "510":
            case "514":
            case "515":
                //雾
                return R.color.color_yellow_f0c518;
            case "502":
            case "511":
            case "512":
            case "513":
                //霾
                return R.color.color_yellow_f0c518;
            case "504":
                //浮尘
                return R.color.color_yellow_f0c518;
            case "503":
                //扬沙
                return R.color.color_yellow_f0c518;
            case "507":
            case "508":
                //沙尘暴
                return R.color.color_yellow_f0c518;
            default:
                return R.color.color_gray_d1d1d1;
        }
    }


}
