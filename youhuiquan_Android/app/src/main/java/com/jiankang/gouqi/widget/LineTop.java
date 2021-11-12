package com.jiankang.gouqi.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.interfaces.LineTopInterface;
import com.jiankang.gouqi.interfaces.ObjectClick;
import com.jiankang.gouqi.util.DisplayUtil;

@SuppressLint("Recycle")
public class LineTop extends RelativeLayout implements OnClickListener {

    /**
     * //黑色图标
     */
    public static final int STYLE_BLACK = 0;
    /**
     * 白色图标
     */
    public static final int STYLE_WHITE = 1;
    private TextView txtRightByLineTop;
    private TextView txtTitleByLineTop;
    private Context mContext;
    /**
     * 单击事件
     */
    private LineTopInterface.LOrRClick lOrRClick;
    /**
     * 右上角图片2点击事件
     */
    private ObjectClick rImg2Click;
    /**
     * 左上角图片2点击事件
     */
    private ObjectClick mLImg2Click;
    private ImageView imgLeftByLineTop;
    private ImageView imgRightByLineTop;
    private TextView txtRightByLineTop2;

    public LineTop(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    /**
     * 初始化
     *
     * @param pContext
     */
    private void init(Context pContext, AttributeSet attrs) {
        mContext = pContext;

        TypedArray a = pContext.obtainStyledAttributes(attrs,
                R.styleable.LineTop);
        String title = a.getString(R.styleable.LineTop_title);
        int theme = a.hasValue(R.styleable.LineTop_colorStyle) ?
                a.getInt(R.styleable.LineTop_colorStyle, STYLE_BLACK) : STYLE_BLACK;
        a.recycle();

        LayoutInflater.from(mContext).inflate(R.layout.line_top, this);
        imgLeftByLineTop = findViewById(R.id.imgLeftByLineTop);
        txtTitleByLineTop = findViewById(R.id.txtTitleByLineTop);
        txtRightByLineTop = findViewById(R.id.txtRightByLineTop);
        imgRightByLineTop = findViewById(R.id.imgRightByLineTop);
        txtRightByLineTop2 = findViewById(R.id.txtRightByLineTop2);

        imgLeftByLineTop.setOnClickListener(this);
        txtRightByLineTop.setOnClickListener(this);
        imgRightByLineTop.setOnClickListener(this);
        txtRightByLineTop2.setOnClickListener(this);

        txtTitleByLineTop.setText(title);

        setTheme(theme);
    }

    //1.白色图标 ，0黑色图标
    public void setTheme(int theme) {
        if (STYLE_WHITE == theme) {
            //深色背景（黑色），白色图标
            imgLeftByLineTop.setImageResource(R.drawable.icon_back_white_arrow);
            txtTitleByLineTop.setTextColor(ContextCompat.getColor(mContext, R.color.white));
            txtRightByLineTop.setTextColor(ContextCompat.getColor(mContext, R.color.white));
            txtRightByLineTop2.setTextColor(ContextCompat.getColor(mContext, R.color.white));
        } else {
            imgLeftByLineTop.setImageResource(R.drawable.ic_back);
            txtTitleByLineTop.setTextColor(ContextCompat.getColor(mContext, R.color.black));
            txtRightByLineTop.setTextColor(ContextCompat.getColor(mContext, R.color.black));
            txtRightByLineTop2.setTextColor(ContextCompat.getColor(mContext, R.color.black));
        }
    }


    /**
     * 设置默认的头部的图片，文字样式等
     */
    public void setTopStyle(String title) {
        txtTitleByLineTop.setText(title);
    }

    /**
     * 单击事件
     */
    public void setLOrRClick(LineTopInterface.LOrRClick iLOrRClick) {
        lOrRClick = iLOrRClick;
    }

    /**
     * 设置右侧图片等
     */
    public void hideRightText() {
        txtRightByLineTop.setVisibility(View.GONE);
    }

    /**
     * 设置右侧图片等
     */
    public void setTopRightStyle(int imgRightId) {
        if (imgRightId == 0) {
            imgRightByLineTop.setVisibility(View.GONE);
        } else {
            imgRightByLineTop.setImageResource(imgRightId);
            imgRightByLineTop.setVisibility(View.VISIBLE);
        }
    }

    public void setTopRightStyle(String rightText) {
        txtRightByLineTop.setVisibility(VISIBLE);
        txtRightByLineTop.setText(rightText);
    }

    public void setTopRightStyle(String rightText,boolean isShowDrawble) {
        txtRightByLineTop.setVisibility(VISIBLE);
        txtRightByLineTop.setText(rightText);
        if (isShowDrawble){
            Drawable drawable = mContext.getResources().getDrawable(R.drawable.ic_shared);
            drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());
            txtRightByLineTop.setCompoundDrawables(drawable,null,null,null);
        }
    }
    /**
     * 设置默认的头部的图片，文字样式等
     */
    public void setTopStyle(String title, String rightTxt) {
        txtRightByLineTop.setVisibility(View.VISIBLE);
        txtRightByLineTop.setText(rightTxt);
        txtTitleByLineTop.setText(title);
    }

