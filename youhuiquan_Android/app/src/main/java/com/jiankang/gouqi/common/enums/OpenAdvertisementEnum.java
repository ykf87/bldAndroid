package com.jiankang.gouqi.common.enums;

/**
 * 打开广告枚举
 */
public enum OpenAdvertisementEnum {
    None(-1, ""),
    NO(0, "什么都不做"),
    ARTICLE(1,"应用内打开链接"),
    JOB(2,"岗位广告"),
    ARTICLE_BROWSER(3,"浏览器打开链接"),
    TOPIC(4,"专题类型"),
    OPNE_APP_PAGE(5,"应用内打开原生页面"),
    WECHAT_APPLTE_PAGE(6,"微信小程序页面"),
    JOB_QUERY_LIST_PAGE(7,"岗位列表页面"),
    ENT_DETAIL_PAGE(8,"雇主广告"),
    SDK_TUI(9,"SDK(推啊)"),
    SDK_PANGOLIN(10,"SDK(穿山甲)"),
    ADVERTORIAL(11, "软文广告"),
    ZB_TASK(12,"任务广告"),
    ZB_TASK_PLAN(13,"任务计划"),
    SDK_YQ(14, "SDK(云蜻)"),
    SDK_BXM(15, "SDK(变现猫)");

    private int code;
    private String desc;

    private OpenAdvertisementEnum(int code, String desc) {
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
        for (OpenAdvertisementEnum type : values()) {
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
    public static OpenAdvertisementEnum valueOf(Integer code) {
        if (code == null) {
            return None;
        }
        for (OpenAdvertisementEnum type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        // 默认什么都不做
        return OpenAdvertisementEnum.valueOf(0);
    }


    public boolean isBXMAd(){
        return this == SDK_BXM;
    }


    public boolean isYQAd(){
        return this == SDK_YQ;
    }
}
