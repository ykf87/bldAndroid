package com.blandal.app.ui.my.activity;

import butterknife.BindView;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.util.GlideUtil;
import com.blandal.app.widget.AppBackBar;
import com.blandal.app.widget.RoundImageView2;

/**
 * 客服
 */
public class MyCustomerActivity extends BaseMvpActivity {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.img)
    RoundImageView2 img;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_my_customer;
    }

    @Override
    public void initData() {
        GlideUtil.loadImage(mContext, UserGlobal.customerImg,img);
    }

    @Override
    public void initView() {

    }

    @Override
    public void initEvent() {

    }

}