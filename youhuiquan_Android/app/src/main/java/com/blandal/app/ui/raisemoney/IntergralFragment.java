package com.blandal.app.ui.raisemoney;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.StaggeredGridLayoutManager;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.listener.OnItemClickListener;
import com.blandal.app.common.event.LoginEvent;
import com.blandal.app.ui.my.entity.CenterEntity;
import com.blandal.app.util.UserShared;
import com.blandal.app.util.YLHVideoUtils;
import com.qq.e.ads.rewardvideo.RewardVideoAD;
import com.qq.e.ads.rewardvideo.RewardVideoADListener;
import com.qq.e.comm.util.AdError;
import com.scwang.smart.refresh.layout.SmartRefreshLayout;
import com.scwang.smart.refresh.layout.api.RefreshLayout;
import com.scwang.smart.refresh.layout.listener.OnLoadMoreListener;
import com.scwang.smart.refresh.layout.listener.OnRefreshListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;

import com.blandal.app.R;
import com.blandal.app.base.BaseMvpFragment;
import com.blandal.app.interfaces.FragmentTagInterfaces;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.my.activity.MyWalletActivity;
import com.blandal.app.util.CSJPlayVideoUtilsV2;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.fragment.TargetFragmentTag;
import com.blandal.app.widget.StaggeredDividerItemDecoration;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

/**
 * @author: ljx
 * @createDate: 2020/12/8  14:29
 */
@TargetFragmentTag(FragmentTagInterfaces.INTEGRAL_FRAGMENT)
public class IntergralFragment extends BaseMvpFragment {
    @BindView(R.id.tv_withdrawal)
    TextView tvWithdrawal;
    @BindView(R.id.tv_star_coin)
    TextView tvStarCoin;
    @BindView(R.id.recyclerView)
    RecyclerView rvWaterFall;
    @BindView(R.id.smartRefreshLayout)
    SmartRefreshLayout refreshLayout;
    private WaterfallFlowAdapter waterfallFlowAdapter;
    List<WaterfallFlowEntity> list = new ArrayList<>();
    private WaterfallFlowEntity curEntity;
    private View emptyView;
    private boolean isSuccess;

    @Override
    protected int provideContentViewId() {
        return R.layout.fragment_intergral;
    }

