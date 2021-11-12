package com.blandal.app.util;

import android.app.Activity;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import com.alibaba.fastjson.JSON;
import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAppDownloadListener;
import com.bytedance.sdk.openadsdk.TTFullScreenVideoAd;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.bytedance.sdk.openadsdk.TTRewardVideoAd;
import com.blandal.app.common.UserGlobal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 */
public class CSJPlayVideoUtilsV2 {

    static CSJPlayVideoUtilsV2 instance = new CSJPlayVideoUtilsV2();

    public static CSJPlayVideoUtilsV2 getInstance() {
        return instance;
    }

    private CJSADListener adListener;

    public interface CJSADListener {
        public void onADLoad();

        public void onADShow();

        public void onReward();

        public void onSkipped();


        public void onADClick();


        public void onVideoComplete();


        public void onADClose();


        public void onError(int var1);
    }

    public void setAdListener(CJSADListener adListener) {
        this.adListener = adListener;
    }


    //一、加载穿山甲激励视频
    //BDAdvanceBaseAppNative 绑定激励视频回调
    public void load(final Activity activity, final CJSADListener appNative, String adspotid, Map<String, Object> map) {
          if (map == null) {
            map = new HashMap<>();
        }

        try {
            String mediaExtra = JSON.toJSONString(map);
            TTAdNative adNative = TTAdManagerHolder.get().createAdNative(activity);

            //模版渲染请求AdSlot
            AdSlot adSlot = new AdSlot.Builder()
                    .setCodeId(adspotid)
                    .setSupportDeepLink(true)
                    .setAdCount(1)
                    .setRewardName("coin")
                    .setRewardAmount(1)
                    .setExpressViewAcceptedSize(500, 500)//个性化模板广告需要设置期望个性化模板广告的大小,单位dp,激励视频场景，只要设置的值大于0即可。仅模板广告需要设置此参数
                    .setImageAcceptedSize(1080, 1920)
                    .setOrientation(TTAdConstant.VERTICAL)
                    .setMediaExtra(mediaExtra)
                    .setUserID("user123")
                    .build();

            //加载激励视频广告
            adNative.loadRewardVideoAd(adSlot, new TTAdNative.RewardVideoAdListener() {
                @Override
                public void onError(int i, String s) {
                    if (appNative != null) {
                        appNative.onError(i);
                    }
                }

                @Override
                public void onRewardVideoAdLoad(TTRewardVideoAd ttRewardVideoAd) {
                    if (ttRewardVideoAd == null) {
                        if (appNative != null) {
                            appNative.onError(0);
                        }
                    } else {
                        bindRewardListener(ttRewardVideoAd, appNative);
                        if (appNative != null) {
                            appNative.onADLoad();
                        }
                    }
                }

                @Override
                public void onRewardVideoCached() {
                }

                @Override
                public void onRewardVideoCached(TTRewardVideoAd ttRewardVideoAd) {
                }
            });
        } catch (Throwable e) {
            ToastShow.showMsg(e.getMessage());
            if (appNative != null) {
                appNative.onError(0);
            }
        }
    }


    //二、绑定穿山甲激励视频回调
    //BDAdvanceBaseAppNative 绑定激励视频回调
    TTRewardVideoAd mttRewardVideoAd;

