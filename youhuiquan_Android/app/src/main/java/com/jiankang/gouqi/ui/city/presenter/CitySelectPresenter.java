package com.jiankang.gouqi.ui.city.presenter;

import android.content.Context;

import com.jiankang.gouqi.base.mvp.BasePresenter;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.ui.city.contract.CitySelectContract;
import com.jiankang.gouqi.ui.city.entity.CityListEntity;
import com.jiankang.gouqi.ui.city.model.CitySelectModel;

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
