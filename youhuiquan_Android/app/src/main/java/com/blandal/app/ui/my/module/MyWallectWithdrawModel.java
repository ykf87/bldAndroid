package com.blandal.app.ui.my.module;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.my.contract.MyWalletWithdrawContract;

/**
 *
 * @author: ljx
 * @createDate: 2020/11/20 16:12
 */
public class MyWallectWithdrawModel implements MyWalletWithdrawContract.MyWalletWithdrawModel {

    @Override
    public void onDestroy() {

    }


    @Override
    public void checkMyWalletPassword(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.checkMoneyBagPassword, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void withdraw(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.postData(context, ServiceListFinal.alipayWithdraw, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void getWithdrawTips(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.getMoneyBagWithdrawNotice, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
