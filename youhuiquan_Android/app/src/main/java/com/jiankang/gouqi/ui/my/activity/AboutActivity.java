package com.jiankang.gouqi.ui.my.activity;

import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.OnClick;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.util.ToastShow;


/**
 * @author: ljx
 * @createDate: 2020/11/19  9:36
 */
public class AboutActivity extends BaseMvpActivity {
    @BindView(R.id.rl_check_update)
    RelativeLayout rlCheckUpdate;
    @BindView(R.id.rl_function)
    RelativeLayout rlFunction;
    @BindView(R.id.tv_user_agreement)
    TextView tvUserAgreement;
    @BindView(R.id.tv_user_private)
    TextView tvUserPrivate;
    @BindView(R.id.tv_version_code)
    TextView tvVersionCode;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_about;
    }

    @Override
    public void initView() {

    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {

    }

    @OnClick({R.id.rl_check_update, R.id.rl_function, R.id.tv_user_agreement, R.id.tv_user_private})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rl_check_update:
                // 查询升级信息
                ToastShow.showMsg("当前已经是最新版本");
//                AppUpdateUtils appDown = new AppUpdateUtils();
//                appDown.selVersion(mContext, handler, true);
                break;
            case R.id.rl_function:
                break;
            case R.id.tv_user_agreement:
                PrivacyPolicyActivity.launch(mContext,false);
                break;
            case R.id.tv_user_private:
//                AppUtils.toWap(mContext, ServiceListFinal.privacyPolicy);
                PrivacyPolicyActivity.launch(mContext,true);
                break;
        }
    }
}
