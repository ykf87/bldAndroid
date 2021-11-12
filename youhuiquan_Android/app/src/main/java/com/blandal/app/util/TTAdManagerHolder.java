package com.blandal.app.util;

import android.app.Activity;
import android.content.Context;
import android.text.TextUtils;
import android.view.View;
import android.widget.FrameLayout;

import com.bytedance.sdk.openadsdk.TTAdConfig;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdManager;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTAppDownloadListener;
import com.bytedance.sdk.openadsdk.TTCustomController;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;



/**
 * 可以用一个单例来保存TTAdManager实例，在需要初始化sdk的时候调用
 */
public class TTAdManagerHolder {

    private static boolean sInit;


    public static TTAdManager get() {
        if (!sInit) {
            throw new RuntimeException("TTAdSdk is not init, please check.");
        }
        return TTAdSdk.getAdManager();
    }

    public static void init(Context context) {
        doInit(context);
    }

    //step1:接入网盟广告sdk的初始化操作，详情见接入文档和穿山甲平台说明
    private static void doInit(Context context) {
        if (!sInit) {
            TTAdSdk.init(context, buildConfig(context), new TTAdSdk.InitCallback() {
                @Override
                public void success() {

                }

                @Override
                public void fail(int i, String s) {

                }
            });
            sInit = true;
        }
    }

    private static TTAdConfig buildConfig(Context context) {
        String appId = "5198096";
        return new TTAdConfig.Builder().asyncInit(true)
                .appId(appId)
                .useTextureView(true) //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView
                .appName("有券")
                .titleBarTheme(TTAdConstant.TITLE_BAR_THEME_DARK)
                .allowShowNotify(true) //是否允许sdk展示通知栏提示
                .allowShowPageWhenScreenLock(true) //是否在锁屏场景支持展示广告落地页
                .debug(true) //测试阶段打开，可以通过日志排查问题，上线时去除该调用
                .directDownloadNetworkType(TTAdConstant.NETWORK_STATE_WIFI) //允许直接下载的网络状态集合
                .supportMultiProcess(false)//是否支持多进程
                .needClearTaskReset()
                //.httpStack(new MyOkStack3())//自定义网络库，demo中给出了okhttp3版本的样例，其余请自行开发或者咨询工作人员。
                .customController(new TTCustomController() {
                    @Override
                    public boolean isCanUseLocation() {
                        return false;
                    }
                })
                .build();
    }

    public static void bindAdListener(Context context, FrameLayout itemView, TTNativeExpressAd ad, String adid, boolean bindDisLike) {
        bindAdListener(context, itemView, ad, adid, bindDisLike, true);
    }

    public static void bindAdListener(Context context, final FrameLayout itemView, TTNativeExpressAd ad, final String adid, boolean bindDisLike, boolean bindDislikeAction) {
        ad.setExpressInteractionListener(new TTNativeExpressAd.ExpressAdInteractionListener() {
            @Override
            public void onAdClicked(View view, int type) {
                if (!TextUtils.isEmpty(adid)) {
                    //AdManagerUtil.getInstance().addAdLog(adid, AdManagerUtil.ADLOG_CLICK);
                }
            }

            @Override
            public void onAdShow(View view, int type) {
                if (!TextUtils.isEmpty(adid)) {
                    //AdManagerUtil.getInstance().addAdLog(adid, AdManagerUtil.ADLOG_SHOW);
                }
            }

            @Override
            public void onRenderFail(View view, String msg, int code) {
            }

            @Override
            public void onRenderSuccess(View view, float width, float height) {
                //返回view的宽高 单位 dp
                if (itemView != null) {
                    itemView.setVisibility(View.VISIBLE);
                    itemView.addView(view);
                }
            }
        });
        //dislike设置
        if (bindDisLike && context != null) {
            bindDislike(context, itemView, ad, bindDislikeAction);
        }
        if (ad.getInteractionType() != TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
            return;
        }
        ad.setDownloadListener(new TTAppDownloadListener() {
            @Override
            public void onIdle() {
            }

            @Override
            public void onDownloadActive(long totalBytes, long currBytes, String fileName, String appName) {

            }

            @Override
            public void onDownloadPaused(long totalBytes, long currBytes, String fileName, String appName) {
            }

            @Override
            public void onDownloadFailed(long totalBytes, long currBytes, String fileName, String appName) {
            }

            @Override
            public void onInstalled(String fileName, String appName) {
            }

            @Override
            public void onDownloadFinished(long totalBytes, String fileName, String appName) {
            }
        });
    }

    /**
     * 设置广告的不喜欢，点击关闭
     *
     * @param ad
     */
    public static void bindDislike(Context context, FrameLayout itemView, TTNativeExpressAd ad) {
        bindDislike(context, itemView, ad, true);
    }

    public static void bindDislike(Context context, FrameLayout itemView, TTNativeExpressAd ad, boolean bindDislikeAction) {
        //使用默认模板中默认dislike弹出样式
        ad.setDislikeCallback((Activity) context, new TTAdDislike.DislikeInteractionCallback() {
            @Override
            public void onShow() {

            }

            @Override
            public void onSelected(int position, String value, boolean b) {
                //用户选择不喜欢原因后，移除广告展示
            }

            @Override
            public void onCancel() {
            }

        });
    }
}
