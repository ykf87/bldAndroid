package com.blandal.app.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.EditText;

import com.blandal.app.common.event.TimeUpRefreshMyTaskListEvent;
import com.blandal.app.ui.main.entity.HomeTaskEntity;
import com.blandal.app.ui.my.entity.ApplyTaskListBean;
import com.blandal.app.util.EventBusManager;


@SuppressLint("AppCompatCustomView")
public class TimeTextView extends EditText {
    ApplyTaskListBean curBean;
    HomeTaskEntity homeTaskEntity;
    private OnTimesUpListener mOnTimeUpListener;

    public TimeTextView(Context context) {
        super(context);
    }

    public TimeTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public TimeTextView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public interface OnTimesUpListener {
        void onTimeUp(ApplyTaskListBean bean);
    }

    public void setTimesUpListener(OnTimesUpListener onTimeUpListener) {
        this.mOnTimeUpListener = onTimeUpListener;
    }

    @Override
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        // 在控件被销毁时移除消息
        handler.removeCallbacksAndMessages(null);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        return false;
    }

    private boolean run = true; // 是否启动了
    @SuppressLint("NewApi")
    private Handler handler = new Handler(Looper.getMainLooper()) {
        @SuppressLint("SetTextI18n")
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 0:
                    if (run) {
                        long mTime = curBean.getStu_submit_left_time();
                        if (mTime > 0) {
                            TimeTextView.this.setVisibility(View.VISIBLE);
                            TimeTextView.this.setText(generateTime(curBean.getStu_submit_left_time()));
                            mTime = mTime - 1000;
                            curBean.setStu_submit_left_time(mTime);
                            handler.sendEmptyMessageDelayed(0, 1000);
                        } else {
                            if (mOnTimeUpListener != null) {
                                mOnTimeUpListener.onTimeUp(curBean);
                            }
                            handler.removeMessages(0);
                            TimeTextView.this.setText("00：00：00");
                        }
                    } else {
                        TimeTextView.this.setVisibility(View.GONE);
                    }
                    break;
                case 1:
                    if (run) {
                        long mTime = homeTaskEntity.getStu_submit_left_time();
                        if (mTime > 0) {
                            TimeTextView.this.setVisibility(View.VISIBLE);
                            TimeTextView.this.setText(generateTime(homeTaskEntity.getStu_submit_left_time()));
                            mTime = mTime - 1000;
                            homeTaskEntity.setStu_submit_left_time(mTime);
                            handler.sendEmptyMessageDelayed(1, 1000);
                        } else {
                            EventBusManager.getInstance().post(new TimeUpRefreshMyTaskListEvent(homeTaskEntity.getTask_apply_id()));
                            handler.removeMessages(1);
                            TimeTextView.this.setVisibility(View.INVISIBLE);
                        }
                    } else {
                        TimeTextView.this.setVisibility(View.GONE);
                    }
                    break;
            }
        }
    };

    @SuppressLint("NewApi")
    public void setTimes(ApplyTaskListBean bean) {
        curBean = bean;
        if (curBean.getStu_submit_dead_time() > 0) {
            handler.removeCallbacksAndMessages(null);
            handler.sendEmptyMessage(0);
        } else {
            TimeTextView.this.setVisibility(View.GONE);
        }
    }

    @SuppressLint("NewApi")
    public void setTimes(HomeTaskEntity bean) {
        homeTaskEntity = bean;
        if (homeTaskEntity.getStu_submit_left_time() > 0) {
            handler.removeCallbacksAndMessages(null);
            handler.sendEmptyMessage(1);
        } else {
            TimeTextView.this.setVisibility(View.INVISIBLE);
        }
    }

    public void stop() {
        run = false;
    }

    public static String generateTime(long time) {
        int totalSeconds = (int) (time / 1000);
        int seconds = totalSeconds % 60;
        int minutes = (totalSeconds / 60) % 60;
        int hours = totalSeconds / 3600;

        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
//        return hours > 0 ? String.format("%02d:%02d:%02d", hours, minutes, seconds) : String.format("%02d:%02d", minutes, seconds);
    }
}