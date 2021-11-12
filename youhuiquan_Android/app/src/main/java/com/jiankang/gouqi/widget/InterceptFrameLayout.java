package com.jiankang.gouqi.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

/**
 * 可以进行事件拦截的FrameLayout
 */
public class InterceptFrameLayout extends FrameLayout {

    public InterceptFrameLayout(@NonNull Context context) {
        super(context);
    }

    public InterceptFrameLayout(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public InterceptFrameLayout(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent ev) {
        if (interceptTouchEventListener != null) {
            if (interceptTouchEventListener.onInterceptTouchEvent(ev) == true) {
                return true;
            }
        }
        return super.onInterceptTouchEvent(ev);
    }

    public interface onInterceptTouchEventListener {
        boolean onInterceptTouchEvent(MotionEvent ev);
    }

    private onInterceptTouchEventListener interceptTouchEventListener;

    public void setInterceptTouchEventListener(onInterceptTouchEventListener interceptTouchEventListener) {
        this.interceptTouchEventListener = interceptTouchEventListener;
    }
}
