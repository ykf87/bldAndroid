package com.blandal.app.entity;

/**
 * Description:全局接口数据类
 * author:ljx
 * time  :2020/10/19 17 21
 */

public class GlobalEntity {

    /**
     * withdraw_ad_list : []
     * task_audit_count : 0
     * list_apply : 0
     * basic_info : {"enterprise_collect_count":0,"job_collect_count":0}
     * version_info : {}
     * special_entry_ad_list : []
     * banner_ad_list : []
     * total_amount : 0
     * is_distribution_on : 0
     * corner_ad_list : []
     * one_click_group : 0WjX3J8zc5giBb_4MXfB8XHE0HkxLShT&jump_from=webapi
     * has_set_bag_pwd : 1
     * index_popup_ad_list : [{"ad_type":3,"ad_name":"有券安卓首页弹窗","ad_content":"","ad_order_num":0,"ad_status":2,"ad_id":35,"need_Login":0,"ad_detail_url":"www.baidu.com","img_url":"https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/test/Upload/shijianke-mgr/artical/upload/2020-11-16/9378b23915ef41769a668bfeaaaaad8e.jpg","sdk_ad_type":0,"ad_site_id":163}]
     * is_login : 0
     * start_front_ad_list : [{"ad_type":3,"ad_name":"有券安卓启动页前景广告","ad_content":"","ad_order_num":0,"ad_status":2,"ad_id":36,"need_Login":0,"ad_detail_url":"www.jianke.cc","img_url":"https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/test/Upload/shijianke-mgr/artical/upload/2020-11-16/983ec2019a5640de9d94713f10f26b23.jpg","sdk_ad_type":0,"ad_site_id":162}]
     * task_apply_count : 0
     *
     */

    public String appname;
    public String version;
    public String versions;
    public String service;
    public boolean isadv;//是否开启广告

    public  BasicInfoEntity basic_info;


    public class BasicInfoEntity {

        /**
         * account_id : 7930142
         * enterprise_collect_count : 0
         * job_collect_count : 0
         * profile_url : https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/product/shijianke-server/userprofile/06bd752155ff4656be641cd8880c52f5/2015-10-07/67ef355408b2449ea5228f527f4975c2.png
         * telphone :
         * true_name :
         * verify_status : 1
         */

        public int account_id;
        public int enterprise_collect_count;
        public int job_collect_count;
        public String profile_url;
        public String telphone;
        public String true_name;
        public int verify_status;
    }

}
