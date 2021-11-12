package com.blandal.app.ui.my.presenter;

import android.content.Context;

import java.util.Map;

import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.my.contract.BindZhiFuBaoContract;
import com.blandal.app.ui.my.module.BindZhiFuBaoModel;


public class BindZhiFuBaoPresenter extends BasePresenter<BindZhiFuBaoContract.Model, BindZhiFuBaoContract.BindZhiFuBaoView> {

    public BindZhiFuBaoPresenter(BindZhiFuBaoContract.BindZhiFuBaoView rootHomeView) {
        super(rootHomeView);
        mModel = new BindZhiFuBaoModel();
    }

    public void bindZhiFuBao(Map map, Context context) {
        mModel.binZhiFuBaoModule(map, context, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.binZhiFuBaoSucc();
                    }
                } else {
                    if (mView != null) {
                        mView.binZhiFuBaoFail(response.getMsg());
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
                if (mView != null) {
                    mView.binZhiFuBaoFail(t.getMessage());
                }
            }
        }, mView.bindAutoDispose());
    }

    public void getCode(Map map, Context context) {
        mModel.getCode(map, context, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.getCodeSucc();
                    }
                } else {
                    if (mView != null) {
                        mView.getCodeFail(response.getMsg());
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
                if (mView != null) {
                    mView.getCodeFail(t.getMessage());
                }
            }
        }, mView.bindAutoDispose());
    }

}
