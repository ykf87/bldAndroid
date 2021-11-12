package com.jiankang.gouqi.ui.login.activity;

import android.annotation.TargetApi;
import android.content.Intent;
import android.os.Build;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.common.event.LoginEvent;
import com.jiankang.gouqi.entity.LoginEntity;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.main.activity.MainAppActivity;
import com.jiankang.gouqi.util.DisplayUtil;
import com.jiankang.gouqi.util.EventBusManager;
import com.jiankang.gouqi.util.ToastShow;
import com.jiankang.gouqi.util.UserShared;
import com.jiankang.gouqi.widget.LineEditView;
import com.jiankang.gouqi.widget.LineTop;


/**
 * 注册页面
 *
 * @author: ljx
 * @createDate: 2020/6/29 16:58
 */
@TargetApi(Build.VERSION_CODES.JELLY_BEAN)
public class RegisterActivity extends BaseMvpActivity {


    @BindView(R.id.lib_top)
    LineTop libTop;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.edt_name)
    LineEditView edtName;
    @BindView(R.id.ll_name)
    LinearLayout llName;
    @BindView(R.id.edt_phone_username)
    LineEditView edtPhoneUsername;
    @BindView(R.id.edt_vercode_pwd)
    LineEditView edtVercodePwd;
    @BindView(R.id.ll_password)
    LinearLayout llPassword;
    @BindView(R.id.tv_login)
    TextView tvLogin;
    @BindView(R.id.ll_login)
    LinearLayout llLogin;
    @BindView(R.id.sv_login)
    ScrollView svLogin;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_register;
    }

    @Override
    public void initView() {

    }

    @Override
    public void initEvent() {
    }

    @Override
    public void initData() {

    }

    @OnClick(R.id.tv_login)
    public void onClick() {
//        if (edtName.getText().length() == 0) {
//            ToastShow.showMsg(mContext, "请填写名称");
//            return;
//        }
        if (edtPhoneUsername.getText().length() == 0) {
            ToastShow.showMsg(mContext, "请填写账号");
            return;
        }
        if (edtVercodePwd.getText().length() == 0) {
            ToastShow.showMsg(mContext, "请填写密码");
            return;
        }
        register();
    }

    private void register() {
        Map map = new HashMap();
        map.put("name", edtName.getText());
        map.put("phone", edtPhoneUsername.getText());
        map.put("password", edtVercodePwd.getText());
        RetrofitService.postData(mContext, ServiceListFinal.register, map, new OnNetRequestListener<ApiResponse<LoginEntity>>() {
            @Override
            public void onSuccess(ApiResponse<LoginEntity> response) {
                if (response.isSuccess()) {
                    LoginEntity oEntity = response.getData();
                    // 保存登录id
                    UserShared.setUserId(mContext, oEntity.getId() + "");
                    // 保存用户的手机号码
                    UserShared.setUserAccount(mContext, edtPhoneUsername.getText());
                    UserShared.setToken(mContext, oEntity.getToken());
                    UserShared.setAvatar(mContext, oEntity.avatar);
                    UserShared.setName(mContext, oEntity.getNickname());
                    DisplayUtil.hideInput(mContext);
                    UserShared.setJinBi(mContext, 0);
                    EventBusManager.getInstance().post(new LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
                    Intent iToUserMain = new Intent(RegisterActivity.this,
                            MainAppActivity.class);
                    startActivity(iToUserMain);
                    finish();
                    overridePendingTransition(0, 0);
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

}