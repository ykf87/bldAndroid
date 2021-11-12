package com.jiankang.gouqi.ui.main.presenter;

import android.content.Context;

import java.util.List;
import java.util.Map;

import com.jiankang.gouqi.base.mvp.BasePresenter;
import com.jiankang.gouqi.ui.main.contract.HomeTaskContract;
import com.jiankang.gouqi.ui.main.entity.ZhaiTaskListEntity;
import com.jiankang.gouqi.ui.main.module.HomeTaskModel;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;


public class HomeTaskPresenter extends BasePresenter<HomeTaskContract.Model, HomeTaskContract.HomeTaskView> {

    public HomeTaskPresenter(HomeTaskContract.HomeTaskView rootHomeTaskView) {
        super(rootHomeTaskView);
        mModel = new HomeTaskModel();
    }

    public void getHomeTaskList(Map map, Context context) {
        mModel.getHomeTaskList(map, context, new OnNetRequestListener<ApiResponse<List<ZhaiTaskListEntity>>>() {
            @Override
            public void onSuccess(ApiResponse<List<ZhaiTaskListEntity>> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.getHomeTaskListSucc(response.getData());
                    }
                } else {
                    if (mView != null) {
                        mView.getHomeTaskListFail();
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
                if (mView != null) {
                    mView.getHomeTaskListFail();
                }
            }
        }, mView.bindAutoDispose());
    }

    public void stuApplyZhaiTask(Map map, Context context) {
        mModel.stuApplyZhaiTask(map, context, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.stuApplyZhaiTaskSucc();
                    }
                } else {
                    if (mView != null) {
                        mView.stuApplyZhaiTaskFail(response.getMsg());
                    }
                }
            }

            @Override
            public void onFailure(Throwable t) {
                if (mView != null) {
                    mView.stuApplyZhaiTaskFail(t.getMessage());
                }
            }
        }, mView.bindAutoDispose());
    }

    public void updateTaskTradeStatus(Map map, Context context) {
        mModel.updateTaskTradeStatus(map, context, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    if (mView != null) {
                        mView.updateTaskTradeStatusSucc();
                    }
                }
            }
            @Override
            public void onFailure(Throwable t) {
            }
        }, mView.bindAutoDispose());
    }
}
