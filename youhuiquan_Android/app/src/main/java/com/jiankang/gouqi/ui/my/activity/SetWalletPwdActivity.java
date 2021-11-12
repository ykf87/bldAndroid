package com.jiankang.gouqi.ui.my.activity;

import android.text.TextUtils;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import com.jakewharton.rxbinding4.widget.RxTextView;


import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.ui.my.contract.SetWalletPwdContract;
import com.jiankang.gouqi.ui.my.presenter.SetWallectPwdPresenter;
import com.jiankang.gouqi.util.KeyBoardUtils;
import com.jiankang.gouqi.util.UserShared;
import com.jiankang.gouqi.util.ViewHelper;
import com.jiankang.gouqi.util.coder.HexUtil;
import com.jiankang.gouqi.util.coder.RSACoder;
import com.jiankang.gouqi.widget.AppBackBar;
import com.jiankang.gouqi.widget.LineEditView;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.functions.BiFunction;
import io.reactivex.rxjava3.functions.Consumer;

public class SetWalletPwdActivity extends BaseMvpActivity<SetWallectPwdPresenter> implements SetWalletPwdContract.SetWalletPwdView {


    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.edt_new_password)
    LineEditView edtNewPassWord;
    @BindView(R.id.edt_again_password)
    LineEditView edtAgainPassword;
    @BindView(R.id.tv_reset_password)
    TextView tvResetPassWord;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_set_wallet_pwd;
    }

    @Override
    public void initView() {
        mPresenter = new SetWallectPwdPresenter(this);
        appBackBar.setRtxtColor(ContextCompat.getColor(mContext, R.color.color_black_333333));
        appBackBar.setTvEndDrawbleLeft(R.drawable.ic_communicate);
    }

    @Override
    public void initEvent() {
        Observable
                .combineLatest(RxTextView.textChanges(edtNewPassWord.getEditText()), RxTextView.textChanges(edtAgainPassword.getEditText()), new BiFunction<CharSequence, CharSequence, Boolean>() {
                    @Override
                    public Boolean apply(CharSequence charSequence, CharSequence charSequence2) throws Exception {
                        return charSequence.length() > 0 && charSequence2.length() > 0;
                    }
                })
                .to(bindAutoDispose())
                .subscribe(new Consumer<Boolean>() {
                    @Override
                    public void accept(Boolean b) throws Exception {
                        tvResetPassWord.setEnabled(b);
                    }
                });

        ViewHelper.throttleClick(tvResetPassWord, new Consumer() {
            @Override
            public void accept(Object o) throws Throwable {
                String pwd = edtNewPassWord.getText().toString().trim();

                if (TextUtils.isEmpty(pwd)) {
                    showMsg("请设置新密码");
                    return;
                }

                if (pwd.length() != 6) {
                    showMsg("请设置6位数字密码");
                    return;
                }

                String pwd_confirm = edtAgainPassword.getText().toString().trim();

                if (TextUtils.isEmpty(pwd_confirm)) {
                    showMsg("请设置确认密码");
                    return;
                }

                if (pwd_confirm.length() != 6) {
                    showMsg("请设置6位确认密码");
                    return;
                }

                if (!pwd.equals(pwd_confirm)) {
                    showMsg("两次输入的密码不一致");
                    return;
                }


                KeyBoardUtils.closeKeybord(edtNewPassWord, mContext);
                KeyBoardUtils.closeKeybord(edtAgainPassword, mContext);


                String pwdStr = edtNewPassWord.getText();
                String modulus = UserShared.getPubkeyModulus(mContext);
                String exponent = UserShared.getPubkeyExp(mContext);
                String password = "";
                try {
                } catch (Exception e) {
                    e.printStackTrace();
                }
                password = HexUtil.bytesToHexString(RSACoder
                        .encryptByPublicKey(pwdStr, modulus, exponent));

                Map map = new HashMap();
                map.put("password", password);
                mPresenter.setPwd(map, mContext);
            }
        });

        appBackBar.setOnBarEndTextClickListener(new AppBackBar.OnBarClickListener() {
            @Override
            public void onClick() {
            }
        });
    }

    @Override
    public void initData() {
    }

    @Override
    public void installMoneyBagPasswordSuccess() {

    }

}