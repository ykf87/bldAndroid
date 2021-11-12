package com.blandal.app.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.Gravity;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import com.blandal.app.R;


/**
 * Description:空数据显示界面
 * Author: ljx
 * Date: 2020/7/30 9:39
 */
public class EmptyView extends LinearLayout {

    private int imgSrc = -1;
    private String text = "暂无数据";
    private float textSize;
    private int textColor;
    private float marginTop;
    private ImageView ivImage;
    private TextView tvText;

    private EmptyView(Builder builder) {
        super(builder.context);
        imgSrc = builder.imgSrc;
        text = builder.text;
        textSize = builder.textSize;
        textColor = builder.textColor;
        initView(builder.context);
    }

    public EmptyView(Context context) {
        this(context, null);
    }

    public EmptyView(Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public EmptyView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        obtainStyledAttributes(context, attrs);
        initView(context);
    }

    private void obtainStyledAttributes(Context context, AttributeSet attrs) {
        if (attrs != null) {
            TypedArray ta = context.obtainStyledAttributes(attrs, R.styleable.EmptyView);
            this.imgSrc = ta.getResourceId(R.styleable.EmptyView_emptyView_imgSrc, -1);
            if (ta.hasValue(R.styleable.EmptyView_emptyView_text)) {
                this.text = ta.getString(R.styleable.EmptyView_emptyView_text);
            } else {
                this.text = "暂无数据";
            }
            this.textSize = ta.getDimension(R.styleable.EmptyView_emptyView_textSize, dpToPx(13));
            this.textColor = ta.getColor(R.styleable.EmptyView_emptyView_textColor, ContextCompat.getColor(context, R.color.color_black_333333));
            this.marginTop = ta.getDimension(R.styleable.EmptyView_emptyView_marginTop, dpToPx(34f));
            ta.recycle();
        } else {
            this.imgSrc = -1;
            this.text = "暂无数据";
            this.textSize = dpToPx(13);
            this.textColor = ContextCompat.getColor(context, R.color.color_black_333333);
            this.marginTop = dpToPx(34);
        }
    }

    private void initView(Context context) {
        setOrientation(VERTICAL);
        setGravity(Gravity.CENTER);
        ivImage = new ImageView(getContext());
        addView(ivImage, LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        if (imgSrc != -1) {
            ivImage.setImageResource(imgSrc);
        }
        tvText = new TextView(getContext());
        tvText.setText(text);
        tvText.setTextSize(textSize);
        tvText.setTextColor(textColor);
        addView(tvText, LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        if (imgSrc != -1) {
            LayoutParams layoutParams = (LayoutParams) tvText.getLayoutParams();
            layoutParams.topMargin = (int)marginTop;
        }
    }

    public void setImageAndText(int resid, String text) {
        ivImage.setImageResource(resid);
        tvText.setText(text);
    }


    public static class Builder {
        private int imgSrc = -1;
        private String text = "暂无数据";
        private float textSize;
        private int textColor;
        private Context context;

        public Builder(Context context) {
            this.context = context;
            this.textSize = context.getResources().getDimensionPixelSize(R.dimen.sp_13);
            this.textColor = ContextCompat.getColor(context, R.color.color_black_333333);
        }

        public Builder setImgSrc(int imgSrc) {
            this.imgSrc = imgSrc;
            return this;
        }

        public Builder setText(String text) {
            this.text = text;
            return this;
        }

        public Builder setTextSize(float textSize) {
            this.textSize = textSize;
            return this;
        }

        public Builder setTextColor(int textColor) {
            this.textColor = textColor;
            return this;
        }

        public EmptyView build() {
            return new EmptyView(this);
        }

    }


    private float dpToPx(float dp) {
        return TypedValue.applyDimension(
                TypedValue.COMPLEX_UNIT_DIP, dp, getResources().getDisplayMetrics());
    }
}
