package com.jiankang.gouqi.base;

import android.app.Dialog;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.DialogFragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import butterknife.ButterKnife;

/**
 * Dialog的基类
 *
 * @author: ljx
 * @createDate: 2020/6/19 14:05
 */
public abstract class BaseDialogFragment extends DialogFragment {
    protected View mView;
    protected Dialog mDialog = null;
    private static String TAG = BaseDialogFragment.class.getSimpleName();

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mView = super.onCreateView(inflater, container, savedInstanceState);
        mDialog = getDialog();
        if (mView == null) {
            mView = inflater.inflate(provideContentViewId(), container, false);
        }
        ButterKnife.bind(this, mView);
        //点击返回键是否可取消
        initView();
        initData();
        return mView;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onStart() {
        super.onStart();
        //设置dialogFragment位置及属性
     if (null != mDialog) {
            Window window = getDialog().getWindow();
            if (window != null) {
                WindowManager.LayoutParams windowParams = window.getAttributes();
                windowParams.dimAmount = 0.5f;
                window.setAttributes(windowParams);
            }

     /*          //设置宽度顶满屏幕,无左右留白
            DisplayMetrics dm = new DisplayMetrics();
            getActivity().getWindowManager().getDefaultDisplay().getMetrics(dm);

            if (getDialog().getWindow() != null) {
                getDialog().getWindow().setLayout(dm.widthPixels, ViewGroup.LayoutParams.MATCH_PARENT);
            }*/
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

    /**
     * 初始化一些view
     */
    protected abstract void initView();


    protected abstract void initData();


    /**
     * 绑定布局
     *
     * @return int
     */
    protected abstract int provideContentViewId();


    @Override
    public void show(FragmentManager fm, String tag) {
        FragmentTransaction ft = fm.beginTransaction();
        ft.add(this, tag);
        // 这里把原来的commit()方法换成了commitAllowingStateLoss()
        // 解决Can not perform this action after onSaveInstanceState with DialogFragment
        ft.commitAllowingStateLoss();
        //解决java.lang.IllegalStateException: Fragment already added
        fm.executePendingTransactions();
    }

    @Override
    public void dismiss() {
        dismissAllowingStateLoss();
    }

    /**
     * 短时间显示Toast
     *
     * @param msg 消息体
     */
    protected void toastShort(String msg) {
//        ToastUtils.showToast(getContext(), msg);
    }

    /**
     * 短时间显示Toast
     *
     * @param resId 消息体
     */
    protected void toastShort(int resId) {
    }

}


