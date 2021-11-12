package com.blandal.app.common.enums;

/**
 * 我的任务列表任务交易状态
 * 对应 task_trade_status 字段
 */
public enum ZhaiTaskTradeStatusEnum {

    None(-1, ""),
    // 任务交易状态： 1已申请 2已提交任务 3已结束
    HAS_APPLY(1,"已申请"),
    HAS_SUBMIT(2,"已提交任务"),
    HAS_END(3,"已结束");
    private int code;
    private String desc;

    private ZhaiTaskTradeStatusEnum(int code, String desc) {
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
        for (ZhaiTaskTradeStatusEnum type : values()) {
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
    public static ZhaiTaskTradeStatusEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (ZhaiTaskTradeStatusEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return ZhaiTaskTradeStatusEnum.HAS_APPLY;
    }
}
