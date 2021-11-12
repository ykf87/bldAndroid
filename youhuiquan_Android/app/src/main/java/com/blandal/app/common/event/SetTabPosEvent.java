package com.blandal.app.common.event;

/**
 * 选择首页tab位置
 *
 * @author: ljx
 * @createDate: 2020/7/17 18:01
 */
public class SetTabPosEvent {
    private int postion;

    public SetTabPosEvent(int postion) {
        this.postion = postion;
    }

    public int getPostion() {
        return postion;
    }

}
