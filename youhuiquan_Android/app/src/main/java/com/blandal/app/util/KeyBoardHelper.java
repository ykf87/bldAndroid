package com.blandal.app.util;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.graphics.Rect;
import android.os.Build;
import android.view.View;
import android.view.ViewTreeObserver;
import android.view.WindowManager;

import androidx.annotation.RequiresApi;

public class KeyBoardHelper {
    private Activity activity;
    private OnKeyBoardStatusChangeListener onKeyBoardStatusChangeListener;
    private int screenHeight;
    // 空白高度 = 屏幕高度 - 当前 Activity 的可见区域的高度
    // 当 blankHeight 不为 0 即为软键盘高度。
    private int blankHeight = 0;

    public KeyBoardHelper(Activity activity) {
        this.activity = activity;
        screenHeight = activity.getResources().getDisplayMetrics().heightPixels;
        activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
        if (activity.getRequestedOrientation() != ActivityInfo.SCREEN_ORIENTATION_PORTRAIT) {
            activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        }
        View content = activity.findViewById(android.R.id.content);
        content.getViewTreeObserver().addOnGlobalLayoutListener(onGlobalLayoutListener);
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    public void onDestory() {
        View content = activity.findViewById(android.R.id.content);
        content.getViewTreeObserver().removeOnGlobalLayoutListener(onGlobalLayoutListener);
    }

    private ViewTreeObserver.OnGlobalLayoutListener onGlobalLayoutListener = new ViewTreeObserver.OnGlobalLayoutListener() {

        @Override
        public void onGlobalLayout() {
            Rect rect = new Rect();
            activity.getWindow().getDecorView().getWindowVisibleDisplayFrame(rect);
            int newBlankheight = screenHeight - rect.bottom;

            if (newBlankheight != blankHeight) {
                if (newBlankheight == 0) {
                    // keyboard close
                    if (onKeyBoardStatusChangeListener != null) {
//                        onKeyBoardStatusChangeListener.OnKeyBoardClose(newBlankheight);
                        onKeyBoardStatusChangeListener.OnKeyBoardClose(blankHeight);
                    }
                } else {
                    // keyboard pop
                    if (onKeyBoardStatusChangeListener != null) {
                        onKeyBoardStatusChangeListener.OnKeyBoardPop(newBlankheight);
                    }
                }
            }
            blankHeight = newBlankheight;
        }
    };

    public void setOnKeyBoardStatusChangeListener(
            OnKeyBoardStatusChangeListener onKeyBoardStatusChangeListener) {
        this.onKeyBoardStatusChangeListener = onKeyBoardStatusChangeListener;
    }

    public interface OnKeyBoardStatusChangeListener {

        void OnKeyBoardPop(int keyBoardheight);

        void OnKeyBoardClose(int oldKeyBoardheight);
    }
}
