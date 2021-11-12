package com.blandal.app.common.enums;

/**
 * 任务列表中任务的类型
 * 对应 icon_classify字段
 */
public enum TaskTypeEnum {

    None(-1, ""),
    NORMAL(0, "普通"),
    HAND_PICK(1, "精选"),
    OFFICIAL_RECOMMEND(2, "官方推荐"),
    EASY_TASK(3, "简单好做");
    private int code;
    private String desc;

    private TaskTypeEnum(int code, String desc) {
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
        for (TaskTypeEnum type : values()) {
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
    public static TaskTypeEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (TaskTypeEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return TaskTypeEnum.NORMAL;
    }
}
