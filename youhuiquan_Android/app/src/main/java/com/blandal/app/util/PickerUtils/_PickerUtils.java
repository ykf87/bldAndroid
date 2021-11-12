package com.blandal.app.util.PickerUtils;

import android.content.Context;

import com.bigkoo.pickerview.builder.OptionsPickerBuilder;
import com.bigkoo.pickerview.listener.OnOptionsSelectListener;


public class _PickerUtils {

    public static OptionsPickerBuilder getDefaultPickerBuilder(Context context,
                                                               OnOptionsSelectListener listener){
        return PickerCenter.getDefaultPickerBuilder(context,listener);//设置外部遮罩颜色
    }

}
