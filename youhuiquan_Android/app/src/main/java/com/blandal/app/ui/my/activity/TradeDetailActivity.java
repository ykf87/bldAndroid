package com.blandal.app.ui.my.activity;

import android.view.LayoutInflater;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

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
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.my.adpter.TradeDetailAdapter;
import com.blandal.app.ui.my.entity.TradeIList;
import com.blandal.app.widget.AppBackBar;
import com.blandal.app.widget.EmptyView;

/**
 * @author: ljx
 * 积分明细
 * @createDate: 2020/12/02  18:36
 */
public class TradeDetailActivity extends BaseMvpActivity {

    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.rl_trade_list)
    RecyclerView rlTradeList;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    private TradeDetailAdapter adapter;
    private List<TradeIList> list = new ArrayList<>();
    private EmptyView mEmptyView;
    private View footerLine;
    private int pageSize = 10;
    private int pageNumber = 1;


    @Override
    protected int provideContentViewId() {
        return R.layout.activity_trade_detail;
    }

    @Override
    public void initData() {
        getTradeList();
    }

    @Override
    public void initView() {
        appBackBar.setRtxtColor(ContextCompat.getColor(mContext, R.color.color_black_333333));
        appBackBar.setRtxtSize(14);
        appBackBar.setTvEndDrawbleLeft(R.drawable.ic_communicate);
        footerLine = LayoutInflater.from(mContext).inflate(R.layout.item_lv_footer, null);
        mEmptyView = new EmptyView.Builder(mContext)
                .setText("空空如也")
                .setTextSize(14)
                .setImgSrc(R.drawable.bg_empty1)
                .setTextColor(ContextCompat.getColor(mContext, R.color.color_gray_999999))
                .build();
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(TradeDetailActivity.this);
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        rlTradeList.setLayoutManager(linearLayoutManager);
        adapter = new TradeDetailAdapter(list, mContext);
        rlTradeList.setAdapter(adapter);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                footerLine.setVisibility(View.GONE);
                list.clear();
                adapter.notifyDataSetChanged();
                adapter.removeAllFooterView();
                refreshLayout.setEnableLoadMore(true);
                getTradeList();
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {

            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getTradeList();
            }

        });
    }

    @Override
    public void initEvent() {
        appBackBar.setOnBarEndTextClickListener(new AppBackBar.OnBarClickListener() {
            @Override
            public void onClick() {
            }
        });

    }

    private void getTradeList() {
        pageNumber = adapter.getData().size() / pageSize + (adapter.getData().size() % pageSize > 0 ? 1 : 0) + 1;
        Map map = new HashMap<>();
        map.put("limit", pageSize);
        map.put("page", pageNumber);
        RetrofitService.getData(mContext, ServiceListFinal.jifen, map, new OnNetRequestListener<ApiResponse<List<TradeIList>>>() {
            @Override
            public void onSuccess(ApiResponse<List<TradeIList>> response) {
                if (response.isSuccess()) {
                    adapter.addData(response.getData());
                    adapter.notifyDataSetChanged();
                    if (response.getData().size() < pageSize) {
                        setFooterVisibility(View.VISIBLE);
                    } else {
                        setFooterVisibility(View.GONE);
                    }
                }
                setEmptyView();
            }

            @Override
            public void onFailure(Throwable t) {
                setEmptyView();
            }
        }, bindAutoDispose());
    }

    private void setEmptyView() {
        if (adapter.getData().size() != 0) {
            adapter.removeEmptyView();
        }
        refreshLayout.finishRefresh(true);
        refreshLayout.finishLoadMore();
        if (adapter.getData().size() == 0) {
            if (!adapter.hasEmptyView()) {
                adapter.setEmptyView(mEmptyView);
            }
            refreshLayout.setEnableLoadMore(false);
            setFooterVisibility(View.GONE);
        }
    }

    private void setFooterVisibility(final int visibility) {
        if (visibility == View.VISIBLE) {
            refreshLayout.setEnableLoadMore(false);
            adapter.removeAllFooterView();
            adapter.addFooterView(footerLine);
        } else {
            refreshLayout.setEnableLoadMore(true);
        }
        post(new Runnable() {
            @Override
            public void run() {
                if (footerLine != null) {
                    footerLine.setVisibility(visibility);
                }
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

}