    private void bindRewardListener(TTRewardVideoAd ttRewardVideoAd, final CJSADListener appNative) {
        mttRewardVideoAd = ttRewardVideoAd;
        mttRewardVideoAd.setRewardAdInteractionListener(new TTRewardVideoAd.RewardAdInteractionListener() {
            @Override
            public void onAdShow() {
                LogUtils.e("TTRewardVideoAd", "-----------------广告显示");
                if (appNative != null) {
                    appNative.onADShow();
                }
            }

            @Override
            public void onAdVideoBarClick() {
                LogUtils.e("TTRewardVideoAd", "-----------------广告被点击");
                if (appNative != null) {
                    appNative.onADClick();
                }
            }

            @Override
            public void onAdClose() {
                LogUtils.e("TTRewardVideoAd", "-----------------广告关闭");
                if (appNative != null) {
                    appNative.onADClose();
                }
            }

            @Override
            public void onVideoComplete() {
                LogUtils.e("TTRewardVideoAd", "-----------------广告播放结束");
                if (appNative != null) {
                    appNative.onVideoComplete();
                }
            }

            @Override
            public void onVideoError() {
                ToastShow.showMsg("广告播放报错");
                LogUtils.e("TTRewardVideoAd", "-----------------广告播放报错");
                if (appNative != null) {
                    appNative.onError(0);
                }
            }

            @Override
            public void onRewardVerify(boolean b, int i, String s, int i1, String s1) {
                LogUtils.e("TTRewardVideoAd", "-----------------广告奖励发放");
                if (appNative != null) {
                    appNative.onReward();
                }
            }

            @Override
            public void onSkippedVideo() {
                LogUtils.e("TTRewardVideoAd", "-----------------广告跳过");
                if (appNative != null) {
                    appNative.onSkipped();
                }
            }
        });
    }

    //三、播放穿山甲激励视频
    public void play(Activity activity) {
        if (mttRewardVideoAd != null) {
            mttRewardVideoAd.showRewardVideoAd(activity);
        }
    }

    public  TTNativeExpressAd mTTAd;
    //banner
    public  void loadBannerAd(String codeId, Activity mContext, FrameLayout mExpressContainer) {
        if (!UserGlobal.isShowAd){
            mExpressContainer.setVisibility(View.GONE);
            return;
        }
        TTAdNative mTTAdNative = TTAdManagerHolder.get().createAdNative(mContext);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(codeId) //广告位id
                .setSupportDeepLink(true)
                .setAdCount(1) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(600,300) //期望模板广告view的size,单位dp
                .build();

        mTTAdNative.loadBannerExpressAd(adSlot, new TTAdNative.NativeExpressAdListener() {
            //请求失败回调
            @Override
            public void onError(int code, String message) {
                ToastShow.showMsg(code+"错误信息："+message);
                mExpressContainer.removeAllViews();
                mExpressContainer.setVisibility(View.GONE);
                Log.e("csj",message);
            }

            //请求成功回调
            @Override
            public void onNativeExpressAdLoad(List<TTNativeExpressAd> ads) {
                if (ads == null || ads.size() == 0) {
                    mExpressContainer.setVisibility(View.GONE);
                    return;
                }
                Log.e("csj","onNativeExpressAdLoad成功");
                mTTAd = ads.get(0);
                mTTAd.render();
                mTTAd.setSlideIntervalTime(30 * 1000);
                bindAdListener(mTTAd,mContext,mExpressContainer);
            }
        });


    }

