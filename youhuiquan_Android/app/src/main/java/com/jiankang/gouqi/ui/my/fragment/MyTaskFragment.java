package com.jiankang.gouqi.ui.my.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

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
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BasePageFragment;
import com.jiankang.gouqi.common.enums.ZhaiTaskTradeFinishTypeEnum;
import com.jiankang.gouqi.common.enums.ZhaiTaskTradeStatusEnum;
import com.jiankang.gouqi.common.event.RefreshMyTaskListEvent;
import com.jiankang.gouqi.common.event.SetTabPosEvent;
import com.jiankang.gouqi.ui.main.activity.MainAppActivity;

import com.jiankang.gouqi.ui.my.adpter.MyTaskAdapter;
import com.jiankang.gouqi.ui.my.entity.ApplyTaskListBean;
import com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.util.EventBusManager;

import static com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_1;
import static com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_2;
import static com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_3;
import static com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_4;
import static com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_5;
import static com.jiankang.gouqi.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_6;

/**
 * @author: ljx
 * 我的任务分类
 * “m_list_type”:  0全部 1进行中 2审核中 3被拒绝（必传）4已结束 5已完成
 * @createDate: 2020/11/19  14:00
 */
public class MyTaskFragment extends BasePageFragment {

    @BindView(R.id.rv_task_list)
    RecyclerView rvTaskList;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    private View footerLine;
    private View emptyView;
    private MyTaskAdapter adapter;
    private List<ApplyTaskListBean> list = new ArrayList<>();
    private static String ARG_CLASSIFY_ID = "classifyId";
    private int classifyId;
    private int pageSize = 10;
    private int pageNumber = 1;

    public static MyTaskFragment newInstance(int classifyId) {
        MyTaskFragment fragment = new MyTaskFragment();
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
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.fragment_my_task;
    }

    @Override
    public void initView(View rootView) {
        footerLine = LayoutInflater.from(mContext).inflate(R.layout.item_lv_footer, null);
        adapter = new MyTaskAdapter(list, mContext);
        emptyView = getLayoutInflater().inflate(R.layout.view_empty_my_task, null);
        TextView tvGoRaise = emptyView.findViewById(R.id.tv_go_raise);
        tvGoRaise.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                EventBusManager.getInstance().post(new SetTabPosEvent(0));
                startActivity(new Intent(mContext, MainAppActivity.class));
            }
        });
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(mContext);
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        rvTaskList.setLayoutManager(linearLayoutManager);
        adapter.addChildClickViewIds(R.id.tv_give_up);
        adapter.addChildClickViewIds(R.id.tv_commit);
        adapter.addChildClickViewIds(R.id.tv_check_detail);
        adapter.addChildClickViewIds(R.id.tv_recommit);
        adapter.addChildClickViewIds(R.id.tv_withdrawal);
        adapter.addChildClickViewIds(R.id.tv_appeal);

        rvTaskList.setAdapter(adapter);
