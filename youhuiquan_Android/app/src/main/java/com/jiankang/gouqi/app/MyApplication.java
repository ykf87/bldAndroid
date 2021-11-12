package com.jiankang.gouqi.app;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.webkit.WebView;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.multidex.MultiDex;

import com.bun.miitmdid.core.JLibrary;
import com.qq.e.comm.managers.GDTAdSdk;
import com.scwang.smart.refresh.footer.ClassicsFooter;
import com.scwang.smart.refresh.header.ClassicsHeader;
import com.scwang.smart.refresh.layout.SmartRefreshLayout;
import com.scwang.smart.refresh.layout.api.RefreshFooter;
import com.scwang.smart.refresh.layout.api.RefreshHeader;
import com.scwang.smart.refresh.layout.api.RefreshLayout;
import com.scwang.smart.refresh.layout.constant.SpinnerStyle;
import com.scwang.smart.refresh.layout.listener.DefaultRefreshFooterCreator;
import com.scwang.smart.refresh.layout.listener.DefaultRefreshHeaderCreator;

import java.util.List;
import java.util.logging.Logger;

import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.util.ExitApplication;
import com.jiankang.gouqi.util.MiitHelper;

import com.jiankang.gouqi.util.TTAdManagerHolder;
import com.jiankang.gouqi.util.UserShared;
import cn.bingoogolapple.swipebacklayout.BGASwipeBackHelper;


public class MyApplication extends Application {
    private static MyApplication instance = null;
    private String mProcessName;
    private String mPackageName;
    private boolean mIsMainProcess;
    /**
     * 渠道
     */
    private static String mChannel;
    public Logger log;

    public static String getChannel() {
        return mChannel;
    }

    /**
     * Android P 以及之后版本不支持同时从多个进程使用具有相同数据目录的WebView
     * 为其它进程webView设置目录
     *
     * @param context 上下文
     */
    @RequiresApi(api = 28)
    public void webviewSetPath(Context context) {
        //判断不等于默认进程名称
        if (!mIsMainProcess) {
            WebView.setDataDirectorySuffix(mProcessName);
        }
    }

    private String getCurProcessName(Context context) {
        int pid = android.os.Process.myPid();
        ActivityManager mActivityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        List<ActivityManager.RunningAppProcessInfo> infos = mActivityManager.getRunningAppProcesses();
        if (infos == null) {
            return null;
        }
        for (ActivityManager.RunningAppProcessInfo appProcess : infos) {
            if (appProcess.pid == pid) {
                return appProcess.processName;
            }
        }
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        //oaid
        new MiitHelper(new MiitHelper.AppIdsUpdater() {
            @Override
            public void OnIdsAvalid(@NonNull String ids) {
                UserShared.setOAID(getApplicationContext(),
                        ids.substring(ids.indexOf("OAID: ") + 6, ids.indexOf("\nVAID: ")));
            }
        }).getDeviceIds(this);

        BGASwipeBackHelper.init(this, null);
        mChannel = UserShared.getUmengChannelId(this);
        TTAdManagerHolder.init(this);
        GDTAdSdk.init(this, "1200106023");
        registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                ExitApplication.getInstance().addActivity(activity);
            }

            @Override
            public void onActivityStarted(Activity activity) {

            }

            @Override
            public void onActivityResumed(Activity activity) {
                // 初始化全局变量，必须加
                UserGlobal.initGlobal();
            }

            @Override
            public void onActivityPaused(Activity activity) {

            }

            @Override
            public void onActivityStopped(Activity activity) {

            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

            }

            @Override
            public void onActivityDestroyed(Activity activity) {
                ExitApplication.getInstance().removeActivity(activity);
            }
        });
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        mProcessName = getCurProcessName(base);
        mPackageName = getPackageName();
        mIsMainProcess = !TextUtils.isEmpty(mPackageName) && TextUtils.equals(mPackageName, mProcessName);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            webviewSetPath(base);
        }
        MultiDex.install(this);
        try {
            JLibrary.InitEntry(base);
        } catch (Exception e) {
        }
    }


    /**
     * 获得实例
     *
     * @return
     */
    public static com.jiankang.gouqi.app.MyApplication getInstance() {
        return instance;
    }

    /**
     * 获取context对象
     */
    public static Context getContext() {
        return instance.getApplicationContext();
    }

    static {
        //设置全局的Header构建器
        SmartRefreshLayout.setDefaultRefreshHeaderCreator(new DefaultRefreshHeaderCreator() {
            @Override
            public RefreshHeader createRefreshHeader(Context context, RefreshLayout layout) {
                //    layout.setPrimaryColorsId(R.color.gray_p, android.R.color.white);//全局设置主题颜色
                return new ClassicsHeader(context).setSpinnerStyle(SpinnerStyle.Translate);//.setTimeFormat(new DynamicTimeFormat("更新于 %s"));//指定为经典Header，默认是 贝塞尔雷达Header
            }
        });

        //设置全局的Footer构建器
        SmartRefreshLayout.setDefaultRefreshFooterCreator(new DefaultRefreshFooterCreator() {
            @Override
            public RefreshFooter createRefreshFooter(Context context, RefreshLayout layout) {
                //指定为经典Footer，默认是 BallPulseFooter
                //return new ClassicsFooter(context).setDrawableSize(20);
                return new ClassicsFooter(context).setSpinnerStyle(SpinnerStyle.Translate);
            }
        });

    }

    /**
     * 是否有网络
     */
    private boolean isConnected = true;

    public boolean isConnected() {
        return isConnected;
    }

    public void setConnected(boolean b) {
        isConnected = b;
    }
}
