package com.blandal.app.dialog;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.lifecycle.Lifecycle;

import com.luck.picture.lib.PictureSelector;
import com.luck.picture.lib.config.PictureConfig;
import com.luck.picture.lib.config.PictureMimeType;
import com.luck.picture.lib.entity.LocalMedia;

import java.util.List;

;import autodispose2.AutoDispose;
import autodispose2.AutoDisposeConverter;
import autodispose2.androidx.lifecycle.AndroidLifecycleScopeProvider;
import com.blandal.app.R;
import com.blandal.app.common.MyHandler;
import com.blandal.app.entity.FileUploadEntity;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.util.ToastShow;

public class PopupCamera extends PopupWindow {

    public static PopupWindow cameraPop;
    private View view;
    private Activity context;
    private OpenCameraFragment openCameraFragment;


    public PopupCamera(final FragmentActivity context) {
        this.context = context;
        View view = context.getCurrentFocus();
        if (view != null) {
            InputMethodManager inputMethodManager = (InputMethodManager) context.getSystemService(Activity.INPUT_METHOD_SERVICE);
            inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
        }
        cameraPop = new PopupWindow(context);
        view = LayoutInflater.from(context).inflate(R.layout.layout_camera_dialog, null);
        cameraPop.setWidth(LinearLayout.LayoutParams.MATCH_PARENT);
        cameraPop.setHeight(LinearLayout.LayoutParams.WRAP_CONTENT);
        cameraPop.setBackgroundDrawable(new ColorDrawable());
        cameraPop.setFocusable(true);
        cameraPop.setOutsideTouchable(true);
        cameraPop.setContentView(view);
        setBackgroundAlpha(context, 0.5f);
        this.setAnimationStyle(R.style.main_menu_photo_anim);
        cameraPop.showAtLocation(view, Gravity.BOTTOM, 0, 0);
        cameraPop.showAsDropDown(view);
        cameraPop.setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                setBackgroundAlpha(context,1f);
            }
        });

        TextView mAlbum = view.findViewById(R.id.tv_album);
        TextView mCamera = view.findViewById(R.id.tv_camera);
        TextView mCancel = view.findViewById(R.id.tv_cancel);

        mAlbum.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (openCameraFragment == null) {
                    openCameraFragment = new OpenCameraFragment();
                    openCameraFragment.setOnCameraListener(onCameraListener);
                }
                if (!openCameraFragment.isAdded()) {
                    FragmentManager fragmentManager = context.getSupportFragmentManager();
                    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                    fragmentTransaction.add(openCameraFragment, openCameraFragment.getClass().getSimpleName());
                    fragmentTransaction.commit();
                    fragmentManager.executePendingTransactions();
                }
                view.post(new Runnable() {
                    @Override
                    public void run() {
                        openCameraFragment.openGallery();
                    }
                });


                closePopupWindow();
            }
        });
        mCamera.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (openCameraFragment == null) {
                    openCameraFragment = new OpenCameraFragment();
                    openCameraFragment.setOnCameraListener(onCameraListener);
                }
                if (!openCameraFragment.isAdded()) {
                    FragmentManager fragmentManager = context.getSupportFragmentManager();
                    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                    fragmentTransaction.add(openCameraFragment, openCameraFragment.getClass().getSimpleName());
                    fragmentTransaction.commit();
                    fragmentManager.executePendingTransactions();
                }
                view.post(new Runnable() {
                    @Override
                    public void run() {
                        openCameraFragment.openCamera();
                    }
                });
                closePopupWindow();
            }
        });
        mCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                closePopupWindow();
            }
        });


    }


    public void closePopupWindow() {
        if (cameraPop != null && cameraPop.isShowing()) {
            cameraPop.dismiss();
            cameraPop = null;
        }
    }


    public static void setBackgroundAlpha(Activity activity, float bgAlpha) {
        WindowManager.LayoutParams lp = activity.getWindow().getAttributes();
        lp.alpha = bgAlpha;
        activity.getWindow().setAttributes(lp);
    }

    private onCameraListener onCameraListener;

    public void setOnCameraListener(PopupCamera.onCameraListener onCameraListener) {
        this.onCameraListener = onCameraListener;
    }

    public static class OpenCameraFragment extends Fragment {

        private onCameraListener onCameraListener;

        public void setOnCameraListener(PopupCamera.onCameraListener onCameraListener) {
            this.onCameraListener = onCameraListener;
        }

        public void openCamera() {
            PictureSelector.create(OpenCameraFragment.this)
                    .openCamera(PictureMimeType.ofImage())
                    .compress(true)
                    .forResult(PictureConfig.CHOOSE_REQUEST);
        }

        @Override
        public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
            super.onActivityResult(requestCode, resultCode, data);
            List<LocalMedia> images;
            if (resultCode == Activity.RESULT_OK) {
                if (requestCode == PictureConfig.CHOOSE_REQUEST) {
                    images = PictureSelector.obtainMultipleResult(data);
                    ProgressDialogShow.showLoadDialog(getContext(), "上传中...", new MyHandler());
                    upLoadImage(getActivity(), onCameraListener, images);
                }
            }
        }

        public void openGallery() {
            PictureSelector.create(OpenCameraFragment.this)
                    .openGallery(PictureMimeType.ofImage())
                    .maxSelectNum(1)
                    .minSelectNum(1)
                    .compress(true)
                    .imageSpanCount(4)
                    .selectionMode(PictureConfig.MULTIPLE)
                    .forResult(PictureConfig.CHOOSE_REQUEST);
        }
    }

    public interface onCameraListener {
        void onCamera(String fileUrl);
    }


    //上传图片至oss
    public static void upLoadImage(FragmentActivity activity, onCameraListener onCameraListener, List<LocalMedia> images) {
        RetrofitService.getInstance().uploadImg(images.get(0).getCompressPath(), new OnNetRequestListener<ApiResponse<FileUploadEntity>>() {
            @Override
            public void onSuccess(ApiResponse<FileUploadEntity> response) {
                if (response.isSuccess()) {
                    if (onCameraListener != null) {
                        onCameraListener.onCamera(response.getData().fileUrl);
                    }
                } else {
                    ToastShow.showMsg(response.getMsg());
                }
                ProgressDialogShow.dismissDialog(new MyHandler());
            }

            @Override
            public void onFailure(Throwable t) {
                ProgressDialogShow.dismissDialog(new MyHandler());
            }
        }, bindAutoDispose(activity));
    }


    public static <T> AutoDisposeConverter<T> bindAutoDispose(FragmentActivity appCompatActivity) {
        return AutoDispose.autoDisposable(AndroidLifecycleScopeProvider
                .from(appCompatActivity, Lifecycle.Event.ON_DESTROY));
    }
}