    public  void bindAdListener(TTNativeExpressAd ad,Activity mContext, FrameLayout mExpressContainer) {
        ad.setExpressInteractionListener(new TTNativeExpressAd.ExpressAdInteractionListener() {
            @Override
            public void onAdClicked(View view, int type) {
            }

            @Override
            public void onAdShow(View view, int type) {
                Log.e("csj","type=="+type);
            }

            @Override
            public void onRenderFail(View view, String msg, int code) {
                mExpressContainer.setVisibility(View.GONE);
                Log.e("csj","msg=="+msg);
            }

            @Override
            public void onRenderSuccess(View view, float width, float height) {
                Log.e("csj","onRenderSuccess");
                mExpressContainer.removeAllViews();
                mExpressContainer.setVisibility(View.VISIBLE);
                mExpressContainer.addView(view);
            }
        });
        //dislike设置
        bindDislike(ad, mContext,mExpressContainer);
        if (ad.getInteractionType() != TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
            return;
        }
        ad.setDownloadListener(new TTAppDownloadListener() {
            @Override
            public void onIdle() {
            }

            @Override
            public void onDownloadActive(long totalBytes, long currBytes, String fileName, String appName) {
//                if (!mHasShowDownloadActive) {
//                    mHasShowDownloadActive = true;
//                    TToast.show(BannerExpressActivity.this, "下载中，点击暂停", Toast.LENGTH_LONG);
//                }
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

    public  void bindDislike(TTNativeExpressAd ad,Activity mContext, FrameLayout mExpressContainer) {
        //使用默认模板中默认dislike弹出样式
        ad.setDislikeCallback(mContext, new TTAdDislike.DislikeInteractionCallback() {
            @Override
            public void onShow() {

            }

            @Override
            public void onSelected(int position, String value, boolean enforce) {
                mExpressContainer.removeAllViews();
                mExpressContainer.setVisibility(View.GONE);
                //用户选择不喜欢原因后，移除广告展示
            }

            @Override
            public void onCancel() {
            }

        });
    }


    //插屏广告
    public  TTNativeExpressAd mTTAdInterac;

    public void loadInteractionExpressAd(String codeId, Activity mContext){
        if (!UserGlobal.isShowAd){
            return;
        }
        TTAdNative mTTAdNative = TTAdManagerHolder.get().createAdNative(mContext);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(codeId) //广告位id
                .setSupportDeepLink(true)
                .setAdCount(1) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(300,300) //期望模板广告view的size,单位dp
                .build();
        mTTAdNative.loadInteractionExpressAd(adSlot, new TTAdNative.NativeExpressAdListener() {
            //请求广告失败
            @Override
            public void onError(int code, String message) {
                ToastShow.showMsg(code+"插屏错误信息："+message);

                Log.e("csj","插屏:"+message);
            }
            //请求广告成功
            @Override
            public void onNativeExpressAdLoad(List<TTNativeExpressAd> ads) {
                mTTAdInterac = ads.get(0);
                mTTAdInterac.render();
                mTTAdInterac.setExpressInteractionListener(new TTNativeExpressAd.AdInteractionListener() {
                    @Override
                    public void onAdDismiss() {
                    }

                    @Override
                    public void onAdClicked(View view, int type) {
                    }

                    @Override
                    public void onAdShow(View view, int type) {
                        Log.e("csj","插屏:广告展示");
                    }

                    @Override
                    public void onRenderFail(View view, String msg, int code) {
                        Log.e("csj","插屏:"+msg + " code:" + code);
                    }

                    @Override
                    public void onRenderSuccess(View view, float width, float height) {
                        //返回view的宽高 单位 dp
                        Log.e("csj","渲染成功:");
                        mTTAdInterac.showInteractionExpressAd(mContext);
                    }
                });
            }
        });
    }

    public TTFullScreenVideoAd mTTFullScreenVideoAd;
    public boolean mIsLoaded = false;
    public void loadAdDialog2(final Activity activity, String adspotid) {
        TTAdNative mTTAdNative = TTAdManagerHolder.get().createAdNative(activity);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(adspotid)
                //模板广告需要设置期望个性化模板广告的大小,单位dp,激励视频场景，只要设置的值大于0即可
                .setExpressViewAcceptedSize(280, 340)
                .setSupportDeepLink(true)
                .setOrientation(TTAdConstant.VERTICAL)//必填参数，期望视频的播放方向：TTAdConstant.HORIZONTAL 或 TTAdConstant.VERTICAL
                .build();

        mTTAdNative.loadFullScreenVideoAd(adSlot, new TTAdNative.FullScreenVideoAdListener() {
            //请求广告失败
            @Override
            public void onError(int code, String message) {
                Log.d("CSJJJJ", message);
            }

            //广告物料加载完成的回调
            @Override
            public void onFullScreenVideoAdLoad(TTFullScreenVideoAd ad) {
                if (ad != null) {
                    mIsLoaded = true;
                    mTTFullScreenVideoAd = ad;
                }
            }

            //广告视频/图片加载完成的回调，接入方可以在这个回调后展示广告
            @Override
            public void onFullScreenVideoCached() {
                mTTFullScreenVideoAd.showFullScreenVideoAd(activity);
            }

            @Override
            public void onFullScreenVideoCached(TTFullScreenVideoAd ttFullScreenVideoAd) {

            }
        });

    }


}
