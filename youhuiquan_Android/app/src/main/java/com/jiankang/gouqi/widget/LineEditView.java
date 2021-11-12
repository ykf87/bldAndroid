package com.jiankang.gouqi.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.TypedArray;
import android.text.Editable;
import android.text.InputFilter;
import android.text.LoginFilter;
import android.text.Selection;
import android.text.Spannable;
import android.text.TextWatcher;
import android.text.method.DigitsKeyListener;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.util.StringUtils;

/**
 * @author chenx 带有一键清除按钮和下划线的输入框控件
 */
@SuppressLint("Recycle")
public class LineEditView extends LinearLayout implements OnClickListener {

    /**
     * 是否出触发输入事件
     */
    private boolean isEventInput = true;
    private RightOnClickListener onRightClickListener;
    private HdOnClickListener onHDClickListener;
    private AddTextChangedListener mAddTextChangedListener;
    private Context mContext;
    private EditText editText;
    private View l_view;
    private ImageView img_clear;
    private ImageView img_show_password;
    private TextView tv_right;

    /**
     * 是否密码
     */
    private boolean isPassword = false;
    /**
     * 是否密码显示文字
     */
    private boolean isPasswordTextVisible = false;

    public LineEditView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public void setOnHDClickListener(HdOnClickListener onHdClickListener) {
        this.onHDClickListener = onHdClickListener;
    }

    public void setAddTextChangedListener(AddTextChangedListener addTextChangedListener) {
        this.mAddTextChangedListener = addTextChangedListener;
    }

    /**
     * 设置右边文字的回调
     */
    public void setOnRightClickListener(
            RightOnClickListener onRightClickListener) {
        this.onRightClickListener = onRightClickListener;
    }

