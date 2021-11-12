package com.blandal.app.util.PickerUtils;

import android.content.Context;
import android.view.View;
import android.widget.Button;

import androidx.core.content.ContextCompat;

import com.bigkoo.pickerview.listener.CustomListener;
import com.bigkoo.pickerview.listener.OnOptionsSelectChangeListener;
import com.bigkoo.pickerview.listener.OnOptionsSelectListener;
import com.bigkoo.pickerview.view.OptionsPickerView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.blandal.app.R;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.KeyBoardUtils;


public class PickerUtils {

    public static String[] mLabelFIRST = new String[]{"—", "", ""};
    public static String[] mLabelNULL = new String[]{"", "", ""};
    private static OptionsPickerView<Object> nPicker;

    //无关联，单选
    public static <T> void openNPicker(Context context, String title, int curSel,
                                       List<T> list, OnOptionsSelectListener listener) {
        nPicker = _PickerUtils.getDefaultPickerBuilder(context, listener)
                .setLayoutRes(R.layout.dialog_home_select, new CustomListener() {

                    @Override
                    public void customLayout(View v) {
                        final Button btnCancel = (Button) v.findViewById(R.id.btnCancel);
                        final Button btnSubmit = (Button) v.findViewById(R.id.btnSubmit);
                        btnSubmit.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                if (nPicker != null) {
                                    nPicker.returnData();
                                    nPicker.dismiss();
                                }

                            }
                        });

                        btnCancel.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                if (nPicker != null) {
                                    nPicker.dismiss();
                                }
                            }
                        });
                    }
                })
                .setTitleText(title)
                .setSelectOptions(curSel == 0 ? curSel : curSel - 1)
                .isRestoreItem(false)
                .setTextColorCenter(ContextCompat.getColor(context, R.color.colorPrimary))
                .isCenterLabel(true)
                .setLabels("", "", "")
                .setOptionsSelectChangeListener(new OnOptionsSelectChangeListener() {
                    @Override
                    public void onOptionsSelectChanged(int options1, int options2, int options3) {

                    }
                })
                .build();
        nPicker.setNPicker((List<Object>) list, null, null);
        nPicker.show();
        KeyBoardUtils.hideInput(context);
    }

    //无关联，三选
    public static <T> OptionsPickerView openNPicker(Context context, String title,
                                                    List<T> list1, List<T> list2, List<T> list3,
                                                    String[] label, boolean showLabel,
                                                    OnOptionsSelectChangeListener changeListener,
                                                    OnOptionsSelectListener listener) {

        OptionsPickerView nPicker = _PickerUtils.getDefaultPickerBuilder(context, listener)
                .setTitleText(title)
                .setSelectOptions(0)
                .isRestoreItem(true)
                .isCenterLabel(showLabel)
                .setLabels(label[0], label[1], label[2])
                .setOptionsSelectChangeListener(changeListener)
                .build();
        nPicker.setNPicker(list1, list2, list3);
        nPicker.show();
        KeyBoardUtils.hideInput(context);
        return nPicker;
    }

    //有关联，双选
    public static void openPicker(Context context, String title,
                                  List<String> mListOne, List<List<String>> mListTwo,
                                  OnOptionsSelectListener listener) {
        OptionsPickerView selector = _PickerUtils.getDefaultPickerBuilder(context, listener)
                .setTitleText(title)
                .setSelectOptions(mListOne.size() - 2, mListTwo.size() - 1)//默认选中项
                .isRestoreItem(true)//切换时是否还原，设置默认选中第一项。
                .isCenterLabel(true) //是否只显示中间选中项的label文字，false则每项item全部都带有label。
                .setLabels("", "", "")
                .setOptionsSelectChangeListener(new OnOptionsSelectChangeListener() {
                    @Override
                    public void onOptionsSelectChanged(int options1, int options2, int options3) {

                    }
                })
                .build();
        selector.setPicker(mListOne, mListTwo);
        selector.show();
        KeyBoardUtils.hideInput(context);
    }

    //有关联，双选
    public static void openPicker(Context context, String title,
                                  int defaultOptionOne, int defaultOptionTwo,
                                  List<String> mListOne, List<List<String>> mListTwo,
                                  OnOptionsSelectListener listener) {
        OptionsPickerView selector = _PickerUtils.getDefaultPickerBuilder(context, listener)
                .setTitleText(title)
                .setSelectOptions(defaultOptionOne, defaultOptionTwo)//默认选中项
                .isRestoreItem(true)//切换时是否还原，设置默认选中第一项。
                .isCenterLabel(true) //是否只显示中间选中项的label文字，false则每项item全部都带有label。
                .setLabels("", "", "")
                .setOptionsSelectChangeListener(new OnOptionsSelectChangeListener() {
                    @Override
                    public void onOptionsSelectChanged(int options1, int options2, int options3) {

                    }
                })
                .build();
        selector.setPicker(mListOne, mListTwo);
        selector.show();
        KeyBoardUtils.hideInput(context);
    }


    @Deprecated
    public static void openHighestDegreePicker(Context context, PickerCallback.OnSelectListener listener) {

    }


    public static String getTime(Date date) {//可根据需要自行截取数据显示
        DisplayUtil.outLog("choice date millis: " + date.getTime());
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
        return format.format(date);
    }
}
