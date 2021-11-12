package com.jiankang.gouqi.common.enums;

/**
 * None(-1, ""), PostPersonalServiceOrder(1, "唤起发个人服务商订单"),
 * PayPersonalServiceCallFee( 2, "支付查看个人服务商电话费用"), PostTeamServiceOrder(3,
 * "唤起发团队服务商订单"), ImgBrowse( 4, "图片浏览"), PersonalYaoYueSucc(5,
 * "个人服务商邀约成功调用js方法"), TeamYaoYueSucc( 6, "团队邀约成功"), ViewPersonalServiceList(7,
 * "查看个人服务商列表（用户兼职）"), SetShareInfo( 9, "h5给客户端分享赋值"), ShowShareInfo(10,
 * "唤起客户端分享方法");
 */
public enum WebViewFlgEnum {
    None(-1, ""),
    PostPersonalServiceOrder(1, "唤起发个人服务商订单"),
    PayPersonalServiceCallFee(2, "支付查看个人服务商电话费用"),
    PostTeamServiceOrder(3, "唤起发团队服务商订单"),
    ImgBrowse(4, "图片浏览"),
    PersonalYaoYueSucc(5, "个人服务商邀约成功调用js方法"),
    TeamYaoYueSucc(6, "团队邀约成功"),
    ViewPersonalServiceList(7, "查看个人服务商列表（用户兼职）"),
    SetShareInfo(9, "h5给客户端分享赋值"),
    ShowShareInfo(10, "唤起客户端分享方法"),
    UploadVideo(11, "调用客户端上传视频方法"),
    OpenPlayVideo(12, "调用客户端播放视频方法"),
    ApplyZhaiSucc(13, "任务接任务成功后调用js方法"),
    UploadAndClippingImage(16, "上传裁剪图片"),
    ApplyJob(17, "岗位报名"),
    ShareZhongBao(18, "分享众包"),
    OpenLogin(19, "打开登录页面"),
    OpenJobList(20, "打开岗位列表页面(取首页)"),
    OpenMyWallet(21, "打开钱袋子"),
    TaskDetailPage(22, "任务详情页");

    private int code;
    private String desc;

    private WebViewFlgEnum(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    /**
     * 判断值是否合法
     *
     * @param code
     * @return
     * @Description:
     */
    public static boolean isValid(Integer code) {
        for (WebViewFlgEnum type : values()) {
            if (type.code == code) {
                return true;
            }
        }
        return false;
    }

    /**
     * valueOf
     *
     * @param code
     * @return
     * @Description:
     */
    public static WebViewFlgEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (WebViewFlgEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        // 建议
        return WebViewFlgEnum.None;
    }
}
