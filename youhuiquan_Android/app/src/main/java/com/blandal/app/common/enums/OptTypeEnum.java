package com.blandal.app.common.enums;

/**
 * 获取验证码类型
 */
public enum OptTypeEnum {

    None(-1, ""), REGISTER(1, "注册"),
    RESETPASSWORD(2, "找回密码"),
    UPDATE_PHONE_NUM(3, "修改手机号码"),
    BIND_PHONE_NUM(4, "第三方登录绑定手机号"),
    RESET_MONEYBAG_PASSWORD(5, "找回钱袋子密码"),
    WEB_REGISTER_APPLY_INFO(6, "登记报名信息"),
    DYNAMIC_PASSWORD(7, "动态密码"),
    MAKEP_BY_URL(8, "链接补录"),
    VACATION_WORKER(9, "寒暑假工"),
    ZHAOSHAGN_CREDIT_CARD(10, "招商信用卡"),
    UPDATE_RESUME_CONTACT_TEL(11, "修改简历联系方式"),
    WECHAT_APPLET_BING_TEL(12, "微信小程序绑定手机号"),
    DESTROY_ACCOUNT(13, "注销账号"),
    PARENT_BINDING_SUB(14, "母账号绑定子账号"),
    BINDING_ALIPAY(15, "绑定银行卡"),
    LOGIN_CHECK(16, "登录安全监测");

    private int code;
    private String desc;

    private OptTypeEnum(int code, String desc) {
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
        for (OptTypeEnum type : values()) {
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
    public static OptTypeEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (OptTypeEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return OptTypeEnum.None;
    }
}
