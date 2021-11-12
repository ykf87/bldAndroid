package com.blandal.app.ui.my.module;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.my.contract.SetWalletPwdContract;

/**
 *
 * @author: ljx
 * @createDate: 2020/12/03 10:12
 */
public class SetWalletPwdModel implements SetWalletPwdContract.Model {

    @Override
    public void onDestroy() {

    }


    @Override
    public void installMoneyBagPassword(Map map, Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        try {
            RetrofitService.getData(context, ServiceListFinal.setMoneyBagPassword, map, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
