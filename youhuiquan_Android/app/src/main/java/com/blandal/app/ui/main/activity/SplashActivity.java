

package com.blandal.app.ui.main.activity;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAppDownloadListener;
import com.bytedance.sdk.openadsdk.TTSplashAd;
import com.blandal.app.util.ToastShow;
import com.yanzhenjie.permission.Action;
import com.yanzhenjie.permission.AndPermission;
import com.yanzhenjie.permission.Rationale;
import com.yanzhenjie.permission.RequestExecutor;
import com.yanzhenjie.permission.runtime.Permission;

import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.constant.GlobalConstants;
import com.blandal.app.dialog.AgreementDialog;
import com.blandal.app.dialog.CommonDialog;
import com.blandal.app.dialog.Confirm;
import com.blandal.app.interfaces.AppInterfaces;
import com.blandal.app.interfaces.Callback;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.util.ExitApplication;
import com.blandal.app.util.LogUtils;
import com.blandal.app.util.TTAdManagerHolder;
import com.blandal.app.util.UIUtils;
import com.blandal.app.widget.CountDownTextView;
import com.blandal.app.widget.MyImageView;
import com.blandal.app.entity.GlobalEntity;
import com.blandal.app.util.AppUtils;
import com.blandal.app.util.StatusBarUtil;
import com.blandal.app.util.UserShared;

/**
 * 启动页
 *
 * @author: ljx
 * @createDate: 2020/11/18 10:45
 */
public class SplashActivity extends BaseMvpActivity {
    @BindView(R.id.iv_ad)
    MyImageView ivAd;
    @BindView(R.id.iv_shoufa)
    ImageView ivShouFa;
    @BindView(R.id.tv_skip)
    TextView tvSkip;
    @BindView(R.id.ll_app_info)
    LinearLayout llAppInfo;
    @BindView(R.id.fl_ad)
    FrameLayout mSplashContainer;
    @BindView(R.id.tv_ad_count_down)
    CountDownTextView tvAdCountDown;


    /**
     * 需要进行检测的权限数组
     */
    protected String[] needPermissions = {
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,};

    //开屏广告加载超时时间,建议大于3000,这里为了冷启动第一次加载到广告并且展示,示例设置了3000ms
    private static final int AD_TIME_OUT = 3000;

    /**
     * 广告是否点击了
     */
    private boolean mIsClickAd = false;

    private String type;


    /**
     * 一打开就要去取，主要是用来判断是否是新激活的设备
     */
    private String userIndexCityId;

    /**
     * 是否处于打开设置后
     */
    private boolean mIsSetting = false;
    private boolean mIsFirstOpen = false;

    @Override
    protected int provideContentViewId() {
//        getWindow().setBackgroundDrawable(null);
        return R.layout.activity_splash;
    }

    @Override
    protected void setStatusBar() {
        StatusBarUtil.setTransparentForImageView(this, null);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mIsClickAd) {
            mIsClickAd = false;
            handler.mPost(runnableAdToMainActivity);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        handler.removeCallbacks(runnableToMainActivity);
    }

    @Override
    public void initView() {
        //不管是否授权，都要去闪验预取号处理
//        SYUtils.getPreNumber();
        showShouFa();
        mIsFirstOpen = TextUtils.isEmpty(UserShared.getFirstOpenApp(this));
        UserGlobal.sIsFirstOpenApp = TextUtils.isEmpty(UserShared.getFirstOpenApp(this));
        //mPresenter = new MainLoadingPresenter(this);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            WindowManager.LayoutParams params = getWindow().getAttributes();
            params.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY;
            getWindow().setAttributes(params);
        }
        getGlobalClientData();
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {

    }

    @Override
    public void setEnableInitGesture(boolean enable) {
        super.setEnableInitGesture(false);
    }

    private void showShouFa() {
        setOutClearMemoryView(ivShouFa);
        if (ivShouFa != null) {
            ivShouFa.setVisibility(View.GONE);
            // 显示首发
            if (GlobalConstants.IsStarters) {

                // 显示首发
                llAppInfo.setVisibility(View.GONE);
                ivShouFa.setVisibility(View.VISIBLE);
            }
        }
    }

