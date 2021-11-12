package com.jiankang.gouqi.ui.my.module;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.my.contract.SetWalletPwdContract;

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
