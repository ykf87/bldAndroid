package com.jiankang.gouqi.dialog;


import android.app.Dialog;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import butterknife.BindView;
import butterknife.OnClick;
import butterknife.Unbinder;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseDialogFragment;
import com.jiankang.gouqi.constant.ArgsContant;
import com.jiankang.gouqi.util.DisplayUtil;

/**
 * @author Android
 */
public class CommonDialog extends BaseDialogFragment {
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_content)
    TextView tvContent;
    @BindView(R.id.btn_start_default_cancel)
    Button btnStartDefaultCancel;
    @BindView(R.id.btn_end_default_confirm)
    Button btnEndDefaultConfirm;
    @BindView(R.id.line)
    View line;

    private String mContent;
    private String mTitle;
    private String mStartText;
    private String mEndText;

    private OnDialogClickListener mListener;
    private Unbinder unbinder;

    private Window window;

    private static final int confirmDialog = 1;
    private static final int alterDialog = 2;

    private int dialogType = confirmDialog;

    public CommonDialog() {
        super();
    }


    public static CommonDialog newInstance(String title, String content) {
        return newInstance(title, content, "", "");
    }

    public static CommonDialog newInstance(String content) {
        return newInstance("", content, "", "");
    }

    public static CommonDialog newInstance(String content,
                                           String startTextDefaultCancel,
                                           String endTextDefaultConfirm) {
        return newInstance("", content, startTextDefaultCancel, endTextDefaultConfirm);
    }

    public static CommonDialog newInstance(String title, String content,
                                           String startTextDefaultCancel,
                                           String endTextDefaultConfirm) {
        Bundle args = new Bundle();
        args.putString(ArgsContant.ARGS_TITLE, title);
        args.putString(ArgsContant.ARGS_CONTENT, content);
        args.putString(ArgsContant.ARGS_START_TEXT, startTextDefaultCancel);
        args.putString(ArgsContant.ARGS_END_TEXT, endTextDefaultConfirm);
        CommonDialog fragment = new CommonDialog();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        if (getDialog() != null) {
            try {
                getDialog().setOnShowListener(null);
                getDialog().setOnDismissListener(null);
                getDialog().setOnCancelListener(null);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle args = getArguments();
        if (args != null) {
            mTitle = args.getString(ArgsContant.ARGS_TITLE);
            mContent = args.getString(ArgsContant.ARGS_CONTENT);
            mStartText = args.getString(ArgsContant.ARGS_START_TEXT);
            mEndText = args.getString(ArgsContant.ARGS_END_TEXT);
        }
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.dialog_common;
    }

    @Override
    protected void initView() {
        Dialog dialog = getDialog();
        if (dialog != null) {
            window = dialog.getWindow();
        }
        if (window != null) {
            window.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            window.setBackgroundDrawable(ContextCompat.getDrawable(getContext(), R.drawable.rect_8_white));
        }

        if (dialog != null) {
            dialog.setCancelable(false);
            dialog.setCanceledOnTouchOutside(false);
        }

        setCancelable(false);
        LinearLayout.LayoutParams lpContent = (LinearLayout.LayoutParams) tvContent.getLayoutParams();

        if (TextUtils.isEmpty(mTitle)) {
            tvTitle.setVisibility(View.GONE);
            if (getContext() != null) {
                lpContent.topMargin = DisplayUtil.dip2px(getContext(), 28);
                lpContent.leftMargin = DisplayUtil.dip2px(getContext(), 28);
                lpContent.rightMargin = DisplayUtil.dip2px(getContext(), 28);
            }
        } else {
            tvTitle.setVisibility(View.VISIBLE);
            tvTitle.setText(mTitle);

/*            if (getContext() != null){
                lpContent.topMargin = DisplayUtil.dip2px(getContext(),14);
                lpContent.leftMargin = DisplayUtil.dip2px(getContext(),16);
                lpContent.rightMargin = DisplayUtil.dip2px(getContext(),16);
            }*/
        }

        tvContent.setText(mContent);
        tvContent.post(new Runnable() {
            @Override
            public void run() {
                if (tvContent.getLineCount() <= 1 ){
                    tvContent.setGravity(Gravity.CENTER);
                }else{
                    tvContent.setGravity(Gravity.LEFT);
                }
            }
        });


        if (TextUtils.isEmpty(mStartText)) {
            btnStartDefaultCancel.setText("取消");
        } else {
            btnStartDefaultCancel.setText(mStartText);
        }

        if (TextUtils.isEmpty(mEndText)) {
            btnEndDefaultConfirm.setText("确认");
        } else {
            btnEndDefaultConfirm.setText(mEndText);
        }

        if (dialogType == alterDialog) {
            line.setVisibility(View.GONE);
            btnStartDefaultCancel.setVisibility(View.GONE);
        }
    }

    @Override
    protected void initData() {

    }

    @OnClick({R.id.btn_start_default_cancel, R.id.btn_end_default_confirm})
    public void onViewClicked(View view) {
        int id = view.getId();
        if (id == R.id.btn_start_default_cancel) {
            if (mListener != null) {
                mListener.onStartBtnDefaultCancelClick();
            }
            dismissAllowingStateLoss();
        } else if (id == R.id.btn_end_default_confirm) {
            if (mListener != null) {
                mListener.onEndBtnDefaultConfirmClick();
            }
            dismissAllowingStateLoss();
        }
    }

    public void setConfirmDialog() {
        this.dialogType = confirmDialog;
    }

    public void setAlterDialog() {
        this.dialogType = alterDialog;
    }

    public void setOnDialogClickListener(OnDialogClickListener listener) {
        mListener = listener;
    }

    public interface OnDialogClickListener {

        void onStartBtnDefaultCancelClick();

        void onEndBtnDefaultConfirmClick();
    }

}
