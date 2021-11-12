package com.jiankang.gouqi.util;

import android.app.Activity;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.CheckBox;
import android.widget.FrameLayout;
import android.widget.Toast;

import com.alibaba.fastjson.JSON;
import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAppDownloadListener;
import com.bytedance.sdk.openadsdk.TTFullScreenVideoAd;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.bytedance.sdk.openadsdk.TTRewardVideoAd;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.common.UserGlobal;
import com.qq.e.ads.rewardvideo.RewardVideoAD;
import com.qq.e.ads.rewardvideo.RewardVideoADListener;
import com.qq.e.ads.rewardvideo.ServerSideVerificationOptions;
import com.qq.e.comm.constants.LoadAdParams;
import com.qq.e.comm.util.AdError;
import com.qq.e.comm.util.VideoAdValidity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 */
public class YLHVideoUtils {

    static YLHVideoUtils instance = new YLHVideoUtils();

    public static YLHVideoUtils getInstance() {
        return instance;
    }

    private YLHADListener adListener;

    public interface YLHADListener {
        public void onADLoad();

        public void onADShow();

        public void onReward();

        public void onSkipped();


        public void onADClick();


        public void onVideoComplete();


        public void onADClose();


        public void onError(int var1);
    }

    public void setAdListener(YLHADListener adListener) {
        this.adListener = adListener;
    }


    /**
     * 加载视频
     * @param context
     * @return
     */
    public  static RewardVideoAD rvad;
    public static RewardVideoAD showRewardVideoAD(Activity context,RewardVideoADListener rewardVideoADListener) {
        String editPosId = "4062932245462854";
        rvad = new RewardVideoAD(context, editPosId, rewardVideoADListener, false);
        ServerSideVerificationOptions options = new ServerSideVerificationOptions.Builder()
                .setCustomData("APP's custom data") // 设置激励视频服务端验证的自定义信息
                .setUserId("APP's user id for server verify") // 设置服务端验证的用户信息
                .build();
        rvad.setServerSideVerificationOptions(options);
        rvad.setLoadAdParams(getLoadAdParams("reward_video"));
        rvad.loadAD();
        return  rvad;
    }

    static LoadAdParams getLoadAdParams(String value) {
        Map<String, String> info = new HashMap<>();
        info.put("custom_key", value);
        LoadAdParams loadAdParams = new LoadAdParams();
        loadAdParams.setDevExtra(info);
        return loadAdParams;
    }



}
