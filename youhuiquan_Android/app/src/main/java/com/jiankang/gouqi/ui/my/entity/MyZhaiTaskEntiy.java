package com.jiankang.gouqi.ui.my.entity;

import java.io.Serializable;
import java.util.List;

import com.jiankang.gouqi.common.enums.ZhaiTaskTradeFinishTypeEnum;
import com.jiankang.gouqi.common.enums.ZhaiTaskTradeStatusEnum;

/**
 * @author: ljx
 * @createDate: 2020/11/19  15:30
 */
public class MyZhaiTaskEntiy implements Serializable{

    public static final int TASK_TYPE_1 = 1;//待提交
    public static final int TASK_TYPE_2 = 2;//审核中

    //3-6 为已结束状态
    public static final int TASK_TYPE_3 = 3;//已失效
    public static final int TASK_TYPE_4 = 4;//已完成
    public static final int TASK_TYPE_5 = 5;//被拒绝
    public static final int TASK_TYPE_6 = 6;//放弃

    private int apply_task_list_count;//任务总数（区分状态）
    private QueryParamBean query_param;
    private int has_apply_task_list_count;//待提交任务数
    private List<ApplyTaskListBean> apply_task_list;


    public int getApply_task_list_count() {
        return apply_task_list_count;
    }

    public void setApply_task_list_count(int apply_task_list_count) {
        this.apply_task_list_count = apply_task_list_count;
    }

    public QueryParamBean getQuery_param() {
        return query_param;
    }

    public void setQuery_param(QueryParamBean query_param) {
        this.query_param = query_param;
    }

    public int getHas_apply_task_list_count() {
        return has_apply_task_list_count;
    }

    public void setHas_apply_task_list_count(int has_apply_task_list_count) {
        this.has_apply_task_list_count = has_apply_task_list_count;
    }

    public List<ApplyTaskListBean> getApply_task_list() {
        return apply_task_list;
    }

    public void setApply_task_list(List<ApplyTaskListBean> apply_task_list) {
        this.apply_task_list = apply_task_list;
    }

    public static int getTaskType(ApplyTaskListBean data){
        if (data.getTask_trade_status() == ZhaiTaskTradeStatusEnum.HAS_APPLY.getCode()) {
            if (data.getStu_submit_dead_time() != 0) {
                data.setStu_submit_left_time(data.getStu_submit_dead_time() - data.getCur_server_time());
            }
            return TASK_TYPE_1;
        } else if (data.getTask_trade_status() == ZhaiTaskTradeStatusEnum.HAS_SUBMIT.getCode()) {
            if (data.getEnt_audit_dead_time() != 0) {
                data.setStu_submit_left_time(data.getEnt_audit_dead_time() - data.getCur_server_time());
            }
            return (TASK_TYPE_2);
        } else if (data.getTask_trade_status() == ZhaiTaskTradeStatusEnum.HAS_END.getCode()) {
            if (data.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.STU_NOT_SUBMIT.getCode()) {
                return(TASK_TYPE_3);
            } else if (data.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_AUDIT_PASS.getCode() ||
                    data.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_DEFAULT_PASS.getCode()) {
                return(TASK_TYPE_4);
            } else if (data.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_AUDIT_FAIL.getCode() ||
                    data.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ENT_DETERMINE_MALICE_SUBMIT.getCode()) {
                return(TASK_TYPE_5);
            } else if (data.getTask_trade_finish_type() == ZhaiTaskTradeFinishTypeEnum.ABANBON.getCode()) {
                return(TASK_TYPE_6);
            }
        }
        return TASK_TYPE_1;
    }


}
