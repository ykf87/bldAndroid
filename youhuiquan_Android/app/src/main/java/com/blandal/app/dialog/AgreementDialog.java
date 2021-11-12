package com.blandal.app.dialog;

import android.annotation.SuppressLint;
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

import com.blandal.app.R;
import com.blandal.app.base.BaseDialogFragment;
import com.blandal.app.interfaces.Callback;
import com.blandal.app.ui.my.activity.PrivacyPolicyActivity;


/**
 * 协议弹窗
 */
public class AgreementDialog extends BaseDialogFragment implements View.OnClickListener {
    /**
     * 1.首次确认
     */
    public static final int TYPE_FIRST = 1;
    /**
     * 2.再次确认
     */
    public static final int TYPE_SECOND = 2;

    private TextView tvStart;
    private TextView tvEnd;
    private TextView tvTitle;
    private TextView tvContent;

    private Callback mListener;
    public int mType;

    @SuppressLint("StaticFieldLeak")
    private static AgreementDialog mAgreementDialog;

    public AgreementDialog() {
        super();
    }

    public static AgreementDialog newInstance(int type) {
        if (mAgreementDialog == null) {
            synchronized (AgreementDialog.class) {
                if (mAgreementDialog == null) {
                    mAgreementDialog = new AgreementDialog(type);
                }
            }
        } else {
            mAgreementDialog.mType = type;
        }
        return mAgreementDialog;
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.dialog_agreement;
    }

    private AgreementDialog(int type){
        this.mType = type;
    }

    @Override
    public void initView() {
        tvStart = mView.findViewById(R.id.tv_start);
        tvEnd = mView.findViewById(R.id.tv_end);
        tvTitle = mView.findViewById(R.id.tv_title);
        tvContent = mView.findViewById(R.id.tv_content);

        if(mType == TYPE_FIRST){
            initFirst();
        }else{
            initSecond();
        }

        tvContent.setMovementMethod(LinkMovementMethod.getInstance());

        tvStart.setOnClickListener(this);
        tvEnd.setOnClickListener(this);


        if (mDialog.getWindow() != null) {
            mDialog.getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            mDialog.getWindow().setBackgroundDrawableResource(android.R.color.transparent);
        }
        setCancelable(false);
        mDialog.setCanceledOnTouchOutside(false);
    }

    private void initSecond(){
        mType = TYPE_SECOND;
        tvTitle.setText("抱歉");
        tvContent.setText("您在同意隐私政策与服务协议条款的情况下，方可继续使用本产品");
        tvStart.setText("再想想");
    }

    private void initFirst(){
        mType = TYPE_FIRST;
        tvTitle.setText(getResources().getString(R.string.dialog_agreement_title));
        tvContent.setText(getResources().getString(R.string.dialog_agreement_desc));
        tvStart.setText(getResources().getString(R.string.dialog_agreement_noagree));
        String userSecret = "《隐私政策》";
        String userProtocol = "《用户协议》";
        String content = getResources().getString(R.string.dialog_agreement_desc);
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
                PrivacyPolicyActivity.launch(getContext(),true);
//                AppUtils.toWap(getContext(), ServiceListFinal.privacyPolicy);
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
        tvContent.setText(spannableString);
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
