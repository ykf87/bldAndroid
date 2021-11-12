package com.blandal.app.dialog;

import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.blandal.app.R;
import com.blandal.app.base.BaseDialogFragment;
import com.blandal.app.interfaces.Callback;


/**
 * 定位成功
 */
public class LocationSuccessDialog extends BaseDialogFragment implements View.OnClickListener {

    private TextView tvCancel;
    private TextView tvConfirm;
    private TextView tvTitle;
    private TextView tvContent;
    private ImageView ivImage;

    private Callback mListener;

    private static LocationSuccessDialog mCommonDialog;
    private String mContent;

    public LocationSuccessDialog() {
        super();
    }

    public static LocationSuccessDialog newInstance(String content) {
        if (mCommonDialog == null) {
            synchronized (LocationSuccessDialog.class) {
                if (mCommonDialog == null) {
                    mCommonDialog = new LocationSuccessDialog(content);
                }
            }
        } else {
            mCommonDialog.mContent = content;
        }
        return mCommonDialog;
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.dialog_location_success;
    }

    private LocationSuccessDialog(String content) {
        this.mContent = content;
    }

    @Override
    public void initView() {
        tvCancel = mView.findViewById(R.id.tv_cancel);
        tvConfirm = mView.findViewById(R.id.tv_confirm);
        tvTitle = mView.findViewById(R.id.tv_title);
        tvContent = mView.findViewById(R.id.tv_content);

        tvContent.setText(mContent);
        tvCancel.setOnClickListener(this);
        tvConfirm.setOnClickListener(this);

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
        switch (v.getId()) {
            default:
                break;
            case R.id.tv_cancel:
                if (mListener != null) {
                    mListener.onStartBtnClick();
                }
                break;
            case R.id.tv_confirm:
                if (mListener != null) {
                    mListener.onEndBtnClick();
                }
                break;
        }
    }

    public void setOnDialogClickListener(Callback listener) {
        mListener = listener;
    }
}
