package com.jiankang.gouqi.ui.main.activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.ashokvarma.bottomnavigation.BottomNavigationBar;
import com.ashokvarma.bottomnavigation.BottomNavigationItem;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseActivity;
import com.jiankang.gouqi.common.UserGlobal;
import com.jiankang.gouqi.common.event.CitySelectEvent;
import com.jiankang.gouqi.common.event.LoginEvent;
import com.jiankang.gouqi.common.event.SetTabPosEvent;
import com.jiankang.gouqi.common.event.ShowAdDialogEvent;
import com.jiankang.gouqi.common.receiver.NetBroadcastReceiver;
import com.jiankang.gouqi.dialog.AgreementUpdateDialog;
import com.jiankang.gouqi.interfaces.Callback;
import com.jiankang.gouqi.interfaces.FragmentTagInterfaces;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.ui.main.event.RefreshMainEvent;
import com.jiankang.gouqi.util.AppUpdateUtils;
import com.jiankang.gouqi.util.CSJPlayVideoUtilsV2;
import com.jiankang.gouqi.util.EventBusManager;
import com.jiankang.gouqi.util.ExitApplication;
import com.jiankang.gouqi.util.JobReadRecordUtil;
import com.jiankang.gouqi.util.LoginUtils;
import com.jiankang.gouqi.util.SystemUtil;
import com.jiankang.gouqi.util.ToastShow;
import com.jiankang.gouqi.util.UmengEventUtils;
import com.jiankang.gouqi.util.UserShared;
import com.jiankang.gouqi.util.fragment.FragmentFactory;

public class MainAppActivity extends BaseActivity implements View.OnClickListener, BottomNavigationBar.OnTabSelectedListener {
    private BottomNavigationBar bottomNavigationBar;
    /**
     * 定义一个布尔值用于判断是否点击了两次返回键 (退出程序)
     */
    private boolean mIsExit;
    private String mLastSelectedTag;
    private FragmentFactory mFactory;

    private Bundle mSavedInstanceState;
    /**
     * fragment列表
     */
    private List<String> mFragmentHashMap = new ArrayList<>();