    @Override
    public void initView(View rootView) {
        StaggeredGridLayoutManager staggeredGridLayoutManager = new StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL);
        //防止Item切换
//        staggeredGridLayoutManager.setGapStrategy(StaggeredGridLayoutManager.GAP_HANDLING_NONE);
        staggeredGridLayoutManager.isAutoMeasureEnabled();
        rvWaterFall.setLayoutManager(staggeredGridLayoutManager);
        rvWaterFall.setHasFixedSize(true);
        rvWaterFall.setNestedScrollingEnabled(false);
        rvWaterFall.addItemDecoration(new StaggeredDividerItemDecoration(mContext, 10, 2));
        waterfallFlowAdapter = new WaterfallFlowAdapter(list, mContext);
        waterfallFlowAdapter.setOnItemClickListener(onWaterFallItemClickListener);
        rvWaterFall.setAdapter(waterfallFlowAdapter);
    }

    @Override
    public void initEvent() {
        tvWithdrawal.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(mContext, MyWalletActivity.class));
            }
        });
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                list.clear();
                waterfallFlowAdapter.notifyDataSetChanged();
                getData();
            }
        });
        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                refreshLayout.finishLoadMore();
            }
        });
    }

    @Override
    public void initData() {
        getData();
        showAdDialog();

    }

    RewardVideoAD rvad;
    OnItemClickListener onWaterFallItemClickListener = new OnItemClickListener() {
        @Override
        public void onItemClick(@NonNull BaseQuickAdapter<?, ?> adapter, @NonNull View view, int position) {
            curEntity = (WaterfallFlowEntity) adapter.getItem(position);
            if (curEntity.leftCout() == 0) {
                if (curEntity.title.contains("新手")) {
                    ToastShow.showMsg("新手福利已完成，请选择其他任务");
                } else {
                    ToastShow.showMsg("今日已完成，请选择其他任务");
                }
                return;
            }
            isReward = false;
            if (curEntity.platform  == 1) {
                csjloadVedio("946427207", new HashMap());
            } else {
                rvad = YLHVideoUtils.showRewardVideoAD(getActivity(), rewardVideoADListener);
            }
        }
    };

    //插屏广告
    public void showAdDialog() {
        CSJPlayVideoUtilsV2.getInstance().loadInteractionExpressAd("946427186", getActivity());
    }

    //获取列表数据
    private void getData() {
        RetrofitService.getData(mContext, ServiceListFinal.task, null,
                new OnNetRequestListener<ApiResponse<List<WaterfallFlowEntity>>>() {
                    @Override
                    public void onSuccess(ApiResponse<List<WaterfallFlowEntity>> response) {
                        if (response.isSuccess()) {
                            if (response.getData() != null && response.getData().size() > 0) {
                                for (int i = 0; i < response.getData().size(); i++) {
                                    response.getData().get(i).resType = (i + 1) % 4;
                                }
                                waterfallFlowAdapter.setNewInstance(response.getData());
                            }
                        }
                        getInfo();
                        setEmptyView();
                        refreshLayout.finishRefresh();
                    }

                    @Override
                    public void onFailure(Throwable t) {
                        setEmptyView();
                        getInfo();
                    }
                }, bindAutoDispose());
    }

    //个人中心数据
    private void getInfo() {
        RetrofitService.getData(mContext, ServiceListFinal.center, null, new OnNetRequestListener<ApiResponse<CenterEntity>>() {
            @SuppressLint("SetTextI18n")
            @Override
            public void onSuccess(ApiResponse<CenterEntity> response) {
                if (response.isSuccess()) {
                    CenterEntity entity = response.getData();
                    UserShared.setJinBi(mContext, entity.getJifen());
                    tvStarCoin.setText(entity.getJifen() + "");
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

    private void setEmptyView() {
        if (waterfallFlowAdapter.getData().size() != 0) {
            waterfallFlowAdapter.removeEmptyView();
        }
        refreshLayout.finishRefresh(true);
        refreshLayout.finishLoadMore();
        if (waterfallFlowAdapter.getData().size() == 0 && emptyView == null) {
            emptyView = getLayoutInflater().inflate(R.layout.view_empty, null);
            waterfallFlowAdapter.setEmptyView(emptyView);
            refreshLayout.setEnableLoadMore(false);
//            setFooterVisibility(View.GONE);
        }
    }

    //激励视频观看结束发放奖励
    private void videoSuccess() {
        Map map = new HashMap();
        map.put("tid", curEntity.id);
        RetrofitService.postData(mContext, ServiceListFinal.videoSuccess, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    isSuccess = true;
                    getData();
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }

    public void csjloadVedio(String videoId, Map map) {
        CSJPlayVideoUtilsV2.getInstance().load((AppCompatActivity) mContext, new CSJPlayVideoUtilsV2.CJSADListener() {
            @Override
            public void onADLoad() {
                CSJPlayVideoUtilsV2.getInstance().play((AppCompatActivity) mContext);
            }

            @Override
            public void onADShow() {
            }

            @Override
            public void onReward() {
                isReward = true;
                videoSuccess();
            }

            @Override
            public void onSkipped() {
                isSuccess = false;
            }

            @Override
            public void onADClick() {
            }

            @Override
            public void onVideoComplete() {
            }

            @Override
            public void onADClose() {
                if (!isReward){
                    return;
                }
                Log.d("TAGGGGG", "关闭广告");
                if (curEntity.min != curEntity.max) {
                    ToastShow.showMsg("恭喜您获得" + curEntity.prize + "个枸币");
                } else {
                    ToastShow.showMsg("再完成" + (curEntity.leftCout() - 1) + "次即可获取奖励");
                }
                isSuccess = false;
            }

            @Override
            public void onError(int var1) {
                isSuccess = false;
                ToastShow.showMsg("数据请求错误，请重试");
            }
        }, videoId, map);
    }

    boolean isReward = false;
    RewardVideoADListener rewardVideoADListener = new RewardVideoADListener() {
        @Override
        public void onADLoad() {
            Log.e("EEEEEE", "onADLoad");
            if (rvad != null) {
                rvad.showAD();
            }
        }

        @Override
        public void onVideoCached() {
            Log.e("EEEEEE", "onVideoCached");
        }

        @Override
        public void onADShow() {
            Log.e("EEEEEE", "onADShow");
        }

        @Override
        public void onADExpose() {
            Log.e("EEEEEE", "onADExpose");
        }

        @Override
        public void onReward(Map<String, Object> map) {
            isReward =true;
            videoSuccess();
        }

        @Override
        public void onADClick() {
            Log.e("EEEEEE", "onADClick");
        }

        @Override
        public void onVideoComplete() {
            Log.e("EEEEEE", "onVideoComplete");
        }

        @Override
        public void onADClose() {
            Log.e("EEEEEE", "onReward");
            if (!isReward){
                return;
            }
            if (curEntity.min != curEntity.max) {
                ToastShow.showMsg("恭喜您获得" + curEntity.prize + "个枸币");
            } else {
                ToastShow.showMsg("再完成" + (curEntity.leftCout() - 1) + "次即可获取奖励");
            }
            isSuccess = false;
        }

        @Override
        public void onError(AdError adError) {
            Log.e("EEEEEE", "onError===" + adError.getErrorMsg());
        }
    };


    @Subscribe(threadMode = ThreadMode.MAIN)
    public void loginEventBus(LoginEvent event) {
        if (event.getLogin() != LoginEvent.LOGIN_TYPE_LOGINOUT) {
            getData();
        }
    }

}
