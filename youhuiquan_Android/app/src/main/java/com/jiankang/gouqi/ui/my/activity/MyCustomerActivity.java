package com.jiankang.gouqi.ui.my.activity;

import butterknife.BindView;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.util.GlideUtil;
import com.jiankang.gouqi.widget.AppBackBar;
import com.jiankang.gouqi.widget.RoundImageView2;

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