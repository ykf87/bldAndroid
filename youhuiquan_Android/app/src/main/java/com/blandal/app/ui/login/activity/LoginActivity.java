package com.blandal.app.ui.login.activity;

import android.animation.ObjectAnimator;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.view.View;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.blandal.app.ui.my.activity.PrivacyPolicyActivity;
import com.jakewharton.rxbinding4.widget.RxTextView;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.enums.LoginTypeEnum;
import com.blandal.app.common.event.LoginEvent;
import com.blandal.app.constant.FinalLoginType;
import com.blandal.app.interfaces.LineTopInterface;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.ui.login.contract.LoginContract;
import com.blandal.app.ui.login.entity.LoginEntity;
import com.blandal.app.ui.login.entity.SessionEntity;
import com.blandal.app.ui.login.presenter.LoginPresenter;
import com.blandal.app.ui.main.activity.MainAppActivity;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.EventBusManager;
import com.blandal.app.util.KeyBoardHelper;
import com.blandal.app.util.LogUtils;
import com.blandal.app.util.SYUtils;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UserShared;
import com.blandal.app.widget.LineEditView;
import com.blandal.app.widget.LineTop;
import com.blandal.app.widget.OnlyCheckBox;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.functions.BiFunction;
import io.reactivex.rxjava3.functions.Consumer;

/**
 * 登录页面
 *
 * @author: ljx
 * @createDate: 2020/6/29 16:58
 */
@TargetApi(Build.VERSION_CODES.JELLY_BEAN)
public class LoginActivity extends BaseMvpActivity<LoginPresenter> implements LoginContract.View {

    @BindView(R.id.tv_new_account)
    TextView tvNewAccount;
    @BindView(R.id.edt_phone_username)
    LineEditView editUserLoginPhone;
    @BindView(R.id.ll_password)
    LinearLayout llPassword;
    @BindView(R.id.edt_vercode_pwd)
    LineEditView editUserPass;
    @BindView(R.id.edt_verification_code)
    LineEditView edt_phoneCode;
    @BindView(R.id.tv_login)
    TextView tvLogin;
    @BindView(R.id.ll_agreement)
    LinearLayout llAgreement;
    @BindView(R.id.cb_agreement)
    OnlyCheckBox cbAgreement;
    @BindView(R.id.tv_lose_code)
    TextView tvLoseCode;
    @BindView(R.id.lib_top)
    LineTop lineTop;
    @BindView(R.id.ll_one_key_login)
    LinearLayout llOneKeyLogin;
    @BindView(R.id.ll_code_login)
    LinearLayout llCodeLogin;
    @BindView(R.id.iv_code_login)
    ImageView ivCodeLogin;
    @BindView(R.id.tv_code_login)
    TextView tvCodeLogin;
    @BindView(R.id.tv_reg_hint)
    TextView tvRegHint;
    @BindView(R.id.tv_agreement)
    TextView tvAgreement;
    @BindView(R.id.tv_policy)
    TextView tvPolicy;
    @BindView(R.id.ll_login)
    LinearLayout rlLogin;
    @BindView(R.id.sv_login)
    ScrollView svLogin;
    @BindView(R.id.tv_onekey_login)
    TextView tvOnekeyLogin;

    public static final int LOGIN_TYPE_PASSWORD = 1;
    public static final int LOGIN_TYPE_CODE = 2;

    /**
     * 必须登录
     */
    private int mLoginType = LOGIN_TYPE_PASSWORD;

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
    private boolean mIsFill;
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
    private int mKeyBoardMoveHeight;

    private boolean isAgreementChecked;

    public static void launch(Context context, boolean mustLogin,
                              boolean isfill, String phoneNum, String password,
                              boolean isNeedRegisterGuide, boolean isFromGuide) {
        Intent intent = new Intent(context, LoginActivity.class);
        intent.putExtra("MustLogin", mustLogin);
        intent.putExtra("isfill", isfill);
        intent.putExtra("isNeedRegisterGuide", isNeedRegisterGuide);
        intent.putExtra("isFromGuide", isFromGuide);
        intent.putExtra("phone_num", phoneNum);
        intent.putExtra("password", password);
        context.startActivity(intent);
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_login;
    }

