package com.jiankang.gouqi.util;


import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;

import com.jiankang.gouqi.app.MyApplication;
import com.jiankang.gouqi.constant.FinalLoginType;
import com.jiankang.gouqi.ui.login.entity.LoginEntity;

import static com.jiankang.gouqi.constant.SPConstant.MAIN_APP;

public class UserShared {
    /**
     * 登录用户的id，取的频率很高，所以用静态变量
     */
    public static String userId;
    /**
     * 渠道字符串
     */
    private static String umeng_channel_id;

    /**
     * 首页城市id
     */
    private static String mUserIndexCityId;
    /**
     * 获取登录状态
     */
    private static String mLoginType;
    /**
     * 验证码登录的token
     */
    public static String mDynamicPassword;
    /**
     * sessionId
     */
    private static String mSessionId;
    private static String mUserAccount;
    private static String mClientToken;
    public static boolean mIsOpenPermission = false;

    /**
     * 获取渠道id
     */
    public static String getUmengChannelId(Context mContext) {
        if (!TextUtils.isEmpty(umeng_channel_id)) {
            return umeng_channel_id;
        }
        try {
            ApplicationInfo appInfo = mContext.getPackageManager()
                    .getApplicationInfo(mContext.getPackageName(),
                            PackageManager.GET_META_DATA);
            Object objStr = appInfo.metaData.get("UMENG_CHANNEL");
            if (objStr != null) {
                umeng_channel_id = objStr.toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return umeng_channel_id;
    }

    public static String getData(Context context, String key) {

        if (context == null) {
            return "";
        }

        SharedPreferences remember = context.getSharedPreferences(
                MAIN_APP, Context.MODE_PRIVATE);

        String val = remember.getString(key, null);

        return val == null ? "" : val;
    }

    public static void setData(Context context, String key, String val) {

        if (context == null || key == null || val == null) {
            return;
        }

        SharedPreferences remember = context.getSharedPreferences(
                MAIN_APP, Context.MODE_PRIVATE);

        SharedPreferences.Editor e = remember.edit();

        e.putString(key, val);

        e.commit();
    }

    /**
     * 是否第一次打开APP
     */
    public static String getFirstOpenApp(Context mContext) {
        return UserShared.getData(mContext, "first_open_app");
    }

    /**
     * 是否第一次打开APP
     */
    public static void setFirstOpenApp(Context context, String val) {
        setData(context, "first_open_app", val);
    }

    public static void setOAID(Context context, String val) {
        setData(context, "phone_oaid", val);
    }

    public static String getOAID(Context context) {
        return UserShared.getData(context, "phone_oaid");
    }


    /**
     * 极光push_id
     *
     * @param context
     * @param val
     */
    public static void setJiGuangPushId(Context context, String val) {
        setData(context, "push_id", val);
    }

    public static String getJiGuangPushId(Context mContext) {
        return UserShared.getData(mContext, "push_id");
    }

    /**
     * 设置默认城市id
     *
     * @param context
     * @param val
     */
    public static void setDefaultCityId(Context context, String val) {
        setData(context, "default_city_id", val);
    }

    public static String getDefaultCityId(Context mContext) {
        return UserShared.getData(mContext, "default_city_id");
    }

    /**
     * 设置首页城市id
     */
    public static void setUserIndexCityId(Context context, String val) {
        if (!TextUtils.isEmpty(val) && !TextUtils.equals(val, "0")) {
            mUserIndexCityId = val;
            setData(context, "UserIndexCityId", val);
        }
    }

    /**
     * 获取首页城市id
     */
    public static String getUserIndexCityId(Context mContext) {
        if (StringUtils.isNullOrEmpty(mUserIndexCityId)) {
            mUserIndexCityId = UserShared.getData(mContext, "UserIndexCityId");
        }
        return mUserIndexCityId;
    }

    /**
     * 保设置用户定位的城市id
     */
    public static void setLocationCityId(Context context, String val) {
        setData(context, "User_LocationCityId", val);
    }

    /**
     * 保设置用户定位的城市name
     */
    public static void setLocationCityName(Context context, String val) {
        setData(context, "User_LocationCityName", val);
    }

    /**
     * 设置首页城市Nm
     */
    public static void setUserIndexCityNm(Context context, String val) {
        setData(context, "UserIndexCityNm", val);
    }

    /**
     * 设置首页城市code
     */
    public static void setCityCode(Context context, String val) {
        setData(context, "UserCityCode", val);
    }

    /**
     * 获取登录状态
     */
    public static String getLoginType(Context mContext) {
        if (StringUtils.isNullOrEmpty(mLoginType)) {
            mLoginType = UserShared.getData(mContext, "LoginType");
        }
        return mLoginType;
    }

    /**
     * 获取登录状态,没有登录的时候 用户和雇主相互切换记录
     */
    public static String getNotLoginType(Context mContext) {
        return UserShared.getData(mContext, "NotLoginType");
    }

    /**
     * 设置动态密码
     */
    public static void setDynamicPassword(Context context, String val) {
        mDynamicPassword = val;
        setData(context, "dynamic_password", val);
    }

    /**
     * 保存动态密码
     */
    public static String getDynamicPassword(Context mContext) {
        if (StringUtils.isNullOrEmpty(mDynamicPassword)) {
            mDynamicPassword = UserShared.getData(mContext, "dynamic_password");
        }
        return mDynamicPassword;
    }

    /**
     * 设置sessionId
     */
    public static void setSessionId(Context context, String val) {
        mSessionId = val;
        setData(context, "sessionId", val);
    }

    /**
     * 获取sessionId
     */
    public static String getSessionId(Context mContext) {
        if (StringUtils.isNullOrEmpty(mSessionId)) {
            mSessionId = UserShared.getData(mContext, "sessionId");
        }
        return mSessionId;
    }

    /**
     * 设置登录密码
     */
    public static void setLoginPass(Context context, String val) {
        setData(context, "LoginPass", val);
    }

    /**
     * 获取登录密码
     */
    public static String getLoginPass(Context mContext) {
        return UserShared.getData(mContext, "LoginPass");
    }

    /**
     * 设置登录状态
     */
    public static void setLoginType(Context context, String val) {
        // 第三方账号登录，清除登录密码，主要是怕与重连冲突
        if (FinalLoginType.ToUserQQLogin.equals(val)
                || FinalLoginType.ToUserWeiBoLogin.equals(val)
                || FinalLoginType.ToUserWeiXinLogin.equals(val)) {
            UserShared.setLoginPass(context, "");
            UserShared.setUserLastLoginType(context, val);
        }
        mLoginType = val;
        setData(context, "LoginType", val);

        /*// 当前是用户登录，那么未登录标识也改成用户登录
        if (LoginUtils.isUserLogin(context)) {
            UserShared.setNotLoginType(context, FinalLoginType.ToUserLogin);
        } else if (LoginUtils.isEntLogin(context)) {
            // 当前是雇主登录，那么未登录标识也改成雇主登录
            UserShared.setNotLoginType(context, FinalLoginType.ToEnterPrise);
        }*/
    }

    /**
     * 设置用户端最后一次登录状态，用作雇主端切换时候用
     */
    public static void setUserLastLoginType(Context context, String val) {
        setData(context, "UserLastLoginType", val);
    }

    /**
     * 登录页面 - 协议自动勾选
     */
    public static boolean getIsOnlyBrowser(Context context) {
        return UserShared.getBoolean(context, "is_only_browser", false);
    }

    public static boolean getBoolean(Context context, String key, boolean defaultValue) {

        if (context == null) {
            return false;
        }
        SharedPreferences remember = context.getSharedPreferences(
                MAIN_APP, Context.MODE_PRIVATE);

        return remember.getBoolean(key, defaultValue);
    }

    public static void setInt(Context context, String key, int val) {

        if (context == null || key == null) {
            return;
        }

        SharedPreferences remember = context.getSharedPreferences(
                MAIN_APP, Context.MODE_PRIVATE);

        SharedPreferences.Editor e = remember.edit();

        e.putInt(key, val);

        e.commit();
    }

    public static void setBoolean(Context context, String key, boolean val) {

        if (context == null || key == null) {
            return;
        }

        SharedPreferences remember = context.getSharedPreferences(
                MAIN_APP, Context.MODE_PRIVATE);

        SharedPreferences.Editor e = remember.edit();

        e.putBoolean(key, val);

        e.commit();
    }

    public static int getInt(Context context, String key) {

        if (context == null) {
            return 0;
        }

        SharedPreferences remember = context.getSharedPreferences(
                MAIN_APP, Context.MODE_PRIVATE);

        int val = remember.getInt(key, 0);

        return val;
    }

    /**
     * 保存用户手机号码
     */
    public static String getUserAccount(Context mContext) {
        if (StringUtils.isNullOrEmpty(mUserAccount)) {
            mUserAccount = UserShared.getData(mContext, "User_Account");
        }
        return mUserAccount;
    }

    /**
     * 设置用户id
     */
    public static void setUserId(Context context, String val) {
        userId = val;
        setData(context, "User_Id", val);
    }

    /**
     * 设置用户账号
     */
    public static void setUserAccount(Context context, String val) {
        mUserAccount = val;
        setData(context, "User_Account", val);
    }

    /**
     * 登录-协议弹窗
     */
    public static void setLoginPopAgreement(Context context, int val) {
        UserShared.setInt(context, "login_pop_agreement", val);
    }

    /**
     * 登录-协议弹窗
     */
    public static int getLoginPopAgreement(Context context) {
        return UserShared.getInt(context, "login_pop_agreement");
    }

    /**
     * 保设Client_Token
     */
    public static void setToken(Context context, String val) {
        mClientToken = val;
        setData(context, "Client_Token", val);
    }

    /**
     * 获取Client_Token
     */
    public static String getToken(Context context) {
        return getData(context, "Client_Token");
    }


    public static void setGoubi(Context context, String val) {
        setData(context, "goubi", val);
    }

    /**
     * 枸币数量
     *
     * @param context
     * @return
     */
    public static String getGoubi(Context context) {
        return getData(context, "goubi");
    }

    /**
     * 设置Challenge
     */
    public static void setChallenge(Context context, String val) {
        setData(context, "challenge", val);
    }

    /**
     * 获取challenge
     */
    public static String getChallenge(Context mContext) {
        return UserShared.getData(mContext, "challenge");
    }

    /**
     * 设置pub_key_exp
     */
    public static void setPubkeyExp(Context context, String val) {
        setData(context, "pub_key_exp", val);
    }

    /**
     * 获取pub_key_exp
     */
    public static String getPubkeyExp(Context mContext) {
        return UserShared.getData(mContext, "pub_key_exp");
    }

    /**
     * 设置pub_key_modulus
     */
    public static void setPubkeyModulus(Context context, String val) {
        setData(context, "pub_key_modulus", val);
    }

    /**
     * 获取pub_key_modulus
     */
    public static String getPubkeyModulus(Context mContext) {
        return UserShared.getData(mContext, "pub_key_modulus");
    }

    /**
     * 设置头像
     */
    public static void setAvatar(Context context, String val) {
        setData(context, "avatar", val);
    }

    /**
     * 获取头像
     */
    public static String getAvatar(Context mContext) {
        return UserShared.getData(mContext, "avatar");
    }

    /**
     * 金币数
     */
    public static void setJinBi(Context context, int val) {
        setInt(context, "jinbi", val);
    }

    /**
     * 金币数
     */
    public static int getJinBi(Context mContext) {
        return UserShared.getInt(mContext, "jinbi");
    }


    public static int getBankId(Context mContext) {
        return UserShared.getInt(mContext, "bankId");
    }

    public static void setBankId(Context context, int val) {
        setInt(context, "bankId", val);
    }

    /**
     * 设置头像
     */
    public static void setName(Context context, String val) {
        setData(context, "name", val);
    }

    /**
     * 获取头像
     */
    public static String getName(Context mContext) {
        return UserShared.getData(mContext, "name");
    }

    /**
     * 获取首页城市Nm
     */
    public static String getUserIndexCityNm(Context mContext) {
        return UserShared.getData(mContext, "UserIndexCityNm");
    }

    /**
     * 获取广告类型
     */
    public static String getAdvertisement(Context mContext) {
        return UserShared.getData(mContext, "AdvertisementType");
    }

    /**
     * 设置广告类型  type 自己定义的广告类型1：第三方 2：自平台 3：没廣告(或者是空)
     */
    public static void setAdvertisement(Context context, String val) {
        setData(context, "AdvertisementType", val);
    }


    public static void setBankEntity(LoginEntity.BankEntity globalEntity) {
        if (globalEntity != null) {
        } else {
            SpUtils.remove(MyApplication.getContext(), "BankEntity");
        }
    }

    public static LoginEntity.BankEntity getBankEntity() {
        LoginEntity.BankEntity data = SpUtils.getBean(MyApplication.getContext(), "BankEntity", LoginEntity.BankEntity.class);
        return data;
    }

}
