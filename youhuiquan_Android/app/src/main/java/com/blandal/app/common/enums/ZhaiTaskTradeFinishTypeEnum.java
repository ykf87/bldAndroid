package com.blandal.app.common.enums;

/**
 * 我的任务列表任务交易结束原因
 * 对应 task_trade_finish_type 字段
 */
public enum ZhaiTaskTradeFinishTypeEnum {

    // 任务交易结束原因: 1用户未提交任务 2雇主审核通过 3雇主未处理默认通过 4雇主审核未通过  5雇主认定恶意提交
    None(-1, ""),
    STU_NOT_SUBMIT(1,"用户未提交任务"),
    ENT_AUDIT_PASS(2,"雇主审核通过"),
    ENT_DEFAULT_PASS(3,"雇主未处理默认通过"),
    ENT_AUDIT_FAIL(4,"雇主审核未通过"),
    ENT_DETERMINE_MALICE_SUBMIT(5,"雇主认定恶意提交"),
    ABANBON(6,"用户放弃");
    private int code;
    private String desc;

    private ZhaiTaskTradeFinishTypeEnum(int code, String desc) {
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
        for (ZhaiTaskTradeFinishTypeEnum type : values()) {
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
    public static ZhaiTaskTradeFinishTypeEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (ZhaiTaskTradeFinishTypeEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return ZhaiTaskTradeFinishTypeEnum.STU_NOT_SUBMIT;
    }
}
