package com.blandal.app.dialog;

import android.app.ProgressDialog;
import android.content.Context;
import android.graphics.drawable.AnimationDrawable;
import android.os.Handler;
import android.os.Looper;
import android.widget.ImageView;
import android.widget.TextView;

import com.blandal.app.R;
import com.blandal.app.interfaces.ObjectCallback;


/**
 * 弹出进度条
 *
 * @author Administrator
 */
public class ProgressDialogShow {

    public static ProgressDialog loadBar = null;

    static AnimationDrawable mAnimation;

    /**
     * 显示加载进度条
     */
    public static TextView showLoadDialog(Context context, boolean cancelable,
                                          String txtContent) {
        try {

            dismissDialog(null);

            if (loadBar == null) {

                // 加载进度条
                loadBar = new ProgressDialog(context,
                        R.style.ProgressDialogShowStyle);

                loadBar.show();

                loadBar.setContentView(R.layout.loading);

                loadBar.setCancelable(cancelable);

                TextView processhint = (TextView) loadBar
                        .findViewById(R.id.processhint);

                processhint.setText(txtContent);

                return processhint;

            }
        } catch (Exception e) {
            if (loadBar != null) {
                try {
                    loadBar.dismiss();
                } catch (Exception e2) {
                }
            }
            loadBar = null;
        }
        return null;
    }

    /**
     * 显示加载中弹层
     *
     * @param txtContent
     */
    public static void showLoadDialog(final Context mContext,
                                      final String txtContent, Handler handler) {
        if (isMainThread()) {
            showLoadDialog(mContext, false, txtContent);
        } else {
            handler.post(new Runnable() {
                @Override
                public void run() {
                    showLoadDialog(mContext, false, txtContent);
                }
            });
        }
    }

    /**
     * 显示有图片的加载进度条
     */
    public static void showLoadDialog(Context context, String txtContent, int resId) {
        try {

            dismissDialog(null);

            if (loadBar == null) {

                // 加载进度条
                loadBar = new ProgressDialog(context,
                        R.style.my_dialog);

                loadBar.show();

                loadBar.setContentView(R.layout.loading_res);

                loadBar.setCancelable(false);

                TextView processhint = (TextView) loadBar
                        .findViewById(R.id.processhint);

                processhint.setText(txtContent);
                if (resId != 0) {
                    ImageView image = (ImageView) loadBar
                            .findViewById(R.id.iv_show);
                    image.setImageResource(resId);
                }
            }
        } catch (Exception e) {
            if (loadBar != null) {
                try {
                    loadBar.dismiss();
                } catch (Exception e2) {
                }
            }
            loadBar = null;
        }
    }

    private static boolean isMainThread() {
        return Looper.myLooper() == Looper.getMainLooper();
    }

    public static void showAutoDismissSuccessDialog(final Context context,
                                                    final boolean cancelable, final String txtContent,
                                                    final Handler handler) {
        showAutoDismissSuccessDialog(context, cancelable, txtContent, handler,
                null);
    }

    public static void showAutoDismissSuccessDialog(final Context context,
                                                    final boolean cancelable, final String txtContent,
                                                    final Handler handler, final ObjectCallback pObjectCallback) {
        showAutoDismissSuccessDialog(context, cancelable, txtContent, handler,
                pObjectCallback, 2000);
    }

    public static void showAutoDismissSuccessDialog(final Context context,
                                                    final boolean cancelable, final String txtContent,
                                                    final Handler handler, final ObjectCallback pObjectCallback,
                                                    final long delayMillis) {
        handler.post(new Runnable() {
            @Override
            public void run() {
                showLoadDialog(context, cancelable, txtContent);

                /*if (loadBar != null) {
                    loadBar.findViewById(R.id.processBar).setVisibility(
                            View.GONE);
                    loadBar.findViewById(R.id.img_sucess).setVisibility(
                            View.VISIBLE);
                }*/
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        dismissDialog(handler);
                        if (pObjectCallback != null) {
                            pObjectCallback.callback(null);
                        }
                    }
                }, delayMillis);
            }
        });
    }

    /**
     * 销毁加载进度条
     */
    public static void dismissDialog(Handler handler) {

        // 当前方法在主线程里面运行的话
        if (isMainThread()) {
            dismiss();
        } else {
            if (handler == null) {
                return;
            }
            handler.post(new Runnable() {
                @Override
                public void run() {
                    dismiss();
                }
            });
        }
    }

    /**
     * 销毁加载框
     */
    private static void dismiss() {
        if (loadBar != null) {
            try {
                loadBar.dismiss();
            } catch (Exception e) {
            }
        }
        loadBar = null;
    }

}
