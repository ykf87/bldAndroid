package com.jiankang.gouqi.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.greenrobot.eventbus.EventBus;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.app.MyApplication;
import com.jiankang.gouqi.ui.main.event.NetStateEvent;
import com.jiankang.gouqi.util.PingNet;
import com.jiankang.gouqi.util.ToastShow;

/**
 * Description:无网络view
 * author:ljx
 * time  :2020/12/18 11 25
 */
public class NoNetWorkView extends FrameLayout {

    private Context mContext;

    private OnNoNetWorkViewListener onRefreshClickListener;


    public NoNetWorkView(@NonNull Context context) {
        super(context);
        this.mContext = context;
        initView();
    }

    public NoNetWorkView(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        this.mContext = context;
        initView();
    }

    public NoNetWorkView(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        this.mContext = context;
        initView();
    }
    private TextView tvRefresh;

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.layout_not_network, null);
        addView(view);
        tvRefresh = view.findViewById(R.id.tv_refresh);
        tvRefresh.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!MyApplication.getInstance().isConnected()) {
                    try {
                        new Thread(new Runnable() {
                            @Override
                            public void run() {
                                PingNet.PingNetEntity pingNetEntity = new PingNet.PingNetEntity("www.baidu.com", 3, 5, new StringBuffer());
                                pingNetEntity = PingNet.ping(pingNetEntity);
                                MyApplication.getInstance().setConnected(pingNetEntity.isResult());
                                EventBus.getDefault().post(new NetStateEvent());
                            }
                        }).start();
                    } catch (Exception e) {
                        e.printStackTrace();
                        MyApplication.getInstance().setConnected(false);
                        EventBus.getDefault().post(new NetStateEvent());
                    }
                    ToastShow.showMsg("当前无网络,请打开网络");
                    return;
                }
                if (onRefreshClickListener != null) {
                    onRefreshClickListener.onRefresh(view);
                }
            }
        });
    }

    public boolean isShow() {
        return !MyApplication.getInstance().isConnected();
    }


    public interface OnNoNetWorkViewListener {
        void onRefresh(View view);
    }

    public void setOnRefreshClickListener(OnNoNetWorkViewListener onRefreshClickListener) {
        this.onRefreshClickListener = onRefreshClickListener;
    }

    public void performRefresh(){
        if (tvRefresh != null && MyApplication.getInstance().isConnected()){
            tvRefresh.performClick();
        }
    }

}
