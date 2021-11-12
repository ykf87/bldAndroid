package com.jiankang.gouqi.util;

import android.app.Activity;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.net.Uri;
import android.os.Looper;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.Display;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;

import java.text.DecimalFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.jiankang.gouqi.app.MyApplication;
import com.jiankang.gouqi.common.activity.UWebActivity;


public class DisplayUtil {

    public static int dip2px(Context context, int dp) {
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dp, context.getResources().getDisplayMetrics());
    }


    protected static int sp2px(Context context, int sp) {
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_SP, sp, context.getResources().getDisplayMetrics());
    }


    public static int px2dp(Context context, float pxValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (pxValue / scale + 0.5f);
    }


    public static int dp2px(Context context, float dipValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dipValue * scale + 0.5f);
    }


    public static int px2sp(Context context, float pxValue) {
        final float fontScale = context.getResources().getDisplayMetrics().scaledDensity;
        return (int) (pxValue / fontScale + 0.5f);
    }


    public static int sp2px(Context context, float spValue) {
        final float fontScale = context.getResources().getDisplayMetrics().scaledDensity;
        return (int) (spValue * fontScale + 0.5f);
    }

    public static Bitmap bitmapResize(Bitmap src, float pxX, float pxY) {
        //压缩图片
        Matrix matrix = new Matrix();
        matrix.postScale(pxX / src.getWidth(), pxY / src.getHeight());
        Bitmap ret = Bitmap.createBitmap(src, 0, 0, src.getWidth(), src.getHeight(), matrix, true);
        return ret;
    }


    public static int getScreenWidth(Context context) {
        DisplayMetrics dm = context.getResources().getDisplayMetrics();
        return dm.widthPixels;
    }

    public static int getScreenWidthDp(Context context) {
        DisplayMetrics dm = context.getResources().getDisplayMetrics();
        return px2dp(context, dm.widthPixels);
    }

    public static int getScreenHeight(Context context) {
        DisplayMetrics dm = context.getResources().getDisplayMetrics();
        return dm.heightPixels;
    }

    public static int getScreenHeightDp(Context context) {
        DisplayMetrics dm = context.getResources().getDisplayMetrics();
        return px2dp(context, dm.heightPixels);
    }

    /**
     * 当前方法是否在主线程里面运行
     *
     * @return
     */
    public static boolean isMainThread() {
        // 当前方法是主线程里面运行
        return Looper.myLooper() == Looper.getMainLooper();
    }

    /**
     * 提示日志，发布时候注掉内容
     */
    public static void outLog(String txt) {
        if (txt != null) {
            LogUtils.test(txt);
        }
    }

    /**
     * 获取屏幕宽度
     */
    public static int getWidth(Context mContext) {
        WindowManager windowManager = (WindowManager) mContext
                .getSystemService(Context.WINDOW_SERVICE);
        Display display = windowManager.getDefaultDisplay();
        return display.getWidth();
    }

    /**
     * 获取屏幕高度
     */
    public static int getHeight(Context mContext) {
        WindowManager windowManager = (WindowManager) mContext
                .getSystemService(Context.WINDOW_SERVICE);
        Display display = windowManager.getDefaultDisplay();
        return display.getHeight();
    }

    /**
     * 判断字符串非等于空
     */
    public static boolean isNotNullOrEmpty(String val) {
        if (val == null)
            return false;
        if (val.trim().length() > 0)
            return true;
        return false;
    }

    /**
     * 隐藏软键盘
     */
    public static void hideInput(Context mContext) {
        hideInput(mContext, InputMethodManager.HIDE_NOT_ALWAYS);
    }

    /**
     * 隐藏软键盘
     */
    public static void hideInput(Context mContext, int flags) {

        if (((Activity) mContext).getCurrentFocus() == null) {
            return;
        }

        InputMethodManager inputMethodManager = (InputMethodManager) mContext
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        inputMethodManager.hideSoftInputFromWindow(((Activity) mContext)
                        .getCurrentFocus().getWindowToken(),
                flags);
    }

    public static boolean isMobile(String mobiles) {
        Pattern p = null;
        Matcher m = null;
        boolean b = false;
        p = Pattern.compile("^[1][3,4,5,7,8,9][0-9]{9}$"); // 验证手机号
        m = p.matcher(mobiles);
        b = m.matches();
        return b;
    }

    /**
     * 判断字符串空
     *
     * @param val
     * @return
     */
    public static boolean isNullOrEmpty(String val) {
        if (val == null)
            return true;
        if (val.trim().length() < 1)
            return true;
        return false;
    }

    /**
     * 获取屏幕高度
     *
     * @return
     */
    public static int getScreenHeight() {
        Resources resources = MyApplication.getInstance().getResources();
        DisplayMetrics dm = resources.getDisplayMetrics();
        return dm.heightPixels;
    }

    /**
     * 金额保留两位小数
     */
    public static String DecimalFormatTwo(double f) {
        DecimalFormat df = new DecimalFormat("#0.00");
        return df.format(f);
    }

    /**
     * 调用默认浏览器打开网址
     */
    public static void openUrl(Context mContext, String url) {
        if (url == null || "".equals(url) || url.startsWith("http") == false) {
            return;
        }
        try {
            Intent intent = new Intent();
            intent.setAction("android.intent.action.VIEW");
            Uri content_url = Uri.parse(url);
            intent.setData(content_url);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            mContext.startActivity(intent);
        } finally {
        }
    }

    /**
     * app内打开链接
     * @param mContext
     * @param url
     * @param pIsShared
     */
    public static void openUrlByApp(Context mContext, String url,
                                    boolean pIsShared) {
        if (url == null || "".equals(url) || url.startsWith("http") == false) {
            return;
        }
//        String token = UserShared.getToken(mContext);
//        int cityId = Integer.parseInt(UserShared.getUserIndexCityId(mContext));
//        if (!url.contains("?")) {
//            url += "?app_user_token=" + token + "&city_id=" + cityId;
//        } else {
//            url += "&app_user_token=" + token + "&city_id=" + cityId;
//        }
        Intent intent = new Intent(mContext, UWebActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.putExtra("url", url);
        intent.putExtra("isDealUrl", true);
        intent.putExtra("isShared", pIsShared);
        mContext.startActivity(intent);
    }

    /**
     * 开屏广告
     */
    public static void openUrlByAppFromAdActivity(Context mContext, String url, boolean pIsShared) {
        if (url == null || "".equals(url) || url.startsWith("http") == false) {
            return;
        }
        Intent intent = new Intent(mContext, UWebActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.putExtra("url", url);
        intent.putExtra("isShared", pIsShared);
        intent.putExtra("from_ad_activity", true);
        mContext.startActivity(intent);
    }


    /**
     * 复制内容到黏贴板
     */
    public static void copyText(Context mContext, String content) {
        ClipboardManager c = (ClipboardManager) mContext
                .getSystemService(Context.CLIPBOARD_SERVICE);
        c.setText(content);// 设置Clipboard 的内容
    }

}
