package com.blandal.app.common.enums;

/**
 * 用户实名认证状态
 * 对应 verify_status 字段
 */
public enum VerifyStatusEnum {

    None(-1, ""),
    // 任务交易状态： 1已申请 2已提交任务 3已结束
    NO_VERIFY(1, "未认证"),
    VERIFYING(2, "认证中"),
    VERIFY_SUCC(3, "认证通过"),
    VERIFY_FAIL(4, "认证失败");
    private int code;
    private String desc;

    private VerifyStatusEnum(int code, String desc) {
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
        for (VerifyStatusEnum type : values()) {
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
    public static VerifyStatusEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (VerifyStatusEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return VerifyStatusEnum.NO_VERIFY;
    }
}
