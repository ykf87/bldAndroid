package com.jiankang.gouqi.ui.my.contract;

import android.content.Context;


import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.base.mvp.IModel;
import com.jiankang.gouqi.base.mvp.IView;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;

public class SetWalletPwdContract {

    public interface Model extends IModel {
        //获取钱袋子信息
        void installMoneyBagPassword(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);
    }

    public interface SetWalletPwdView extends IView {
        void installMoneyBagPasswordSuccess();

    }
}
