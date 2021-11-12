package com.jiankang.gouqi.ui.my.contract;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.base.mvp.IModel;
import com.jiankang.gouqi.base.mvp.IView;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.ui.my.entity.WithDrawTipsEntity;

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