//        adapter.addFooterView(footerLine);
//        footerLine.setVisibility(View.GONE);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                footerLine.setVisibility(View.GONE);
                list.clear();
                adapter.setNewInstance(list);
                refreshLayout.finishLoadMore(true);
                adapter.removeAllFooterView();
                getTaskList();
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {

            @Override
            public void onLoadMore(RefreshLayout refreshlayout) {
                getTaskList();
            }
        });

        adapter.setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(@NonNull BaseQuickAdapter<?, ?> adapter, @NonNull View view, int position) {
            }
        });
        adapter.setOnItemChildClickListener(new OnItemChildClickListener() {
            @Override
            public void onItemChildClick(@NonNull BaseQuickAdapter adapter, @NonNull View view, int position) {
                ApplyTaskListBean bean = (ApplyTaskListBean) adapter.getItem(position);

            }
        });
    }


    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {
        adapter.setTimesUpListener(new MyTaskAdapter.TimesUpListener(){

            @Override
            public void onTimeUp(ApplyTaskListBean bean) {
                updateTaskTradeStatus(bean.getTask_apply_id());
            }
        });
    }

    @Override
    public void fetchData() {
        getTaskList();
    }

    /**
     * 获取我的任务列表
     */
    private void getTaskList() {
        pageNumber = adapter.getData().size() / pageSize + (adapter.getData().size() % pageSize > 0 ? 1 : 0) + 1;
        Map map = new HashMap<>();
        map.put("page_size", pageSize);
        map.put("page_num", pageNumber);
        map.put("m_list_type", classifyId);
        RetrofitService.getData(mContext, ServiceListFinal.queryApplyTaskList, map, new OnNetRequestListener<ApiResponse<MyZhaiTaskEntiy>>() {
            @Override
            public void onSuccess(ApiResponse<MyZhaiTaskEntiy> response) {
                if (response.isSuccess()) {
                    list = response.getData().getApply_task_list();
                    if (list != null && list.size() > 0) {
                        for (ApplyTaskListBean bean : list) {
                            if (bean.getTask_trade_status() == ZhaiTaskTradeStatusEnum.HAS_APPLY.getCode()) {
                                if (bean.getStu_submit_dead_time() != 0) {
                                    bean.setStu_submit_left_time(bean.getStu_submit_dead_time() - bean.getCur_server_time());
                                }
                                bean.setType(TASK_TYPE_1);
                            } else if (bean.getTask_trade_status() == ZhaiTaskTradeStatusEnum.HAS_SUBMIT.getCode()) {
                                if (bean.getEnt_audit_dead_time() != 0) {
                                    bean.setStu_submit_left_time(bean.getEnt_audit_dead_time() - bean.getCur_server_time());
                                }
                                bean.setType(TASK_TYPE_2);
                            } else if (bean.getTask_trade_status() == ZhaiTaskTradeStatusEnum.HAS_END.getCode()) {
                                if (bean.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.STU_NOT_SUBMIT.getCode()) {
                                    bean.setType(TASK_TYPE_3);
                                } else if (bean.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_AUDIT_PASS.getCode() ||
                                        bean.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_DEFAULT_PASS.getCode()) {
                                    bean.setType(TASK_TYPE_4);
                                } else if (bean.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_AUDIT_FAIL.getCode() ||
                                        bean.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_DETERMINE_MALICE_SUBMIT.getCode()) {
                                    bean.setType(TASK_TYPE_5);
                                } else if (bean.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ABANBON.getCode()) {
                                    bean.setType(TASK_TYPE_6);
                                }
                            }
                        }
                    }
                    adapter.addData(list);
                    adapter.notifyDataSetChanged();
                    if (list.size() < pageSize) {
                        setFooterVisibility(View.VISIBLE);
                    } else {
                        setFooterVisibility(View.GONE);
                    }
                    setEmptyView();
                } else {
                    setEmptyView();
                }
            }

            @Override
            public void onFailure(Throwable t) {
                setEmptyView();
            }
        }, bindAutoDispose());
    }

    /**
     * 倒计时小于0时，上报服务端修改任务状态
     *
     * @param task_apply_id
     */
    private void updateTaskTradeStatus(int task_apply_id) {
        Map map = new HashMap();
        map.put("task_apply_id", task_apply_id);
        RetrofitService.getData(mContext, ServiceListFinal.updateTaskTradeStatus, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    //刷新列表
                    footerLine.setVisibility(View.GONE);
                    list.clear();
                    adapter.setNewInstance(list);
                    refreshLayout.setEnableLoadMore(true);
                    getTaskList();
                }
            }

            @Override
            public void onFailure(Throwable t) {
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
                adapter.setEmptyView(emptyView);
            }
            refreshLayout.setEnableLoadMore(false);
            setFooterVisibility(View.GONE);
        }
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
        footerLine.setVisibility(View.GONE);
        list.clear();
        adapter.setNewInstance(list);
        refreshLayout.setEnableLoadMore(true);
        getTaskList();
    }
}
