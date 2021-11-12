package com.blandal.app.ui.my.activity;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.listener.OnItemClickListener;
import com.scwang.smart.refresh.layout.SmartRefreshLayout;
import com.scwang.smart.refresh.layout.api.RefreshLayout;
import com.scwang.smart.refresh.layout.listener.OnLoadMoreListener;
import com.scwang.smart.refresh.layout.listener.OnRefreshListener;

import org.jetbrains.annotations.NotNull;

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
import com.blandal.app.ui.main.activity.ArticleDetailActivity;
import com.blandal.app.ui.main.adapter.HomeTaskAdapter;
import com.blandal.app.ui.main.entity.ZhaiTaskListEntity;
import com.blandal.app.widget.AppBackBar;

public class MycollectionActivity extends BaseMvpActivity {
    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.recyclerView)
    RecyclerView recyclerView;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    private HomeTaskAdapter adapter;
    private List<ZhaiTaskListEntity> list = new ArrayList<>();
    private View mEmptyView;
    private View footerLine;
    private int pageSize = 10;
    private int pageNumber = 1;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_my_collection;
    }

    @Override
    public void initData() {
        showLoadDialog("加载中...");
        getList();
    }

    @Override
    public void initView() {
        footerLine = LayoutInflater.from(mContext).inflate(R.layout.item_lv_footer, null);
        mEmptyView = getLayoutInflater().inflate(R.layout.view_empty, null);
        ((TextView) mEmptyView.findViewById(R.id.tv_title)).setText("暂无收藏文章");
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(MycollectionActivity.this);
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);
        adapter = new HomeTaskAdapter(list, mContext);
        adapter.setOnItemClickListener(new OnItemClickListener() {

            @Override
            public void onItemClick(@NonNull @NotNull BaseQuickAdapter<?, ?> adapter, @NonNull @NotNull View view, int position) {
                ZhaiTaskListEntity entity = (ZhaiTaskListEntity) adapter.getItem(position);
                ArticleDetailActivity.launch(mContext, entity.getId());
            }
        });
        recyclerView.setAdapter(adapter);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                footerLine.setVisibility(View.GONE);
                list.clear();
                adapter.notifyDataSetChanged();
                adapter.removeAllFooterView();
                refreshLayout.setEnableLoadMore(true);
                getList();
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {

            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getList();
            }

        });
    }

    private void getList() {
        pageNumber = adapter.getData().size() / pageSize + (adapter.getData().size() % pageSize > 0 ? 1 : 0) + 1;
        Map map = new HashMap<>();
        map.put("page", pageNumber);
        map.put("limit", pageSize);
        RetrofitService.getData(mContext, ServiceListFinal.watch, map, new OnNetRequestListener<ApiResponse<List<ZhaiTaskListEntity>>>() {
            @Override
            public void onSuccess(ApiResponse<List<ZhaiTaskListEntity>> response) {
                if (response.isSuccess()) {
                    adapter.addData(response.getData());
                    adapter.notifyDataSetChanged();
                    if (response.getData().size() < pageSize) {
                        setFooterVisibility(View.VISIBLE);
                    } else {
                        setFooterVisibility(View.GONE);
                    }
                }
                closeLoadDialog();
                setEmptyView();
            }

            @Override
            public void onFailure(Throwable t) {
                setEmptyView();
                closeLoadDialog();
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
    public void initEvent() {

    }

}