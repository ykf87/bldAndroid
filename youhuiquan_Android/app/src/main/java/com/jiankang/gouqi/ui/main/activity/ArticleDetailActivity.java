package com.jiankang.gouqi.ui.main.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.style.ClickableSpan;
import android.view.View;
import android.webkit.WebView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.main.entity.ArticleDetailEntity;
import com.jiankang.gouqi.util.HtmlUtil;
import com.jiankang.gouqi.util.TimeUtil;
import com.jiankang.gouqi.util.ToastShow;
import com.jiankang.gouqi.widget.AppBackBar;

/**
 * @author: ljx
 * @createDate: 2021/7/20  15:47
 */
public class ArticleDetailActivity extends BaseMvpActivity {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.webView)
    WebView mWebView;
    @BindView(R.id.tv_scan)
    TextView tvScan;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_title)
    TextView tv_title;
    @BindView(R.id.ll_scan_time)
    LinearLayout llScanTime;
    @BindView(R.id.tv_task_scan_time)
    TextView tvTaskScanTime;

    private int id;
    ArticleDetailEntity entity;
    public int scanJobTime = 10;//页面计时时间
    private boolean isFromIntegral;

    public static void launch(Context context, int id) {
        Intent intent = new Intent(context, ArticleDetailActivity.class);
        intent.putExtra("id", id);
        context.startActivity(intent);
    }

    public static void launch(Context context, int id,boolean isFromIntegral) {
        Intent intent = new Intent(context, ArticleDetailActivity.class);
        intent.putExtra("id", id);
        intent.putExtra("isFromIntegral", isFromIntegral);
        context.startActivity(intent);
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_article_detail;
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
        appBackBar.setOnBarLastImageViewClickListener(new AppBackBar.OnBarClickListener() {
            @Override
            public void onClick() {
                collect();
            }
        });
    }

    @Override
    public void initData() {
        id = getIntent().getIntExtra("id", 0);
        isFromIntegral = getIntent().getBooleanExtra("isFromIntegral",false);
        showLoadDialog("加载中");
        getData();
        scanTask();
    }


    private void getData() {
        Map<String, String> map = new HashMap<>();
        map.put("id", String.valueOf(id));
        RetrofitService.getData(mContext, ServiceListFinal.articleDetail+id,null, new OnNetRequestListener<ApiResponse<ArticleDetailEntity>>() {
            @Override
            public void onSuccess(ApiResponse<ArticleDetailEntity> response) {
                if (response.isSuccess()) {
                    entity = response.getData();
                    mWebView.loadDataWithBaseURL("file:///android_asset/", HtmlUtil.getHtmlData(response.getData().getContent()), "text/html", "utf-8", null);
                    tvScan.setText("收藏：" + response.getData().getHearted());
                    tvTime.setText(TimeUtil.stampToDate(response.getData().getCreated_at()));
                    tv_title.setText(response.getData().getTitle());
                    appBackBar.setLastDrawable(entity.isIs_heart()?R.drawable.ic_colletion_sel:R.drawable.ic_collection);
                }
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }

    private void collect() {
        showLoadDialog("请求中");
        Map<String, String> map = new HashMap<>();
        map.put("id", String.valueOf(id));
        RetrofitService.postData(mContext, ServiceListFinal.collect, map, new OnNetRequestListener<ApiResponse<ArticleDetailEntity>>() {
            @Override
            public void onSuccess(ApiResponse<ArticleDetailEntity> response) {
                if (response.isSuccess()) {
                    if (entity != null) {
                        ToastShow.showMsg(response.getMsg());
                       entity.setIs_heart(!entity.isIs_heart());
                       appBackBar.setLastDrawable(entity.isIs_heart()?R.drawable.ic_colletion_sel:R.drawable.ic_collection);
                    }
                }
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }


    /**
     * 积分模块 浏览任务
     */
    public void scanTask() {
        //任务浏览
        if (isFromIntegral) {
            llScanTime.setVisibility(View.VISIBLE);
            SpannableString timeString = new SpannableString(String.valueOf(scanJobTime));
            timeString.setSpan(new ClickableSpan() {
                @Override
                public void onClick(View widget) {
                }

                @Override
                public void updateDrawState(TextPaint ds) {
                    super.updateDrawState(ds);
                    ds.setColor(ContextCompat.getColor(tvTaskScanTime.getContext(), R.color.color_FFE67B));
                    ds.setUnderlineText(false);
                }
            }, 0, timeString.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            tvTaskScanTime.setText("");
            tvTaskScanTime.append("浏览");
            tvTaskScanTime.append(timeString);
            tvTaskScanTime.append("S");
            handler.post(scanJobTimeRunnable);
        }
    }

    /**
     * 岗位浏览任务 倒计时
     */
    private Runnable scanJobTimeRunnable = new Runnable() {
        @Override
        public void run() {
            SpannableString timeString = new SpannableString(String.valueOf(scanJobTime));
            timeString.setSpan(new ClickableSpan() {
                @Override
                public void onClick(View widget) {
                }

                @Override
                public void updateDrawState(TextPaint ds) {
                    super.updateDrawState(ds);
                    ds.setColor(ContextCompat.getColor(tvTaskScanTime.getContext(), R.color.color_FFE67B));
                    ds.setUnderlineText(false);
                }
            }, 0, timeString.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            if (tvTaskScanTime != null) {
                tvTaskScanTime.setText("");
                tvTaskScanTime.append("浏览");
                tvTaskScanTime.append(timeString);
                tvTaskScanTime.append("S");
            }
            if (scanJobTime == 0) {
                if (tvTaskScanTime != null) {
                    tvTaskScanTime.setText("浏览完成");
                    scanSuccess();
                }
                handler.removeCallbacks(scanJobTimeRunnable);
                return;
            }
            scanJobTime--;
            handler.mPostDelayed(scanJobTimeRunnable, 1000);
        }
    };

    //文章浏览结束发放奖励
    private void scanSuccess() {
        Map map = new HashMap();
        map.put("type",2);
        RetrofitService.postData(mContext, ServiceListFinal.videoSuccess, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    ToastShow.showMsg("恭喜您获得10枸币");
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }
}
