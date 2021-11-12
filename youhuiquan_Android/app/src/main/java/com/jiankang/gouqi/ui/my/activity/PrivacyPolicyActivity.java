package com.jiankang.gouqi.ui.my.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.webkit.WebView;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.main.entity.ArticleDetailEntity;
import com.jiankang.gouqi.util.HtmlUtil;
import com.jiankang.gouqi.widget.AppBackBar;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;

/**
 * @author: ljx
 * 隐私政策，用户协议
 * @createDate: 2021/7/20  15:47
 */
public class PrivacyPolicyActivity extends BaseMvpActivity {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.webView)
    WebView mWebView;

    private boolean isPrivacy;//是否是隐私政策

    public static void launch(Context context, boolean isPrivacy) {
        Intent intent = new Intent(context, PrivacyPolicyActivity.class);
        intent.putExtra("isPrivacy", isPrivacy);
        context.startActivity(intent);
    }


    @Override
    protected int provideContentViewId() {
        return R.layout.activity_privacy;
    }

    @Override
    public void initView() {
        mWebView.removeJavascriptInterface("searchBoxJavaBridge_");
        mWebView.removeJavascriptInterface("accessibility");
        mWebView.removeJavascriptInterface("accessibilityTraversal");
//        mWebView.setLayerType(View.LAYER_TYPE_HARDWARE, null);
        mWebView.getSettings().setJavaScriptEnabled(false);
        // 设置可以支持缩放
        mWebView.getSettings().setSupportZoom(false);
        //关闭保存密码功能，安全监测要求添加
        mWebView.getSettings().setSavePassword(false);
        mWebView.getSettings().setAllowFileAccess(false);
        //设置出现缩放工具
        mWebView.getSettings().setBuiltInZoomControls(true);
        //扩大比例的缩放
        mWebView.getSettings().setUseWideViewPort(true);
        //自适应屏幕
        mWebView.getSettings().setLoadWithOverviewMode(true);
        if (Build.VERSION.SDK_INT >= 19)
            mWebView.getSettings().setLayoutAlgorithm(android.webkit.WebSettings.LayoutAlgorithm.TEXT_AUTOSIZING);
        else {
            mWebView.getSettings().setLayoutAlgorithm(android.webkit.WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
        }
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {
        isPrivacy = getIntent().getBooleanExtra("isPrivacy",true);
        appBackBar.setTitle(isPrivacy?"隐私政策":"用户协议");
        showLoadDialog("加载中");
        getData();
    }


    private void getData() {
        Map<String, String> map = new HashMap<>();
        map.put("key", isPrivacy?"privacy":"agreement");
        RetrofitService.getData(mContext, ServiceListFinal.agreement,map, new OnNetRequestListener<ApiResponse<ArticleDetailEntity>>() {
            @Override
            public void onSuccess(ApiResponse<ArticleDetailEntity> response) {
                if (response.isSuccess()) {
                    mWebView.loadDataWithBaseURL("file:///android_asset/", HtmlUtil.getHtmlData(response.getData().getContent()), "text/html", "utf-8", null);
                }
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }

}
