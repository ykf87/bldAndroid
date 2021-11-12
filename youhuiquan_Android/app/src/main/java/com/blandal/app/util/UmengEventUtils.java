package com.blandal.app.util;

import android.content.Context;


import java.util.HashMap;
import java.util.Map;

/**
 * 友盟事件上报
 *
 * @author: ljx
 * @createDate: 2020/10/22 16:44
 */
public class UmengEventUtils {
    /**
     * 进入主界面
     */
    public static final String EVENT_MAIN_START = "main_start";
    /**
     * App启动
     */
    public static final String EVENT_APP_START = "app_start";
    /**
     * 获取广告
     */
    public static final String EVENT_AD_GET = "ad_get";
    /**
     * 获取广告失败
     */
    public static final String EVENT_AD_FAIL = "ad_fail";
    /**
     * 显示广告
     */
    public static final String EVENT_AD_SHOW = "ad_show";
    /**
     * 点击广告
     */
    public static final String EVENT_AD_CLICK = "ad_click";
    /**
     * 展示h5
     */
    public static final String EVENT_H5_SHOW = "h5_show";
    /**
     * 验证码登录_获取验证码
     */
    public static final String EVENT_GET_CODE = "get_code";
    /**
     * 获取验证码页面_登录成功
     */
    public static final String EVENT_GET_CODE_SUCC = "get_code_succ";
    /**
     * 获取验证码页面_验证码错误
     */
    public static final String EVENT_GET_CODE_LOGIN_ERR = "get_code_err";
    /**
     * 首页列表_前12个任务
     */
    public static final String EVENT_HOME_LIST_CLICK = "home_list_click";
    /**
     * 任务详情_分享
     */
    public static final String EVENT_TASK_DETAIL_SHARED = "task_detail_shared";
    /**
     * 任务详情_分享_微信好友
     */
    public static final String EVENT_TASK_DETAIL_SHARED_WX = "task_detail_shared_wx";
    /**
     * 任务详情_分享_朋友圈
     */
    public static final String EVENT_TASK_DETAIL_SHARED_WX_CIRCLE = "task_detail_shared_wx_circle";
    /**
     * 任务详情_分享_QQ
     */
    public static final String EVENT_TASK_DETAIL_SHARED_QQ = "task_detail_shared_qq";
    /**
     * 任务详情_分享_QQ空间
     */
    public static final String EVENT_TASK_DETAIL_SHARED_QQ_SPACE = "task_detail_shared_qq_space";
    /**
     * 任务详情_复制链接
     */
    public static final String EVENT_TASK_DETAIL_SHARED_COPY_LINK = "task_detail_shared_copy_link";
    /**
     * 任务详情_分享_海报
     */
    public static final String EVENT_TASK_DETAIL_SHARED_POSTER = "task_detail_shared_poster";
    /**
     * 任务详情（被分享页面）
     */
    public static final String EVENT_TASK_DETAIL_SHARED_PAGE = "task_detail_shared_page";
    /**
     * 任务详情_联系客服
     */
    public static final String EVENT_TASK_DETAIL_CONTACK_CUSTOMER = "task_detail_contact_customer";
    /**
     * 任务详情_立即领取
     */
    public static final String EVENT_TASK_DETAIL_COLLECT_TASK = "task_detail_collect_task";
    /**
     * 赚钱计划_马上赚钱_微信好友
     */
    public static final String EVENT_RAISE_MONEY_SHARED_WX = "raise_money_shared_wx";
    /**
     * 赚钱计划_马上赚钱_微信朋友圈
     */
    public static final String EVENT_RAISE_MONEY_SHARED_WX_CIRCLE = "raise_money_shared_wx_circle";
    /**
     * 赚钱计划_马上赚钱_QQ
     */
    public static final String EVENT_RAISE_MONEY_SHARED_QQ = "raise_money_shared_qq";
    /**
     * 赚钱计划_马上赚钱_QQ空间
     */
    public static final String EVENT_RAISE_MONEY_SHARED_QQ_SPACE = "raise_money_shared_qq_space";
    /**
     * 赚钱计划_马上赚钱_复制链接
     */
    public static final String EVENT_RAISE_MONEY_SHARED_COPY_LINK = "raise_money_shared_copy_link";
    /**
     * 赚钱计划_马上赚钱_海报
     */
    public static final String EVENT_RAISE_MONEY_SHARED_POSTER = "raise_money_shared_poster";
    /**
     * 个人中心_赚钱攻略
     */
    public static final String EVENT_MY_MAKING_MONEY_STRATEGY = "making_money_strategy";
    /**
     * 我的钱包_提现
     */
    public static final String EVENT_MY_WALLET_WITHDRAW = "my_wallet_withdraw";
    /**
     * 我的钱包_提现_未达提现门槛弹窗_做小任务
     */
    public static final String EVENT_MY_WALLET_WITHDRAW_DO_SMALL_TASK = "my_wallet_withdraw_do_small_task";
    /**
     * 我的钱包_提现_未达提现门槛弹窗_参与活动
     */
    public static final String EVENT_MY_WALLET_WITHDRAW_DO_ACTIVITY = "my_wallet_withdraw_do_activities";
    /**
     * 我的钱包_提现_未达提现门槛弹窗_关闭
     */
    public static final String EVENT_MY_WALLET_WITHDRAW_CLOSE_DIALOG = "my_wallet_withdraw_close_dialog";
    /**
     * 实名认证_认证
     */
    public static final String EVENT_AUTHENTICATION = "authentication";
    /**
     * 我的任务_放弃
     */
    public static final String EVENT_MY_TASK_GIVE_UP = "my_task_give_up";
    /**
     * 我的任务_放弃_提交
     */
    public static final String EVENT_MY_TASK_GIVE_UP_COMMIT = "my_task_give_up_commit";

