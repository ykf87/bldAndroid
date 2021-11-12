package com.blandal.app.ui.main.fragment;


import android.graphics.Typeface;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;


import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.RecyclerView;
import androidx.viewpager.widget.ViewPager;

import com.google.android.material.appbar.AppBarLayout;
import com.google.android.material.tabs.TabLayout;
import com.blandal.app.common.event.RefreshMyTaskListEvent;
import com.scwang.smart.refresh.layout.SmartRefreshLayout;
import com.scwang.smart.refresh.layout.api.RefreshLayout;
import com.scwang.smart.refresh.layout.listener.OnRefreshListener;
import com.to.aboomy.pager2banner.Banner;
import com.to.aboomy.pager2banner.IndicatorView;

import org.greenrobot.eventbus.EventBus;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpFragment;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.entity.AdEntity;
import com.blandal.app.entity.GlobalEntity;
import com.blandal.app.interfaces.FragmentTagInterfaces;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.main.adapter.HomeClassifyAdapter;
import com.blandal.app.ui.main.adapter.MyBannerAdapter;
import com.blandal.app.ui.main.contract.HomeContract;
import com.blandal.app.ui.main.entity.ClassifyBean;
import com.blandal.app.ui.main.event.RefreshMainEvent;
import com.blandal.app.ui.main.presenter.HomePresenter;
import com.blandal.app.util.CSJPlayVideoUtilsV2;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.StatusBarUtil;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.fragment.TargetFragmentTag;
import com.blandal.app.widget.AppBarStateChangeListener;
import com.blandal.app.widget.NoNetWorkView;


