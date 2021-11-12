package com.blandal.app.ui.main.module;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.ui.main.contract.HomeTaskContract;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;


public class HomeTaskModel implements HomeTaskContract.Model {

    @Override
    public void onDestroy() {

    }

    @Override
    public void getHomeTaskList(Map map, Context context,
                                OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.getHomeList, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void stuApplyZhaiTask(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.stuApplyZhaiTask, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 倒计时结束更新状态
     *
     * @param map
     * @param context
     * @param listener
     * @param bindAutoDispose
     */
    @Override
    public void updateTaskTradeStatus(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.updateTaskTradeStatus, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
