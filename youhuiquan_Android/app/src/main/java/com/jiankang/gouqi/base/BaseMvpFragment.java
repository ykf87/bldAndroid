package com.jiankang.gouqi.base;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.lifecycle.Lifecycle;

import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import butterknife.ButterKnife;
import butterknife.Unbinder;
import com.jiankang.gouqi.base.mvp.BasePresenter;
import com.jiankang.gouqi.base.mvp.BaseView;


/**
 * mvp的fragment基类
 *
 * @author: ljx
 * @createDate: 2020/6/18 15:25
 */
public abstract class BaseMvpFragment<T extends BasePresenter> extends BaseFragment implements BaseView {

    protected T mPresenter;
    protected View rootView;
    private Unbinder mUnbinder;
    //得到当前界面的布局文件id(由子类实现)
    protected abstract int provideContentViewId();

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        if (rootView == null) {
            rootView = inflater.inflate(provideContentViewId(),container,false);
            mUnbinder = ButterKnife.bind(this, rootView);

            initView(rootView);
            initEvent();
            initData();
        } else {
            ViewGroup parent = (ViewGroup) rootView.getParent();
            if (parent != null) {
                parent.removeView(rootView);
            }
        }
        return rootView;
    }

    /**
     * 初始化view
     * @param rootView 主视图
     */
    public abstract void initView(View rootView) ;
    /**
     * 初始化事件
     */
    public abstract void initEvent() ;

    /**
     * 初始化数据
     */
    public abstract void initData();

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        if (mPresenter != null) {
            mPresenter.onDestroy();
        }
        this.mPresenter = null;
        if (mUnbinder != null && mUnbinder != Unbinder.EMPTY) {
            mUnbinder.unbind();
        }
        this.mUnbinder = null;
        this.rootView = null;
    }

    /**
     * 绑定生命周期 防止MVP内存泄漏
     *
     * @param <T> 泛型
     * @return 泛型
     */
    @Override
    public <T> AutoDisposeConverter<T> bindAutoDispose() {
        return AutoDispose.autoDisposable(AndroidLifecycleScopeProvider
                .from(this, Lifecycle.Event.ON_DESTROY));
    }

}
