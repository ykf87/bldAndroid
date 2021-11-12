package com.jiankang.gouqi.widget;

import android.Manifest;
import android.app.Dialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.DialogFragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.common.MyHandler;
import com.jiankang.gouqi.entity.AdEntity;
import com.jiankang.gouqi.util.GlideUtil;
import com.jiankang.gouqi.util.LoginUtils;


/**
 * 首页广告弹窗
 */
public class ImageAdDialog extends DialogFragment implements View.OnClickListener {
    private View mView;
    private ImageView img_close;
    private InterceptFrameLayout flAd;
    private RoundImageView2 img_ad;
    private static final String ARGS_DATA = "args_data";
    private AdEntity mData;
    /**
     * 需要进行检测的权限数组
     */
    protected String[] needPermissions = {
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,};

    public ImageAdDialog() {

    }


    public static ImageAdDialog newInstance(AdEntity entity) {
        Bundle args = new Bundle();
        args.putSerializable(ARGS_DATA, entity);
        ImageAdDialog fragment = new ImageAdDialog();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mData = (AdEntity) getArguments().getSerializable(ARGS_DATA);
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        Dialog dialog = getDialog();
        Window window = dialog.getWindow();
        if (mView == null) {
            mView = inflater.inflate(R.layout.dialog_image_ad, container, false);
        }

        flAd = mView.findViewById(R.id.fl_ad);
        img_ad = mView.findViewById(R.id.img_ad);
        img_close = mView.findViewById(R.id.img_close);


        if (mData != null) {
            img_ad.setVisibility(View.VISIBLE);
            GlideUtil.loadImage(getContext(), mData.img_url, img_ad,R.drawable.image_default);
        }


        img_ad.setOnClickListener(this);
        img_close.setOnClickListener(this);
        flAd.setInterceptTouchEventListener(new InterceptFrameLayout.onInterceptTouchEventListener() {
            @Override
            public boolean onInterceptTouchEvent(MotionEvent ev) {
                if (MotionEvent.ACTION_UP == ev.getAction() && mData.need_Login == 1 && LoginUtils.isNotLogin(getContext())) {
                    LoginUtils.toLoginActivity(new MyHandler(), getContext());
                    return true;
                }
                return false;
            }
        });

        if (window != null) {
            window.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            window.setBackgroundDrawable(new ColorDrawable(Color.parseColor("#44000000")));
        }
        setCancelable(true);
        dialog.setCanceledOnTouchOutside(false);
        return mView;
    }


    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            default:
                break;
            case R.id.img_ad:
                if (mListener != null) {
                    mListener.onImageClick(mData);
                }
                break;
            case R.id.img_close:
                if (mListener != null) {
                    mListener.onCloseClick();
                }
                break;
        }
    }

    @Override
    public void onStart() {
        super.onStart();
        Window window = getDialog().getWindow();
        if (window != null) {
            WindowManager.LayoutParams windowParams = window.getAttributes();
            windowParams.dimAmount = 0.5f;
            window.setAttributes(windowParams);
        }

        //设置宽度顶满屏幕,无左右留白
        DisplayMetrics dm = new DisplayMetrics();
        getActivity().getWindowManager().getDefaultDisplay().getMetrics(dm);

        if (getDialog().getWindow() != null) {
            getDialog().getWindow().setLayout(dm.widthPixels, ViewGroup.LayoutParams.MATCH_PARENT);
        }
    }

    private OnDialogClickListener mListener;

    public interface OnDialogClickListener {
        void onImageClick(AdEntity entity);

        void onCloseClick();
    }

    public void setOnDialogClickListener(OnDialogClickListener listener) {
        mListener = listener;
    }

    @Override
    public void show(FragmentManager fm, String tag) {
        FragmentTransaction ft = fm.beginTransaction();
        ft.add(this, tag);
        // 这里把原来的commit()方法换成了commitAllowingStateLoss()
        // 解决Can not perform this action after onSaveInstanceState with DialogFragment
        ft.commitAllowingStateLoss();
        //解决java.lang.IllegalStateException: Fragment already added
        fm.executePendingTransactions();
    }

    @Override
    public void dismiss() {
        dismissAllowingStateLoss();
    }
}
