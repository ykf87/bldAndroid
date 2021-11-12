package com.jiankang.gouqi.ui.my.activity;

import android.content.Intent;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.OnClick;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.common.event.LoginEvent;
import com.jiankang.gouqi.dialog.CommonDialog;
import com.jiankang.gouqi.ui.login.activity.ForgetPasswordActivity;
import com.jiankang.gouqi.ui.main.activity.MainAppActivity;
import com.jiankang.gouqi.util.EventBusManager;
import com.jiankang.gouqi.util.LoginUtils;
import com.jiankang.gouqi.util.UserShared;

/**
 * @author: ljx
 * @createDate: 2020/11/19  9:36
 */
public class SettingActivity extends BaseMvpActivity {
    @BindView(R.id.rl_about)
    RelativeLayout rlAbout;
    @BindView(R.id.rl_reset_password)
    RelativeLayout rlResetPassword;
    @BindView(R.id.tv_logout)
    TextView tvLogout;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_setting;
    }

    @Override
    public void initView() {
        if (!UserGlobal.isLogin()){
            tvLogout.setVisibility(View.GONE);
        }else {
            tvLogout.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {

    }

    @OnClick({R.id.rl_about, R.id.tv_logout, R.id.rl_reset_password})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rl_about:
                startActivity(new Intent(SettingActivity.this, AboutActivity.class));
                break;
            case R.id.rl_reset_password:
                startActivity(new Intent(SettingActivity.this, ForgetPasswordActivity.class));
                break;
            case R.id.tv_logout:
                loginOutDialog();
                break;
        }
    }

    private void loginOutDialog() {
        CommonDialog outLoginDialog = CommonDialog.newInstance("提示", "亲，您确定要退出登录么?", "取消", "退出");
        outLoginDialog.setOnDialogClickListener(new CommonDialog.OnDialogClickListener() {
            @Override
            public void onStartBtnDefaultCancelClick() {

            }

            @Override
            public void onEndBtnDefaultConfirmClick() {
//                        MyRongClient.getMyRClient().disConnect();
                LoginUtils.userExit(mContext);
                logout();
                Intent toLogin = new Intent(mContext, MainAppActivity.class);
                toLogin.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                toLogin.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                EventBusManager.getInstance().post(new LoginEvent(LoginEvent.LOGIN_TYPE_LOGINOUT));
                startActivity(toLogin);
                finish();
            }
        });
        outLoginDialog.show(getSupportFragmentManager(), "dialog_out_login");
    }

    private void logout() {
        UserShared.setToken(mContext,"");
//        RetrofitService.getData(this, ServiceListFinal.logout, null, new OnNetRequestListener<ApiResponse<Void>>() {
//            @Override
//            public void onSuccess(ApiResponse<Void> response) {
//                if (response.isSuccess()) {
//                }
//            }
//
//            @Override
//            public void onFailure(Throwable t) {
//            }
//        }, bindAutoDispose());
    }
}
