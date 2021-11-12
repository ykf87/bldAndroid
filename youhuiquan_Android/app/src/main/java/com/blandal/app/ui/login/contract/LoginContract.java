package com.blandal.app.ui.login.contract;

import android.content.Context;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.base.mvp.IModel;
import com.blandal.app.base.mvp.IView;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.login.entity.LoginEntity;
import com.blandal.app.ui.login.entity.SessionEntity;


public interface LoginContract {
    interface Model extends IModel {
        /**
         * 获取Session
         * @param sessionId
         */
        public void getSession(Context context, String sessionId, final OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose);

        /**
         * 用户登录
         * @param context
         * @param isLoginByPsw
         * @param username
         * @param userType
         * @param password
         * @param listener
         * @param bindAutoDispose
         */
        public void userLogin(Context context, boolean isLoginByPsw, String username, String userType, String password,
                              final OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose);
    }

    interface View extends IView {
        void userLoginSucc(ApiResponse<LoginEntity> response);
        void userLoginFail();
        void getSessionSucc(ApiResponse<SessionEntity> response);
        void getSessionFail();
    }

    interface Presenter {

    }
}
