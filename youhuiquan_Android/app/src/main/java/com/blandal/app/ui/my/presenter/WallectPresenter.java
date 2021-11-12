package com.blandal.app.ui.my.presenter;

import com.blandal.app.base.mvp.BasePresenter;
import com.blandal.app.ui.my.contract.WalletContract;
import com.blandal.app.ui.my.module.WallectModel;


public class WallectPresenter extends BasePresenter<WalletContract.Model, WalletContract.WalletView> {

    public WallectPresenter(WalletContract.WalletView rootHomeView) {
        super(rootHomeView);
        mModel = new WallectModel();
    }


}
