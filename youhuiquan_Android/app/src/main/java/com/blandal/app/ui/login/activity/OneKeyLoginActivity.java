package com.blandal.app.ui.login.activity;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;



import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CountDownLatch;

import com.blandal.app.base.BaseActivity;
import com.blandal.app.common.MyHandler;
import com.blandal.app.common.event.LoginEvent;
import com.blandal.app.constant.FinalLoginType;
import com.blandal.app.dialog.ProgressDialogShow;
import com.blandal.app.entity.LoginEntity;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.HttpUtility;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.login.entity.SessionEntity;
import com.blandal.app.ui.main.activity.MainAppActivity;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.EventBusManager;
import com.blandal.app.util.JsonUtils;
import com.blandal.app.util.LogUtils;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.SystemUtil;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UserShared;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.annotations.NonNull;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.functions.Consumer;
import io.reactivex.rxjava3.functions.Function;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class OneKeyLoginActivity extends BaseActivity {

    private boolean isFill;
    private boolean isFromGuide;
    private boolean mustLogin = false;
    private boolean isNeedRegisterGuide;
    private String pPhoneNum;
    private String pPassword;

    public static void launch(Context context, boolean mustLogin,
                              boolean isfill, boolean isFromGuide, boolean isNeedRegisterGuide) {
        Intent intent = new Intent(context, com.blandal.app.ui.login.activity.OneKeyLoginActivity.class);
        intent.putExtra("MustLogin", mustLogin);
        intent.putExtra("isfill", isfill);
        intent.putExtra("isFromGuide", isFromGuide);
        intent.putExtra("isNeedRegisterGuide", isNeedRegisterGuide);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setEnableGesture(false);
        // 是否必须登录，默认否
        mustLogin = getIntent().getBooleanExtra("MustLogin", false);
        isFill = getIntent().getBooleanExtra("isfill", false);
        isFromGuide = getIntent().getBooleanExtra("isFromGuide", false);
        isNeedRegisterGuide = getIntent().getBooleanExtra(
                "isNeedRegisterGuide", false);
        pPhoneNum = getIntent().getStringExtra("phone_num");
        pPassword = getIntent().getStringExtra("password");

        LoginActivity.launch(mContext, mustLogin, isFill,
                pPhoneNum, pPassword, isNeedRegisterGuide, isFromGuide);
        finish();
//        switchLoginPage();
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode,
                                 final Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }

    @SuppressLint("AutoDispose")
    private void loginMetOneClick(final String token) {

        //handler销毁再开启
        if (handler == null) {
            handler = new MyHandler();
        }
        if (handler.isDestroy) {
            handler.isDestroy = false;
        }
        //创建session
        Map<String, String> paramSession = new HashMap<>();
        paramSession.put("sessionId_sjk", "");
        RetrofitService.addCommonParam(this, paramSession);
        final String sessionService = ServiceListFinal.createSession;
        final String service = ServiceListFinal.oneClickLogin;
        Map<String, String> param = new HashMap<>();
        Observable<ApiResponse> observable = RetrofitService.getInstance().getApiService().postData(sessionService, paramSession);
        observable.subscribeOn(Schedulers.io())
                .observeOn(Schedulers.io())
                .flatMap(new Function<ApiResponse, Observable<ApiResponse>>() {
                    @Override
                    public Observable<ApiResponse> apply(ApiResponse apiResponse) throws Throwable {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + sessionService);
                            LogUtils.data("请求数据：" + paramSession.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }
                        if (apiResponse.isSuccess()) {
                            SessionEntity sessionEntity = RetrofitService.objectToEntity(SessionEntity.class, apiResponse.getData());
                            // 设置用户session信息
                            UserShared.setSessionId(mContext, sessionEntity.getSessionId());
                            UserShared.setChallenge(mContext, sessionEntity.getChallenge());
                            UserShared.setPubkeyExp(mContext, sessionEntity.getPub_key_exp());
                            UserShared.setPubkeyModulus(mContext, sessionEntity.getPub_key_modulus());
                            UserShared.setToken(mContext, sessionEntity.getUserToken());
                            // UserShared.setExpireTime(mContext, sEntity.getExpire_time());
                        }

                        param.put("flash_login_tocken", token);
                        param.put("user_type", "2");
                        param.put("client_type", "1");
                        param.put("client_version", SystemUtil.getVersionNm(mContext));
                        RetrofitService.addCommonParam(OneKeyLoginActivity.this, param);
                        return RetrofitService.getInstance().getApiService().postData(service, param);
                    }
                })
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe(new Consumer<Disposable>() {
                    @Override
                    public void accept(Disposable disposable) throws Exception {

                    }
                })
                .subscribe(new Observer<ApiResponse>() {

                    @Override
                    public void onSubscribe(@NonNull Disposable d) {

                    }

                    @Override
                    public void onNext(ApiResponse apiResponse) {
                        if (HttpUtility.isOutLog) {
                            LogUtils.data("请求接口：" + service);
                            LogUtils.data("请求数据：" + param.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }

                        ProgressDialogShow.dismissDialog(handler);
                        if (apiResponse.isSuccess()) {
                            LoginEntity oEntity = RetrofitService.objectToEntity(LoginEntity.class, apiResponse.getData());
                            if (oEntity.is_register == 1) {
                                //注册
                        /*Map eventRef = new HashMap();
                        eventRef.put("source", "一键登录注册");
                        AllRequest.uploadDiary(mContext, eventRef, String.valueOf(Constants.REGISTER_EVENT), cc.jianke.zhaiwanzhuan.ui.login.activity.OneKeyLoginActivity.class.getSimpleName());*/
                            } else {
                                //一键登录
                        /*Map eventRef = new HashMap();
                        eventRef.put("source", uploadDiaryEventNameEnum.LoginOneKey.getCode());
                        AllRequest.uploadDiary(mContext, eventRef, String.valueOf(Constants.CLICK_EVENT), cc.jianke.zhaiwanzhuan.ui.login.activity.OneKeyLoginActivity.class.getSimpleName());*/
                            }
                            // 保存登录id

                            // 保存用户的手机号码
                            UserShared.setUserAccount(mContext, oEntity.phone_num);

                            // 保存下发的动态密码
                            UserShared.setDynamicPassword(mContext, oEntity.dynamic_password);


                            // 设置登录类型，账号密码登录
                            UserShared.setLoginType(mContext, FinalLoginType.ToUserLogin);
                            UserShared.setLoginPass(mContext, "");

                            //记录用户回到首页需不需要协议弹窗
                            UserShared.setLoginPopAgreement(mContext, oEntity.is_need_pop);


                            callActivityInterface();
                            CountDownLatch countDownLatch = new CountDownLatch(1);
                            // 隐藏键盘
                            DisplayUtil.hideInput(mContext);
                            showLoadDialog("登录中...");
                            toMainActivity(oEntity.true_name);
                            ProgressDialogShow.dismissDialog(handler);
                        } else {
                            if (!TextUtils.isEmpty(apiResponse.getMsg())) {
                                ToastShow.showMsg(apiResponse.getMsg());
                            }
                            finish();
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        ProgressDialogShow.dismissDialog(handler);
                        ToastShow.showMsg("服务器异常，登录失败！");
                        finish();
                    }

                    @Override
                    public void onComplete() {
                    }
                });

    }

    private void loginMet(final String userLoginPhoneStr, final String userPassStr, final boolean isLoginByPsw) {

        if (userLoginPhoneStr.length() == 0) {
            ToastShow.showMsg(mContext, "请填写账户");
            return;
        }
        if (isLoginByPsw) {
            if (userPassStr.length() == 0) {
                ToastShow.showMsg(mContext, "请填写密码");
                return;
            }
        } else {
            if (userPassStr.length() == 0) {
                ToastShow.showMsg(mContext, "请填写登录验证码");
                return;
            }
        }

        /*startThread(new MyThread() {
            @Override
            public void myRun() throws InterruptedException {
                try {
                    showLoadDialog("登录中...");
                    getSessionMain();
                    String sendPass;

                    // 用户密码的hash，算法MD5(密码明文+challenge)
                    if (isLoginByPsw) {
                        sendPass = HexUtil.bytesToHexString(Coder.encryptMD5(userPassStr + UserShared.getChallenge(mContext)));
                    } else {
                        sendPass = userPassStr;
                    }

                    JSONObject param = new JSONObject();
                    param.put("username", userLoginPhoneStr);
                    param.put("user_type", "2");
                    param.put(isLoginByPsw ? "password" : "dynamic_sms_code", sendPass);
                    param.put("client_type", 1);
                    param.put("client_version", SystemUtil.getVersionNm(mContext));
                    param.put("city_id", UserShared.getLocationCityId(mContext));
                    param.put("push_id", UserShared.getJiGuangPushId(mContext));

                    final LoginEntity oEntity = executeReq(ServiceListFinal.shijianke_userLogin,
                            param, LoginEntity.class);

                    if (!oEntity.isSucc()) {
                        if (!isLoginByPsw) {
                            if (oEntity.getAppErrCode() == 8) {
                                post(new Runnable() {
                                    @Override
                                    public void run() {
                                        // 用户不存在 跳转新页面
                                        Intent intent = new Intent(mContext,
                                                CLoginCompleteInfoActivity.class);
                                        intent.putExtra("phone_num",
                                                userLoginPhoneStr);
                                        intent.putExtra("sms_authentication_code", userPassStr);
                                        startActivityForResult(intent,
                                                FinalActivityReturn.CLoginCompleteInfoActivityReturn);
                                    }
                                });
                                return;
                            }
                        }
                        ToastShow.showMsg(mContext, oEntity.getAppErrDesc(), handler);
                        return;
                    }

                    // 保存登录id
                    UserShared.setUserId(mContext, oEntity.id + "");

                    // 保存用户的手机号码
                    UserShared.setUserAccount(mContext, userLoginPhoneStr);

                    if (isLoginByPsw) {
                        UserShared.setDynamicPassword(mContext, "");
                    } else {
                        // 保存下发的动态密码
                        UserShared.setDynamicPassword(mContext, oEntity.dynamic_password);
                    }
                    YSFUserInfo userInfo = new YSFUserInfo();
                    // App 的用户 ID
                    userInfo.userId = userLoginPhoneStr;
                    // 当且仅当开发者在管理后台开启了 authToken 校验功能时，该字段才有效
                    userInfo.authToken = "auth-token-from-user-server";

                    // CRM 扩展字段
                    JSONArray data = new JSONArray();
                    JSONObject data1 = new JSONObject();
                    data1.put("key", "real_name");
                    data1.put("value", oEntity.true_name);
                    data.put(data1);
                    JSONObject data2 = new JSONObject();
                    data2.put("key", "mobile_phone");
                    data2.put("value", userLoginPhoneStr);
                    data2.put("hidden", "false");
                    data.put(data2);
                    JSONObject data3 = new JSONObject();
                    data3.put("key", "avatar");
                    data3.put("value", oEntity.profile_url);
                    data.put(data3);

                    userInfo.data = data.toString();
                    Unicorn.setUserInfo(userInfo);


                    // 在用户帐号登录成功的时候调用 TalkingDataAppCpa 的 onLogin 方法。
                    TCAgent.onLogin(userLoginPhoneStr, TDAccount.AccountType.ANONYMOUS, "");

                    // 设置登录类型，账号密码登录
                    UserShared.setLoginType(mContext, FinalLoginType.ToUserLogin);

                    UserShared.setLoginPass(mContext, userPassStr);


                    //记录用户回到首页需不需要协议弹窗
                    UserShared.setLoginPopAgreement(mContext, oEntity.is_need_pop);
                    Log.e("tdlx", "myRun is_need_pop: " + oEntity.is_need_pop);

                    UserShared.setAvatar(mContext, oEntity.profile_url);

                    callActivityInterface();
                    CountDownLatch countDownLatch = new CountDownLatch(1);
                    handler.mPost(new Runnable() {
                        @Override
                        public void run() {

                            // 隐藏键盘
                            DisplayUtil.hideInput(mContext);
                            showLoadDialog("登录中...");
                            toMainActivity(oEntity.true_name);
                            ProgressDialogShow.dismissDialog(handler);
                            countDownLatch.countDown();
                        }
                    });
                    countDownLatch.await();
                } catch (Exception e) {
                    ToastShow.showMsg(mContext, e.getMessage(), handler);
                } finally {
                    ProgressDialogShow.dismissDialog(handler);
                }
            }
        });*/
    }

    private void toMainActivity(String true_name) {
/*        // 初始化融云
        ImPushService.connectionRongYun(mContext, handler);
        // 获取快捷语
        AllRequest.getClientCustom(mContext, handler);*/
        ToastShow.showMsg(mContext, "登录成功", handler);

        // 直接回退到上次的页面
        if (mustLogin) {
            EventBusManager.getInstance().post(new LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
/*            // 登录后判断是否需要弹出首次进入弹窗
            setPageRefresh(MainAppActivityNew.class);
            // 刷新用户个人中心,刷新雇主个人中心
            setPageRefresh(UserMeFragment.class);
            // 刷新任务首页
            setPageRefresh(TaskActivity.class);
            // 登录后消息列表
            setPageRefresh(ImMsgListFragment.class);
            setPageRefresh(UserMainFuliFragment.class);*/

            if ((isFill && isNeedRegisterGuide) || (StringUtils.isNullOrEmpty(true_name))) {
                toRegisterGuidePage();
                return;
            }

            finish();
            return;
        }
        /**
         * 从引导页注册进来自动登录
         */
        if ((isFill && isNeedRegisterGuide) || (StringUtils.isNullOrEmpty(true_name))) {
            toRegisterGuidePage();
            return;
        }

        // 测试重登
        // UserShared.setSessionId(mContext, "");
        DisplayUtil.hideInput(mContext);
        Intent iToUserMain = new Intent(
                this, MainAppActivity.class);
        startActivity(iToUserMain);
        finish();
        overridePendingTransition(0, 0);
    }

    private void getSessionMain() throws Exception {
        String sessionId = UserShared.getSessionId(mContext);
        /*SessionEntity entity = AllRequest.getSession(mContext, handler, sessionId);
        if (!entity.isSucc()) {
            throw new Exception(entity.getAppErrDesc());
        }*/
    }

    private void toRegisterGuidePage() {
        Intent intent = new Intent(mContext, MainAppActivity.class);
        intent.putExtra("isFromRegisterSucc", true);
        mContext.startActivity(intent);
        finish();
        /*executeReq(new AppReqInterfaces() {
            @Override
            public void onPreExecute() throws Exception {

            }

            @Override
            public void doInBackground() throws Exception {
                final RegisterConfigEntity entity = executeReq(ServiceListFinal.shijianke_queryRegistResumeConfig,
                        new JSONObject(), RegisterConfigEntity.class);

                if (!entity.isSucc()) {
                    showMsg(entity.getAppErrDesc());
                    return;
                }

                post(new Runnable() {
                    @Override
                    public void run() {
                        if (entity.resumeInformation.isExhibition == 1) {
                            BaseInfoActivity.launch(mContext, null, true);
                            finish();
                            return;
                        }

                        if (entity.resumeEmployerIntention.isExhibition == 1) {
                            AddIntentionActivity.launch(mContext, null, true);
                            finish();
                            return;
                        }

                        Intent intent = new Intent(mContext, MainAppActivityNew.class);
                        intent.putExtra("isFromRegisterSucc", true);
                        mContext.startActivity(intent);
                        finish();
                    }
                });

            }

            @Override
            public void onPostExecute() throws Exception {

            }

            @Override
            public void onError(String pError) throws Exception {
                post(new Runnable() {
                    @Override
                    public void run() {
                        BaseInfoActivity.launch(mContext, null, true);
                        finish();
                    }
                });
            }
        });*/
    }

    public interface OnFinishListener {
        void onFinish(boolean finish);
    }
}
