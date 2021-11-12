package com.blandal.app.ui.main.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.listener.OnItemChildClickListener;
import com.chad.library.adapter.base.listener.OnItemClickListener;
import com.scwang.smart.refresh.layout.SmartRefreshLayout;
import com.scwang.smart.refresh.layout.api.RefreshLayout;
import com.scwang.smart.refresh.layout.listener.OnLoadMoreListener;
import com.scwang.smart.refresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import com.blandal.app.R;
import com.blandal.app.base.BasePageFragment;
import com.blandal.app.common.event.RefreshMyTaskListEvent;

import com.blandal.app.ui.main.activity.ArticleDetailActivity;
import com.blandal.app.ui.main.adapter.HomeTaskAdapter;
import com.blandal.app.ui.main.contract.HomeTaskContract;
import com.blandal.app.ui.main.entity.ZhaiTaskListEntity;
import com.blandal.app.ui.main.presenter.HomeTaskPresenter;
import com.blandal.app.util.ToastShow;

/**
 * @author: ljx
 * 首页任务分类
 * @createDate: 2020/11/17  14:00
 */
public class HomeTaskFragment extends BasePageFragment<HomeTaskPresenter> implements HomeTaskContract.HomeTaskView {

    @BindView(R.id.rv_task_list)
    RecyclerView rvTaskList;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    private View footerLine;
    private View emptyView;
    private HomeTaskAdapter adapter;
    private List<ZhaiTaskListEntity> list = new ArrayList<>();
    private static String ARG_CLASSIFY_ID = "classifyId";
    private int classifyId;
    private int pageSize = 10;
    private int pageNumber = 1;
    private ZhaiTaskListEntity curClickItem;
    private int[] adPosition = {1, 3, 5, 7};

    public static HomeTaskFragment newInstance(int classifyId) {
        HomeTaskFragment fragment = new HomeTaskFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_CLASSIFY_ID, classifyId);
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            classifyId = getArguments().getInt(ARG_CLASSIFY_ID);
        }
        mPresenter = new HomeTaskPresenter(this);
    }

    @Override
    public void fetchData() {
        getData();
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.fragment_task_list;
    }

    @Override
    public void initView(View rootView) {
        initView();
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void getHomeTaskListSucc(List<ZhaiTaskListEntity> list) {
        if (list != null) {
//            if (pageNumber == 1) {
//                ZhaiTaskListEntity adEntity = new ZhaiTaskListEntity();
//                adEntity.isCsjAd = true;
//                list.add(2,adEntity);
//                ZhaiTaskListEntity adEntity2 = new ZhaiTaskListEntity();
//                adEntity2.isCsjAd = true;
//                list.add(4,adEntity2);
//            }
            adapter.addData(list);
            adapter.notifyDataSetChanged();
            if (list.size() < pageSize) {
                setFooterVisibility(View.VISIBLE);
            } else {
                setFooterVisibility(View.GONE);
            }
        }
        setEmptyView();
    }

    @Override
    public void getHomeTaskListFail() {
        setEmptyView();
    }

    @Override
    public void stuApplyZhaiTaskSucc() {
//        footerLine.setVisibility(View.GONE);
//        list.clear();
//        adapter.notifyDataSetChanged();
//        refreshLayout.setEnableLoadmore(true);
//        getData();
        refreshData();
    }

    @Override
    public void stuApplyZhaiTaskFail(String err) {
        ToastShow.showMsg(err);
    }

    @Override
    public void updateTaskTradeStatusSucc() {
        refreshData();
    }

    @Override
    public void initData() {
        getData();
    }

    public void getData() {
        pageNumber = adapter.getData().size() / pageSize + (adapter.getData().size() % pageSize > 0 ? 1 : 0) + 1;
        Map map = new HashMap<>();
        map.put("limit", pageSize);
        map.put("page", pageNumber);
        if (classifyId != 0) {
            map.put("cate", classifyId);
        }
        mPresenter.getHomeTaskList(map, mContext);
    }

    private void setEmptyView() {
        if (adapter.getData().size() != 0) {
            adapter.removeEmptyView();
        }
        refreshLayout.finishRefresh(true);
        refreshLayout.finishLoadMore();
        if (adapter.getData().size() == 0 && emptyView == null) {
            emptyView = getLayoutInflater().inflate(R.layout.view_empty, null);
            adapter.setEmptyView(emptyView);
            refreshLayout.setEnableLoadMore(false);
            setFooterVisibility(View.GONE);
        }
    }

    private void initView() {
        footerLine = LayoutInflater.from(mContext).inflate(R.layout.item_lv_footer, null);
        adapter = new HomeTaskAdapter(list, mContext);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        rvTaskList.setLayoutManager(linearLayoutManager);
        adapter.addFooterView(footerLine);
        footerLine.setVisibility(View.GONE);
        rvTaskList.setAdapter(adapter);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                footerLine.setVisibility(View.GONE);
                list.clear();
                adapter.notifyDataSetChanged();
                refreshLayout.setEnableAutoLoadMore(true);
                adapter.removeAllFooterView();
                getData();
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(RefreshLayout refreshlayout) {
                getData();
            }
        });
        adapter.addChildClickViewIds(R.id.tv_commit);
        adapter.setOnItemChildClickListener(new OnItemChildClickListener() {
            @Override
            public void onItemChildClick(@NonNull BaseQuickAdapter adapter, @NonNull View view, int position) {
                curClickItem = (ZhaiTaskListEntity) adapter.getItem(position);
                switch (view.getId()) {

                }
            }
        });
        adapter.setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(@NonNull BaseQuickAdapter<?, ?> adapter, @NonNull View view, int position) {
                ZhaiTaskListEntity entity = (ZhaiTaskListEntity) adapter.getItem(position);
                ArticleDetailActivity.launch(mContext, entity.getId());
            }
        });
    }

    private void setFooterVisibility(final int visibility) {
        if (visibility == View.VISIBLE) {
            adapter.removeAllFooterView();
            adapter.addFooterView(footerLine);
            refreshLayout.setEnableLoadMore(false);
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

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void refreshList(RefreshMyTaskListEvent event) {
        refreshData();
    }


    public void refreshData() {
        footerLine.setVisibility(View.GONE);
        list.clear();
        adapter.notifyDataSetChanged();
        refreshLayout.setEnableAutoLoadMore(true);
        getData();
    }


}
