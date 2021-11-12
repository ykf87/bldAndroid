package com.blandal.app.widget;

import android.app.Activity;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.blandal.app.R;


/**
 * @author Android
 */
public class AppBackBar extends RelativeLayout {
    private static final int UN_REFERENCE = -1;
    private Context mContext;
    private ImageView ivStart,ivLast,ivLastSecond;
    private TextView tvTitle, tvEnd;

    private String mTitle,mEndText;
    private int mStartSrc,mLastSrc, mLastSecondSrc;

    private OnBarClickListener mBackListener,mEndTextListener,
            mLastImageViewClickListener, mLastSecondImageViewClickListener;

    public AppBackBar(Context context) {
        super(context);
        mContext = context;
        init();
    }

    public AppBackBar(Context context, AttributeSet attrs) {
        super(context, attrs);
        mContext = context;

        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.AppBackBar);
        mTitle = typedArray.getString(R.styleable.AppBackBar_bar_title);
        mStartSrc = typedArray.getResourceId(R.styleable.AppBackBar_bar_start_src, R.drawable.ic_back);
        mEndText = typedArray.getString(R.styleable.AppBackBar_bar_end_text);
        mLastSrc = typedArray.getResourceId(R.styleable.AppBackBar_bar_last_src,-1);
        mLastSecondSrc = typedArray.getResourceId(R.styleable.AppBackBar_bar_last_second_src,-1);
        typedArray.recycle();
        init();
    }

    public AppBackBar(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        mContext = context;
        init();
    }

    private void init(){
        LayoutInflater.from(mContext).inflate(R.layout.widget_app_back_bar,this);
        ivStart = findViewById(R.id.iv_bar_start);
        tvTitle = findViewById(R.id.tv_bar_title);
        tvEnd = findViewById(R.id.tv_bar_end);
        ivLast = findViewById(R.id.iv_bar_last);
        ivLastSecond = findViewById(R.id.iv_bar_last_second);

        ivStart.setImageResource(mStartSrc);
        tvTitle.setText(mTitle);
        if (!TextUtils.isEmpty(mEndText)){
            tvEnd.setVisibility(VISIBLE);
            tvEnd.setText(mEndText);
        }else {
            tvEnd.setVisibility(GONE);
        }

        if (UN_REFERENCE == mLastSrc){
            ivLast.setVisibility(GONE);
        }else {
            ivLast.setVisibility(VISIBLE);
            ivLast.setImageResource(mLastSrc);
        }

        if (UN_REFERENCE == mLastSecondSrc){
            ivLastSecond.setVisibility(GONE);
        }else {
            ivLastSecond.setVisibility(VISIBLE);
            ivLastSecond.setImageResource(mLastSecondSrc);
        }

        ivStart.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mBackListener != null){
                    mBackListener.onClick();
                    return;
                }
                if (mContext instanceof Activity){
                    ((Activity) mContext).finish();
                }
            }
        });

        tvEnd.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mEndTextListener != null){
                    mEndTextListener.onClick();
                }
            }
        });

        ivLast.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mLastImageViewClickListener != null){
                    mLastImageViewClickListener.onClick();
                }
            }
        });

        ivLastSecond.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mLastSecondImageViewClickListener != null){
                    mLastSecondImageViewClickListener.onClick();
                }
            }
        });
    }

    public void setTitle(String title){
       tvTitle.setText(title);
    }



    public void setTitleColor(int c) {
        tvTitle.setTextColor(c);
    }
    public void setRtxtColor(int c) {
        tvEnd.setTextColor(c);
    }
    public void setRtxtSize(float c) {
        tvEnd.setTextSize(c);
    }

    public void setRtxtText(String str) {
        tvEnd.setText(str);
    }

    public void setLImgVisibility(int visibility) {
        ivStart.setVisibility(visibility);
    }
    public void setRtxtVisibility(int visibility) {
        tvEnd.setVisibility(visibility);
    }


    public void setOnBarEndTextClickListener(OnBarClickListener listener){
        mEndTextListener = listener;
    }

    public void setOnBarLastImageViewClickListener(OnBarClickListener listener){
        mLastImageViewClickListener = listener;
    }

    public void setOnBarLastSecondImageViewClickListener(OnBarClickListener listener){
        mLastSecondImageViewClickListener = listener;
    }

    public void setOnBackClickListener(OnBarClickListener listener){
        mBackListener = listener;
    }

    public interface OnBarClickListener{
        void onClick();
    }

    public void setLastSecondDrawable(int drawable){
        ivLastSecond.setImageResource(drawable);
    }

    public void setLastDrawable(int drawable){
        ivLast.setImageResource(drawable);
    }

    public void setTvEndDrawbleLeft(int drawble){
        Drawable drawable = mContext.getResources().getDrawable(drawble);
        drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());
        tvEnd.setCompoundDrawables(drawable,null,null,null);
        tvEnd.setCompoundDrawablePadding(5);
    }
}
