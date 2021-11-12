package com.blandal.app.util;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.scwang.smart.refresh.layout.SmartRefreshLayout;


import java.util.List;

public class RefreshUtils {

    public static final int STATE_NORMAL = 0;
    public static final int STATE_REFRESH = 1;
    public static final int STATE_MORE = 2;

    /**
     * @param state               状态
     * @param data                数据集
     * @param pageSize            请求时要获取的数量
     * @param adapter
     * @param smartRefreshLayout
     */
    public static void showSmallRefreshData(int state, List data, int pageSize, BaseQuickAdapter adapter, SmartRefreshLayout smartRefreshLayout) {
        switch (state) {
            case STATE_NORMAL:
                adapter.setNewInstance(data);

                break;

            case STATE_REFRESH:
                adapter.setNewInstance(data);
                smartRefreshLayout.finishRefresh();
                break;

            case STATE_MORE:
                if (data != null && data.size() != 0) {
                    adapter.addData(data);
                }
                smartRefreshLayout.finishLoadMore();
                break;
        }

        if (adapter.getData() == null || adapter.getData().size() == 0) {
            smartRefreshLayout.setEnableRefresh(true);
            smartRefreshLayout.setEnableLoadMore(false);
        } else {
            smartRefreshLayout.setEnableRefresh(true);
            smartRefreshLayout.setEnableLoadMore(true);
        }

        if (data != null && data.size() < pageSize) {
            smartRefreshLayout.finishLoadMoreWithNoMoreData();
            //沒有更多了
        } else {
            smartRefreshLayout.setNoMoreData(false);
        }
    }

}
