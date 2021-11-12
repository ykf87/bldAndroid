package com.blandal.app.ui.main.entity;

/**
 * @author: ljx
 * @createDate: 2020/11/18  15:58
 * 首页分类实体
 */
public class ClassifyBean {
    /**
     * zhaiTask_classfier_id : 14
     * zhaiTask_classfier_status : 1
     * zhaiTask_classfier_img_url : https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/product/Upload/shijianke-mgr/zhaiTaskClassify/2020-08-30/d13be3eff78440e78221ff330eab8bd6.png
     * zhaiTask_classfier_name : 极速立审
     */

    private int id;
    private int zhaiTask_classfier_status;
    private String zhaiTask_classfier_img_url;
    private String name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getZhaiTask_classfier_status() {
        return zhaiTask_classfier_status;
    }

    public void setZhaiTask_classfier_status(int zhaiTask_classfier_status) {
        this.zhaiTask_classfier_status = zhaiTask_classfier_status;
    }

    public String getZhaiTask_classfier_img_url() {
        return zhaiTask_classfier_img_url;
    }

    public void setZhaiTask_classfier_img_url(String zhaiTask_classfier_img_url) {
        this.zhaiTask_classfier_img_url = zhaiTask_classfier_img_url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
