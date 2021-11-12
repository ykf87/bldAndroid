package com.jiankang.gouqi.base;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.res.TypedArray;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.lifecycle.Lifecycle;


import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.common.MyHandler;
import com.jiankang.gouqi.dialog.ProgressDialogShow;
import com.jiankang.gouqi.interfaces.AppInterfaces;
import com.jiankang.gouqi.util.AppUtils;
import com.jiankang.gouqi.util.DisplayUtil;
import com.jiankang.gouqi.util.EventBusManager;
import com.jiankang.gouqi.util.RecycleBitmap;
import com.jiankang.gouqi.util.StatusBarUtil;
import com.jiankang.gouqi.util.ToastShow;
import cn.bingoogolapple.swipebacklayout.BGASwipeBackHelper;


public abstract  class BaseActivity extends AppCompatActivity implements BGASwipeBackHelper.Delegate{


    /**
     * 父类封装，用于线程中处理UI等操作
     */
    protected MyHandler handler = new MyHandler();
    /**
     * 基类的Context
     */
    protected Context mContext;

    /**
     * 是否打开动画
     */
    private boolean isOpenAnimation = true;

    //侧滑关闭页面
    protected BGASwipeBackHelper mSwipeBackHelper;


    public MyHandler getMyHandler() {
        return handler;
    }

    /**
     * 退出时候要清除缓存的控件集合
     */
    protected List<View> outClearMemoryView;
    /**
     * true 表示用户 雇主都没登录
     */
    protected boolean isNotLogin;

    /**
     * 设置退出时，要回收图片的控件
     */
    public void setOutClearMemoryView(View pView) {
        if (outClearMemoryView == null) {
            outClearMemoryView = new ArrayList<>();
        }
        outClearMemoryView.add(pView);
    }

    public static void launch(Context context, Class<?> clz) {
        context.startActivity(new Intent(context, clz));
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        if (Build.VERSION.SDK_INT == Build.VERSION_CODES.O && isTranslucentOrFloating()) {
            boolean result = fixOrientation();
        }
        setEnableInitGesture(true);
        super.onCreate(savedInstanceState);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);


        mContext = this;

        if (isOpenAnimation) {
            //overridePendingTransition(R.anim.activity_ani_enter, 0);
        } else {
            overridePendingTransition(0, 0);
        }

        getWindow().setBackgroundDrawable(new ColorDrawable(0));

        getWindow().getDecorView().setBackgroundResource(0);

