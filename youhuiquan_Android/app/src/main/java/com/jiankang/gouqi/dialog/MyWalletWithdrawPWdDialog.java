package com.jiankang.gouqi.dialog;

import android.app.Dialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.text.SpannableString;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;


import com.maning.pswedittextlibrary.MNPasswordEditText;

import butterknife.BindView;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseDialogFragment;
import com.jiankang.gouqi.util.KeyBoardUtils;
import com.jiankang.gouqi.widget.TopAlignSuperscriptSpan;


/**
 * Description:
 * Author: ljx
 * Date: 2020/7/25 16:11
 */
public class MyWalletWithdrawPWdDialog extends BaseDialogFragment {
    public static final String ARGS_MONEY = "args_money";

    @BindView(R.id.tv_money)
    TextView tvMoney;
    @BindView(R.id.tv_forget_pwd)
    TextView tvForgetPwd;
    @BindView(R.id.editPwd)
    MNPasswordEditText editPwd;
    @BindView(R.id.iv_close)
    ImageView ivClose;

    private OnCheckPwdListener mCheckPwdListener;
    private OnForgetPwdListener mForgetPwdListener;

    @Override
    protected int provideContentViewId() {
        return R.layout.dialog_my_wallet_withdraw_pwd;
    }


    public MyWalletWithdrawPWdDialog() {
    }

    public static MyWalletWithdrawPWdDialog newInstance(String money) {
        Bundle args = new Bundle();
        args.putString(ARGS_MONEY, money);
        MyWalletWithdrawPWdDialog fragment = new MyWalletWithdrawPWdDialog();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    protected void initView() {
        Dialog dialog = getDialog();

        if (dialog != null) {
            dialog.setCancelable(false);
            dialog.setCanceledOnTouchOutside(false);
            dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        }

        setCancelable(false);

        String money = getArguments().getString(ARGS_MONEY);

        SpannableString ss = new SpannableString("￥" + money);
        ss.setSpan(new TopAlignSuperscriptSpan((float) 0.35), 0, 1, 0);
        tvMoney.setText(ss);
        ivClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
        tvForgetPwd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mForgetPwdListener != null) {
                    mForgetPwdListener.onForgetPwd();
                }
            }
        });
        editPwd.setOnTextChangeListener(new MNPasswordEditText.OnTextChangeListener() {
            @Override
            public void onTextChange(String text, boolean isComplete) {
                if (isComplete) {
                    if (mCheckPwdListener != null) {
                        mCheckPwdListener.onCheckPwd(money, text);
                    }
                }
            }
        });
        editPwd.setFocusable(true);
        editPwd.setFocusableInTouchMode(true);
        editPwd.requestFocus();
        KeyBoardUtils.openKeybord(editPwd, getContext());
    }

    @Override
    protected void initData() {

    }



    public void clearInput() {
        editPwd.setText(null);
    }


    public interface OnCheckPwdListener {
        void onCheckPwd(String money, String pwd);
    }

    public interface OnForgetPwdListener {
        void onForgetPwd();
    }

    public void setCheckPwdListener(OnCheckPwdListener checkPwdListener) {
        this.mCheckPwdListener = checkPwdListener;
    }

    public void setForgetPwdListener(OnForgetPwdListener forgetPwdListener) {
        this.mForgetPwdListener = forgetPwdListener;
    }

    @Override
    public void dismiss() {
        KeyBoardUtils.closeKeybord(editPwd, getContext());
        super.dismiss();
    }
}
