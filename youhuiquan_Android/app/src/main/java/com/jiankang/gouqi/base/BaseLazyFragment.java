package com.jiankang.gouqi.base;

import com.jiankang.gouqi.base.mvp.BasePresenter;

/**
 * 懒加载
 *
 * @author: ljx
 * @createDate: 2020/9/16 11:30
 */
public abstract class BaseLazyFragment<T extends BasePresenter>  extends BaseMvpFragment {
    public boolean mIsLoaded = false;

    /**
     * 加载
     */
    public abstract void initLazy();

    @Override
    public void onResume() {
        super.onResume();
        if (!mIsLoaded && !isHidden()) {
            initLazy();
            mIsLoaded = true;
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        mIsLoaded = false;
    }

    protected void refreshMet() {

    }
}
