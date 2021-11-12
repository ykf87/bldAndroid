package com.blandal.app.util;

import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.PopupWindow;

import com.blandal.app.R;

/**
 * Description:重新领取弹窗
 * author:ljx
 * time  :2020/12/16 11 30
 */
public class ReCollectTaskPopupWindow extends PopupWindow {

    private WindowManager windowManager;
    private Context mContext;
    private View view;

    public ReCollectTaskPopupWindow(Context context) {
        super(context);
        view = View.inflate(context, R.layout.popwindow_recollect_task, null);
        windowManager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        setContentView(view);
        setWidth(DisplayUtil.dp2px(context, 230));
        setHeight(DisplayUtil.dp2px(context, 95));
        this.mContext = context;
        //设置可以获得焦点
        setFocusable(true);
        // 设置弹窗内可点击
        setTouchable(true);
        // 设置弹窗外可点击
        setOutsideTouchable(true);
        setBackgroundDrawable(new ColorDrawable());
        setAnimationStyle(0);

        initView();
    }

    private void initView() {
        ImageView ivClose = view.findViewById(R.id.iv_close);
        ivClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }

    public void show(View view) {
        int[] location = new int[2];
        view.getLocationOnScreen(location);
        showAtLocation(view, Gravity.NO_GRAVITY, (location[0] + view.getWidth() / 2) - getWidth() / 2,
                location[1] - getHeight() - DisplayUtil.dp2px(view.getContext(), 0));//向上偏移16dp
    }
}
