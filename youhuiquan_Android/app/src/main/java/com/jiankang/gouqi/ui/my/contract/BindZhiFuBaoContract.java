package com.jiankang.gouqi.ui.my.contract;

import android.content.Context;

import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.base.mvp.IModel;
import com.jiankang.gouqi.base.mvp.IView;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;

/**
 * @author: ljx
 * @createDate: 2020/11/20  15:10
 */
public class BindZhiFuBaoContract {
    public interface Model extends IModel {
        //绑定银行卡
        void binZhiFuBaoModule(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);
       //获取验证码
        void getCode(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

    }

    public interface BindZhiFuBaoView extends IView {
        void binZhiFuBaoSucc();
        void binZhiFuBaoFail(String errMsg);

        void getCodeSucc();
        void getCodeFail(String errMsg);

    }
}
