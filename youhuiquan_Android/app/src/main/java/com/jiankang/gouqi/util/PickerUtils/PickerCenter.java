package com.jiankang.gouqi.util.PickerUtils;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.core.content.ContextCompat;

import com.bigkoo.pickerview.builder.OptionsPickerBuilder;
import com.bigkoo.pickerview.listener.OnOptionsSelectListener;

import com.jiankang.gouqi.R;


public class PickerCenter {

    public static OptionsPickerBuilder getDefaultPickerBuilder(Context context,
                                                               OnOptionsSelectListener listener) {
        ViewGroup view  = (ViewGroup) LayoutInflater.from(context).inflate(R.layout.dialog_home_select,null);
        return new OptionsPickerBuilder(context, listener)
                .setSubmitText("确认")
                .setContentTextSize(16)
                .setTitleSize(17)
                .setSubCalSize(14)
                .setDividerColor(ContextCompat.getColor(context, R.color.color_eaeaea))
                .setBgColor(android.graphics.Color.WHITE)
                .setTitleBgColor(ContextCompat.getColor(context, R.color.white))
                .setTitleColor(ContextCompat.getColor(context, R.color.text_title_info))
                .setCancelColor(ContextCompat.getColor(context, R.color.color_gray_999999))
                .setSubmitColor(ContextCompat.getColor(context, R.color.colorPrimary))
                .setTextColorCenter(ContextCompat.getColor(context, R.color.text_title_info))
                .setTextColorOut(ContextCompat.getColor(context, R.color.color_gray_999999))
                .setLineSpacingMultiplier(3.4f)
                .setItemVisibleCount(5)
                .isAlphaGradient(false)
                .setTextXOffset(0, 0, 0)
                .setOutSideColor(0x8A000000);
    }
}
