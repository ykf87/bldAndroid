package com.blandal.app.dialog;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnDismissListener;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;

import com.blandal.app.R;
import com.blandal.app.interfaces.ObjectInterface;
import com.blandal.app.util.DisplayUtil;


/**
 * 弹窗样式 标题 内容 只有一个确定按钮
 *
 * @author mac
 */
public class ConfirmV2 implements OnClickListener {

    Context mContext;
    ObjectInterface.ObjReturnMet3 returnMet;
    private Dialog dialogPhoto;
    private Button btnOk;
    private TextView tv_title;
    private TextView txtContent;
    private TextView txtContent2;
    private ObjectInterface.ObjReturnMet btnOkClick;

    public ConfirmV2(Context context, String txtOk, String title, CharSequence txtContext) {
        init(context, txtOk, title, txtContext, null);
    }

    public ConfirmV2(Context context, String txtOk, String title, CharSequence txtContext, CharSequence txtContext2) {
        init(context, txtOk, title, txtContext, txtContext2);
    }

    public ConfirmV2(Context context, String txtOk, String txtContext) {
        init(context, txtOk, null, txtContext, null);
    }

    public void setOnDismissLisner(ObjectInterface.ObjReturnMet3 returnMet) {
        this.returnMet = returnMet;
    }

    private void init(Context context, String txtOk, String title, CharSequence txtContext, CharSequence txtContext2) {
        mContext = context;
        dialogPhoto = new Dialog(mContext, R.style.my_dialog);

        dialogPhoto.setContentView(R.layout.dialog_confirmv2);

        dialogPhoto.setCancelable(true);
        dialogPhoto.setCanceledOnTouchOutside(true);
        WindowManager.LayoutParams lp = dialogPhoto.getWindow().getAttributes();

        // 设置宽度
        lp.width = DisplayUtil.getWidth(mContext);

        dialogPhoto.getWindow().setAttributes(lp);

        btnOk = (Button) dialogPhoto.findViewById(R.id.btnOk);
        btnOk.setOnClickListener(this);

        txtContent = (TextView) dialogPhoto.findViewById(R.id.txtContent);
        txtContent2 = (TextView) dialogPhoto.findViewById(R.id.txtContent2);

        if (!TextUtils.isEmpty(txtContext2)) {
            txtContent2.setVisibility(View.VISIBLE);
            txtContent2.setText(txtContext2);
        }

        tv_title = (TextView) dialogPhoto.findViewById(R.id.tv_title);

        dialogPhoto.setOnDismissListener(new OnDismissListener() {

            @Override
            public void onDismiss(DialogInterface dialog) {
                if (returnMet != null) {
                    returnMet.callback();
                }
            }
        });

        dialogPhoto.show();

        setOkText(txtOk);
        setTitleText(title);
        setContent(txtContext);
    }

    private void setTitleText(String str) {
        if (TextUtils.isEmpty(str)) {
            tv_title.setVisibility(View.GONE);
        } else {
            tv_title.setText(str);
        }
    }

    private void setOkText(String str) {
        btnOk.setText(str);
    }

    private void setContent(CharSequence text) {
        if (TextUtils.isEmpty(text)) {
            txtContent.setVisibility(View.GONE);
        } else {
            txtContent.setText(text);
            txtContent.post(new Runnable() {
                @Override
                public void run() {
                    // 内容大于一行 就左居中,负责就居中对齐
                    if (txtContent.getLineCount() > 1) {
                        txtContent.setGravity(Gravity.LEFT);
                    } else {
                        txtContent.setGravity(Gravity.CENTER);
                    }
                }
            });
        }
    }

    public void setCancelable(boolean b) {
        dialogPhoto.setCancelable(b);
    }

    public void setCanceledOnTouchOutside(boolean b) {
        dialogPhoto.setCanceledOnTouchOutside(b);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btnOk:
                if (btnOkClick != null) {
                    btnOkClick.callback("");
                }
                dialogPhoto.dismiss();
                break;

            default:
                break;
        }
    }

    public void setMyBtnOkClick(ObjectInterface.ObjReturnMet l) {
        btnOkClick = l;
    }

}
