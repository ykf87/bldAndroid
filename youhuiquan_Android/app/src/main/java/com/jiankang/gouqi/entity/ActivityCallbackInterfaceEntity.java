package com.jiankang.gouqi.entity;

import android.content.Context;

import com.jiankang.gouqi.interfaces.AppInterfaces;

/**
 * XX页面触发上个页面的回调
 *
 * @author Administrator
 */
public class ActivityCallbackInterfaceEntity {

    public Object object;
    /**
     * 触发的页面
     */
    public String callActivityName;
    /**
     * 是否需要手动触发
     */
    public boolean isManuallyCall;
    /**
     * 上个页面Activity
     */
    public Context mContext;
    /**
     * 回调接口
     */
    public AppInterfaces.ActivityCallBackInterface mActivityCallBackInterface;

    public ActivityCallbackInterfaceEntity(Context pContext, Class<?> pClass,
                                           AppInterfaces.ActivityCallBackInterface pActivityCallBackInterface, boolean pIsManuallyCall) {
        mContext = pContext;
        mActivityCallBackInterface = pActivityCallBackInterface;
        isManuallyCall = pIsManuallyCall;
        callActivityName = pClass.getName();
    }
}
