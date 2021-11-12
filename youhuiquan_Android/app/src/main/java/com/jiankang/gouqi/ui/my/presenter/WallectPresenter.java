package com.jiankang.gouqi.ui.my.presenter;

import com.jiankang.gouqi.base.mvp.BasePresenter;
import com.jiankang.gouqi.ui.my.contract.WalletContract;
import com.jiankang.gouqi.ui.my.module.WallectModel;


public class WallectPresenter extends BasePresenter<WalletContract.Model, WalletContract.WalletView> {

    public WallectPresenter(WalletContract.WalletView rootHomeView) {
        super(rootHomeView);
        mModel = new WallectModel();
    }


}
