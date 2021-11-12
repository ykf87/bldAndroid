package com.blandal.app.entity;

import java.io.Serializable;

/**
 * @author: ljx
 * 广告
 * @createDate: 2020/11/18  15:25
 */
public class AdEntity implements Serializable {
    private static final long serialVersionUID = -2512395247680543352L;
    /**
     * ad_type : 3
     * ad_detail_id : 39371
     * ad_name : 小红书
     * ad_content :
     * ad_order_num : 0
     * ad_status : 2
     * ad_id : 13513
     * need_Login : 0
     * ad_detail_url : http://www.jianke.cc/zixun/1735.html?isFromMgr=1
     * img_url : https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/product/Upload/shijianke-mgr/artical/upload/2020-11-16/0447f4c96ba84f86bb4b9491cf105745.jpg
     * sdk_ad_type : 0
     * ad_site_id : 152
     */

    public int ad_type;
    public int ad_detail_id;
    public String ad_name;
    public String ad_content;
    public int ad_order_num;
    public int ad_status;
    public int ad_id;
    public int need_Login; //是否需要登录 0否 1是
    public String ad_detail_url;//广告链接
    public String img_url;
    public int sdk_ad_type;
    public int ad_site_id;


    public AdEntity(String img_url) {
        this.img_url = img_url;
    }
    public AdEntity() {
    }
}
