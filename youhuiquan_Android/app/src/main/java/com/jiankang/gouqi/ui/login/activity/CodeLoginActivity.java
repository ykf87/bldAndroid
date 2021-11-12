package com.jiankang.gouqi.ui.login.activity;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.text.TextUtils;
import android.view.View;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.common.enums.LoginTypeEnum;
import com.jiankang.gouqi.common.event.CloseLoginActivty;
import com.jiankang.gouqi.common.event.CodeCountDownEvent;
import com.jiankang.gouqi.common.event.LoginEvent;
import com.jiankang.gouqi.constant.FinalLoginType;
import com.jiankang.gouqi.dialog.ProgressDialogShow;
import com.jiankang.gouqi.entity.LoginEntity;
import com.jiankang.gouqi.interfaces.LineTopInterface;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.HttpUtility;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.login.entity.SessionEntity;
import com.jiankang.gouqi.ui.main.activity.MainAppActivity;
import com.jiankang.gouqi.ui.my.activity.PrivacyPolicyActivity;
import com.jiankang.gouqi.util.DisplayUtil;
import com.jiankang.gouqi.util.EventBusManager;
import com.jiankang.gouqi.util.JsonUtils;
import com.jiankang.gouqi.util.LogUtils;
import com.jiankang.gouqi.util.SystemUtil;
import com.jiankang.gouqi.util.ToastShow;
import com.jiankang.gouqi.util.UmengEventUtils;
import com.jiankang.gouqi.util.UserShared;
import com.jiankang.gouqi.widget.LineTop;
import com.jiankang.gouqi.widget.VerCodeInputView;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.annotations.NonNull;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.functions.Consumer;
import io.reactivex.rxjava3.functions.Function;
import io.reactivex.rxjava3.schedulers.Schedulers;

/**
 * 验证码获取输入页面
 *
 * @author: ljx
 * @createDate: 2020/7/25 15:32
 */
@TargetApi(Build.VERSION_CODES.JELLY_BEAN)
public class CodeLoginActivity extends BaseMvpActivity {

    @BindView(R.id.lib_top)
    LineTop lineTop;
    @BindView(R.id.tv_phone_end)
    TextView tvPhoneEnd;
    @BindView(R.id.tv_get_code)
    TextView tvGetCode;
    @BindView(R.id.tv_second)
    TextView tvSecond;
    @BindView(R.id.tv_code_hint)
    TextView tvCodeHint;

    @BindView(R.id.view_code_input)
    VerCodeInputView mVerCodeInputView;

    private String mPhone;

    /**
     * 必须登录
     */
    private boolean mMustLogin = false;
    /**
     * 倒计时秒钟
     */
    private int mSeconds = 60;

    /**
     * 是否需要自动填写账号进行登录
     */
    private boolean mIsfill;
    /**
     * 是否是账号密码登录 默认是
     */
    private boolean mIsLoginByPsw = true;
    /**
     * 是否需要注册意向引导
     */
    private boolean mIsNeedRegisterGuide;

    private LoginTypeEnum mLoginTypeEnum;

    /**
     * 是否从引导页进入
     */
    private boolean mIsFromGuide;
    /**
     * 是否倒计时
     */
    private boolean mIsCountDown;
    /**
     * 倒计时剩余秒
     */
    private int mCountDown;

    /**
     * 倒计时
     */
    private Runnable msgRunnable = new Runnable() {
        @Override
        public void run() {
            if (mIsCountDown) {
                if (mSeconds < 1) {
                    mSeconds = 60;
                    tvSecond.setVisibility(View.GONE);
                    tvGetCode.setText("重新获取验证码");
                    tvGetCode.setTextColor(ContextCompat.getColor(CodeLoginActivity.this, R.color.colorPrimary));
                    tvCodeHint.setVisibility(View.GONE);
                    mIsCountDown = false;
                    return;
                }
                tvGetCode.setText("秒后可重新获取");
                tvGetCode.setTextColor(ContextCompat.getColor(CodeLoginActivity.this, R.color.text_title_info));
                mSeconds--;
                tvSecond.setVisibility(View.VISIBLE);
                tvSecond.setText(mSeconds + "");
                handler.mPostDelayed(msgRunnable, 1000);
            }

        }
    };
    private boolean mIsAgreementChecked;

