package com.jiankang.gouqi.ui.login.presenter;

import android.content.Context;

import com.jiankang.gouqi.base.mvp.BasePresenter;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.ui.login.contract.LoginContract;
import com.jiankang.gouqi.ui.login.entity.LoginEntity;
import com.jiankang.gouqi.ui.login.entity.SessionEntity;
import com.jiankang.gouqi.ui.login.model.LoginModel;

/**
 * 登录
 *
 * @author: ljx
 * @createDate: 2020/6/18 15:29
 */
public class LoginPresenter extends BasePresenter<LoginContract.Model, LoginContract.View> {

    public LoginPresenter(LoginContract.View rootView) {
        super(rootView);
        mModel = new LoginModel();
    }

    public void getSession(Context context, String sessionId) {
        mModel.getSession(context, sessionId, new OnNetRequestListener<ApiResponse<SessionEntity>>() {
            @Override
            public void onSuccess(ApiResponse<SessionEntity> response) {
                mView.getSessionSucc(response);
            }

            @Override
            public void onFailure(Throwable t) {
                mView.getSessionFail();
            }
        }, mView.bindAutoDispose());
    }

    public void userLogin(Context context, boolean isLoginByPsw, String username, String userType, String password) {
        mModel.userLogin(context, isLoginByPsw, username, userType, password, new OnNetRequestListener<ApiResponse<LoginEntity>>() {
            @Override
            public void onSuccess(ApiResponse<LoginEntity> response) {
                mView.userLoginSucc(response);
            }

            @Override
            public void onFailure(Throwable t) {
                mView.userLoginFail();
            }
        }, mView.bindAutoDispose());
    }

    @Override
    public boolean useEventBus() {
        return true;
    }
}
