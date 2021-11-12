package com.blandal.app.ui.my.presenter;

import android.content.Context;

import java.util.Map;

import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.my.contract.SetWalletPwdContract;
import com.blandal.app.ui.my.entity.TradeIList;
import com.blandal.app.ui.my.module.SetWalletPwdModel;


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
