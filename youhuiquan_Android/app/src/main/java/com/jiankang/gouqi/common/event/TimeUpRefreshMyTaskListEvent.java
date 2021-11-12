package com.jiankang.gouqi.common.event;

/**
 * @author: ljx
 * @createDate: 2020/12/11  15:45
 */
public class TimeUpRefreshMyTaskListEvent {
    private int task_apply_id;
    public TimeUpRefreshMyTaskListEvent(int task_apply_id) {
        this.task_apply_id = task_apply_id;
    }
    public int getTask_apply_id() {
        return task_apply_id;
    }

    public void setTask_apply_id(int task_apply_id) {
        this.task_apply_id = task_apply_id;
    }


}
