package com.jiankang.gouqi.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.jiankang.gouqi.R;


public class ViewRefresh extends LinearLayout {
    Context mContext;

    ImageView ivRefresh;

    RefreshInterface.RefreshClick refreshClick;

    public void setRefreshClick(RefreshInterface.RefreshClick pRefreshClick) {
        refreshClick = pRefreshClick;
    }

    public ViewRefresh(Context context) {
        super(context);
        init(context);
    }

    public ViewRefresh(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    /**
     * 初始化
     */
    private void init(Context pContext) {
        mContext = pContext;
        LayoutInflater.from(mContext).inflate(R.layout.view_refresh, this);
        if (isInEditMode()) {
            return;
        }
        ivRefresh = (ImageView) findViewById(R.id.iv_refresh);
        ivRefresh.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View arg0) {
                if (refreshClick != null) {
                    refreshClick.onClick();
                }
            }
        });
    }

    public static class RefreshInterface {
        public interface RefreshClick {
            void onClick();
        }
    }
}
