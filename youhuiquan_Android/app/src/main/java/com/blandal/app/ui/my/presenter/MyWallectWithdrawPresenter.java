package com.blandal.app.ui.my.presenter;

import android.content.Context;

import java.util.Map;

import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.my.contract.MyWalletWithdrawContract;
import com.blandal.app.ui.my.entity.WithDrawTipsEntity;
import com.blandal.app.ui.my.module.MyWallectWithdrawModel;


public class MyWallectWithdrawPresenter extends BasePresenter<MyWalletWithdrawContract.MyWalletWithdrawModel, MyWalletWithdrawContract.View> {

    public MyWallectWithdrawPresenter(MyWalletWithdrawContract.View rootHomeView) {
        super(rootHomeView);
        mModel = new MyWallectWithdrawModel();
    }

    public void checkMyWalletPassword(Map map, Context context) {
        mModel.checkMyWalletPassword(map, context, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.checkMyWalletPasswordSucc();
                    }
                }else {
                    mView.checkMyWalletPasswordFail(response.getMsg());
                }
            }

            @Override
            public void onFailure(Throwable t) {
                mView.checkMyWalletPasswordFail(t.getMessage());
            }
        }, mView.bindAutoDispose());
    }

    public void withdraw(Map map, Context context) {
        mModel.withdraw(map, context, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.zhiFuBaoTakeoutSuccess(response.getMsg());
                    }
                }else {
                    mView.zhiFuBaoTakeoutFail(response.getMsg());
                }
            }

            @Override
            public void onFailure(Throwable t) {
                mView.zhiFuBaoTakeoutFail(t.getMessage());
            }
        }, mView.bindAutoDispose());
    }


    public void getWithdrawTips(Map map, Context context) {
        mModel.getWithdrawTips(map, context, new OnNetRequestListener<ApiResponse<WithDrawTipsEntity>>() {
            @Override
            public void onSuccess(ApiResponse<WithDrawTipsEntity> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.getWithdrawTipsSucc(response.getData());
                    }
                }else {
                    mView.getWithdrawTipsFail(response.getMsg());
                }
            }

            @Override
            public void onFailure(Throwable t) {
                mView.getWithdrawTipsFail(t.getMessage());
            }
        }, mView.bindAutoDispose());
    }

}
