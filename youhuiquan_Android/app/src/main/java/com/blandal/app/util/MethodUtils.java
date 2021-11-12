package com.blandal.app.util;

import android.content.Context;

import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import java.util.HashMap;
import java.util.Map;

import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import com.blandal.app.common.MyHandler;
import com.blandal.app.entity.AdEntity;
import com.blandal.app.entity.SharedPersonEntity;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;

public class MethodUtils {

    public static void advertisementClick(final Context context, MyHandler handler, final AdEntity data) {

    }

    //上报广告点击日志
    public static void updateDialry(Context context,int adId) {
        Map map = new HashMap();
        map.put("ad_id",adId);
        RetrofitService.postData(context, ServiceListFinal.adClick, map, new OnNetRequestListener<ApiResponse<SharedPersonEntity>>() {
            @Override
            public void onSuccess(ApiResponse<SharedPersonEntity> response) {
                if (response.isSuccess()) {

                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose(context));
    }

    public static <T> AutoDisposeConverter<T> bindAutoDispose(Context context) {
        return AutoDispose.autoDisposable(AndroidLifecycleScopeProvider
                .from((LifecycleOwner) context, Lifecycle.Event.ON_DESTROY));
    }
}
