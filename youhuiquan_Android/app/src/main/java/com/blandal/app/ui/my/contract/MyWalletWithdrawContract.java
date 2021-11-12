package com.blandal.app.ui.my.contract;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.base.mvp.IModel;
import com.blandal.app.base.mvp.IView;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.my.entity.WithDrawTipsEntity;

public class MyWalletWithdrawContract {
    public interface MyWalletWithdrawModel extends IModel {
        void checkMyWalletPassword(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

        void withdraw(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

        //获取提现小贴士
        void getWithdrawTips(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);
    }

    public interface View extends IView {
        void zhiFuBaoTakeoutSuccess(String msg);
        void zhiFuBaoTakeoutFail(String errMsg);

        void checkMyWalletPasswordSucc();
        void checkMyWalletPasswordFail(String errMsg);

        void getWithdrawTipsSucc(WithDrawTipsEntity entity);
        void getWithdrawTipsFail(String errMsg);
    }
}
