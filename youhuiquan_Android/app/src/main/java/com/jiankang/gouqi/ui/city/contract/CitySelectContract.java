package com.jiankang.gouqi.ui.city.contract;

import android.content.Context;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.base.mvp.IModel;
import com.jiankang.gouqi.base.mvp.IView;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.ui.city.entity.CityListEntity;

/**
 * 城市选择协议
 *
 * @author: ljx
 * @createDate: 2020/7/2 17:43
 */
public interface CitySelectContract {
    interface Model extends IModel {
        /**
         * 获取城市列表
         * @param context 上下文
         * @param listener 回调
         */
        void getCityList(Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);
    }

    interface View extends IView {
        /**
         * 获取城市列表成功
         * @param entity
         */
        void getCityListSucc(ApiResponse<CityListEntity> entity);

        /**
         * 获取城市列表失败
         */
        void getCityListFail();
    }

    interface Presenter {

    }
}
