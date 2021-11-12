package com.blandal.app.ui.my.activity;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.bigkoo.pickerview.listener.OnOptionsSelectListener;
import com.jakewharton.rxbinding4.widget.RxTextView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.ui.login.entity.LoginEntity;
import com.blandal.app.ui.my.contract.BindZhiFuBaoContract;
import com.blandal.app.ui.my.entity.BankDemo;
import com.blandal.app.ui.my.presenter.BindZhiFuBaoPresenter;
import com.blandal.app.util.PickerUtils.PickerUtils;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UserShared;
import com.blandal.app.widget.AppBackBar;
import com.blandal.app.widget.LineEditView;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.functions.Consumer;
import io.reactivex.rxjava3.functions.Function3;

import static com.blandal.app.common.enums.OptTypeEnum.BINDING_ALIPAY;

/**
 * @author: ljx
 * @createDate: 2020/12/03  18:36
 */
public class BindZhiFuBaoActivity extends BaseMvpActivity<BindZhiFuBaoPresenter> implements BindZhiFuBaoContract.BindZhiFuBaoView {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.edt_username)
    LineEditView edtUsername;
    @BindView(R.id.edt_account)
    LineEditView edtAccount;
    @BindView(R.id.edt_code)
    LineEditView edtCode;
    @BindView(R.id.edt_bank)
    LineEditView edtBank;
    @BindView(R.id.tv_phone_tip)
    TextView tvPhoneTip;
    @BindView(R.id.btn_bind)
    Button btnBind;
    @BindView(R.id.ll_select)
    LinearLayout llSelect;
    @BindView(R.id.tv_bank)
    TextView tvBank;
    String phone;//用户手机号
    /**
     * 倒计时秒钟
     */
    int seconds = 60;
    public boolean isApliyBind;//是否绑定过银行卡
    private List<BankDemo> banList = new ArrayList<>();
    private List<String> banString = new ArrayList<>();
    private String selBank = "";
    private String banks[] = {"中国银行", "中国建设银行", "中国工商银行", "中国农业银行", "中国农商银行"
            , "平安银行", "交通银行", "中国民生银行", "招商银行"};


    public static void launch(Context context, boolean isApliyBind) {
        Intent intent = new Intent(context, BindZhiFuBaoActivity.class);
        intent.putExtra("isApliyBind", isApliyBind);
        context.startActivity(intent);
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_bind_zhi_fu_bao;
    }

    @Override
    public void initView() {
        for (String bank : banks) {
            banString.add(bank);
        }
        isApliyBind = getIntent().getBooleanExtra("isApliyBind", false);
        if (isApliyBind) {
            btnBind.setText("换绑");
            appBackBar.setTitle("换绑银行卡");
        } else {
            btnBind.setText("绑定");
        }
        mPresenter = new BindZhiFuBaoPresenter(this);
    }


    private void selectBank() {
        PickerUtils.openNPicker(mContext, "", 0, banString, new OnOptionsSelectListener() {
            @Override
            public void onOptionsSelect(int options1, int options2, int options3, View v) {
                if (options1 > banList.size()) {
                    options1 = 0;
                }
                selBank = banString.get(options1);
                tvBank.setText(banString.get(options1));
            }
        });
    }

    @Override
    public void initEvent() {
        llSelect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                selectBank();
            }
        });

        Observable
                .combineLatest(RxTextView.textChanges(edtUsername.getEditText()),
                        RxTextView.textChanges(edtAccount.getEditText()),
                        RxTextView.textChanges(edtBank.getEditText()),
                        new Function3<CharSequence, CharSequence, CharSequence, Boolean>() {
                            @Override
                            public Boolean apply(CharSequence charSequence, CharSequence charSequence2, CharSequence charSequence3) throws Throwable {
                                return charSequence.length() > 0 && charSequence2.length() > 0 && charSequence3.length() > 0;
                            }
                        })
                .to(bindAutoDispose())
                .subscribe(new Consumer<Boolean>() {
                    @Override
                    public void accept(Boolean b) throws Exception {
                        btnBind.setEnabled(b);
                    }
                });

        // 用户手机号码
        edtCode.setOnRightClickListener(new LineEditView.RightOnClickListener() {

            @Override
            public void OnRightClickListener() {

                if (seconds != 60) {
                    return;
                }
                getPhoneCode();
            }
        });
    }

    /**
     * 获取手机验证码
     */
    private void getPhoneCode() {
        if (StringUtils.isNullOrEmpty(phone)) {
            return;
        }
        showLoadDialog("验证码发送中...");
        Map map = new HashMap();
        map.put("phone_num", phone);
        map.put("opt_type", BINDING_ALIPAY.getCode());
        map.put("user_type", "2");
        mPresenter.getCode(map, mContext);
    }

    @Override
    public void getCodeSucc() {
        closeLoadDialog();
        handler.mPost(msgRunnable);
        ToastShow.showMsg("验证码已发送，请注意查收");
        tvPhoneTip.setText("短信接收手机号：" + phone + "（即为当前账号的注册号码）");
    }

    @Override
    public void getCodeFail(String errMsg) {
        closeLoadDialog();
        ToastShow.showMsg(errMsg);
    }

    /**
     * 倒计时
     */
    Runnable msgRunnable = new Runnable() {
        @Override
        public void run() {
            if (seconds < 1) {
                seconds = 60;
                edtCode.setRightText("获取验证码");
                return;
            }
            seconds--;
            edtCode.setRightText(seconds + "秒后重试");
            handler.mPostDelayed(msgRunnable, 1000);
        }
    };

    @Override
    protected void onResume() {
        super.onResume();

    }

    @Override
    public void initData() {
    }

    @Override
    public void binZhiFuBaoSucc() {
        ToastShow.showMsg("银行卡绑定成功");
        finish();
    }

    @Override
    public void binZhiFuBaoFail(String errMsg) {
        ToastShow.showMsg(errMsg);
    }


    @OnClick(R.id.btn_bind)
    public void onClick() {
        if (StringUtils.isNullOrEmpty(selBank)) {
            ToastShow.showMsg("请选择所属银行");
            return;
        }
        //“alipay_user_true_name”://银行卡账号所属人姓名
        //“alipay_user_name”: // 银行卡账号名
        // “dynamic_sms_code”：// 动态验证码
        Map map = new HashMap();
        map.put("name", edtUsername.getText());
        map.put("telphone", edtAccount.getText());
        map.put("type", selBank);
        map.put("number", edtBank.getText());
        if (isApliyBind) {
            LoginEntity.BankEntity bankInfo = UserShared.getBankEntity();
            if (bankInfo != null){
            map.put("id", bankInfo.id);
            }
        }
        mPresenter.bindZhiFuBao(map, mContext);
    }
}
