package com.jiankang.gouqi.dialog;

import android.app.Dialog;
import android.content.Context;
import android.text.TextUtils;
import android.text.method.ScrollingMovementMethod;
import android.view.Gravity;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.interfaces.ObjectInterface;

public class ZhaiCommonDialog extends Dialog implements OnClickListener {

    private ObjectInterface.ObjReturnMet3 onclick1;
    private ObjectInterface.ObjReturnMet3 onclick2;
    private ObjectInterface.ObjReturnMet3 onclick3;
    private Context mContext;

    public ZhaiCommonDialog(Context context, String desc, String textBtn1, String textBtn2, final boolean isShowBtn2) {
        super(context, R.style.my_dialog);
        this.mContext = context;
        setContentView(R.layout.dialog_zhai_common);
        init(desc, textBtn1, textBtn2, isShowBtn2);
    }

    public void setOnclick1(ObjectInterface.ObjReturnMet3 onclick1) {
        this.onclick1 = onclick1;
    }

    public void setOnclick2(ObjectInterface.ObjReturnMet3 onclick2) {
        this.onclick2 = onclick2;
    }

    public void setOnclick3(ObjectInterface.ObjReturnMet3 onclick3) {
        this.onclick3 = onclick3;
    }

    private void init(String content, String textBtn1, String textBtn2, final boolean isShowBtn2) {
        setCancelable(false);
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        lp.gravity = Gravity.CENTER;
        getWindow().setAttributes(lp);
        TextView tvBtn1 = findViewById(R.id.tv_btn1);
        TextView tvBtn2 = findViewById(R.id.tv_btn2);
        tvBtn1.setText(textBtn1);
        tvBtn2.setText(textBtn2);
        tvBtn1.setOnClickListener(this);
        tvBtn2.setOnClickListener(this);
        findViewById(R.id.iv_close).setOnClickListener(this);
        if (!isShowBtn2) {
            tvBtn2.setVisibility(View.GONE);
            final LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) tvBtn1.getLayoutParams();
            params.width = 280;
            tvBtn1.setLayoutParams(params);
        }

        TextView tvContent = (TextView) findViewById(R.id.tv_content);

        if (!TextUtils.isEmpty(content)) {
            tvContent.setMovementMethod(ScrollingMovementMethod.getInstance());
            tvContent.setText(content);
        }
        show();
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.tv_btn1:
                if (onclick1 != null) {
                    onclick1.callback();
                }
                dismiss();
                break;
            case R.id.tv_btn2:
                if (onclick2 != null) {
                    onclick2.callback();
                }
                dismiss();
                break;
            case R.id.iv_close:
                if (onclick3 != null) {
                    onclick3.callback();
                }
                dismiss();
                break;
            default:
                break;
        }
    }
}