    private NetBroadcastReceiver netBroadcastReceiver;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        closeAnimation();
        super.onCreate(savedInstanceState);
        mSavedInstanceState = savedInstanceState;
        super.setEnableGesture(false);
        // 这个情况是页面被系统销毁后重新打开的情况下
        if (savedInstanceState != null) {
            //AllRequest.setDefaultGlobalInfo(mContext);
        }
        setContentView(R.layout.activity_main_app);
        bottomNavigationBar = findViewById(R.id.bottom_navigation_bar);
        bottomNavigationBar.setTabSelectedListener(this);
        registerReceiver();
        initData();
        showAdDialog();
    }


    private void initData() {
        if (UserGlobal.mGlobalConfigInfo != null) {
            // 查询升级信息
            AppUpdateUtils appDown = new AppUpdateUtils();
            appDown.selVersion(mContext, handler, false);
            JobReadRecordUtil.delExceedData(mContext);
            //initInfoFragment();
            initBottomBar(mSavedInstanceState);
            dialogFlow(true);
        } else {
            initBottomBar(mSavedInstanceState);
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void refreshMainEventEventBus(RefreshMainEvent event) {
        UserShared.setAdvertisement(mContext, "2");
        initData();
    }


    public void showAdDialog() {
//        CSJPlayVideoUtilsV2.getInstance().loadAdDialog2(MainAppActivity.this,"946427217");
        CSJPlayVideoUtilsV2.getInstance().loadInteractionExpressAd("946427186",MainAppActivity.this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        openTabPage(getPosition());
    }

    private int getPosition() {
        int position = 0;
        if (mFragmentHashMap.contains(mLastSelectedTag)) {
            position = mFragmentHashMap.indexOf(mLastSelectedTag);
        }
        return position;
    }

    @Override
    public void setEnableInitGesture(boolean enable) {
        super.setEnableInitGesture(false);
    }

    @Override
    public void onTabSelected(int position) {
        openTabPage(position);
    }

    @Override
    public void onTabUnselected(int position) {
        if (position == 0) {
            Fragment fragment = mFactory.getFragmentByTag(FragmentTagInterfaces.MAIN_FRAGMENT);
        }
    }

    @Override
    public void onTabReselected(int position) {
        if (mFragmentHashMap.size() > position) {
            //mFragmentHashMap.get(position)
            reopenTabPage(position);
        }
    }

    private void initBottomBar(Bundle savedInstanceState) {
        bottomNavigationBar.clearAll();
        mFragmentHashMap.clear();

        bottomNavigationBar.setMode(BottomNavigationBar.MODE_FIXED);
        bottomNavigationBar.addItem(new BottomNavigationItem(R.drawable.home_selector, "首页").setActiveColorResource(R.color.colorPrimary)
                .setInactiveIconResource(R.drawable.home_nor).setInActiveColorResource(R.color.color_cdcdcd));
        mFragmentHashMap.add(FragmentTagInterfaces.MAIN_FRAGMENT);

//        if (UserGlobal.isShowAd){
//            bottomNavigationBar.setMode(BottomNavigationBar.MODE_FIXED);
//            bottomNavigationBar.addItem(new BottomNavigationItem(R.drawable.integer_selector, "福利").setActiveColorResource(R.color.colorPrimary)
//                    .setInactiveIconResource(R.drawable.integer_nor).setInActiveColorResource(R.color.color_cdcdcd));
//            mFragmentHashMap.add(FragmentTagInterfaces.INTEGRAL_FRAGMENT);
//        }

        bottomNavigationBar.addItem(new BottomNavigationItem(R.drawable.mime_selector, "我的").setActiveColorResource(R.color.colorPrimary)
                .setInactiveIconResource(R.drawable.mime_nor).setInActiveColorResource(R.color.color_cdcdcd));
        mFragmentHashMap.add(FragmentTagInterfaces.MY_FRAGMENT);

        bottomNavigationBar.setFirstSelectedPosition(getPosition())
                .initialise();

        mFactory = FragmentFactory.getInstance().init(this, R.id.main_app_tab_content);

        if (savedInstanceState != null) {
            mFactory.restoreCurrentFragmentInfo(savedInstanceState);
        } else {
            openTabPage(getPosition());
        }
    }

    /**
     * 捕捉返回键，如果当前显示菜单，刚隐藏
     */
    @Override
    public void onBackPressed() {

        if (!mIsExit) {
            ToastShow.showMsg(mContext, "再按一次退出程序", handler);
            mIsExit = true;
            handler.mPostDelayed(new Runnable() {
                @Override
                public void run() {
                    mIsExit = false;
                }
            }, 2000);
        } else {
            ExitApplication.getInstance().exit();
        }
    }

    private void reopenTabPage(int position) {
        if (mFactory == null) {
            mFactory = FragmentFactory.getInstance().init(this, R.id.main_app_tab_content);
        }
    }

    private void openTabPage(int position) {
        if (mFragmentHashMap.get(position).equals(FragmentTagInterfaces.INTEGRAL_FRAGMENT) && !UserGlobal.isLogin()){
            LoginUtils.toLoginActivity(handler, mContext);
            bottomNavigationBar.selectTab(getLastPosition());
            return;
        }
        if (mFactory == null) {
            mFactory = FragmentFactory.getInstance().init(this, R.id.main_app_tab_content);
        }
        mLastSelectedTag = mFragmentHashMap.get(position);
        mFactory.showFragment(mFragmentHashMap.get(position));

    }
    private int getLastPosition() {
        int position = 0;
        if (mFragmentHashMap.contains(mLastSelectedTag)) {
            position = mFragmentHashMap.indexOf(mLastSelectedTag);
        }
        return position;
    }

    @Override
    public void onClick(View v) {

    }

    @Override
    public boolean useEventBus() {
        return true;
    }

    @Override
    protected void onDestroy() {
        unRegisterReceiver();
        super.onDestroy();
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    /**
     * 保存Fragment的状态
     */
    @SuppressLint("MissingSuperCall")
    @Override
    protected void onSaveInstanceState(@NonNull Bundle outState) {
        //保存我的tab选择状态
        int currentTab = bottomNavigationBar.getCurrentSelectedPosition();
        outState.putInt("currentTab", currentTab);
        mFactory.saveCurrentFragmentInfo(outState);
    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        //回复我的tab选择状态
        int currentTab = savedInstanceState.getInt("currentTab");
        if (currentTab < bottomNavigationBar.getNavigationTabSize()) {
            bottomNavigationBar.selectTab(currentTab);
        } else {
            bottomNavigationBar.selectTab(0);
        }
        if (savedInstanceState != null) {
            mFactory.restoreCurrentFragmentInfo(savedInstanceState);
        }
    }


    @Subscribe(threadMode = ThreadMode.MAIN)
    public void selectCityEventBus(CitySelectEvent event) {
        String cityName = event.getCityName();
        int cityId = event.getCityId();
        //setSelCity(cityId, cityName);
        //LogUtils.data("CitySelectEvent");
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void setTabPositionEventBus(SetTabPosEvent event) {
        int postion = event.getPostion();
        bottomNavigationBar.selectTab(postion);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void showAdDialog(ShowAdDialogEvent event) {
        showAdDialog();
    }


    private void dialogFlow(final boolean isOpenAdDialog) {
        if (UserGlobal.mGlobalConfigInfo == null) {
            return;
        }
    }

    private void openAgreementUpdateDialog(final boolean isOpenAdDialog) {
        final AgreementUpdateDialog agreementDialog = AgreementUpdateDialog.newInstance();
        agreementDialog.setOnDialogClickListener(new Callback() {
            @Override
            public void onStartBtnClick() {
                agreementDialog.dismiss();
                LoginUtils.userExit(mContext);
                logout();

                EventBusManager.getInstance().post(new LoginEvent(LoginEvent.LOGIN_TYPE_LOGINOUT));
                if (isOpenAdDialog) {
                    //getAdDialog();
                    showAdDialog();
                }
            }

            @Override
            public void onEndBtnClick() {
                agreementDialog.dismiss();
                if (isOpenAdDialog) {
                    //getAdDialog();
                    showAdDialog();
                }
            }
        });
        //本地记录置0
        UserShared.setLoginPopAgreement(mContext, 0);
        //报告服务端，已经弹过了
        Map<String, String> map = new HashMap<>();
        map.put("client_version", SystemUtil.getVersionNm(this));
        RetrofitService.postData(this, ServiceListFinal.popUserAgreement, map, null, bindAutoDispose());
        agreementDialog.show(getSupportFragmentManager(), agreementDialog.getClass().getName());
    }

    private void logout() {
        RetrofitService.getData(this, ServiceListFinal.logout, null, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

    private void registerReceiver() {
        //实例化IntentFilter对象
        IntentFilter filter = new IntentFilter();
        filter.addAction(WifiManager.WIFI_STATE_CHANGED_ACTION);
        filter.addAction(WifiManager.NETWORK_STATE_CHANGED_ACTION);
        filter.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
        netBroadcastReceiver = new NetBroadcastReceiver();
        registerReceiver(netBroadcastReceiver, filter);
    }

    private void unRegisterReceiver() {
        if (netBroadcastReceiver != null) {
            unregisterReceiver(netBroadcastReceiver);
        }
    }
}
