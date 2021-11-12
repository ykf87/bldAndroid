package com.jiankang.gouqi.ui.login.model;

import android.content.Context;


import java.util.HashMap;
import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.login.contract.LoginContract;

/**
 * 登录接口
 * @author: ljx
 * @createDate: 2020/6/9 9:29
 */
public class LoginModel implements LoginContract.Model {
    /**
     * 获取Session
     * @param sessionId
     */
    @Override
    public void getSession(Context context, String sessionId, final OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose){
        Map<String, String> param = new HashMap<>();
        try {
            RetrofitService.getData(context, ServiceListFinal.createSession, param, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void userLogin(Context context, boolean isLoginByPsw, String username, String userType, String password,
                          OnNetRequestListener listener, AutoDisposeConverter<ApiResponse> bindAutoDispose) {
        Map<String, String> param = new HashMap<>();
        try {
            param.put("phone", username);
            param.put("password", password);
            RetrofitService.postData(context, ServiceListFinal.login, param, listener, bindAutoDispose);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void onDestroy() {

    }
}
