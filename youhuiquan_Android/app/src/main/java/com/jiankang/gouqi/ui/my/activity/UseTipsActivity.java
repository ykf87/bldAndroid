package com.jiankang.gouqi.ui.my.activity;

import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.my.entity.WithDrawTipsEntity;
import com.jiankang.gouqi.util.StringUtils;
import com.jiankang.gouqi.widget.AppBackBar;

/**
 * @author: ljx
 * @createDate: 2020/12/4  11:49
 */
public class UseTipsActivity extends BaseMvpActivity {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.tv_tips)
    TextView tvTips;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_use_tips;
    }

    @Override
    public void initView() {

    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {
        getData();
    }

    private void getData() {
        Map map = new HashMap<>();
        RetrofitService.getData(mContext, ServiceListFinal.getMoneyBagWithdrawNotice, map, new OnNetRequestListener<ApiResponse<WithDrawTipsEntity>>() {
            @Override
            public void onSuccess(ApiResponse<WithDrawTipsEntity> response) {
                if (StringUtils.isNotNullOrEmpty(response.getData().getDesc())) {
                    tvTips.setText(response.getData().getDesc());
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

}
