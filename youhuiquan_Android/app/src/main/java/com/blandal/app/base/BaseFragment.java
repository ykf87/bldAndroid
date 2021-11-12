package com.blandal.app.base;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.blandal.app.common.MyHandler;
import com.blandal.app.dialog.ProgressDialogShow;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.EventBusManager;
import com.blandal.app.util.ToastShow;


public abstract class BaseFragment extends Fragment {

    /**
     * 主要用于异步消息的处理
     */
    protected MyHandler handler = new MyHandler();

    /**
     * 基类的Context
     */
    protected Context mContext;

    protected Activity mActivity;

    /**
     * 用户是否已经登录
     */
    protected boolean isUserLogin;

    /**
     * 雇主是否已经
     */
    protected boolean isEntLogin;

    /**
     * true 表示用户 雇主都没登录
     */
    protected boolean isNotLogin;

    /**
     * 主要view
     */
    protected View mView;

    /**
     * 是否初始化过view
     */
    protected boolean isInitView = false;

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
                    ProgressDialogShow.showLoadDialog(mContext, false,	txtContent);
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
     * 是否开启状态栏透明
     */
    boolean isPpenStatusTransparent = false;

    /**
     * 开启状态栏透明
     */
    protected void openStatusTransparent() {
        isPpenStatusTransparent = true;
    }

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
        mContext = getContext();
        mActivity = getActivity();
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
//        mContext = getActivity();
        //setLoginData();
        if (isPpenStatusTransparent) {
            //AppUtils.initSystemBar(mContext, mView);
        }
        super.onActivityCreated(savedInstanceState);

        //如果要使用 EventBus 请将此方法返回 true
        if (useEventBus()) {
            EventBusManager.getInstance().register(this);
        }
    }

    /**
     * 加载主线程运行
     */
    public void post(Runnable runnable) {
        handler.mPost(runnable);
    }


    /**
     * 关闭加载层
     *
     */
    public void closeLoadDialog() {
        ProgressDialogShow.dismissDialog(handler);
    }

    @Override
    public void onStart() {
        super.onStart();
        isInitView = true;
    }

	public void setLoginData() {
//		isUserLogin = LoginUtils.isUserLogin(mContext);
//		isEntLogin = LoginUtils.isEntLogin(mContext);
//		isNotLogin = LoginUtils.isNotLogin(mContext);
	}

	@Override
    public void onResume() {
        super.onResume();
        setLoginData();
//        MobclickAgent.onPageStart(this.getClass().getName());
    }

	@Override
    public void onPause() {
		super.onPause();
//        MobclickAgent.onPageEnd(this.getClass().getName());
	}

    @Override
    public void onDestroy() {
        handler.setDestroy();
        super.onDestroy();
        if (useEventBus()) {
            EventBusManager.getInstance().unregister(this);
        }
    }

    /**
     * 显示系统提示
     */
    public void showMsg(final String txtContent) {
        ToastShow.showMsg(mContext, txtContent, handler);
    }


    /**
     * 是否使用 EventBus
     */
    public boolean useEventBus() {
        return true;
    }
}
