package com.blandal.app.dialog;

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

import com.blandal.app.R;
import com.blandal.app.common.MyHandler;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.util.ImageUtils;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.ZXingUtils;


/**
 * 赚钱计划分享海报
 */
public class SharedPosterDialog extends Dialog implements View.OnClickListener {
    private Context context;
    private Bitmap code;
    private RelativeLayout rlPoster;
    private String phone;
    private String share_url;//带参分享链接;
    private String main_title;// 分享链接主标题;
    private String sub_title;  //分享链接副标题;
    private String share_icon_url;//分享图标url;


    public SharedPosterDialog(Context context) {
        super(context, R.style.my_dialog);
        this.context = context;
        setContentView(R.layout.dialog_shared_poster);
        initview();
    }

    private void initview() {
        if (UserGlobal.mSharedInfo != null) {
            share_url = UserGlobal.mSharedInfo.share_url;
            main_title = UserGlobal.mSharedInfo.main_title;
            sub_title = UserGlobal.mSharedInfo.sub_title;
            share_icon_url = UserGlobal.mSharedInfo.share_icon_url;
        }
        if (StringUtils.isNotNullOrEmpty(share_url)) {
            code = ZXingUtils.createQRImage(share_url, 300, 300, null);
        }
        setCanceledOnTouchOutside(true);
        show();
        ImageView ivCode = findViewById(R.id.iv_code);
        TextView tvTitle = findViewById(R.id.tv_title);
        TextView tvCancle = findViewById(R.id.tv_cancle);
        TextView tvSave = findViewById(R.id.tv_save);
        LinearLayout llWeixin = findViewById(R.id.ll_weixin);
        LinearLayout llWeixinCircle = findViewById(R.id.ll_weixin_circle);
        LinearLayout llQQ = findViewById(R.id.ll_qq);
        LinearLayout llQQSpace = findViewById(R.id.ll_qq_space);
        rlPoster = findViewById(R.id.rl_poster);

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
                tvTitle.setText(phone + "给您发了一个红包");
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