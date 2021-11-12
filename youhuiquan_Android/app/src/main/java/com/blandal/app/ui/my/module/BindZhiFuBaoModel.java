package com.blandal.app.ui.my.module;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.my.contract.BindZhiFuBaoContract;

/**
 *
 * @author: ljx
 * @createDate: 2020/11/20 16:12
 */
public class BindZhiFuBaoModel implements BindZhiFuBaoContract.Model {

    @Override
    public void onDestroy() {

    }


    @Override
    public void binZhiFuBaoModule(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.postData(context, ServiceListFinal.bindBank, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void getCode(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.postData(context, ServiceListFinal.getSmsAuthenticationCode, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