    @Override
    public void initView() {
        mPresenter = new LoginPresenter(this);
        // 是否必须登录，默认否
        mMustLogin = getIntent().getBooleanExtra("MustLogin", false);

        mIsFill = getIntent().getBooleanExtra("isfill", false);

        isAgreementChecked = !UserShared.getIsOnlyBrowser(mContext);

        mIsNeedRegisterGuide = getIntent().getBooleanExtra(
                "isNeedRegisterGuide", false);
        // 是否从引导页进入
        mIsFromGuide = getIntent().getBooleanExtra("isFromGuide", false);
        init();
    }

    @Override
    public void initEvent() {
        Observable.combineLatest(RxTextView.textChanges(editUserLoginPhone.getEditText()), RxTextView.textChanges(editUserPass.getEditText()), new BiFunction<CharSequence, CharSequence, Boolean>() {
            @Override
            public Boolean apply(CharSequence phone, CharSequence pwd) throws Throwable {
                if (mLoginType == LOGIN_TYPE_PASSWORD) {
                    return phone.length() != 0 && pwd.length() != 0;
                } else {
                    return phone.length() != 0;
                }
            }
        }).to(bindAutoDispose())
                .subscribe(new Consumer<Boolean>() {
                    @Override
                    public void accept(Boolean enabled) throws Throwable {
                        tvLogin.setEnabled(enabled);
                    }
                });
    }

    @Override
    public void initData() {

    }

    @Override
    protected void onResume() {
        super.onResume();
        //getWeiXinToken();
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        mIsFill = getIntent().getBooleanExtra("isfill", false);
        if (mIsFill) {
            mIsLoginByPsw = true;
            String phoneStr = getIntent().getStringExtra("phone_num");
            String passStr = getIntent().getStringExtra("password");
            loginMet(phoneStr, passStr);
        }
    }


    /**
     * 初始化
     */
    private void init() {
        if (mLoginType == LOGIN_TYPE_PASSWORD) {
            tvRegHint.setVisibility(View.GONE);
        } else {
            tvRegHint.setVisibility(View.VISIBLE);
        }
        cbAgreement.setChecked(isAgreementChecked);
        lineTop.setTopStyle(R.drawable.icon_black_close, 0, "");
        lineTop.setLOrRClick(new LineTopInterface.LOrRClick() {
            @Override
            public void rightClick() {
            }

            @Override
            public void leftClick() {
                onBackPressed();
            }
        });

        editUserLoginPhone.setOnHDClickListener(new LineEditView.HdOnClickListener() {

            @Override
            public void OnHdClickListener() {

            }
        });

        // 获取上一次用户登录的账号
        String userPhone = UserShared.getUserAccount(mContext);

        if (!DisplayUtil.isNullOrEmpty(userPhone)) {
            editUserLoginPhone.setText(userPhone);
        }

        if (mIsFill) {
            String phoneStr = getIntent().getStringExtra("phone_num");
            String passStr = getIntent().getStringExtra("password");
            loginMet(phoneStr, passStr);
        }

        mLoginType = getIntent().getIntExtra("LoginType", LOGIN_TYPE_PASSWORD);
        loginPassword();
        moveKeyBoard();
    }

