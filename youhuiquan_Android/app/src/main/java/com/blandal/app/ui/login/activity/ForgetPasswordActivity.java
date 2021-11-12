package com.blandal.app.ui.login.activity;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.interfaces.LineTopInterface;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.main.entity.ArticleDetailEntity;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.LoginUtils;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UserShared;
import com.blandal.app.util.coder.HexUtil;
import com.blandal.app.util.coder.RSACoder;
import com.blandal.app.widget.LineEditView;
import com.blandal.app.widget.LineTop;

import static com.blandal.app.common.enums.OptTypeEnum.RESET_MONEYBAG_PASSWORD;

/**
 * 忘记密码 与钱袋子共用
 *
 * @author: ljx
 * @createDate: 2020/7/25 17:37
 */
public class ForgetPasswordActivity extends BaseMvpActivity {
    @BindView(R.id.lib_top)
    LineTop lineTop;
    @BindView(R.id.edt_phone_username)
    LineEditView edtPhone;
    @BindView(R.id.edt_vercode)
    LineEditView edtPhoneCode;
    @BindView(R.id.edt_old_password)
    LineEditView edtOldword;
    @BindView(R.id.edt_new_password)
    LineEditView edtNewPassword;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_confirm)
    TextView tvConfirm;
    @BindView(R.id.tv_tail_phone)
    TextView tvTailPhone;

    /**
     * 倒计时秒钟
     */
    int seconds = 60;

    /**
     * 发送验证码的手机号
     */
    String sendPhone;

    /**
     * 是否是雇主登录
     */
    boolean isEntLogin;
    /**
     * 是不是钱袋子修改密码
     **/
    boolean isPackage;

    public static void launch(Context context, boolean isPackage) {
        Intent intent = new Intent(context, com.blandal.app.ui.login.activity.ForgetPasswordActivity.class);
        intent.putExtra("isPackage", isPackage);
        context.startActivity(intent);
    }

    /**
     * 倒计时
     */
    Runnable msgRunnable = new Runnable() {
        @Override
        public void run() {
            if (seconds < 1) {
                seconds = 60;
                edtPhoneCode.setRightText("获取验证码");
                return;
            }
            seconds--;
            edtPhoneCode.setRightText(seconds + "秒后重试");
            handler.mPostDelayed(msgRunnable, 1000);
        }
    };

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_forget_password;
    }


    @Override
    public void initData() {
        if (LoginUtils.isEntLogin(mContext)) {
            isEntLogin = true;
        } else if (LoginUtils.isUserLogin(mContext)) {
            isEntLogin = false;
        }
    }

    @Override
    public void initView() {
        isPackage = getIntent().getBooleanExtra("isPackage", false);

        LineTop lineTop = (LineTop) findViewById(R.id.lib_top);
        if (isPackage) {
            tvTitle.setText("重置钱袋子密码");
            lineTop.setTitle("钱袋子");
            lineTop.setRtxt("联系客服");
            lineTop.setRtxtLeftImg(R.drawable.iv_contact);
            tvTailPhone.setText("请输入手机号、新密码、短信验证码");
        } else {
            tvTitle.setText("重置密码");
        }
        lineTop.setLOrRClick(new LineTopInterface.LOrRClick() {
            @Override
            public void rightClick() {
            }

            @Override
            public void leftClick() {
                DisplayUtil.hideInput(mContext);
                finish();
            }
        });

        // 用户手机号码
        edtPhoneCode.setOnRightClickListener(new LineEditView.RightOnClickListener() {

            @Override
            public void OnRightClickListener() {
                String phone = edtPhone.getText();
                if (!DisplayUtil.isMobile(phone)) {
                    ToastShow.showMsg(mContext, "请输入11位有效手机号码");
                    return;
                }
                if (isPackage) {
                    if (!phone.equals(UserGlobal.mGlobalConfigInfo.basic_info.telphone)) {
                        ToastShow.showMsg(mContext, "请输入当前账号的手机号");
                        return;
                    }
                }
                if (seconds != 60) {
                    return;
                }
                getPhoneCode(phone);
            }
        });
        if (isPackage) {
            if (UserGlobal.mGlobalConfigInfo != null) {
                edtPhone.setText(UserGlobal.mGlobalConfigInfo.basic_info.telphone);
            }
            edtPhoneCode.setDigits(null, 6);
            edtPhoneCode.setHint("请输入验证码");
            edtPhoneCode.setDigits2(getString(R.string.pwd_format_onlynum));
            edtNewPassword.setDigits(null, 6);
            edtNewPassword.setDigits2(getString(R.string.pwd_format_onlynum));
        } else {
//            edt_pass.setDigits(getString(R.string.pwd_format), 32);
            edtPhoneCode.setDigits("", 32);
        }
    }

    @Override
    public void initEvent() {
        edtNewPassword.setAddTextChangedListener(new LineEditView.AddTextChangedListener() {
            @Override
            public void onTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
                if (arg0.length() > 0) {
                    tvConfirm.setEnabled(true);
                } else {
                    tvConfirm.setEnabled(false);
                }
            }
        });
    }

    /**
     * 获取手机验证码
     */
    private void getPhoneCode(final String phone) {
        showLoadDialog("发送验证码...");
        Map map = new HashMap();
        map.put("phone_num", phone);
        map.put("opt_type", RESET_MONEYBAG_PASSWORD.getCode());
        map.put("user_type", "2");
        getCode(map);
    }

    /**
     * 找回密码
     */
    private void forgetPassMet() {

        final String edt_phoneStr = edtPhone.getText();
        final String edtOldStr = edtOldword.getText();
        String edt_passStr = edtNewPassword.getText().toString().trim();

        if (edt_phoneStr.length() == 0) {
            ToastShow.showMsg(mContext, "请输入用户名");
            return;
        } else if (edtOldStr.length() < 6) {
            ToastShow.showMsg(mContext, "请正确输入原始密码");
            return;
        } else if (edt_passStr.length() < 6) {
            ToastShow.showMsg(mContext, "新的密码长度不小于6位");
            return;
        }
        showLoadDialog("请稍等...");
        setPassword(edt_phoneStr,edtOldStr,edt_passStr);
    }
    private void setPassword(String edt_phoneStr,String edtOldStr,String edt_passStr) {
        Map<String, String> map = new HashMap<>();
        map.put("username", edt_phoneStr);
        map.put("password", edtOldStr);
        map.put("newpwd", edt_passStr);
        RetrofitService.postData(mContext, ServiceListFinal.reset, map, new OnNetRequestListener<ApiResponse<ArticleDetailEntity>>() {
            @Override
            public void onSuccess(ApiResponse<ArticleDetailEntity> response) {
                if (response.isSuccess()) {
                    ToastShow.showMsg("密码重置成功");
                    finish();
                    return;
                 }
                ToastShow.showMsg(response.getMsg());
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                ToastShow.showMsg(t.getMessage());
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }

    /**
     * 找回密码
     */
    private void forgetPackeagePassMet() {

        final String edt_phoneStr = edtPhone.getText();
        final String edt_phoneCodeStr = edtPhoneCode.getText();
        final String edt_passStr = edtNewPassword.getText();

        if (!DisplayUtil.isMobile(edt_phoneStr)) {
            ToastShow.showMsg(mContext, "请正确输入手机号码");
            return;
        } else if (edt_phoneCodeStr.length() != 6) {
            ToastShow.showMsg(mContext, "请正确输入验证码");
            return;
        } else if (edt_passStr.length() < 6) {
            ToastShow.showMsg(mContext, "请正确输入6位密码");
            return;
        }
        String modulus = UserShared.getPubkeyModulus(mContext);
        String exponent = UserShared.getPubkeyExp(mContext);
        String encryptPwd = "";
        try {
            encryptPwd = HexUtil.bytesToHexString(RSACoder
                    .encryptByPublicKey(edt_passStr, modulus, exponent));
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map map = new HashMap();
        map.put("phone_num", edt_phoneStr);
        map.put("password", encryptPwd);
        map.put("sms_authentication_code", edt_phoneCodeStr);
        showLoadDialog("请稍等...");
        resetMoneyBagPassword(map);
    }

    private void resetMoneyBagPassword(Map map) {
        RetrofitService.postData(this, ServiceListFinal.resetMoneyBagPassword, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    ToastShow.showMsg("重置密码成功");
                    finish();
                } else {
                    ToastShow.showMsg(response.getMsg());
                }
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                ToastShow.showMsg(t.getMessage());
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }

    private void getCode(Map map) {
        RetrofitService.postData(this, ServiceListFinal.getSmsAuthenticationCode, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    handler.mPost(msgRunnable);
                    ToastShow.showMsg("验证码已发送，请注意查收");
                } else {
                    ToastShow.showMsg(response.getMsg());
                }
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                ToastShow.showMsg(t.getMessage());
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        // 取消验证码倒计时
        handler.removeCallbacks(msgRunnable);

    }

    @OnClick({R.id.tv_confirm})
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.tv_confirm:
                if (isPackage) {
                    forgetPackeagePassMet();
                } else {
                    forgetPassMet();
                }
                break;
            default:
                break;
        }
    }
}
