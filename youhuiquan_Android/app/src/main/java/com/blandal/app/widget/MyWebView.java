package com.blandal.app.widget;

import android.content.Context;
import android.content.res.Configuration;
import android.os.Build;
import android.util.AttributeSet;
import android.webkit.WebView;

public class MyWebView extends WebView {

    public MyWebView(Context context) {
        super(getFixedContext(context));
    }

    public MyWebView(Context context, AttributeSet attrs) {
        super(getFixedContext(context), attrs);
    }

    public MyWebView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(getFixedContext(context), attrs, defStyleAttr);
    }

    // To fix Android Lollipop WebView problem create a new configuration on that Android version only
    private static Context getFixedContext(Context context) {
        // Android Lollipop 5.0 & 5.1
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP || Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return context.createConfigurationContext(new Configuration());
        }
        return context;
    }
}
