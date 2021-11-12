package com.jiankang.gouqi.common.event;

public class LoginEvent {
    /**
     * 登录成功
     */
    public static int LOGIN_TYPE_LOGIN = 1;
    /**
     * 退出成功
     */
    public static int LOGIN_TYPE_LOGINOUT = 2;
    /**
     * 注册成功，登录界面需要重新登录
     */
    public static int LOGIN_TYPE_REG_RELOGIN = 3;
    //1.登录 2.退出 3重新登录
    private int mLogin;
    private String mPhone;
    private String mPassword;

    public LoginEvent(int login) {
       mLogin = login;
    }

    public int getLogin() {
        return mLogin;
    }

    public String getPhone() {
        return mPhone;
    }

    public void setPhone(String phone) {
        this.mPhone = phone;
    }

    public String getPassword() {
        return mPassword;
    }

    public void setPassword(String password) {
        this.mPassword = password;
    }
}