@TargetFragmentTag(FragmentTagInterfaces.MAIN_FRAGMENT)
public class MainFragment extends BaseMvpFragment<HomePresenter> implements HomeContract.HomeView {
    @BindView(R.id.banner)
    Banner banner;
    @BindView(R.id.rl_special)
    RecyclerView rlSpecial;
    @BindView(R.id.tablayout)
    TabLayout tablayout;
    @BindView(R.id.view_pager)
    ViewPager viewPager;
    @BindView(R.id.iv_ad)
    ImageView ivAd;
    @BindView(R.id.no_network)
    NoNetWorkView noNetwork;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.fl_ad_banner_container)
    FrameLayout flAdBannerContainer;

    @BindView(R.id.appbar)
    AppBarLayout appBar;

    private int pageSize = 20;
    private int pageNumber = 1;

    private String[] mHeaders;
    private List<ClassifyBean> classifyList = new ArrayList<>();

    @Override
    protected int provideContentViewId() {
        return R.layout.fragment_home;
    }

    @Override
    public void initView(View rootView) {
        mPresenter = new HomePresenter(this);
        refreshLayout.setEnableLoadMore(false);
        StatusBarUtil.setDarkMode(getActivity());
        StatusBarUtil.setColor(getActivity(), ContextCompat.getColor(mContext, R.color.white), 0);
//        mPresenter.getClassifyList(new HashMap(), mContext);
//        initBanner();
//        CSJPlayVideoUtilsV2.getInstance().loadBannerAd("946427157",getActivity(),flAdBannerContainer);
    }

    private void initBanner() {
        List<AdEntity> bannerList = new ArrayList<>();
        bannerList.add(new AdEntity("https://img1.baidu.com/it/u=395380977,272417941&fm=26&fmt=auto&gp=0.jpg"));
        bannerList.add(new AdEntity("https://img2.baidu.com/it/u=360400461,2955275651&fm=26&fmt=auto&gp=0.jpg"));
        bannerList.add(new AdEntity("https://img2.baidu.com/it/u=1336119765,2231343437&fm=26&fmt=auto&gp=0.jpg"));
        banner.setVisibility(View.GONE);
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        params.bottomMargin = DisplayUtil.dip2px(mContext, 10);
        params.rightMargin = DisplayUtil.dip2px(mContext, 14);
        IndicatorView indicator = new IndicatorView(mContext)
                .setIndicatorColor(ContextCompat.getColor(mContext, R.color.color_40000000))
                .setIndicatorRadius(1)
                .setParams(params)
                .setIndicatorRatio(7)
                .setIndicatorSelectedRatio(7)
                .setIndicatorSpacing(4)
                .setIndicatorSelectorColor(ContextCompat.getColor(mContext, R.color.colorPrimary));
        MyBannerAdapter adapter = new MyBannerAdapter(bannerList, getActivity());
        //传入RecyclerView.Adapter 即可实现无限轮播
        banner.setIndicator(indicator)
                .setAutoTurningTime(3000)
                .setAdapter(adapter);
    }

    private void initViewPager() {
//        tablayout.setupWithViewPager(viewPager);
        if (classifyList == null || classifyList.size() == 0) {
            return;
        }
        ClassifyBean cl = new ClassifyBean();
        cl.setName("全部");
        cl.setId(0);
        classifyList.add(0,cl);
        mHeaders = new String[classifyList.size()];
        for (int i=0;i<classifyList.size();i++){
            mHeaders[i] = classifyList.get(i).getName();
        }
        tablayout.removeAllTabs();
        for (String mHeader : mHeaders) {
            TabLayout.Tab tabItem = tablayout.newTab();
            View view = LayoutInflater.from(mContext).inflate(R.layout.layout_home_tab, null);
            TextView tvTabText = view.findViewById(R.id.tv_tab_text);
            tvTabText.setText(mHeader);
            tabItem.setCustomView(view);
            tablayout.addTab(tabItem);
        }
        viewPager.setSaveEnabled(false);
        viewPager.setAdapter(new HomeClassifyAdapter(getChildFragmentManager(), classifyList));
        tablayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {

                TextView tvTabText = tab.getCustomView().findViewById(R.id.tv_tab_text);
                if (tvTabText != null) {
                    tvTabText.setTextColor(ContextCompat.getColor(mContext, R.color.colorPrimary));
                    tvTabText.setTextSize(18);
                    tvTabText.setTypeface(Typeface.DEFAULT_BOLD, Typeface.BOLD);
                }
                if (viewPager != null) {
                    viewPager.setCurrentItem(tab.getPosition());
                }
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {
                TextView tvTabText = tab.getCustomView().findViewById(R.id.tv_tab_text);
                if (tvTabText != null) {
                    tvTabText.setTextColor(ContextCompat.getColor(mContext, R.color.color_text_666666_tab));
                    tvTabText.setTextSize(14);
                    tvTabText.setTypeface(Typeface.DEFAULT, Typeface.NORMAL);
                }

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });

        if (viewPager != null) {
            viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                @Override
                public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

                }

                @Override
                public void onPageSelected(int position) {
                    tablayout.selectTab(tablayout.getTabAt(position));
                }

                @Override
                public void onPageScrollStateChanged(int state) {

                }
            });

        }
        TextView tvTabText = tablayout.getTabAt(0).getCustomView().findViewById(R.id.tv_tab_text);
        if (tvTabText != null) {
            tvTabText.setTextColor(ContextCompat.getColor(mContext, R.color.colorPrimary));
            tvTabText.setTextSize(18);
            tvTabText.setTypeface(Typeface.DEFAULT_BOLD, Typeface.BOLD);
        }

    }

    @Override
    public void initEvent() {
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                mPresenter.getGlobalClientData(null, mContext);
//                CSJPlayVideoUtilsV2.getInstance().loadBannerAd("946427157",getActivity(),flAdBannerContainer);
            }
        });
        appBar.addOnOffsetChangedListener(new AppBarStateChangeListener() {
            @Override
            public void onStateChanged(AppBarLayout appBarLayout, State state) {
            }
        });
        noNetwork.setOnRefreshClickListener(new NoNetWorkView.OnNoNetWorkViewListener() {
            @Override
            public void onRefresh(View view) {
                RetrofitService.getData(mContext, ServiceListFinal.getGlobalConfig, null, new OnNetRequestListener<ApiResponse<GlobalEntity>>() {
                    @Override
                    public void onSuccess(ApiResponse<GlobalEntity> response) {
                        if (response.isSuccess()) {
                            UserGlobal.setGlobalConfigInfo(response.getData());
                            EventBus.getDefault().post(new RefreshMainEvent());
                        } else {
                            ToastShow.showMsg("加载失败，请稍后再试");
                        }
                        noNetWork();
                    }

                    @Override
                    public void onFailure(Throwable t) {
                        noNetWork();
                        ToastShow.showMsg("加载失败，请稍后再试");
                    }
                }, bindAutoDispose());
            }
        });
    }


    private void noNetWork() {
        if (UserGlobal.getGlobalConfigInfo() == null || noNetwork.isShow()) {
            refreshLayout.setVisibility(View.GONE);
            noNetwork.setVisibility(View.VISIBLE);
        } else {
            refreshLayout.setVisibility(View.VISIBLE);
            noNetwork.setVisibility(View.GONE);
        }

    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
    }

    @Override
    public void initData() {
    }

    @Override
    public void getClassifyListSucc(List<ClassifyBean> list) {
        classifyList = list;
        initViewPager();
    }

    @Override
    public void getClassifyListFail() {
    }

    @Override
    public void getGlobalClientDataSucc(GlobalEntity entity) {
        refreshLayout.finishRefresh();
        EventBus.getDefault().post(new RefreshMyTaskListEvent());
    }

    @Override
    public void getGlobalClientDataFail() {
        refreshLayout.finishRefresh();
        EventBus.getDefault().post(new RefreshMyTaskListEvent());
    }

}