package com.jiankang.gouqi.dialog;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.common.MyHandler;
import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.util.ImageUtils;
import com.jiankang.gouqi.util.StringUtils;
import com.jiankang.gouqi.util.TimeUtil;
import com.jiankang.gouqi.util.ZXingUtils;


/**
 * 任务详情分享海报
 */
public class SharedTaskPosterDialog extends Dialog implements View.OnClickListener {
    private Context context;
    private Bitmap code;
    private RelativeLayout rlPoster;
    private String phone;
    private String share_url;//带参分享链接;
    private String main_title;// 分享链接主标题;
    private String sub_title;  //分享链接副标题;
    private String share_icon_url;//分享图标url;
    private double taskFee;


    public SharedTaskPosterDialog(Context context, String share_url, String sub_title, double taskFee) {
        super(context, R.style.my_dialog);
        this.context = context;
        this.share_url = share_url;
        this.sub_title = sub_title;
        this.taskFee = taskFee;
        setContentView(R.layout.dialog_shared_task_poster);
        initview();
    }

    private void initview() {

        if (StringUtils.isNotNullOrEmpty(share_url)) {
            code = ZXingUtils.createQRImage(share_url, 600, 600, null);
        }
        setCanceledOnTouchOutside(true);
        show();
        TextView tvTitle = findViewById(R.id.tv_title);
        ImageView ivCode = findViewById(R.id.iv_code);
        TextView tvTaskFee = findViewById(R.id.tv_task_fee);
        TextView tvCancle = findViewById(R.id.tv_cancle);
        TextView tvSave = findViewById(R.id.tv_save);
        LinearLayout llWeixin = findViewById(R.id.ll_weixin);
        LinearLayout llWeixinCircle = findViewById(R.id.ll_weixin_circle);
        LinearLayout llQQ = findViewById(R.id.ll_qq);
        LinearLayout llQQSpace = findViewById(R.id.ll_qq_space);
        rlPoster = findViewById(R.id.rl_poster);

        tvTitle.setText(sub_title);
        tvTaskFee.setText(TimeUtil.taskFee(taskFee) + "元/次");

        llWeixin.setOnClickListener(this);
        llWeixinCircle.setOnClickListener(this);
        llQQ.setOnClickListener(this);
        llQQSpace.setOnClickListener(this);
        tvCancle.setOnClickListener(this);
        tvSave.setOnClickListener(this);

        if (code != null) {
            ivCode.setImageBitmap(code);
        }
        if (UserGlobal.mGlobalConfigInfo != null) {
            phone = UserGlobal.mGlobalConfigInfo.basic_info.telphone;
            if (StringUtils.isNotNullOrEmpty(phone)) {
                phone = phone.substring(0, 3) + "****" + phone.substring(7, 11);
            }
        }

        Window window = getWindow();
        window.getDecorView().setPadding(0, 0, 0, 0);
        WindowManager.LayoutParams params = window.getAttributes();
        params.width = ViewGroup.LayoutParams.MATCH_PARENT;
        params.gravity = Gravity.BOTTOM;
        window.setAttributes(params);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_weixin:
                // 分享到微信
                new MyHandler().post(new Runnable() {
                    @Override
                    public void run() {
                        ImageUtils.upLoadImage(context, ImageUtils.getImgPath(context, ImageUtils.getPosterBitmap(rlPoster)), new ImageUtils.ImageCallbcack() {
                            @Override
                            public void getImgUrl(String url) {
//                                MobSharedUtils.sharedWX(main_title, sub_title, share_icon_url, share_url, SHARE_IMAGE, url);
                            }
                        });
                    }
                });
                break;
            case R.id.ll_weixin_circle:
                // 分享到朋友圈
                new MyHandler().post(new Runnable() {
                    @Override
                    public void run() {
                        ImageUtils.upLoadImage(context, ImageUtils.getImgPath(context, ImageUtils.getPosterBitmap(rlPoster)), new ImageUtils.ImageCallbcack() {
                            @Override
                            public void getImgUrl(String url) {
//                                MobSharedUtils.sharedWechatMoments(main_title, sub_title, share_icon_url, share_url, SHARE_IMAGE, url);
                            }
                        });
                    }
                });

                break;
            case R.id.ll_qq:
                // qq
                new MyHandler().post(new Runnable() {
                    @Override
                    public void run() {
                        ImageUtils.upLoadImage(context, ImageUtils.getImgPath(context, ImageUtils.getPosterBitmap(rlPoster)), new ImageUtils.ImageCallbcack() {
                            @Override
                            public void getImgUrl(String url) {
//                                MobSharedUtils.sharedQQ(main_title, sub_title, share_icon_url, share_url, SHARE_IMAGE, url);
                            }
                        });
                    }
                });

                break;
            case R.id.ll_qq_space:
                new MyHandler().post(new Runnable() {
                    @Override
                    public void run() {
                        ImageUtils.upLoadImage(context, ImageUtils.getImgPath(context, ImageUtils.getPosterBitmap(rlPoster)), new ImageUtils.ImageCallbcack() {
                            @Override
                            public void getImgUrl(String url) {
//                                MobSharedUtils.shareQQZone(main_title, sub_title, share_icon_url, share_url, SHARE_IMAGE, url);
                            }
                        });
                    }
                });

                break;
            case R.id.tv_cancel:
                break;
            case R.id.tv_save:
                ImageUtils.saveScreenImage(context, rlPoster);
                break;
        }
        dismiss();
    }

}