    /**
     * 首页tab点击
     */
    public static final String EVENT_HOME_TAB_CLICK_MAIN = "home_tab_click_main";
    /**
     * 我的tab点击
     */
    public static final String EVENT_HOME_TAB_CLICK_MY = "home_tab_click_my";
    /**
     * 赚钱计划tab点击
     */
    public static final String EVENT_HOME_TAB_CLICK_RAISE = "home_tab_click_raise";

    /**
     * 提交通用事件
     *
     * @param context
     * @param eventId 事件id
     */
    public static void pushCommonEvent(Context context, String eventId) {
        String access_channel_code = UserShared.getUmengChannelId(context);
        String now_city_name = ContentUtil.NOW_CITY_NAME;
        String imei = SystemUtil.getIMEI(context, 0);
        String androidId = SystemUtil.getAndroidId(context);
        String oaid = UserShared.getOAID(context);
        int osVersion = SystemUtil.getOSVersion();
        String brand = SystemUtil.getDeviceBrand();
        String model = SystemUtil.getDeviceModel();

        Map<String, Object> event = new HashMap<String, Object>();
        event.put("access_channel_code", access_channel_code);
        event.put("now_city_name", now_city_name);
        event.put("imei", imei);
        event.put("androidId", androidId);
        event.put("oaid", oaid);
        event.put("osVersion", osVersion);
        event.put("brand", brand);
        event.put("model", model);
    }

    /**
     * H5
     */
    public static void pushH5Event(Context context, String eventId, String url) {
        String access_channel_code = UserShared.getUmengChannelId(context);
        String now_city_name = ContentUtil.NOW_CITY_NAME;
        String imei = SystemUtil.getIMEI(context, 0);
        String androidId = SystemUtil.getAndroidId(context);
        String oaid = UserShared.getOAID(context);
        int osVersion = SystemUtil.getOSVersion();
        String brand = SystemUtil.getDeviceBrand();
        String model = SystemUtil.getDeviceModel();

        Map<String, Object> event = new HashMap<String, Object>();
        event.put("access_channel_code", access_channel_code);
        event.put("now_city_name", now_city_name);
        event.put("imei", imei);
        event.put("androidId", androidId);
        event.put("oaid", oaid);
        event.put("osVersion", osVersion);
        event.put("brand", brand);
        event.put("model", model);
        event.put("url", url);
    }

}
