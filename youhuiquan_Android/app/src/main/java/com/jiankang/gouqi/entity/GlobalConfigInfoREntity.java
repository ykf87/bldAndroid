package com.jiankang.gouqi.entity;

/**
 * 全局配置
 *
 * @author: ljx
 * @createDate: 2020/10/18 17:09
 */
public class GlobalConfigInfoREntity {

    /**
     * 是否需要弹协议更新弹窗 0：不弹 1:要弹
     */
    public int is_need_pop;


    /**
     * 服务端时间毫秒数
     */
    public long current_time_millis;

    /**
     * 客户端版本信息
     */
    public ClientVersionEntity version_info;

}
