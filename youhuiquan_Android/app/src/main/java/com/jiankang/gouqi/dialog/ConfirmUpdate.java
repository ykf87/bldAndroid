package com.jiankang.gouqi.dialog;

import android.app.Dialog;
import android.content.Context;
import android.text.TextUtils;
import android.text.method.ScrollingMovementMethod;
import android.view.Gravity;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.TextView;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.common.event.ShowAdDialogEvent;
import com.jiankang.gouqi.interfaces.ObjectInterface;
import com.jiankang.gouqi.util.DisplayUtil;
import com.jiankang.gouqi.util.EventBusManager;

public class ConfirmUpdate extends Dialog implements OnClickListener {

    private ObjectInterface.ObjReturnMet3 okReturnMet;
    private ObjectInterface.ObjReturnMet3 cancleReturnMet;
    private boolean needUpdate;

    public ConfirmUpdate(Context context, String desc, String version, final boolean needUpdate) {
        super(context, R.style.my_dialog);
        setContentView(R.layout.dialog_update);
        init(desc, version, needUpdate);
    }

    public void setOkReturnMet(ObjectInterface.ObjReturnMet3 pOkReturnMet) {
        okReturnMet = pOkReturnMet;
    }

    public void setCancleReturnMet(ObjectInterface.ObjReturnMet3 pCancleReturnMet) {
        cancleReturnMet = pCancleReturnMet;
    }

    private void init(String desc, String version, final boolean needUpdate) {
        this.needUpdate = needUpdate;
        setCancelable(false);
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        lp.gravity = Gravity.CENTER;
        lp.y = -DisplayUtil.dip2px(getContext(), 30);
        getWindow().setAttributes(lp);
        TextView tvCancel = findViewById(R.id.tv_cancel);
        tvCancel.setOnClickListener(this);
        findViewById(R.id.tv_update).setOnClickListener(this);
        if (needUpdate) {
            tvCancel.setVisibility(View.GONE);
        }
        TextView tv_version = (TextView) findViewById(R.id.tv_new_version);
        if (!TextUtils.isEmpty(version)) {
            tv_version.setText("V" + version);
        }
        TextView tv_desc = (TextView) findViewById(R.id.tv_desc);
        if (!TextUtils.isEmpty(desc)) {
            tv_desc.setMovementMethod(ScrollingMovementMethod.getInstance());
            tv_desc.setText(desc);
        }
        show();
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.tv_update:
                if (okReturnMet != null) {
                    okReturnMet.callback();
                }
                dismiss();
                break;
            case R.id.tv_cancel:
                EventBusManager.getInstance().post(new ShowAdDialogEvent());
                dismiss();
                break;
            default:
                break;
        }
    }
}
