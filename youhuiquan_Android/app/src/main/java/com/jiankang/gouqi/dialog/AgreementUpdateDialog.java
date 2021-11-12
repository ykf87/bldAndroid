package com.jiankang.gouqi.dialog;

import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.text.style.ForegroundColorSpan;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseDialogFragment;
import com.jiankang.gouqi.interfaces.Callback;
import com.jiankang.gouqi.ui.my.activity.PrivacyPolicyActivity;


/**
 * 协议更新弹窗
 */
public class AgreementUpdateDialog extends BaseDialogFragment implements View.OnClickListener {
    private TextView tvStart;
    private TextView tvEnd;

    private Callback mListener;

    private static AgreementUpdateDialog mAgreementDialog;

    public AgreementUpdateDialog() {
    }

    public static AgreementUpdateDialog newInstance() {
        if (mAgreementDialog == null) {
            synchronized (AgreementUpdateDialog.class) {
                if (mAgreementDialog == null) {
                    mAgreementDialog = new AgreementUpdateDialog();
                }
            }
        }
        return mAgreementDialog;
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.dialog_agreement_update;
    }

    @Override
    public void initView() {
        String userSecret = "《隐私政策》";
        String userProtocol = "《服务协议》";
        String content = getResources().getString(R.string.dialog_agreement_desc_2);
        SpannableString spannableString = new SpannableString(content);
        int indexSecret = content.indexOf(userSecret);
        int indexProtocol = content.indexOf(userProtocol);

        spannableString.setSpan(new ClickableSpan() {
            @Override
            public void onClick(@NonNull View widget) {
//                AppUtils.toWap(getContext(), ServiceListFinal.userAgreement);
                PrivacyPolicyActivity.launch(getContext(),false);
            }

            @Override
            public void updateDrawState(TextPaint ds) {
                ds.setColor(ContextCompat.getColor(getContext(), R.color.colorPrimary));
                ds.setUnderlineText(false);
                ds.clearShadowLayer();
                ds.bgColor = -1;
            }
        }, indexProtocol, indexProtocol+userProtocol.length(), Spanned.SPAN_INCLUSIVE_EXCLUSIVE);

        spannableString.setSpan(new ClickableSpan() {
            @Override
            public void onClick(@NonNull View widget) {
//                AppUtils.toWap(getContext(), ServiceListFinal.privacyPolicy);
                PrivacyPolicyActivity.launch(getContext(),true);
            }

            @Override
            public void updateDrawState(TextPaint ds) {
                ds.setColor(ContextCompat.getColor(getContext(), R.color.colorPrimary));
                ds.setUnderlineText(false);
                ds.clearShadowLayer();
                ds.bgColor = -1;
            }
        }, indexSecret, indexSecret+userSecret.length(), Spanned.SPAN_INCLUSIVE_EXCLUSIVE);
        ForegroundColorSpan colorSpan = new ForegroundColorSpan(ContextCompat.getColor(getContext(), R.color.colorPrimary));
        spannableString.setSpan(colorSpan, indexProtocol, indexProtocol+userProtocol.length(), Spanned.SPAN_INCLUSIVE_INCLUSIVE);
        spannableString.setSpan(colorSpan, indexSecret, indexSecret+userSecret.length(), Spanned.SPAN_INCLUSIVE_INCLUSIVE);

        ((TextView) mView.findViewById(R.id.tv_content)).setText(spannableString);
        ((TextView) mView.findViewById(R.id.tv_content)).setMovementMethod(LinkMovementMethod.getInstance());

        tvStart = mView.findViewById(R.id.tv_start);
        tvEnd = mView.findViewById(R.id.tv_end);

        tvStart.setOnClickListener(this);
        tvEnd.setOnClickListener(this);


        if (mDialog.getWindow() != null) {
            mDialog.getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            mDialog.getWindow().setBackgroundDrawableResource(android.R.color.transparent);
        }
        setCancelable(false);
        mDialog.setCanceledOnTouchOutside(false);
    }

    @Override
    protected void initData() {

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            default:
                break;
            case R.id.tv_start:
                if (mListener != null){
                    mListener.onStartBtnClick();
                }
                break;
            case R.id.tv_end:
                if (mListener != null){
                    mListener.onEndBtnClick();
                }
                break;
        }
    }

    public void setOnDialogClickListener(Callback listener){
        mListener = listener;
    }
}
