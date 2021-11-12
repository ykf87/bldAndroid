package com.blandal.app.ui.my.activity;

import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.common.event.SetUserInfoEvent;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.my.entity.MyZhaiTaskEntiy;
import com.blandal.app.util.EventBusManager;
import com.blandal.app.widget.AppBackBar;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.ToastShow;

/**
 * @author: ljx
 * @createDate: 2020/11/19  9:36
 */
public class SetUserNameActivity extends BaseMvpActivity {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.et_user_name)
    EditText etUserName;
    @BindView(R.id.iv_del_content)
    ImageView ivDelContent;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_set_user_name;
    }

    @Override
    public void initView() {
        if (UserGlobal.mGlobalConfigInfo != null) {
            String trueName = UserGlobal.mGlobalConfigInfo.basic_info.true_name;
            if (StringUtils.isNotNullOrEmpty(trueName)) {
                etUserName.setText(trueName);
            }
        }
        appBackBar.setRtxtVisibility(View.VISIBLE);
        appBackBar.setRtxtText("保存");
        appBackBar.setRtxtColor(getResources().getColor(R.color.color_black_ff333333));
        appBackBar.setOnBarEndTextClickListener(new AppBackBar.OnBarClickListener() {
            @Override
            public void onClick() {
                String userName = etUserName.getText().toString();
                if (!StringUtils.isNotNullOrEmpty(userName)) {
                    ToastShow.showLongMsg(mContext, "请输入你的昵称");
                } else if (userName.length() < 2) {
                    ToastShow.showLongMsg(mContext, "昵称须2-5个字符");
                } else {
                    updateName();
                }
            }
        });

        etUserName.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View view, boolean b) {
                if (b) {
                    ivDelContent.setVisibility(View.VISIBLE);
                } else {
                    ivDelContent.setVisibility(View.GONE);
                }
            }
        });
        etUserName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                if (charSequence.length() > 0) {
                    ivDelContent.setVisibility(View.VISIBLE);
                } else {
                    ivDelContent.setVisibility(View.GONE);
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {

    }

    private void updateName() {
        Map map = new HashMap<>();
        map.put("true_name", etUserName.getText().toString());
        RetrofitService.postData(mContext, ServiceListFinal.postResumeInfo, map, new OnNetRequestListener<ApiResponse<MyZhaiTaskEntiy>>() {
            @Override
            public void onSuccess(ApiResponse<MyZhaiTaskEntiy> response) {
                if (response.isSuccess()) {
                    EventBusManager.getInstance().post(new SetUserInfoEvent());
                    UserGlobal.mGlobalConfigInfo.basic_info.true_name = etUserName.getText().toString();
                    ToastShow.showMsg(mContext, "修改成功", handler);
                    finish();
                } else {
                    ToastShow.showMsg(mContext, response.getMsg(), handler);
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

    @OnClick(R.id.iv_del_content)
    public void onClick() {
        etUserName.setText("");
    }


}
