package com.blandal.app.ui.my.activity;

import android.content.Intent;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.entity.AdEntity;
import com.blandal.app.ui.my.contract.WalletContract;
import com.blandal.app.ui.my.presenter.WallectPresenter;
import com.blandal.app.util.CSJPlayVideoUtilsV2;
import com.blandal.app.util.MethodUtils;
import com.blandal.app.util.UserShared;
import com.blandal.app.widget.AppBackBar;

import static com.blandal.app.common.enums.MyTaskClassifyEnum.IN_PROGRESS;

/**
 * @author: ljx
 * @createDate: 2020/12/02  18:36
 */
public class MyWalletActivity extends BaseMvpActivity<WallectPresenter> implements WalletContract.WalletView {

    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.tv_money)
    TextView tvMoney;
    @BindView(R.id.btn_withdraw)
    Button btnWithdraw;
    @BindView(R.id.ll_my_soon_account)
    LinearLayout llMySoonAccount;
    @BindView(R.id.fl_ad)
    FrameLayout flAd;
    @BindView(R.id.ll_use_tips)
    LinearLayout llUseTips;

    private AdEntity adEntity;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_my_wallet;
    }

    @Override
    public void initView() {
        mPresenter = new WallectPresenter(this);
    }

    @Override
    public void initEvent() {
        appBackBar.setOnBarEndTextClickListener(new AppBackBar.OnBarClickListener() {
            @Override
            public void onClick() {
                startActivity(new Intent(MyWalletActivity.this, TradeDetailActivity.class));
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        tvMoney.setText(UserShared.getJinBi(mContext)+"");
//        CSJPlayVideoUtilsV2.getInstance().loadBannerAd("946427157",this,flAd);
    }

    @Override
    public void initData() {

    }

    @OnClick({R.id.btn_withdraw, R.id.ll_my_soon_account, R.id.ll_use_tips, R.id.iv_ad})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_use_tips:
                startActivity(new Intent(mContext, UseTipsActivity.class));
                break;
            case R.id.btn_withdraw:
                startActivity(new Intent(mContext, MyWalletWithdrawActivity.class));
                break;
            case R.id.ll_my_soon_account:
                MyTaskActivity.launch(mContext, IN_PROGRESS.getCode());
                break;
            case R.id.iv_ad:
                MethodUtils.advertisementClick(mContext, handler, adEntity);
                break;
        }
    }

}