    public static void launch(Context context, boolean mustLogin,
                              boolean isfill, String phoneNum,
                              boolean isNeedRegisterGuide, boolean isFromGuide, int countDown) {
        Intent intent = new Intent(context, CodeLoginActivity.class);
        intent.putExtra("MustLogin", mustLogin);
        intent.putExtra("isfill", isfill);
        intent.putExtra("isNeedRegisterGuide", isNeedRegisterGuide);
        intent.putExtra("isFromGuide", isFromGuide);
        intent.putExtra("phone_num", phoneNum);
        intent.putExtra("countdown", countDown);
        context.startActivity(intent);
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_code_login;
    }

    @Override
    public void initView() {
        setEnableGesture(false);
        mPhone = getIntent().getStringExtra("phone_num");
        // 是否必须登录，默认否
        mMustLogin = getIntent().getBooleanExtra("MustLogin", false);

        mIsfill = getIntent().getBooleanExtra("isfill", false);

        mIsAgreementChecked = !UserShared.getIsOnlyBrowser(mContext);

        mIsNeedRegisterGuide = getIntent().getBooleanExtra(
                "isNeedRegisterGuide", false);
        // 是否从引导页进入
        mIsFromGuide = getIntent().getBooleanExtra("isFromGuide", false);
        mCountDown = getIntent().getIntExtra("countdown", 0);

        init();
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {

    }

    @Override
    protected void onResume() {
        super.onResume();
        //getWeiXinToken();
    }


    /**
     * 初始化
     */
    private void init() {
        lineTop.setRtxt("联系客服");
        lineTop.setRtxtLeftImg(R.drawable.ic_communicate);
        lineTop.setLOrRClick(new LineTopInterface.LOrRClick() {
            @Override
            public void rightClick() {
            }

            @Override
            public void leftClick() {
                onBackPressed();
            }
        });

        if (!TextUtils.isEmpty(mPhone)) {
            tvPhoneEnd.setText(mPhone.substring(mPhone.length() - 4, mPhone.length()));
        }
        mVerCodeInputView.setAutoWidth();
        mVerCodeInputView.setOnCompleteListener(new VerCodeInputView.OnCompleteListener() {
            @Override
            public void onComplete(String content) {
                loginMet(mPhone, content);
            }
        });
        if (mCountDown > 0) {
            tvCodeHint.setVisibility(View.VISIBLE);
            mSeconds = mCountDown;
            mIsCountDown = true;
            handler.mPost(msgRunnable);
        } else {
            tvCodeHint.setVisibility(View.GONE);
            getLoginPhoneCode(mPhone);
        }
    }

    private int repeatCount = 0; //重试次数
    private Runnable initUserInfoRunnable = new Runnable() {
        @Override
        public synchronized void run() {
            if (isNotLogin) {
                return;
            }

            //toRegisterGuidePage();
        }
    };

    /**
     * 登录方法
     */
    @SuppressLint("AutoDispose")
    private void loginMet(final String userLoginPhoneStr, final String userPassStr) {
        mLoginTypeEnum = LoginTypeEnum.JianzhiLogin;

        showLoadDialog("登录中...");


        String sendPass = userPassStr;
        boolean isLoginByPsw = false;

        Map<String, String> param = new HashMap<>();
        param.put("username", userLoginPhoneStr);
        param.put("user_type", "2");

        param.put("dynamic_sms_code", sendPass);

        param.put("client_type", "1");
        param.put("client_version", SystemUtil.getVersionNm(mContext));
        param.put("city_id", UserShared.getUserIndexCityId(mContext));
        param.put("push_id", UserShared.getJiGuangPushId(mContext));

        RetrofitService.postData(this, ServiceListFinal.userRegisterLogin, param, new OnNetRequestListener<ApiResponse<LoginEntity>>() {
            @Override
            public void onSuccess(ApiResponse<LoginEntity> response) {
                ProgressDialogShow.dismissDialog(handler);
                mVerCodeInputView.clearContent();
                LoginEntity oEntity = response.getData();
                if (!response.isSuccess()) {
                    UmengEventUtils.pushCommonEvent(mContext,UmengEventUtils.EVENT_GET_CODE_LOGIN_ERR);
                    ToastShow.showMsg(mContext, response.getMsg(), handler);
                    return;
                }
                //用户注册
                if (oEntity.is_register == 1) {
                    /*Map eventRef = new HashMap();
                    eventRef.put("source", "code");
                    AllRequest.uploadDiary(mContext, eventRef, String.valueOf(Constants.REGISTER_EVENT), "CodeLoginActivity");*/
                } else {
                    //验证码登录
                    /*Map eventRef = new HashMap();
                    eventRef.put("source", "code");
                    AllRequest.uploadDiary(mContext, eventRef, String.valueOf(Constants.LOGIN_SUCC), "CodeLoginActivity");*/
                }

                // 保存登录id

                // 保存用户的手机号码
                UserShared.setUserAccount(mContext, userLoginPhoneStr);

                if (isLoginByPsw) {
                    UserShared.setDynamicPassword(mContext, "");
                } else {
                    // 保存下发的动态密码
                    UserShared.setDynamicPassword(mContext,
                            oEntity.dynamic_password);
                }

                // 设置登录类型，账号密码登录
                UserShared.setLoginType(mContext, FinalLoginType.ToUserLogin);

                UserShared.setLoginPass(mContext, userPassStr);


                //记录用户回到首页需不需要协议弹窗
                UserShared.setLoginPopAgreement(mContext, oEntity.is_need_pop);

                callActivityInterface();
                EventBusManager.getInstance().post(new LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
                // 隐藏键盘
                DisplayUtil.hideInput(mContext);
                UmengEventUtils.pushCommonEvent(mContext,UmengEventUtils.EVENT_GET_CODE_SUCC);
            }

            @Override
            public void onFailure(Throwable t) {
                ProgressDialogShow.dismissDialog(handler);
            }
        }, bindAutoDispose());
    }

    /**
     * 跳转到首页
     */
    private void toMainActivity(int is_register, String true_name) {


        ToastShow.showMsg(mContext,"登录成功",handler);
        // 直接回退到上次的页面
        if (mMustLogin) {
            // 登录后判断是否需要弹出首次进入弹窗
            //setPageRefresh(MainAppActivityNew.class);

            // 刷新雇主页面
            // setPageRefresh(EntMainFragment.class);

            // 刷新用户个人中心,刷新雇主个人中心
            //setPageRefresh(UserMeFragment.class);

            // 刷新任务首页
            //setPageRefresh(TaskActivity.class);

            // 登录后消息列表
            //setPageRefresh(ImMsgListFragment.class);
            //setPageRefresh(UserMainFuliFragment.class);

            if ((mIsfill && mIsNeedRegisterGuide)
                    || (is_register == 1)
                    && mLoginTypeEnum == LoginTypeEnum.JianzhiLogin) {
                toRegisterGuidePage();
                return;
            }
            DisplayUtil.hideInput(mContext);
            EventBusManager.getInstance().post(new CloseLoginActivty());
            finish();
            overridePendingTransition(0, 0);

            return;
        }
        /**
         * 从引导页注册进来自动登录
         */
        if ((mIsfill && mIsNeedRegisterGuide)
                || (is_register == 1)
                && mLoginTypeEnum == LoginTypeEnum.JianzhiLogin) {
            toRegisterGuidePage();
            return;
        }

        // 测试重登
        DisplayUtil.hideInput(mContext);
        Intent iToUserMain = new Intent(this,
                MainAppActivity.class);
        startActivity(iToUserMain);
        finish();
        overridePendingTransition(0, 0);
    }


    /**
     * 获取手机验证码
     */
    @SuppressLint("AutoDispose")
    private void getLoginPhoneCode(final String phone) {
        //创建session
        Map<String, String> paramSession = new HashMap<>();
        paramSession.put("sessionId_sjk", "");
        RetrofitService.addCommonParam(this, paramSession);
        final String sessionService = ServiceListFinal.createSession;
        final String codeService = ServiceListFinal.getSmsAuthenticationCode;
        Map<String, String> paramCode = new HashMap<>();
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

                        paramCode.put("phone_num", phone);
                        paramCode.put("opt_type", "7");
                        paramCode.put("user_type", "2");
                        RetrofitService.addCommonParam(CodeLoginActivity.this, paramCode);
                        return RetrofitService.getInstance().getApiService().postData(codeService, paramCode);
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
                            LogUtils.data("请求接口：" + codeService);
                            LogUtils.data("请求数据：" + paramCode.toString());
                            LogUtils.data("返回数据：" + JsonUtils.toJson(apiResponse));
                            LogUtils.data("数据大小：" + apiResponse.toString().length() + " 字节");
                        }

                        closeLoadDialog();
                        if (!apiResponse.isSuccess()) {
                            if (apiResponse.getCode() == ApiResponse.ERR_CODE_FAIL) {
                                mIsCountDown = true;
                                handler.mPost(msgRunnable);
                                ToastShow.showMsg(mContext, apiResponse.getMsg(), handler);
                            }else{
                                mIsCountDown = true;
                                mSeconds = 0;
                                handler.mPost(msgRunnable);
                                ToastShow.showMsg(mContext, apiResponse.getMsg(), handler);
                            }
                            return;
                        }
                        LoginEntity oEntity = RetrofitService.objectToEntity(LoginEntity.class, apiResponse.getData());
                        mIsCountDown = true;
                        handler.mPost(msgRunnable);
                        ToastShow.showMsg(mContext, "验证码已发送，请注意查收", handler);
                    }

                    @Override
                    public void onError(Throwable e) {
                        ProgressDialogShow.dismissDialog(handler);
                    }

                    @Override
                    public void onComplete() {
                    }
                });

        /*showLoadDialog("发送验证码...");
        Map<String, String> param = new HashMap<>();
        param.put("phone_num", phone);
        param.put("opt_type", "7");
        param.put("user_type", "2");
        RetrofitService.postData(this, ServiceListFinal.getSmsAuthenticationCode, param, new OnNetRequestListener<ApiResponse<cc.jianke.zhaiwanzhuan.entity.LoginEntity>>() {
            @Override
            public void onSuccess(ApiResponse<cc.jianke.zhaiwanzhuan.entity.LoginEntity> response) {
                closeLoadDialog();
                LoginEntity oEntity = response.getContent();
                if (!response.isSuccess()) {
                    if (oEntity.getAppErrCode() == ApiResponse.ERR_CODE_FAIL) {
                        mIsCountDown = true;
                        handler.mPost(msgRunnable);
                        ToastShow.showMsg(mContext, oEntity.getAppErrDesc(), handler);
                    }else{
                        mIsCountDown = true;
                        mSeconds = 0;
                        handler.mPost(msgRunnable);
                        ToastShow.showMsg(mContext, oEntity.getAppErrDesc(), handler);
                    }
                    return;
                }
                mIsCountDown = true;
                handler.mPost(msgRunnable);
                ToastShow.showMsg(mContext, "验证码已发送，请注意查收", handler);
            }

            @Override
            public void onFailure(Throwable t) {
                closeLoadDialog();
            }
        }, bindAutoDispose());*/
    }

    /**
     * 捕捉返回键，如果当前显示菜单，刚隐藏
     */
    @Override
    public void onBackPressed() {
        if (mIsCountDown && mSeconds > 0) {
            EventBusManager.getInstance().post(new CodeCountDownEvent(mPhone, mSeconds));
        }
        if (mIsFromGuide) {
            //toMainActivity();
        } else {
            DisplayUtil.hideInput(mContext);
            finish();
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, final Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }


    /**
     * 打开忘记密码页面
     */
    private void openForgetPwdActivity() {
        /*Intent iToForgetPass = new Intent(CLoginActivity.this
                , CForgetPassActivity.class);
        iToForgetPass.putExtra("isFrmLogin", true);
        startActivityForResult(iToForgetPass, FinalActivityReturn.UserForgetPassReturn);*/
    }

    /**
     * 打开登录界面
     */
    public static void openLoginActivity(Context context) {
        Intent intent = new Intent(context, com.jiankang.gouqi.ui.login.activity.CodeLoginActivity.class);
        intent.putExtra("MustLogin", true);
        intent.putExtra("isNeedRegisterGuide", true);
        context.startActivity(intent);
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
                    }
                });
            }
        });*/
    }

    @OnClick({R.id.tv_get_code, R.id.tv_agreement, R.id.tv_policy})
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.tv_get_code:
                if (!mIsCountDown) {
                    tvCodeHint.setVisibility(View.GONE);
                    getLoginPhoneCode(mPhone);
                    UmengEventUtils.pushCommonEvent(mContext,UmengEventUtils.EVENT_GET_CODE);
                }
                break;
            case R.id.tv_agreement:
//                AppUtils.toWap(com.gouqiapp.www.ui.login.activity.CodeLoginActivity.this, ServiceListFinal.userAgreement);
                PrivacyPolicyActivity.launch(mContext,false);
                break;
            case R.id.tv_policy:
//                AppUtils.toWap(com.gouqiapp.www.ui.login.activity.CodeLoginActivity.this, ServiceListFinal.privacyPolicy);
                PrivacyPolicyActivity.launch(mContext,true);
                break;
            default:
                break;
        }
    }

}
