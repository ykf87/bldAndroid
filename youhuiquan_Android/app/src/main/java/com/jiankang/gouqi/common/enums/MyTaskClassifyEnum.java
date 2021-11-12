package com.jiankang.gouqi.common.enums;

/**
 * 我的任务分类栏
 * 0全部 1进行中 2审核中 3被拒绝（必传）4已结束 5已完成
 */
public enum MyTaskClassifyEnum {
    None(-1, ""),
    ALL(0, "全部"),
    IN_PROGRESS(1, "待提交"),
    IN_REVIEW(2, "审核中"),
    REFUSE(3, "被拒绝"),
    ENDING(4, "已结束"),
    COMPELETE(5, "已完成");
    private int code;
    private String desc;

    private MyTaskClassifyEnum(int code, String desc) {
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
        for (MyTaskClassifyEnum type : values()) {
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
    public static MyTaskClassifyEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (MyTaskClassifyEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }

        // 默认样式
        return MyTaskClassifyEnum.ALL;
    }
}
