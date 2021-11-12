package com.blandal.app.common.enums;

/**
 * 我的任务列表任务结束原因
 * 对应  字段
 */
public enum ZhaiTaskCloseTypeEnum {

    None(-1, ""),
    // 任务结束原因（枚举）1审核不通过 2到期结束 3被下架
    AUDIT_FAIL(1,"审核不通过"),
    EXPIRED(2,"到期结束"),
    OFFSHELF(3,"客服下架"),
    ENT_CLOSE(4,"雇主下架"),//进行中任务下架
    ENT_CLOSE_TASK(5,"雇主关闭任务");//审核拒绝关闭任务
    private int code;
    private String desc;

    private ZhaiTaskCloseTypeEnum(int code, String desc) {
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
        for (ZhaiTaskCloseTypeEnum type : values()) {
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
    public static ZhaiTaskCloseTypeEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (ZhaiTaskCloseTypeEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return ZhaiTaskCloseTypeEnum.AUDIT_FAIL;
    }
}
