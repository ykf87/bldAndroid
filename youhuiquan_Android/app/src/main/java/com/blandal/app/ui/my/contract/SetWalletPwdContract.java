package com.blandal.app.ui.my.contract;

import android.content.Context;


import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.base.mvp.IModel;
import com.blandal.app.base.mvp.IView;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;

public class SetWalletPwdContract {

    public interface Model extends IModel {
        //获取钱袋子信息
        void installMoneyBagPassword(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);
    }

    public interface SetWalletPwdView extends IView {
        void installMoneyBagPasswordSuccess();

    }
}
