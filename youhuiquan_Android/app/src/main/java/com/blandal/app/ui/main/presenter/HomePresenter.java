package com.blandal.app.ui.main.presenter;

import android.content.Context;

import java.util.List;
import java.util.Map;

import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.entity.GlobalEntity;
import com.blandal.app.ui.main.contract.HomeContract;
import com.blandal.app.ui.main.entity.ClassifyBean;
import com.blandal.app.ui.main.module.HomeModel;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;


public class HomePresenter extends BasePresenter<HomeContract.Model, HomeContract.HomeView> {

    public HomePresenter(HomeContract.HomeView rootHomeView) {
        super(rootHomeView);
        mModel = new HomeModel();
    }

    public void getClassifyList(Map map, Context context) {
        mModel.getClassifyList(map, context, new OnNetRequestListener<ApiResponse<List<ClassifyBean>>>() {
            @Override
            public void onSuccess(ApiResponse<List<ClassifyBean>> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        if (response.getData() != null) {
                            mView.getClassifyListSucc(response.getData());
                        } else {
                            mView.getClassifyListFail();
                        }
                    }
                } else {
                    if (mView != null) {
                        mView.getClassifyListFail();
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
                if (mView != null) {
                    mView.getClassifyListFail();
                }
            }
        }, mView.bindAutoDispose());
    }

    public void getGlobalClientData(Map map, Context context) {
        mModel.getGlobalClientData(map, context, new OnNetRequestListener<ApiResponse<GlobalEntity>>() {
            @Override
            public void onSuccess(ApiResponse<GlobalEntity> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                      mView.getGlobalClientDataSucc(response.getData());
                    }
                } else {
                    if (mView != null) {
                        mView.getGlobalClientDataFail();
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
                if (mView != null) {
                    mView.getGlobalClientDataFail();
                }
            }
        }, mView.bindAutoDispose());
    }

}