    public void dialogFlow(boolean isNotLogin) {
        LogUtils.data("dialogFlow");
        if (UserGlobal.sIsFirstOpenApp) {
            //未登录
            final AgreementDialog agreementDialog = AgreementDialog.newInstance(AgreementDialog.TYPE_FIRST);
            agreementDialog.setOnDialogClickListener(new Callback() {
                @Override
                public void onStartBtnClick() {
                    CommonDialog dialog = CommonDialog.newInstance("提示","继续当前操作会退出App，是否继续？", "取消", "退出App");
                    dialog.setOnDialogClickListener(new CommonDialog.OnDialogClickListener() {
                        @Override
                        public void onStartBtnDefaultCancelClick() {
                            dialog.dismiss();
                        }

                        @Override
                        public void onEndBtnDefaultConfirmClick() {
                            dialog.dismiss();
                            //退出
                            ExitApplication.getInstance().exit();
                        }
                    });
                    dialog.show(getSupportFragmentManager(), "saveTipDialog");
                }

                @Override
                public void onEndBtnClick() {
                    UserShared.setFirstOpenApp(SplashActivity.this, "1");
                    agreementDialog.dismiss();
                    requestPermission();
                }
            });
            agreementDialog.show(getSupportFragmentManager(), agreementDialog.getClass().getName());
        } else {
            requestPermission();
        }
    }

    private void requestPermission() {
        if (!UserGlobal.sIsFirstOpenApp || UserShared.mIsOpenPermission) {
            init();
            return;
        }
        if (!isFinishing()) {
            UserShared.mIsOpenPermission = true;
            AndPermission.with(this)
                    .runtime()
                    .permission(Permission.READ_PHONE_STATE, Permission.WRITE_EXTERNAL_STORAGE,Permission.ACCESS_COARSE_LOCATION,Permission.ACCESS_FINE_LOCATION)
                    .onGranted(new Action<List<String>>() {
                        @Override
                        public void onAction(List<String> data) {
                            init();
                        }
                    })
                    .onDenied(new Action<List<String>>() {
                        @Override
                        public void onAction(List<String> data) {
                            init();
                        }
                    })
                    .start();
        } else {
            init();
        }
    }

    /**
     * 初始化
     */
    private void init() {
        // type 自己定义的广告类型1：第三方 2：自平台 3：没廣告(或者是空)
        type = UserShared.getAdvertisement(this);
        LogUtils.data("init");
        if (ivAd != null) {
            ivAd.setVisibility(View.VISIBLE);
        }
        toMainOrAdActivity(false);
    }

    /**
     * 跳转到主页或者广告页面
     */
    private Runnable runnableToMainActivity = new Runnable() {
        @Override
        public void run() {
            handler.removeCallbacks(runnableToMainActivity);
            Uri uri = getIntent().getData();
            if (uri == null) {
                toMainOrAdActivity(false);
                return;
            } else {
                LogUtils.data("uri not null");
                //web开启
                toMainOrAdActivity(false);
                return;
            }
        }
    };

    /**
     * 提交推送平台信息（极光推送）
     */
    private void postThirdPushPlatInfo() {
        //mPresenter.postPushInfo(this);
    }

    private void toMainOrAdActivity(boolean isToMain) {
        if (isToMain) {
            toMainActivity();
        } else {
            if (mIsFirstOpen) {
                toMainActivity();
                return;
            }
            if (UserGlobal.isShowAd){
                if (!limitIsShowAd()) {
                    toMainActivity();
                }
                return;
            }
            toMainActivity();
//            if (!UserGlobal.sIsFirstOpenApp) {
//                //加载广告
//                if (!limitIsShowAd()) {
//                    toMainActivity();
//                }
//            } else {
//                toMainActivity();
//            }
        }
    }

    private void toMainActivity() {
        LogUtils.data("toMainActivity");
        Intent toUserLogin = new Intent(this,
                MainAppActivity.class);
        startActivity(toUserLogin);
        finish();
        overridePendingTransition(0, 0);
    }

    private void getGlobalClientData() {
        RetrofitService.getData(this, ServiceListFinal.getGlobalConfig, null, new OnNetRequestListener<ApiResponse<GlobalEntity>>() {
            @Override
            public void onSuccess(ApiResponse<GlobalEntity> response) {
                if (response.isSuccess()) {
                    UserGlobal.isShowAd = response.getData().isadv;
                    UserGlobal.customerImg = response.getData().service;
                }
                todDialogFlow();
            }

            @Override
            public void onFailure(Throwable t) {
                todDialogFlow();
            }
        }, bindAutoDispose());
    }