        //如果要使用 EventBus 请将此方法返回 true
        if (useEventBus()) {
            EventBusManager.getInstance().register(this);
        }
    }

    public void setEnableInitGesture(boolean enable){
        if (enable){
            initSwipeBackFinish();
        }
    }


    /**
     * 设置是否允许侧滑推出(true允许 false不允许)
     */
    public void setEnableGesture(boolean enable) {
        if (mSwipeBackHelper == null){
            return;
        }
        mSwipeBackHelper.setSwipeBackEnable(enable);
    }


    /**
     * 显示系统提示
     */
    public void showMsg(final String txtContent) {
        ToastShow.showMsg(mContext, txtContent, handler);
    }

    /**
     * 关闭加载层
     */
    public void closeLoadDialog() {
        ProgressDialogShow.dismissDialog(handler);
    }

    /**
     * 加载主线程运行
     */
    public void post(Runnable runnable) {
        handler.mPost(runnable);
    }

    /**
     * 关闭动画（super.onCreate 前调用）
     */
    public void closeAnimation() {
        isOpenAnimation = false;
    }

    @Override
    public void setRequestedOrientation(int requestedOrientation) {
        if (Build.VERSION.SDK_INT == Build.VERSION_CODES.O && isTranslucentOrFloating()) {
            return;
        }
        super.setRequestedOrientation(requestedOrientation);
    }

    private boolean isTranslucentOrFloating() {
        boolean isTranslucentOrFloating = false;
        try {
            int[] styleableRes = (int[]) Class.forName("com.android.internal.R$styleable").getField("Window").get(null);
            final TypedArray ta = obtainStyledAttributes(styleableRes);
            Method m = ActivityInfo.class.getMethod("isTranslucentOrFloating", TypedArray.class);
            m.setAccessible(true);
            isTranslucentOrFloating = (boolean) m.invoke(null, ta);
            m.setAccessible(false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isTranslucentOrFloating;
    }

    private boolean fixOrientation() {
        try {
            Field field = Activity.class.getDeclaredField("mActivityInfo");
            field.setAccessible(true);
            ActivityInfo o = (ActivityInfo) field.get(this);
            o.screenOrientation = -1;
            field.setAccessible(false);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void setContentView(int viewId) {
        super.setContentView(viewId);
        setStatusBar();
    }

    protected void setStatusBar() {
        StatusBarUtil.setLightMode(this);
        StatusBarUtil.setColor(this, ContextCompat.getColor(this, R.color.white), 0);
    }



    @Override
    protected void onResume() {
        super.onResume();
        //TCAgentManner.getInstance().onPageStart(this, this.getClass().getName());
    }

    @Override
    protected void onPause() {
        super.onPause();
       // TCAgentManner.getInstance().onPageEnd(this, this.getClass().getName());
    }


    @Override
    protected void onDestroy() {
        handler.setDestroy();
        RecycleBitmap.recycleImageViews(outClearMemoryView);
        super.onDestroy();

        System.gc();
        if (useEventBus()) {
            EventBusManager.getInstance().unregister(this);
        }
    }

    /**
     * 手动回调 关联这个页面的其它 回调接口
     */
    protected void callActivityInterface() {
        post(new Runnable() {
            @Override
            public void run() {
                AppUtils.callActivityInterface(mContext, true, null);
            }
        });
    }

    /**
     * 手动回调 关联这个页面的其它 回调接口
     */
    protected void callActivityInterface(final Object obj) {
        post(new Runnable() {
            @Override
            public void run() {
                AppUtils.callActivityInterface(mContext, true, obj);
            }
        });
    }

    /**
     * 设置页面回调触发的回调接口
     */
    protected void setActivityInterface(Class<?> callActivity,
                                        AppInterfaces.ActivityCallBackInterface pActivityCallBackInterface,
                                        boolean pIsManuallyCall) {
        AppUtils.setActivityInterface(mContext, callActivity,
                pActivityCallBackInterface, pIsManuallyCall);
    }

    /**
     * 返回键调成此方法
     */
    @Override
    public void onBackPressed() {
        super.onBackPressed();
        if (isOpenAnimation) {
            //overridePendingTransition(0, R.anim.activity_ani_exist);
        }
    }

    @Override
    public void finish() {
        super.finish();
        if (isOpenAnimation) {
            //overridePendingTransition(0, R.anim.activity_ani_exist);
        }
    }

    public void setSwipeBackEnable(boolean enable) {
        if (mSwipeBackHelper == null){
            return;
        }
        mSwipeBackHelper.setSwipeBackEnable(enable);
    }


    /**
     * 显示加载中弹层
     */
    public void showLoadDialog(final String txtContent) {
        if (DisplayUtil.isMainThread()) {
            ProgressDialogShow.showLoadDialog(mContext, false, txtContent);
        } else {
            handler.mPost(new Runnable() {
                @Override
                public void run() {
                    ProgressDialogShow.showLoadDialog(mContext, false, txtContent);
                }
            });
        }
    }

    /**
     * 显示加载中弹层
     */
    public void showLoadDialog() {
        this.showLoadDialog("加载中...");
    }

    /**
     * 是否使用 EventBus
     */
    public boolean useEventBus() {
        return true;
    }

    /**
     * 绑定生命周期 防止MVP内存泄漏
     *
     * @param <T> 泛型
     * @return 泛型
     */
    public <T> AutoDisposeConverter<T> bindAutoDispose() {
        return AutoDispose.autoDisposable(AndroidLifecycleScopeProvider
                .from(this, Lifecycle.Event.ON_DESTROY));
    }



    /**
     * 初始化滑动返回。在 super.onCreate(savedInstanceState) 之前调用该方法
     */
    private void initSwipeBackFinish() {
        mSwipeBackHelper = new BGASwipeBackHelper(this, this);

        // 「必须在 Application 的 onCreate 方法中执行 BGASwipeBackHelper.init 来初始化滑动返回」
        // 下面几项可以不配置，这里只是为了讲述接口用法。

        // 设置滑动返回是否可用。默认值为 true
       mSwipeBackHelper.setSwipeBackEnable(true);
        // 设置是否仅仅跟踪左侧边缘的滑动返回。默认值为 true
        mSwipeBackHelper.setIsOnlyTrackingLeftEdge(false);
        // 设置是否是微信滑动返回样式。默认值为 true
        mSwipeBackHelper.setIsWeChatStyle(false);
        // 设置阴影资源 id。默认值为 R.drawable.bga_sbl_shadow
        mSwipeBackHelper.setShadowResId(R.drawable.bga_sbl_shadow);
        // 设置是否显示滑动返回的阴影效果。默认值为 true
        mSwipeBackHelper.setIsNeedShowShadow(true);
        // 设置阴影区域的透明度是否根据滑动的距离渐变。默认值为 true
        mSwipeBackHelper.setIsShadowAlphaGradient(true);
        // 设置触发释放后自动滑动返回的阈值，默认值为 0.3f
        mSwipeBackHelper.setSwipeBackThreshold(0.3f);
        // 设置底部导航条是否悬浮在内容上，默认值为 false
        mSwipeBackHelper.setIsNavigationBarOverlap(false);
    }

    public void smallLarge(List<TextView> tvList) {
        for (TextView textView : tvList) {
            float textSize = textView.getTextSize();
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * 11 / 8);
        }
    }

    public void smallMid(List<TextView> tvList) {
        for (TextView textView : tvList) {
            float textSize = textView.getTextSize();
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * 5 / 4);
        }
    }

    public void midSmall(List<TextView> tvList) {
        for (TextView textView : tvList) {
            float textSize = textView.getTextSize();
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * 4 / 5);
        }
    }

    public void midLarge(List<TextView> tvList) {
        for (TextView textView : tvList) {
            float textSize = textView.getTextSize();
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * 11 / 10);
        }
    }

    public void largeSmall(List<TextView> tvList) {
        for (TextView textView : tvList) {
            float textSize = textView.getTextSize();
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * 8 / 11);
        }
    }

    public void largeMid(List<TextView> tvList) {
        for (TextView textView : tvList) {
            float textSize = textView.getTextSize();
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * 10 / 11);
        }
    }

    @Override
    public boolean isSupportSwipeBack() {
        return true;
    }

    @Override
    public void onSwipeBackLayoutSlide(float slideOffset) {

    }

    @Override
    public void onSwipeBackLayoutCancel() {

    }

    @Override
    public void onSwipeBackLayoutExecuted() {
        mSwipeBackHelper.swipeBackward();
    }
}