    /**
     * 设置默认的头部的图片，文字样式等
     */
    public void setTopStyle(String title, String rightTxt, int rColor,
                            boolean isCanClick) {
        txtRightByLineTop.setVisibility(View.VISIBLE);
        txtRightByLineTop.setText(rightTxt);
        txtTitleByLineTop.setText(title);
        txtRightByLineTop.setTextColor(rColor);
        if (isCanClick) {
            txtRightByLineTop.setOnClickListener(this);
        } else {
            txtRightByLineTop.setOnClickListener(null);
        }
    }

    /**
     * 设置头部标题，右侧按钮
     */
    public void setTopStyle(String title, String rightTxt, int rightBg,
                            int rColor) {
        txtRightByLineTop2.setVisibility(View.VISIBLE);
        txtRightByLineTop2.setText(rightTxt);
        txtTitleByLineTop.setText(title);

        txtRightByLineTop2.setBackgroundResource(rightBg);

        txtRightByLineTop2.setTextColor(rColor);
    }

    /**
     * 设置头部的图片，文字样式等
     */
    public void setTopStyle(int imgLeftId, int imgRightId, String title) {
        setRtxtGone();
        txtTitleByLineTop.setText(title);
        if (imgLeftId == 0) {
            imgLeftByLineTop.setVisibility(View.GONE);
        } else {
            imgLeftByLineTop.setVisibility(View.VISIBLE);
            imgLeftByLineTop.setImageResource(imgLeftId);
        }
        if (imgRightId == 0) {
            imgRightByLineTop.setVisibility(View.GONE);
        } else {
            imgRightByLineTop.setImageResource(imgRightId);
            imgRightByLineTop.setVisibility(View.VISIBLE);
        }
    }

    public void setTopStyle(int imgLeftId, String rightText, String title) {

        txtTitleByLineTop.setText(title);
        if (imgLeftId == 0) {
            imgLeftByLineTop.setVisibility(View.GONE);
        } else {
            imgLeftByLineTop.setVisibility(View.VISIBLE);
            imgLeftByLineTop.setImageResource(imgLeftId);
        }

        imgRightByLineTop.setVisibility(View.GONE);
        txtRightByLineTop.setVisibility(VISIBLE);
        txtRightByLineTop.setText(rightText);
    }

    public void setLightStyle(int imgLeftId, int imgRightId, String title) {
        setRtxtGone();
        txtTitleByLineTop.setPadding(0, 0, 0, 0);
        txtTitleByLineTop.setGravity(Gravity.CENTER);
        int pad = DisplayUtil.dip2px(mContext, 3);
        imgLeftByLineTop.setPadding(pad, pad, pad, pad);
        txtTitleByLineTop.setText(title);
        txtTitleByLineTop.setTextColor(ContextCompat.getColor(mContext, R.color.black));
        if (imgLeftId == 0) {
            imgLeftByLineTop.setVisibility(View.GONE);
        } else {
            imgLeftByLineTop.setVisibility(View.VISIBLE);
            imgLeftByLineTop.setImageResource(imgLeftId);
        }
        if (imgRightId == 0) {
            imgRightByLineTop.setVisibility(View.GONE);
        } else {
            imgRightByLineTop.setImageResource(imgRightId);
            imgRightByLineTop.setVisibility(View.VISIBLE);
        }
    }

