package com.jiankang.gouqi.ui.my.presenter;

import android.content.Context;

import java.util.Map;

import com.jiankang.gouqi.base.mvp.BasePresenter;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.ui.my.contract.SetWalletPwdContract;
import com.jiankang.gouqi.ui.my.entity.TradeIList;
import com.jiankang.gouqi.ui.my.module.SetWalletPwdModel;


public class SetWallectPwdPresenter extends BasePresenter<SetWalletPwdContract.Model, SetWalletPwdContract.SetWalletPwdView> {

    public SetWallectPwdPresenter(SetWalletPwdContract.SetWalletPwdView rootHomeView) {
        super(rootHomeView);
        mModel = new SetWalletPwdModel();
    }

    public void setPwd(Map map, Context context) {
        mModel.installMoneyBagPassword(map, context, new OnNetRequestListener<ApiResponse<TradeIList>>() {
            @Override
            public void onSuccess(ApiResponse<TradeIList> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.installMoneyBagPasswordSuccess();
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, mView.bindAutoDispose());
    }

}
