package com.jiankang.gouqi.ui.main.contract;

import android.content.Context;

import java.util.List;
import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.jiankang.gouqi.base.mvp.IModel;
import com.jiankang.gouqi.base.mvp.IView;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.ui.main.entity.ZhaiTaskListEntity;

/**
 * @author: ljx
 * @createDate: 2020/11/20  15:10
 */
public class HomeTaskContract {
    public interface Model extends IModel {
        /**
         * 获取任务列表
         */
        void getHomeTaskList(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

        /**
         * 领取任务
         */
        void stuApplyZhaiTask(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

        /**
         * 倒计时结束更新状态
         * @param map
         * @param context
         * @param listener
         * @param bindAutoDispose
         */
        void updateTaskTradeStatus(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);
    }

    public interface HomeTaskView extends IView {
        void getHomeTaskListSucc(List<ZhaiTaskListEntity> list);
        void getHomeTaskListFail();

        void stuApplyZhaiTaskSucc();
        void stuApplyZhaiTaskFail(String err);

        void updateTaskTradeStatusSucc();
    }
}
