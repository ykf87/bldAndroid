package com.blandal.app.util;

import android.content.Context;
import android.content.Intent;

import com.blandal.app.common.MyHandler;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.common.enums.ConfirmEnum;
import com.blandal.app.constant.FinalLoginType;
import com.blandal.app.dialog.Confirm;
import com.blandal.app.interfaces.AppInterfaces;
import com.blandal.app.ui.login.activity.OneKeyLoginActivity;

public class LoginUtils {

    /**
     * 是否 用户登录
     */
    public static boolean isUserLogin(Context mContext) {

        // 拿到登录类型
        String loginType = UserShared.getLoginType(mContext);

        if (loginType.length() < 1) {
            return false;
        }

        if (FinalLoginType.ToUserLogin.equals(loginType)) {
            return true;
        } else if (FinalLoginType.ToUserQQLogin.equals(loginType)) {
            return true;
        } else if (FinalLoginType.ToUserWeiBoLogin.equals(loginType)) {
            return true;
        } else if (FinalLoginType.ToUserWeiXinLogin.equals(loginType)) {
            return true;
        }

        return false;
    }

    /**
     * 企业是否已经登录
     *
     * @param mContext
     * @return
     */
    public static boolean isEntLogin(Context mContext) {
        // 拿到登录类型
        String loginType = UserShared.getLoginType(mContext);

        // 企业账号密码登录
        return FinalLoginType.ToEnterPrise.equals(loginType);
    }

    /**
     * (当前是否企业未登录状态)未登录状态下是否跳转到企业
     *
     * @param mContext
     * @return
     */
    public static boolean isNotLoginToEnt(Context mContext) {
        // 拿到登录类型
        String notLoginType = UserShared.getNotLoginType(mContext);

        // 企业账号密码登录
        return FinalLoginType.ToEnterPrise.equals(notLoginType);
    }

    /**
     * 企业和用户都未登录的情况下
     *
     * @return
     */
    public static boolean isNotLogin(Context mContext) {
        if (mContext == null) {
            return true;
        }
        if (isUserLogin(mContext)) {
            return false;
        }
        if (isEntLogin(mContext)) {
            return false;
        }
        return true;
    }

    /**
     * 用户退出方法
     */
    public static void userExit(Context mContext) {

        if (mContext == null) {
            return;
        }

        UserGlobal.mUserResume = null;


        // 退出清除动态密码
        UserShared.setDynamicPassword(mContext, "");

        // 清除session
        UserShared.setSessionId(mContext, "");

        // 清除保存的密码
        UserShared.setLoginPass(mContext, "");

        // 设置跳转类型为到登录选择页面
        UserShared.setLoginType(mContext, FinalLoginType.ToLoginSel);
    }

    /**
     * 跳转到登录页面
     */
    public static void toLoginTip(final MyHandler handler,
                                  final Context mContext,
                                  final AppInterfaces.ToLoginTipCallBackInterface pToLoginTipCallBackInterface) {
        handler.mPost(new Runnable() {
            @Override
            public void run() {
                Confirm confirm = new Confirm(mContext, "确定", "取消",
                        "您还没有登录唷~请登录解锁更多惊喜!", ConfirmEnum.hope, "请先登录");
                confirm.setBtnOkClick(new Confirm.MyBtnOkClick() {
                    @Override
                    public void btnOkClickMet() {
                        if (pToLoginTipCallBackInterface != null) {
                            pToLoginTipCallBackInterface.callback();
                        }
                        toLoginActivity(handler, mContext);
                    }
                });
            }
        });
    }

    /**
     * 跳转到登录页面
     */
    public static void toLoginTip(final MyHandler handler,
                                  final Context mContext) {
        toLoginTip(handler, mContext, null);
    }

    /**
     * 跳转到用户登录页面 传入文字
     */
    public static void toUserLoginTip(final MyHandler handler,
                                      final Context mContext, final String title, final String yes,
                                      final String no) {
        handler.mPost(new Runnable() {
            @Override
            public void run() {
                Confirm confirm = new Confirm(mContext, yes, no, title,
                        ConfirmEnum.hope);
                confirm.setBtnOkClick(new Confirm.MyBtnOkClick() {
                    @Override
                    public void btnOkClickMet() {
                        toLoginActivity(handler, mContext);
                    }
                });
            }
        });
    }

    /**
     * 跳转到登录页面
     */
    public static void toLoginActivity(MyHandler handler, final Context mContext) {
        handler.mPost(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(mContext, OneKeyLoginActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.putExtra("MustLogin", true);
                mContext.startActivity(intent);
            }
        });
    }
}
