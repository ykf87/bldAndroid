package com.blandal.app.common.enums;

/**
 * 我的任务列表任务状态
 * 对应 task_status 字段
 */
public enum ZhaiTaskStatusEnum {

    None(-1, ""),
    // 1待预付款 , 2待审核, 3已发布 , 4已结束
    WAIT_PAYMENT(1,"待预付款"),
    PENDING(2,"待审核"),
    PUBLISHED(3,"已发布"),
    END(4,"已结束");
    private int code;
    private String desc;

    private ZhaiTaskStatusEnum(int code, String desc) {
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
        for (ZhaiTaskStatusEnum type : values()) {
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
    public static ZhaiTaskStatusEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (ZhaiTaskStatusEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return ZhaiTaskStatusEnum.WAIT_PAYMENT;
    }
}
