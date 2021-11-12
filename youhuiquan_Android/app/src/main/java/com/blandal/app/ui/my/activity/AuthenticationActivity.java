package com.blandal.app.ui.my.activity;

import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.common.enums.VerifyStatusEnum;
import com.blandal.app.dialog.CommonDialog;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.ToastShow;
import com.blandal.app.widget.AppBackBar;
import com.blandal.app.widget.LineEditView;


/**
 * 实名认证
 */
public class AuthenticationActivity extends BaseMvpActivity {

    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.edit_name)
    LineEditView editName;
    @BindView(R.id.edit_id_card_no)
    LineEditView editIdCardNo;
    @BindView(R.id.tv_action)
    TextView tvAction;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_authentication;
    }

    /**
     * 是否修改过内容
     * 有修改内容，未保存，退出时显示提示框
     */
    private boolean isModified = false;

    @Override
    public void initView() {
        setEnableGesture(false);
    }

    @Override
    public void initEvent() {

    }


    @Override
    public void initData() {
        editName.getEditText().addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                setActionState();
            }
        });

        editIdCardNo.getEditText().addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                setActionState();
            }
        });
        isModified = false;
    }


    private void setActionState() {
        tvAction.setEnabled(false);
        isModified = true;
        if (TextUtils.isEmpty(editName.getText())) {
            return;
        }

        if (TextUtils.isEmpty(editIdCardNo.getText())) {
            return;
        }
        tvAction.setEnabled(true);
    }


    @Override
    public void finish() {
        DisplayUtil.hideInput(mContext);
        if (isModified) {
            showSaveTipDialog();
        } else {
            AuthenticationActivity.super.finish();
        }
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();

    }

    private void showSaveTipDialog() {
        CommonDialog dialog = CommonDialog.newInstance("您还未提交认证，确认退出吗？", "留在此页", "退出");
        dialog.setOnDialogClickListener(new CommonDialog.OnDialogClickListener() {
            @Override
            public void onStartBtnDefaultCancelClick() {

            }

            @Override
            public void onEndBtnDefaultConfirmClick() {
                DisplayUtil.hideInput(mContext);
                AuthenticationActivity.super.finish();
            }
        });
        dialog.show(getSupportFragmentManager(), "saveTipDialog");
    }

    @Override
    public boolean useEventBus() {
        return true;
    }

    @OnClick(R.id.tv_action)
    public void onClick() {
        if (tvAction.isEnabled()) {
            commitInfo();
        }
    }

    public void commitInfo() {
        Map map = new HashMap();
        map.put("id_card_no", editIdCardNo.getText());
        map.put("true_name", editName.getText());
        RetrofitService.postData(mContext, ServiceListFinal.postAutoVerifyInfo, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    isModified = false;
                    ToastShow.showMsg(mContext, "实名认证成功", handler);
                    UserGlobal.getGlobalConfigInfo().basic_info.verify_status = VerifyStatusEnum.VERIFY_SUCC.getCode();
                    UserGlobal.getGlobalConfigInfo().basic_info.true_name = editName.getText();
                    finish();
                }else {
                    ToastShow.showMsg(response.getMsg());
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }
}