    public void init(Context pContext, AttributeSet attrs) {
//        if (isInEditMode()) {
//            return;
//        }

        mContext = pContext;
        LayoutInflater.from(mContext).inflate(R.layout.line_edit_view, this);

        setOrientation(LinearLayout.VERTICAL);

        editText = (EditText) findViewById(R.id.edit_text);
        TypedArray a = pContext.obtainStyledAttributes(attrs,
                R.styleable.LineEditView);

        String edithint = a.getString(R.styleable.LineEditView_Edithint);
        boolean editFocus = a.getBoolean(R.styleable.LineEditView_EditFocus,true);

        String edittext = a.getString(R.styleable.LineEditView_Edittext);

        boolean showBottomLine = a.getBoolean(R.styleable.LineEditView_showBottomLine, true);

        String righttext = a.getString(R.styleable.LineEditView_Righttext);

        String digits = a.getString(R.styleable.LineEditView_digits);

        int color = a.getColor(R.styleable.LineEditView_Editcolor,
                ContextCompat.getColor(mContext, R.color.text_content));

        int righttextColor = a.getColor(R.styleable.LineEditView_RighttextColor,
                ContextCompat.getColor(mContext, R.color.text_content));

        int editmax = a.getInteger(R.styleable.LineEditView_EditMaxL, -1);

        boolean isShowRight = a.getBoolean(
                R.styleable.LineEditView_isShowRight, false);

        editText.addTextChangedListener(new TextWatcher() {

            @Override
            public void onTextChanged(CharSequence s, int start, int before,
                                      int count) {
                if (isEventInput) {
                    isEventInput = false;
                    if (onHDClickListener != null) {
                        onHDClickListener.OnHdClickListener();
                    }
                }
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count,
                                          int after) {

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        img_clear = (ImageView) findViewById(R.id.img_clear);
        img_clear.setVisibility(View.GONE);
        img_clear.setOnClickListener(this);

        img_show_password = (ImageView) findViewById(R.id.img_show_password);
        img_show_password.setVisibility(View.GONE);
        img_show_password.setOnClickListener(this);

        l_view = findViewById(R.id.l_view);

        tv_right = (TextView) findViewById(R.id.tv_right);
        tv_right.setOnClickListener(this);
        tv_right.setTextColor(righttextColor);

        if (isShowRight) {
            tv_right.setVisibility(View.VISIBLE);
            tv_right.setText(righttext);
        } else {
            tv_right.setVisibility(View.GONE);
        }

        editText.setHint(edithint);
        editText.setText(edittext);

        if (StringUtils.isNotNullOrEmpty(edittext)) {
            editText.setSelection(edittext.length());
        }

        editText.setHintTextColor(ContextCompat.getColor(mContext, R.color.text_hint));
        editText.setTextColor(color);

        // 输入类型，默认可以输入文本
        int inputType = a.getInteger(R.styleable.LineEditView_inputType, -1);
        setInputType(inputType);
        //密码显示密码查看图片
        if (inputType == 18 || inputType == 129) {
            isPassword = true;
        }

        // 在布局里设置digits值是默认弹出字母输入法的
        setDigits(digits, editmax);

        if (showBottomLine) {
            l_view.setVisibility(VISIBLE);
        } else {
            l_view.setVisibility(GONE);
        }

        if (editFocus){
            editText.setOnFocusChangeListener(new OnFocusChangeListener() {
                @Override
                public void onFocusChange(View v, boolean hasFocus) {
                    if (hasFocus) {
                        if (editText.getText().toString().trim().length() > 0) {
                            img_clear.setVisibility(View.VISIBLE);
                            if (isPassword) {
                                img_show_password.setVisibility(VISIBLE);
                            }
                        } else {
                            img_clear.setVisibility(View.GONE);
                            if (isPassword) {
                                img_show_password.setVisibility(GONE);
                            }
                        }
                    } else {
                        img_clear.setVisibility(View.GONE);
                        if (isPassword) {
                            img_show_password.setVisibility(GONE);
                        }
                    }
                }
            });


            editText.addTextChangedListener(new TextWatcher() {
                @Override
                public void onTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
                    if (mAddTextChangedListener != null) {
                        mAddTextChangedListener.onTextChanged(arg0, arg1, arg2, arg3);
                    }
                }

                @Override
                public void beforeTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
                }

                @Override
                public void afterTextChanged(Editable s) {
                    if (editText.isFocused() && s.toString().trim().length() > 0) {
                        img_clear.setVisibility(View.VISIBLE);
                        if (isPassword) {
                            img_show_password.setVisibility(VISIBLE);
                        }
                    } else {
                        img_clear.setVisibility(View.GONE);
                        if (isPassword) {
                            img_show_password.setVisibility(VISIBLE);
                        }
                    }
                }
            });
        }else {
            editText.setFocusable(editFocus);
        }


        CharSequence text = editText.getText();

        if (text != null) {
            Spannable spanText = (Spannable) text;
            Selection.setSelection(spanText, text.length());
        }
    }

    /**
     * 设置digits
     *
     * @param digits 默认弹出是数字
     */
    public void setDigits2(String digits) {
        editText.setKeyListener(DigitsKeyListener.getInstance(digits));
    }

    /**
     * 设置digits和最大字数限制
     *
     * @param digits 默认弹出是字母
     */
    public void setDigits(String digits, int editmax) {

        if (StringUtils.isNullOrEmpty(digits) && editmax < 1) {
            return;
        }

        if (StringUtils.isNotNullOrEmpty(digits)) {
            setDigits(new MyInputFilter(digits));
        }

        if (editmax > 0) {
            setDigits(new InputFilter.LengthFilter(editmax));
        }
    }

    /**
     * 设置digits和最大字数限制
     */
    public void setDigits(InputFilter filter) {
        if (filter == null) {
            return;
        }

        InputFilter[] filters = editText.getFilters();

        InputFilter[] filtersByLs = null;

        if (filters == null) {
            filters = new InputFilter[]{filter};
        } else {
            filtersByLs = new InputFilter[filters.length + 1];
            for (int i = 0; i < filters.length; i++) {
                filtersByLs[i] = filters[i];
            }
            filtersByLs[filters.length] = filter;
        }
        editText.setFilters(filtersByLs != null ? filtersByLs : filters);
    }

    /**
     * 设置输入类型
     */
    public void setInputType(int inputType) {
        if (inputType == -1) {
            return;
        }
        editText.setInputType(inputType); // 输入类型
    }

    /**
     * 设置右侧文本
     */
    public void setRightText(String s) {
        tv_right.setText(s);
    }

    /**
     * 设置文本
     */
    public void setHint(String s) {
        editText.setHint(s);
    }

    /**
     * 设置文本颜色
     */
    public void setTextColor(int color) {
        editText.setTextColor(color);
    }

    /**
     * 获取编辑的文本
     */
    public String getText() {
        return editText.getText().toString().trim();
    }

    /**
     * 设置文本
     */
    public void setText(String s) {
        editText.setText(s);
        if (StringUtils.isNotNullOrEmpty(s)) {
            editText.setSelection(editText.getText().length());
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.img_clear:
                editText.setText("");
                break;
            case R.id.tv_right:
                if (onRightClickListener != null) {
                    onRightClickListener.OnRightClickListener();
                }
                break;
            case R.id.img_show_password:
                if (isPasswordTextVisible) {
                    img_show_password.setImageResource(R.drawable.ic_hide);
                    editText.setTransformationMethod(PasswordTransformationMethod.getInstance());
                    editText.setSelection(editText.getText().length());
                } else {
                    img_show_password.setImageResource(R.drawable.ic_show);
                    editText.setTransformationMethod(HideReturnsTransformationMethod.getInstance());
                    editText.setSelection(editText.getText().length());
                }
                isPasswordTextVisible = !isPasswordTextVisible;
                break;
            default:
                break;
        }
    }

    public interface RightOnClickListener {
        void OnRightClickListener();
    }

    /**
     * 回调接口：输入埋点 只执行一次
     */
    public interface HdOnClickListener {
        /**
         * 回调方法
         */
        void OnHdClickListener();
    }

    /**
     * 回调接口：内容变化
     */
    public interface AddTextChangedListener {
        /**
         * 内容变化方法
         */
        void onTextChanged(CharSequence arg0, int arg1, int arg2, int arg3);
    }

    public class MyInputFilter extends LoginFilter.UsernameFilterGeneric {
        private String mAllowedDigits;

        MyInputFilter(String digits) {
            mAllowedDigits = digits;
        }

        @Override
        public boolean isAllowed(char c) {
            return mAllowedDigits.indexOf(c) != -1;
        }
    }

    public EditText getEditText() {
        return editText;
    }
}