    /**
     * 设置头部的图片，文字样式等
     */
    public void setRightImg2(int imgRightId2, int padding,
                             ObjectClick pRImg2Click) {
        rImg2Click = pRImg2Click;
        ImageView imgRightByLineTop2 = (ImageView) findViewById(R.id.imgRightByLineTop2);
        imgRightByLineTop2.setOnClickListener(this);
        if (imgRightId2 == 0) {
            imgRightByLineTop2.setVisibility(View.GONE);
        } else {
            imgRightByLineTop2.setVisibility(View.VISIBLE);
            imgRightByLineTop2.setImageResource(imgRightId2);
            int paddingPx = DisplayUtil.dip2px(mContext, padding);
            imgRightByLineTop2.setPadding(paddingPx, paddingPx, paddingPx,
                    paddingPx);
        }
    }

    /**
     * 设置左边第二个图片显示
     */
    public void setLeftImg2Visible(boolean imgVisible, ObjectClick lImg2Click) {
        mLImg2Click = lImg2Click;
        ImageView imgLeftByLineTop2 = (ImageView) findViewById(R.id.iv_left_close);
        ImageView imgRightByLineTop2 = (ImageView) findViewById(R.id.iv_right_close);
        imgLeftByLineTop2.setVisibility(imgVisible ? VISIBLE:GONE);
        imgRightByLineTop2.setVisibility(imgVisible ? VISIBLE:GONE);
        imgLeftByLineTop2.setOnClickListener(this);
    }

    /**
     * 设置右侧文本显示
     */
    public void setRtxtVisble() {
        txtRightByLineTop.setVisibility(View.VISIBLE);
        txtRightByLineTop.setOnClickListener(this);
    }

    /**
     * 设置右侧文本显示
     */
    public String getRtxt() {
        return txtRightByLineTop.getText().toString().trim();
    }

    /**
     * 设置右侧文本显示
     */
    public void setRtxt(String rtext) {
        txtRightByLineTop.setVisibility(View.VISIBLE);
        findViewById(R.id.imgRightByLineTop).setVisibility(View.GONE);
        txtRightByLineTop.setOnClickListener(this);
        txtRightByLineTop.setText(rtext);
    }

    /**
     * 设置右侧文本的左图标
     */
    public void setRtxtLeftImg(int drawble) {
        Drawable drawable = mContext.getResources().getDrawable(drawble);
        drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());
        txtRightByLineTop.setCompoundDrawables(drawable,null,null,null);
        txtRightByLineTop.setCompoundDrawablePadding(5);
    }

    /**
     * 设置右侧文本显示
     */
    public void setRtxtColor(int c) {
        txtRightByLineTop.setTextColor(c);
    }

    /**
     * 设置右侧文本显示
     */
    public void setRClickNull() {
        txtRightByLineTop.setOnClickListener(null);
        txtRightByLineTop.setBackgroundResource(0);
    }

    /**
     * 设置右侧文本显示
     */
    public void setRClick() {
        txtRightByLineTop.setOnClickListener(this);
    }

    /**
     * 设置右侧文本消失
     */
    public void setRtxtGone() {
        findViewById(R.id.txtRightByLineTop).setVisibility(View.GONE);
    }

    public void setRGone() {
        findViewById(R.id.txtRightByLineTop).setVisibility(View.GONE);
        findViewById(R.id.imgRightByLineTop).setVisibility(View.GONE);
    }

    /**
     * 设置头部的标题
     */
    public void setTitle(String title) {
        TextView txtTitle = (TextView) findViewById(R.id.txtTitleByLineTop);
        txtTitle.setText(title);
    }

    public void hideShadow() {
    }

    /**
     * 内部padding
     */
    public void setRightPadding(Context mContext, int size) {
        ImageView imgRight = (ImageView) findViewById(R.id.imgRightByLineTop);
        int paddingPx = DisplayUtil.dip2px(mContext, size);
        imgRight.setPadding(paddingPx, paddingPx, paddingPx, paddingPx);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.imgLeftByLineTop:
                if (lOrRClick != null) {
                    lOrRClick.leftClick();
                }
                break;
            case R.id.imgRightByLineTop:
            case R.id.txtRightByLineTop:
            case R.id.txtRightByLineTop2:
                if (lOrRClick != null) {
                    lOrRClick.rightClick();
                }
                break;
            case R.id.imgRightByLineTop2:
                if (rImg2Click != null) {
                    rImg2Click.callback(null);
                }
                break;
            case R.id.iv_left_close:
                if (mLImg2Click != null) {
                    mLImg2Click.callback(null);
                }
                break;
            default:
                break;
        }
    }
}
