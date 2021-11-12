package com.blandal.app.common.activity;

import android.os.Bundle;
import android.view.WindowManager;
import android.widget.ProgressBar;

import com.blandal.app.R;
import com.blandal.app.base.BaseActivity;

import com.blandal.app.widget.MyWebView;


/**
 * 工具页面 嵌入wap页面
 *
 * @author Administrator
 */
public class UWebActivity extends BaseActivity {

    MyWebView webBrowser;
    ProgressBar pbWeb;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        super.setEnableGesture(false);

        getWindow().setSoftInputMode(
                WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE
                        | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);

        setContentView(R.layout.activity_web);

        webBrowser = (MyWebView) findViewById(R.id.webBrowser);
        pbWeb = (ProgressBar) findViewById(R.id.pb_web);

    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }


}
