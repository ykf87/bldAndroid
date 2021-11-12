package com.jiankang.gouqi.ui.my.activity;

import android.content.Intent;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.luck.picture.lib.PictureSelector;
import com.luck.picture.lib.config.PictureConfig;
import com.luck.picture.lib.entity.LocalMedia;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.common.enums.VerifyStatusEnum;
import com.jiankang.gouqi.common.event.SetUserInfoEvent;
import com.jiankang.gouqi.dialog.PopupCamera;
import com.jiankang.gouqi.entity.FileUploadEntity;
import com.jiankang.gouqi.entity.GlobalEntity;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.util.EventBusManager;
import com.jiankang.gouqi.util.GlideUtil;
import com.jiankang.gouqi.util.StringUtils;
import com.jiankang.gouqi.util.ToastShow;

/**
 * @author: ljx
 * @createDate: 2020/11/19  9:36
 */
public class UserInfoActivity extends BaseMvpActivity {
    @BindView(R.id.iv_user_head)
    ImageView ivUserHead;
    @BindView(R.id.tv_user_name)
    TextView tvUserName;
    @BindView(R.id.ll_set_name)
    LinearLayout llSetName;
    @BindView(R.id.iv_name_right)
    ImageView ivNameRight;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    private PopupWindow cameraPop;
    private String trueName;
    private String userPone;
    private int verifyStatus;//实名认证状态
    private String profileUrl;//用户头像

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_user_info;
    }

    @Override
    public void initView() {
    }

    @Override
    public void initEvent() {

    }

    @Override
    protected void onResume() {
        super.onResume();
        setView();
    }

    @Override
    public void initData() {
    }

    public void setView() {
        if (UserGlobal.mGlobalConfigInfo != null) {
            trueName = UserGlobal.mGlobalConfigInfo.basic_info.true_name;
            verifyStatus = UserGlobal.mGlobalConfigInfo.basic_info.verify_status;
            userPone = UserGlobal.mGlobalConfigInfo.basic_info.telphone;
            profileUrl = UserGlobal.mGlobalConfigInfo.basic_info.profile_url;
            if (StringUtils.isNotNullOrEmpty(trueName)) {
                tvUserName.setText(trueName);
                if (verifyStatus != VerifyStatusEnum.VERIFY_SUCC.getCode()) {
                    //未实名通过
                    tvUserName.setTextColor(mContext.getResources().getColor(R.color.color_black_333333));
                    ivNameRight.setVisibility(View.VISIBLE);
                } else {
                    tvUserName.setTextColor(mContext.getResources().getColor(R.color.color_gray_999999));
                    ivNameRight.setVisibility(View.INVISIBLE);
                }
            } else {
                tvUserName.setText("点击设置昵称");
                tvUserName.setTextColor(mContext.getResources().getColor(R.color.color_text_pink_FF9580));
            }
            if (StringUtils.isNotNullOrEmpty(userPone)) {
                tvPhone.setText(userPone);
            }
            if (StringUtils.isNullOrEmpty(profileUrl)) {
                GlideUtil.loadImage(mContext, mContext.getResources().getDrawable(R.drawable.iv_default_head), ivUserHead);
            } else {
                GlideUtil.loadCircleImage(mContext, profileUrl, ivUserHead);
            }
        }
    }

    private void showPop() {
        new PopupCamera(UserInfoActivity.this).setOnCameraListener(new PopupCamera.onCameraListener() {
            @Override
            public void onCamera(String fileUrl) {
                upLoadHead(fileUrl);
            }
        });
    }


    //上传图片至oss
    public void upLoadImage(List<LocalMedia> images) {
        RetrofitService.getInstance().uploadImg(images.get(0).getCompressPath(), new OnNetRequestListener<ApiResponse<FileUploadEntity>>() {
            @Override
            public void onSuccess(ApiResponse<FileUploadEntity> response) {
                if (response.isSuccess()) {
                    upLoadHead(response.getData().fileUrl);
                } else {
                    ToastShow.showMsg(response.getMsg());
                    closeLoadDialog();
                }
            }

            @Override
            public void onFailure(Throwable t) {
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }

    //上传头像至服务端
    public void upLoadHead(String imgUrl) {
        Map map = new HashMap();
        map.put("profile_url", imgUrl);
        RetrofitService.postData(this, ServiceListFinal.postUserProfile, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    GlideUtil.loadCircleImage(mContext, imgUrl, ivUserHead);
                    EventBusManager.getInstance().post(new SetUserInfoEvent());
                } else {
                    ToastShow.showMsg(response.getMsg());
                }
                closeLoadDialog();
            }

            @Override
            public void onFailure(Throwable t) {
                ToastShow.showMsg(t.getMessage());
                closeLoadDialog();
            }
        }, bindAutoDispose());
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        List<LocalMedia> images;
        if (resultCode == RESULT_OK) {
            if (requestCode == PictureConfig.CHOOSE_REQUEST) {
                images = PictureSelector.obtainMultipleResult(data);
                upLoadImage(images);
                showLoadDialog("上传中...");
            }
        }
    }

    @OnClick({R.id.iv_user_head, R.id.ll_set_name})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_user_head:
                showPop();
                break;
            case R.id.ll_set_name:
                if (verifyStatus != VerifyStatusEnum.VERIFY_SUCC.getCode()) {
                    startActivity(new Intent(UserInfoActivity.this, SetUserNameActivity.class));
                }
                break;
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void setUserInfo(SetUserInfoEvent event) {
        getGlobalClientData();
    }

    private void getGlobalClientData() {
        RetrofitService.getData(mContext, ServiceListFinal.getGlobalConfig, null, new OnNetRequestListener<ApiResponse<GlobalEntity>>() {
            @Override
            public void onSuccess(ApiResponse<GlobalEntity> response) {
                if (response.isSuccess()) {
                    UserGlobal.mGlobalConfigInfo = response.getData();
                    setView();
                } else {
                    getGlobalClientData();
                }
            }

            @Override
            public void onFailure(Throwable t) {
                getGlobalClientData();
            }
        }, bindAutoDispose());
    }
}
