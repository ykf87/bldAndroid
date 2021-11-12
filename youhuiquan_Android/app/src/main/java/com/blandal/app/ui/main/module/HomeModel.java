package com.blandal.app.ui.main.module;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.ui.main.contract.HomeContract;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;

/**
 * 启动页接口
 *
 * @author: ljx
 * @createDate: 2020/11/20 16:12
 */
public class HomeModel implements HomeContract.Model {

    @Override
    public void onDestroy() {

    }

    @Override
    public void getClassifyList(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.getClassifyList, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void getGlobalClientData(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.getGlobalConfig, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
