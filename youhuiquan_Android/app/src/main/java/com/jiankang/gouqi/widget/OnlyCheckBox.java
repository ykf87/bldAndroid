package com.jiankang.gouqi.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.jiankang.gouqi.R;

/**
 * @author chenx 带有一键清除按钮和下划线的输入框控件
 */
@SuppressLint("Recycle")
public class OnlyCheckBox extends LinearLayout {

    private ImageView ivCheck;
    private boolean isChecked;
    private int imgChecked;
    private int imgUnchecked;

    public OnlyCheckBox(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    private void init(Context context, AttributeSet attrs) {
        LayoutInflater.from(context).inflate(R.layout.only_checkbox_view, this);
        ivCheck = findViewById(R.id.iv_check);

        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.OnlyCheckBox);

        imgChecked = a.getResourceId(R.styleable.OnlyCheckBox_drawable_checked, R.drawable.ic_check_on);
        imgUnchecked = a.getResourceId(R.styleable.OnlyCheckBox_drawable_checked, R.drawable.ic_check_off);

        isChecked = a.getBoolean(R.styleable.OnlyCheckBox_is_checked, false);

        if (isChecked) {
            ivCheck.setImageResource(imgChecked);
            isChecked = true;
        } else {
            ivCheck.setImageResource(imgUnchecked);
            isChecked = false;
        }

        ivCheck.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isChecked) {
                    ivCheck.setImageResource(imgUnchecked);
                } else {
                    ivCheck.setImageResource(imgChecked);
                }

                isChecked = !isChecked;
            }
        });
    }

    public boolean isChecked () {
        return isChecked;
    }

    public void setChecked(boolean isChecked) {
        if (isChecked) {
            ivCheck.setImageResource(imgChecked);
            isChecked = true;
        } else {
            ivCheck.setImageResource(imgUnchecked);
            isChecked = false;
        }
        this.isChecked = isChecked;
    }

}