    /**
     * 登录方法
     */
    private void loginMet(final String userLoginPhoneStr, final String userPassStr) {

        if (userLoginPhoneStr.length() == 0) {
            ToastShow.showMsg(mContext, "请填写账户");
            return;
        }
        if (mIsLoginByPsw) {
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

        mLoginTypeEnum = LoginTypeEnum.JianzhiLogin;

        showLoadDialog("登录中...");

        mPresenter.userLogin(this, mIsLoginByPsw, userLoginPhoneStr, "2", userPassStr);

    }


    /**
     * 捕捉返回键，如果当前显示菜单，刚隐藏
     */
    @Override
    public void onBackPressed() {
        if (mIsFromGuide) {
            //toMainActivity();
        } else {
            DisplayUtil.hideInput(mContext);
            finish();
        }
    }


    @OnClick({R.id.tv_register, R.id.tv_login, R.id.img_qq_login, R.id.img_weibo_login, R.id.img_wechat_login,
            R.id.tv_policy, R.id.tv_agreement, R.id.tv_lose_code, R.id.ll_one_key_login, R.id.ll_code_login, R.id.tv_new_account, R.id.tv_onekey_login})
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.ll_one_key_login:
            case R.id.tv_onekey_login:
                if (1022 != SYUtils.SY_PRE_CODE) {
                    showMsg("一键登录失败，请使用其他方式登录");
                    return;
                }
                if (getIntent().getBooleanExtra(
                        "isFromOneKeyLogin", false)) {
                    finish();
                    return;
                }
                OneKeyLoginActivity.launch(mContext, mMustLogin, mIsFill,
                        mIsFromGuide, mIsNeedRegisterGuide);
                finish();
                break;
            case R.id.tv_register:
                /*Intent iToRegistration = new Intent(CLoginActivity.this,
                        CRegistrationActivity.class);
                startActivity(iToRegistration);*/
                break;
            case R.id.tv_login:
                mIsLoginByPsw = true;
                String userLoginPhoneStr = editUserLoginPhone.getText();
                String passStr = editUserPass.getText();
                String codeStr = edt_phoneCode.getText();
                loginMet(userLoginPhoneStr, mIsLoginByPsw ? passStr : codeStr);
                break;
            case R.id.tv_new_account:
                Intent intent = new Intent(LoginActivity.this, RegisterActivity.class);
                mContext.startActivity(intent);
                break;
            case R.id.tv_policy:
//                AppUtils.toWap(this, ServiceListFinal.privacyPolicy);
                PrivacyPolicyActivity.launch(mContext,true);
                break;
            case R.id.tv_agreement:
//                AppUtils.toWap(this, ServiceListFinal.userAgreement);
                PrivacyPolicyActivity.launch(mContext,false);
                break;
            case R.id.tv_lose_code:
                ForgetPasswordActivity.launch(this, false);
                break;
            default:
                break;
        }
    }


    /**
     * 跳转到首页
     */
    private void toMainActivity() {
        // 直接回退到上次的页面
        if (mMustLogin) {
            finish();
            return;
        }
        DisplayUtil.hideInput(mContext);
        Intent iToUserMain = new Intent(LoginActivity.this,
                MainAppActivity.class);
        startActivity(iToUserMain);
        finish();
        overridePendingTransition(0, 0);
    }


    private void doLoginSucc(LoginEntity oEntity) {
        String userLoginPhoneStr = editUserLoginPhone.getText();
        String passStr = editUserPass.getText();
        String codeStr = edt_phoneCode.getText();
        String userPassStr = mIsLoginByPsw ? passStr : codeStr;


        // 保存用户的手机号码
        UserShared.setUserAccount(mContext, userLoginPhoneStr);

        UserShared.setToken(mContext, oEntity.getToken());
        UserShared.setName(mContext, oEntity.getNickname());
        UserShared.setLoginPass(mContext, userPassStr);
        UserShared.setAvatar(mContext, oEntity.avatar);
        UserShared.setJinBi(mContext, oEntity.getJifen());
        if (oEntity.getBank() != null) {
            UserShared.setBankEntity(oEntity.getBank());
            UserShared.setBankId(mContext, oEntity.getBank().getId());
        }

        try {
            // 设置登录类型，账号密码登录
            UserShared.setLoginType(mContext, FinalLoginType.ToUserLogin);
            callActivityInterface();
            EventBusManager.getInstance().post(new LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
            handler.mPost(new Runnable() {
                @Override
                public void run() {
                    // 隐藏键盘
                    DisplayUtil.hideInput(mContext);

                    toMainActivity();
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void getSessionSucc(ApiResponse<SessionEntity> response) {

    }

    @Override
    public void getSessionFail() {

    }

    @Override
    public void userLoginSucc(ApiResponse<LoginEntity> response) {
        closeLoadDialog();
        if (response.getCode() == ApiResponse.ERR_CODE_SUCC) {
            doLoginSucc(response.getData());
        } else {
            ToastShow.showMsg(mContext, response.getMsg(), handler);
        }
    }

    @Override
    public void userLoginFail() {
        closeLoadDialog();
        ToastShow.showLongMsg(mContext, "登录失败", handler);
    }

    /**
     * 密码登录
     */
    private void loginPassword() {
        mLoginType = LOGIN_TYPE_PASSWORD;
        if (mLoginType == LOGIN_TYPE_PASSWORD) {
            tvRegHint.setVisibility(View.GONE);
        } else {
            tvRegHint.setVisibility(View.VISIBLE);
        }
        editUserLoginPhone.setText(editUserLoginPhone.getText());//判断登录按钮是否能点击
        tvNewAccount.setVisibility(View.VISIBLE);
        llPassword.setVisibility(View.VISIBLE);
        tvLogin.setText("登录");
        llAgreement.setVisibility(View.GONE);
        tvLoseCode.setVisibility(View.VISIBLE);
        ivCodeLogin.setImageResource(R.drawable.ic_login_mobile);
        tvCodeLogin.setText("验证码登录");
    }

    private void moveKeyBoard() {
        KeyBoardHelper keyBoardHelper = new KeyBoardHelper(this);
        keyBoardHelper.setOnKeyBoardStatusChangeListener(new KeyBoardHelper.OnKeyBoardStatusChangeListener() {
            @Override
            public void OnKeyBoardPop(int keyBoardHeight) {
                LogUtils.data(keyBoardHeight + "--open");
                int[] viewLocation = new int[2];
                int height = 0;
                //获取该控价在屏幕中的位置（左上角的点）
                if (tvLogin != null) {
                    tvLogin.getLocationOnScreen(viewLocation);
                    height = tvLogin.getHeight();
                }
                int loginViewtoBottom = DisplayUtil.getScreenHeight() - viewLocation[1] - height;
                if (keyBoardHeight > loginViewtoBottom && rlLogin != null) {
                    mKeyBoardMoveHeight = keyBoardHeight - loginViewtoBottom;
                    ObjectAnimator animatorUp = ObjectAnimator.ofFloat(rlLogin, "translationY", 0, -mKeyBoardMoveHeight);
                    animatorUp.setDuration(360);
                    animatorUp.setInterpolator(new AccelerateDecelerateInterpolator());
                    animatorUp.start();
                }

            }

            @Override
            public void OnKeyBoardClose(int oldKeyBoardHeight) {
                LogUtils.data(oldKeyBoardHeight + "--close");
                int[] viewLocation = new int[2];
                if (mKeyBoardMoveHeight > 0) {
                    ObjectAnimator animatorDown = ObjectAnimator.ofFloat(rlLogin, "translationY", -mKeyBoardMoveHeight, 0);
                    animatorDown.setDuration(360);
                    animatorDown.setInterpolator(new AccelerateDecelerateInterpolator());
                    animatorDown.start();
                    mKeyBoardMoveHeight = 0;
                }
            }
        });
    }

    @Override
    public boolean useEventBus() {
        return true;
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void loginEventBus(LoginEvent event) {
        if (event.getLogin() == LoginEvent.LOGIN_TYPE_REG_RELOGIN) {
            mIsLoginByPsw = true;
            String phoneStr = event.getPhone();
            String passStr = event.getPassword();
            loginMet(phoneStr, passStr);
        }
    }

}
