package com.jiankang.gouqi.ui.my;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.core.content.ContextCompat;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.OnClick;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.app.MyApplication;
import com.jiankang.gouqi.base.BaseMvpFragment;
import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.common.event.LoginEvent;
import com.jiankang.gouqi.interfaces.FragmentTagInterfaces;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.my.activity.AboutActivity;
import com.jiankang.gouqi.ui.my.activity.MyCustomerActivity;
import com.jiankang.gouqi.ui.my.activity.MyFooterActivity;
import com.jiankang.gouqi.ui.my.activity.MyWalletActivity;
import com.jiankang.gouqi.ui.my.activity.MycollectionActivity;
import com.jiankang.gouqi.ui.my.activity.SettingActivity;
import com.jiankang.gouqi.ui.my.activity.SuggestActivity;
import com.jiankang.gouqi.ui.my.entity.CenterEntity;
import com.jiankang.gouqi.util.CSJPlayVideoUtilsV2;
import com.jiankang.gouqi.util.GlideUtil;
import com.jiankang.gouqi.util.LoginUtils;
import com.jiankang.gouqi.util.SpUtils;
import com.jiankang.gouqi.util.StatusBarUtil;
import com.jiankang.gouqi.util.StringUtils;
import com.jiankang.gouqi.util.UserShared;
import com.jiankang.gouqi.util.fragment.TargetFragmentTag;
import com.jiankang.gouqi.widget.RoundImageView2;

/**
 * @author: ljx
 * @createDate: 2020/11/17  14:00
 */
@TargetFragmentTag(FragmentTagInterfaces.MY_FRAGMENT)
public class MyFragment extends BaseMvpFragment {

    @BindView(R.id.my_head)
    RoundImageView2 myHead;
    @BindView(R.id.my_name)
    TextView myName;
    @BindView(R.id.tv_id)
    TextView tvPhoto;
    @BindView(R.id.iv_right)
    ImageView ivRight;
    @BindView(R.id.rl_top_layout)
    RelativeLayout rlTopLayout;
    @BindView(R.id.ll_my_footprint)
    LinearLayout llMyFootprint;
    @BindView(R.id.ll_my_collection)
    LinearLayout llMyCollection;
    @BindView(R.id.ll_my_income)
    LinearLayout llMyIncome;
    @BindView(R.id.ll_my_customer)
    LinearLayout llMyCustomer;
    @BindView(R.id.tv_setting)
    TextView tvSetting;
    @BindView(R.id.tv_suggest)
    TextView tvSuggest;
    @BindView(R.id.tv_about)
    TextView tvAbout;
    @BindView(R.id.fl_ad)
    FrameLayout flAd;

    @BindView(R.id.ll_info)
    LinearLayout llInfo;
    @BindView(R.id.tv_login)
    TextView tvLogin;

    @Override
    protected int provideContentViewId() {
        return R.layout.fragment_my;
    }

    @SuppressLint("SetTextI18n")
    @Override
    public void initView(View rootView) {
        setView();
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {

    }

    @Override
    public void onResume() {
        super.onResume();
        getData();
        StatusBarUtil.setDarkMode(getActivity());
        StatusBarUtil.setColor(getActivity(), ContextCompat.getColor(mContext, R.color.colorPrimary), 0);
        CSJPlayVideoUtilsV2.getInstance().loadBannerAd("946427157", getActivity(), flAd);
    }

    /**
     * 解决tab切换不走onResume问题
     *
     * @param hidden
     */
    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
        if (!hidden) {
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void loginEventBus(LoginEvent event) {
        setView();
        if (event.getLogin() == LoginEvent.LOGIN_TYPE_LOGINOUT) {
            //退出登录
            tvLogin.setVisibility(View.VISIBLE);
            llInfo.setVisibility(View.GONE);
        }
    }

    private void setView() {
        if (UserGlobal.isLogin()) {
            tvLogin.setVisibility(View.GONE);
            llInfo.setVisibility(View.VISIBLE);
        } else {
            tvLogin.setVisibility(View.VISIBLE);
            llInfo.setVisibility(View.GONE);
        }
        if (StringUtils.isNotNullOrEmpty(UserShared.getName(mContext))) {
            myName.setText(UserShared.getName(mContext));
        }
        tvPhoto.setText(UserShared.getUserAccount(mContext));
        GlideUtil.loadImage(UserShared.getAvatar(mContext), myHead);
    }

    private void getData() {
        if (!UserGlobal.isLogin()) {
            return;
        }
        RetrofitService.getData(mContext, ServiceListFinal.center, null, new OnNetRequestListener<ApiResponse<CenterEntity>>() {
            @Override
            public void onSuccess(ApiResponse<CenterEntity> response) {
                if (response.isSuccess()) {
                    CenterEntity entity = response.getData();
                    UserShared.setJinBi(mContext, entity.getJifen());
                    if (entity.getBank() != null) {
                        UserShared.setBankEntity(entity.getBank());
                        UserShared.setBankId(mContext, entity.getBank().getId());
                    }else {
                        SpUtils.remove(MyApplication.getContext(), "BankEntity");
                        UserShared.setBankId(mContext, 0);
                    }
                    setView();
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

    @OnClick({R.id.rl_top_layout, R.id.ll_my_footprint, R.id.ll_my_collection, R.id.ll_my_income, R.id.ll_my_customer, R.id.tv_setting, R.id.tv_suggest, R.id.tv_about})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rl_top_layout:
                if (!UserGlobal.isLogin()) {
                    LoginUtils.toLoginActivity(handler, mContext);
                    return;
                }
                break;
            case R.id.ll_my_footprint:
                if (!UserGlobal.isLogin()) {
                    LoginUtils.toLoginActivity(handler, mContext);
                    return;
                }
                startActivity(new Intent(mContext, MyFooterActivity.class));
                break;
            case R.id.ll_my_collection:
                if (!UserGlobal.isLogin()) {
                    LoginUtils.toLoginActivity(handler, mContext);
                    return;
                }
                startActivity(new Intent(mContext, MycollectionActivity.class));
                break;
            case R.id.ll_my_income:
                if (!UserGlobal.isLogin()) {
                    LoginUtils.toLoginActivity(handler, mContext);
                    return;
                }
                startActivity(new Intent(mContext, MyWalletActivity.class));
                break;
            case R.id.ll_my_customer:
                if (!UserGlobal.isLogin()) {
                    LoginUtils.toLoginActivity(handler, mContext);
                    return;
                }
                startActivity(new Intent(mContext, MyCustomerActivity.class));
                break;
            case R.id.tv_setting:
                startActivity(new Intent(mContext, SettingActivity.class));
                break;
            case R.id.tv_suggest:
                if (!UserGlobal.isLogin()) {
                    LoginUtils.toLoginActivity(handler, mContext);
                    return;
                }
                SuggestActivity.launch(mContext);
                break;
            case R.id.tv_about:
                startActivity(new Intent(mContext, AboutActivity.class));
                break;

        }
    }
}
