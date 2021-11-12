package com.blandal.app.common;

import com.blandal.app.app.MyApplication;
import com.blandal.app.entity.GlobalEntity;
import com.blandal.app.entity.SharedPersonEntity;
import com.blandal.app.entity.SharedTaskEntity;
import com.blandal.app.ui.my.entity.ResumeInfoV200;
import com.blandal.app.util.SpUtils;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.UserShared;

/**
 * 全局变量
 *
 * @author: ljx
 * @createDate: 2020/10/18 17:06
 */
public class UserGlobal {
    /**
     * 可能不存在，慎用,退出登录，清除这个对象
     */
    public static ResumeInfoV200 mUserResume;

    /**
     * 是否首次打开app
     */
    public static boolean sIsFirstOpenApp;

    /**
     * app配置信息，用的时候请判断null
     */
    public static GlobalEntity mGlobalConfigInfo;

    /**
     * 分销拉新分享信息
     */
    public static SharedPersonEntity mSharedInfo;

    /**
     * 获取任务分享配置
     */
    public static SharedTaskEntity mSharedTaskInfo;

    /**
     * 页面是否打开
     */
    public static boolean isActivityOpen = false;
    public static boolean isShowAd = false;
    public static String customerImg = "";

    /**
     * 初始化全局参数
     */
    public static void initGlobal() {
        isActivityOpen = true;
    }

    /**
     * 微信登录成功后获取的code
     */
    public static String weiXinCode = "";

    /**
     * lock专用
     */
    public final static Object objPostLock = new Object();

    /**
     * lock时间专用
     */
    public final static Object objLockTime = new Object();

    /**
     * 聊天页面的标题，该昵称时候设置，有的话，界面呈现
     */
    public static String chatFrmTitle;

    /**
     * 服务器当前时间
     */
    private static long current_time_millis;

    /**
     * app打开时间
     */
    public static long appStartTime;

    public static boolean isLogin(){
        return StringUtils.isNotNullOrEmpty(UserShared.getToken(MyApplication.getContext()));
    }
    /**
     * 设置服务器时间
     */
    public static void setMyTimeMillis(long time) {
        synchronized (objLockTime) {
            current_time_millis = time;
        }
    }

    /**
     * 获取服务器时间
     */
    public static long getMyTimeMillis() {
        synchronized (objLockTime) {

            if (current_time_millis == 0) {
                return System.currentTimeMillis();
            }

            // 取得服务器时间 加上 当前时间 减去app启动时间
            return current_time_millis
                    + (System.currentTimeMillis() - appStartTime);
        }
    }

    public static GlobalEntity getGlobalConfigInfo() {
        if (mGlobalConfigInfo != null) {
            return mGlobalConfigInfo;
        }
        GlobalEntity data = SpUtils.getBean(MyApplication.getContext(), "ClientGlobalInfo", GlobalEntity.class);
        if (data != null) {
            mGlobalConfigInfo = data;
        }
        return mGlobalConfigInfo;
    }

    public static void setGlobalConfigInfo(GlobalEntity globalEntity) {
        if (globalEntity != null) {
            SpUtils.saveBean(MyApplication.getContext(), "ClientGlobalInfo", globalEntity);
        } else {
            SpUtils.remove(MyApplication.getContext(), "ClientGlobalInfo");
        }
        UserGlobal.mGlobalConfigInfo = globalEntity;
    }

}
