package com.blandal.app.ui.city.presenter;

import android.content.Context;

import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.city.contract.CitySelectContract;
import com.blandal.app.ui.city.entity.CityListEntity;
import com.blandal.app.ui.city.model.CitySelectModel;

/**
 * 城市选择
 *
 * @author: ljx
 * @createDate: 2020/7/2 17:37
 */
public class CitySelectPresenter extends BasePresenter<CitySelectContract.Model, CitySelectContract.View> {

    public CitySelectPresenter(CitySelectContract.View rootView) {
        super(rootView);
        mModel = new CitySelectModel();
    }


    public void getCityList(Context context) {
        mModel.getCityList(context, new OnNetRequestListener<ApiResponse<CityListEntity>>() {
            @Override
            public void onSuccess(ApiResponse<CityListEntity> response) {
                if (mView != null) {
                    mView.getCityListSucc(response);
                }
            }

            @Override
            public void onFailure(Throwable t) {
                t.printStackTrace();
                if (mView != null) {
                    mView.getCityListFail();
                }
            }
        }, mView.bindAutoDispose());
    }

    @Override
    public boolean useEventBus() {
        return false;
    }
}