    @OnClick({R.id.tv_skip, R.id.iv_ad})
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.iv_ad:

                break;
            case R.id.tv_skip:
                toMainActivity();
                break;
            default:
                break;
        }
    }

    /**
     * 判断是否显示启动页广告
     */
    public boolean limitIsShowAd() {
        loadAdPangolin();
        return true;
//        if (UserGlobal.mGlobalConfigInfo != null) {
//            List<AdEntity> entities = UserGlobal.mGlobalConfigInfo.getStart_front_ad_list();
//            if (entities != null && entities.size() > 0) {
//                GlideUtil.loadImageAd(this, entities.get(0).img_url, ivAd);
//                tvSkip.setVisibility(View.VISIBLE);
//                tvAdCountDown.setNormalText("广告")
//                        .setCountDownText("", "s")
//                        .setCountDownClickable(false)
//                        .setOnCountDownFinishListener(new CountDownTextView.OnCountDownFinishListener() {
//                            @Override
//                            public void onFinish() {
//                                tvAdCountDown.setVisibility(View.GONE);
//                            }
//                        });
//                tvAdCountDown.setVisibility(View.VISIBLE);
//                tvAdCountDown.startCountDown(3);
//                handler.mPostDelayed(runnableAdToMainActivity, 3000);
//                return true;

//            }
//        }
//        return false;
    }

    /**
     * 广告跳转到主页
     */
    private Runnable runnableAdToMainActivity = new Runnable() {
        @Override
        public void run() {
            handler.removeCallbacks(runnableAdToMainActivity);
            toMainActivity();
        }
    };

    public void todDialogFlow() {
        handler.post(new Runnable() {
            @Override
            public void run() {
                dialogFlow(true);
            }
        });
    }

    private static final String TAG = "SplashActivity";

    /**
     * Android M运行时权限请求封装
     *
     * @param permissionDes 权限描述
     * @param runnable      请求权限回调
     * @param permissions   请求的权限（数组类型），直接从Manifest中读取相应的值，比如Manifest.permission.WRITE_CONTACTS
     */
    @SuppressLint("WrongConstant")
    public void performCodeWithPermission(@NonNull final String permissionDes, final AppInterfaces.PermissionCallback runnable, @NonNull String... permissions) {

        AndPermission.with(mContext)
                .runtime()
                .permission(permissions)
                .onGranted(new Action<List<String>>() {
                    @Override
                    public void onAction(List<String> data) {
                        if (runnable != null) {
                            runnable.hasPermission();
                        }
                    }
                })
                .onDenied(new Action<List<String>>() {
                    @Override
                    public void onAction(List<String> data) {
                        //hasAlwaysDeniedPermission()只能在onDenied()的回调中调用
//						if (AndPermission.hasAlwaysDeniedPermission(mContext, data)) {
//							// 这些权限被用户总是拒绝。
//						}
                        if (runnable != null) {
                            runnable.noPermission();
                        }
                    }
                })
                .rationale(new Rationale<List<String>>() {
                    @Override
                    public void showRationale(Context context, List<String> data, final RequestExecutor executor) {
                        openPermissionDialog(executor, permissionDes);
                    }
                })
                .start();
    }

    private void openPermissionDialog(final RequestExecutor executor, final String permissionDes) {

    }

    private void openPermissionDialog() {
        final Confirm permissionDialog = new Confirm(mContext, "确定", "取消", "为了不影响您的正常使用，请您去设置中开启 允许程序使用定位 权限", "提示");
        permissionDialog.setBtnCancelClick(new Confirm.MyBtnCancelClick() {
            @Override
            public void btnCancelClickMet() {

            }
        });
        permissionDialog.setBtnOkClick(new Confirm.MyBtnOkClick() {
            @Override
            public void btnOkClickMet() {
                mIsSetting = true;
                AppUtils.gotoAppDetailIntent(SplashActivity.this);
            }
        });
    }


    /**
     * 选择城市:如果没有默认城市则需要选择一个
     */
    private void selectCity() {

    }

    private TTAdNative mTTAdNative;
    private boolean mIsExpress = false; //是否请求模板广告
    private void loadAdPangolin() {
        if (mTTAdNative == null) {
            mTTAdNative = TTAdManagerHolder.get().createAdNative(this);
        }
        //step3:创建开屏广告请求参数AdSlot,具体参数含义参考文档
        AdSlot adSlot = null;
        if (mIsExpress) {
            //个性化模板广告需要传入期望广告view的宽、高，单位dp，请传入实际需要的大小，
            //比如：广告下方拼接logo、适配刘海屏等，需要考虑实际广告大小
            float expressViewWidth = UIUtils.getScreenWidthDp(this);
            float expressViewHeight = UIUtils.getHeight(this);
            adSlot = new AdSlot.Builder()
                    .setCodeId("887521768")
                    .setSupportDeepLink(true)
                    .setImageAcceptedSize(1080, 1920)
                    //模板广告需要设置期望个性化模板广告的大小,单位dp,代码位是否属于个性化模板广告，请在穿山甲平台查看
                    .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
                    .build();
        } else {
            adSlot = new AdSlot.Builder()
                    .setCodeId("887521768")
                    .setSupportDeepLink(true)
                    .setImageAcceptedSize(1080, 1920)
                    .build();
        }

        //AdManagerUtil.addAdLogPangolin(entity, AdManagerUtil.AD_OPT_REQUEST, mContext);
        mTTAdNative.loadSplashAd(adSlot, new TTAdNative.SplashAdListener() {
            @Override
            public void onError(int i, String s) {
                Log.e("CSJ",s);
                ToastShow.showMsg("onError"+"i=="+i+"s=="+s);
                toMainActivity();
            }

            @Override
            public void onTimeout() {
                Log.e("CSJ","超时");
                ToastShow.showMsg("超时");
              toMainActivity();
            }

            @Override
            public void onSplashAdLoad(TTSplashAd ttSplashAd) {
                Log.e("CSJ","成分");
                if (ttSplashAd == null) {
                    return;
                }
                //获取SplashView
                View view = ttSplashAd.getSplashView();
                if (view != null && mSplashContainer != null && !isFinishing()) {
                    mSplashContainer.removeAllViews();
                    //把SplashView 添加到ViewGroup中,注意开屏广告view：width >=70%屏幕宽；height >=50%屏幕高
                    mSplashContainer.addView(view);
                    //设置不开启开屏广告倒计时功能以及不显示跳过按钮,如果这么设置，您需要自定义倒计时逻辑
                    //ad.setNotAllowSdkCountdown();
                } else {
                    toMainActivity();
                }

                ttSplashAd.setSplashInteractionListener(new TTSplashAd.AdInteractionListener() {
                    @Override
                    public void onAdClicked(View view, int i) {
                        //AdManagerUtil.addAdLogPangolin(entity, AdManagerUtil.AD_OPT_CLICK, mContext);
                    }

                    @Override
                    public void onAdShow(View view, int i) {
                        //AdManagerUtil.addAdLogPangolin(entity,AdManagerUtil.AD_OPT_SHOW, mContext);
                     }

                    @Override
                    public void onAdSkip() {
                        toMainActivity();
                    }

                    @Override
                    public void onAdTimeOver() {
                        toMainActivity();
                    }
                });

                if (ttSplashAd.getInteractionType() == TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
                    ttSplashAd.setDownloadListener(new TTAppDownloadListener() {
                        boolean hasShow = false;

                        @Override
                        public void onIdle() {
                        }

                        @Override
                        public void onDownloadActive(long totalBytes, long currBytes, String fileName, String appName) {
                            if (!hasShow) {
                                //showMsg("下载中...");
                                hasShow = true;
                            }
                        }

                        @Override
                        public void onDownloadPaused(long totalBytes, long currBytes, String fileName, String appName) {
                            //showMsg("下载暂停...");

                        }

                        @Override
                        public void onDownloadFailed(long totalBytes, long currBytes, String fileName, String appName) {
                            //showMsg("下载失败...");

                        }

                        @Override
                        public void onDownloadFinished(long totalBytes, String fileName, String appName) {
                            //showMsg("下载完成...");

                        }

                        @Override
                        public void onInstalled(String fileName, String appName) {
                            //showMsg("安装完成...");
                        }
                    });
                }
            }
        }, AD_TIME_OUT);
    }
}
