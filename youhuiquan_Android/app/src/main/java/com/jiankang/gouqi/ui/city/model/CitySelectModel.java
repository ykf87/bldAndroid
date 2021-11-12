package com.jiankang.gouqi.ui.city.model;

import android.content.Context;

import java.util.HashMap;
import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.city.contract.CitySelectContract;
import com.jiankang.gouqi.util.UserShared;

/**
 * 城市选择接口
 *
 * @author: ljx
 * @createDate: 2020/7/2 17:43
 */
public class CitySelectModel implements CitySelectContract.Model {

    @Override
    public void onDestroy() {

    }

    @Override
    public void getCityList(Context context, OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        Map<String, String> param = new HashMap<>();
        String md5_hash = UserShared.getData(context,
                ServiceListFinal.getCityList + "md5_file");
        param.put("md5_hash", md5_hash);
        try {
            RetrofitService.getData(context, ServiceListFinal.getCityList, param, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
