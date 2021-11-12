package com.blandal.app.dialog;

import android.app.Dialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.blandal.app.R;
import com.blandal.app.common.MyHandler;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.util.LoginUtils;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UmengEventUtils;


/**
 * 分享
 */
public class SharedDialog extends Dialog implements View.OnClickListener {
    private Context mContext;
    private String sharedUrl;
    private String sharedContent;//分享中的内容content
    private String defaultTitle;
    private double taskFee;
    private int type;// 1:任务分享 2：赚钱计划分享
    private String shareIconUrl;
    public static int TYPE_TASK = 1;// 1:任务分享
    public static int TYPE_RAISE = 2;// 2：赚钱计划分享

    /**
     * @param mContext
     * @param sharedUrl 分享链接
     * @param taskTitle 任务标题（分享的副标题）
     * @param type      1:任务分享 2：赚钱计划分享
     * @param taskFee   任务佣金
     */
    public SharedDialog(Context mContext, String sharedUrl, String taskTitle, int type, double taskFee) {
        super(mContext, R.style.my_dialog);
        this.mContext = mContext;
        this.sharedUrl = sharedUrl;
        this.sharedContent = taskTitle;
        this.type = type;
        this.taskFee = taskFee;
        initview();
    }

    private void initview() {
        if (!LoginUtils.isUserLogin(mContext)){
            LoginUtils.toLoginActivity(new MyHandler(), mContext);
            return;
        }
        setContentView(R.layout.shared_dialog);
        setCanceledOnTouchOutside(true);
        show();
        TextView tvCancle = findViewById(R.id.tv_cancle);
        TextView tvTitle = findViewById(R.id.tv_title);
        LinearLayout llWeixin = findViewById(R.id.ll_weixin);
        LinearLayout llWeixinCircle = findViewById(R.id.ll_weixin_circle);
        LinearLayout llQQ = findViewById(R.id.ll_qq);
        LinearLayout llQQSpace = findViewById(R.id.ll_qq_space);
        LinearLayout llCopyLink = findViewById(R.id.ll_copy_link);
        LinearLayout llPoster = findViewById(R.id.ll_poster);
        if (type == TYPE_TASK){
            tvTitle.setVisibility(View.GONE);
        }else {
            tvTitle.setVisibility(View.VISIBLE);
        }

        llWeixin.setOnClickListener(this);
        llWeixinCircle.setOnClickListener(this);
        llQQ.setOnClickListener(this);
        llQQSpace.setOnClickListener(this);
        llCopyLink.setOnClickListener(this);
        llPoster.setOnClickListener(this);
        tvCancle.setOnClickListener(this);

        Window window = getWindow();
        window.getDecorView().setPadding(0, 0, 0, 0);
        WindowManager.LayoutParams params = window.getAttributes();
        params.width = ViewGroup.LayoutParams.MATCH_PARENT;
        params.gravity = Gravity.BOTTOM;
        window.setAttributes(params);

        defaultTitle = mContext.getResources().getString(R.string.shared_title);//默认分享标题
        shareIconUrl = "http://wodan-idc.oss-cn-hangzhou.aliyuncs.com/apk/resource/zwz_logo.png";//默认分享图标
        if (UserGlobal.mSharedInfo != null) {
            if (type == TYPE_RAISE) {
                sharedUrl = UserGlobal.mSharedInfo.share_url;
                defaultTitle = UserGlobal.mSharedInfo.main_title;
                sharedContent = UserGlobal.mSharedInfo.sub_title;
                shareIconUrl = UserGlobal.mSharedInfo.share_icon_url;
            }
        }
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_weixin:
                // 分享到微信
//                MobSharedUtils.sharedWX(defaultTitle, sharedContent, shareIconUrl, sharedUrl, SHARE_WEBPAGE, "");
                if (type == TYPE_TASK) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_TASK_DETAIL_SHARED_WX);
                } else if (type == TYPE_RAISE) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_RAISE_MONEY_SHARED_WX);
                }
                break;
            case R.id.ll_weixin_circle:
                // 分享到朋友圈
//                MobSharedUtils.sharedWechatMoments(defaultTitle, sharedContent, shareIconUrl, sharedUrl, SHARE_WEBPAGE, "");
                if (type == TYPE_TASK) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_TASK_DETAIL_SHARED_WX_CIRCLE);
                } else if (type == TYPE_RAISE) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_RAISE_MONEY_SHARED_WX_CIRCLE);
                }
                break;
            case R.id.ll_qq:
                // qq
//                MobSharedUtils.sharedQQ(defaultTitle, sharedContent,
//                        shareIconUrl,
//                        sharedUrl, SHARE_WEBPAGE, "");
                if (type == TYPE_TASK) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_TASK_DETAIL_SHARED_QQ);
                } else if (type == TYPE_RAISE) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_RAISE_MONEY_SHARED_QQ);
                }
                break;
            case R.id.ll_qq_space:
                // qq空间
//                MobSharedUtils.shareQQZone(defaultTitle, sharedContent,
//                        shareIconUrl,
//                        sharedUrl, SHARE_WEBPAGE, "");
                if (type == TYPE_TASK) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_TASK_DETAIL_SHARED_QQ_SPACE);
                } else if (type == TYPE_RAISE) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_RAISE_MONEY_SHARED_QQ_SPACE);
                }
                break;
            case R.id.ll_copy_link:
                String copyContent ;
                if (type == TYPE_RAISE){
                    copyContent =UserGlobal.mSharedTaskInfo.distribution_share_text +sharedUrl;
                }else {
                    copyContent =UserGlobal.mSharedTaskInfo.task_share_text +sharedUrl;
                }
                ClipboardManager cm = (ClipboardManager) mContext.getSystemService(Context.CLIPBOARD_SERVICE);
                ClipData mClipData = ClipData.newPlainText("Label", copyContent);
                cm.setPrimaryClip(mClipData);
                ToastShow.showMsg(mContext, "复制成功");
                if (type == TYPE_TASK) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_TASK_DETAIL_SHARED_COPY_LINK);
                } else if (type == TYPE_RAISE) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_RAISE_MONEY_SHARED_COPY_LINK);
                }
                break;
            case R.id.ll_poster:
                if (type == 1) {
                    new SharedTaskPosterDialog(mContext, sharedUrl, sharedContent, taskFee);
                } else {
                    new SharedPosterDialog(mContext);
                }
                if (type == TYPE_TASK) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_TASK_DETAIL_SHARED_POSTER);
                } else if (type == TYPE_RAISE) {
                    UmengEventUtils.pushCommonEvent(mContext, UmengEventUtils.EVENT_RAISE_MONEY_SHARED_POSTER);
                }
                break;
            case R.id.tv_cancel:
                break;
        }
        dismiss();
    }
}