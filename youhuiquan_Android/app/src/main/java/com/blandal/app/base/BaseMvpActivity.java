package com.blandal.app.base;

import android.os.Bundle;
import android.view.InflateException;

import androidx.annotation.Nullable;
import androidx.lifecycle.Lifecycle;

import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import butterknife.ButterKnife;
import butterknife.Unbinder;
import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.base.mvp.BaseView;

/**
 * mvp的activity基类
 *
 * @author: ljx
 * @createDate: 2020/6/18 11:54
 */
public abstract class BaseMvpActivity<T extends BasePresenter> extends BaseActivity implements BaseView {

    protected T mPresenter;
    private Unbinder mUnbinder;

    protected abstract int provideContentViewId();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        try {
            int layoutResID = provideContentViewId();
            if (layoutResID != 0) {
                setContentView(layoutResID);
                //绑定到butterknife
                mUnbinder = ButterKnife.bind(this);
            }
        } catch (Exception e) {
            if (e instanceof InflateException) {
                throw e;
            }
            e.printStackTrace();
        }
        initView();
        initEvent();
        initData();
    }

    public abstract void initView();

    public abstract void initEvent();

    public abstract void initData();


    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mPresenter != null) {
            mPresenter.onDestroy();
        }
        this.mPresenter = null;
        if (mUnbinder != null && mUnbinder != Unbinder.EMPTY) {
            mUnbinder.unbind();
        }
        this.mUnbinder = null;
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
