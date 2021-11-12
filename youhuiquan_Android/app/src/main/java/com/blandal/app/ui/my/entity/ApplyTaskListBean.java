package com.blandal.app.ui.my.entity;

import com.chad.library.adapter.base.entity.MultiItemEntity;

import java.io.Serializable;
import java.util.List;

import com.blandal.app.ui.main.entity.HomeTaskEntity;

/**
 * @author: ljx
 * @createDate: 2020/11/19  15:38
 */
public class ApplyTaskListBean implements Serializable, MultiItemEntity {
    /**
     * cur_server_time : 1605770833486
     * is_qr_submit : 0
     * left_can_apply_count : 4
     * mark_type : 0
     * mark_type_name :
     * show_complain_btn : 0
     * show_reapply_btn : 0
     * status_name :
     * stu_account_id : 7930142
     * stu_apply_salary : 1500
     * stu_apply_time : 1605770820000
     * stu_submit_dead_time : 1605778020000
     * stu_true_name :
     * task_apply_id : 2491272
     * task_id : 39555
     * task_trade_finish_type
     * task_submit_type : 4
     * task_trade_status : 1
     * zhai_task : {"task_classify_id":14,"task_classify_img_url":"https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/product/Upload/shijianke-mgr/zhaiTaskClassify/2020-08-30/d13be3eff78440e78221ff330eab8bd6.png","task_fee":2600,"task_has_apply_valid_num":10,"task_left_can_apply_count":90,"task_salary":1500,"task_status":3,"task_submit_check_success_rate":100,"task_submit_published_count":0,"task_title":"【5分钟立审】赞丽生活简单下载","task_uuid":"b952ebeb-b158-4bc7-b2c8-c9ab095dc379","times_limit":1}
     */

    private long cur_server_time;
    private int is_qr_submit;
    private int left_can_apply_count;  //可领取次数（最大5）
    private int mark_type;
    private String mark_type_name;
    private long ent_audit_dead_time;//商家审核截止时间
    private int show_complain_btn;//是否展示申诉按钮 0不展示 1展示
    private int show_reapply_btn;//是否展示重新领取按钮 0不展示 1展示
    private String status_name;
    private String task_trade_audit_remark;
    private int stu_account_id;
    private int stu_apply_salary;
    private long stu_apply_time;
    private long stu_submit_dead_time;
    private String stu_true_name;
    private int task_apply_id;
    private int task_id;
    private int task_submit_type;
    private int task_trade_finish_type;
    private int task_trade_status;
    public boolean isReadTask;
    private HomeTaskEntity zhai_task;
    private int type;
    private long stu_submit_left_time;//剩余时间  stu_submit_dead_time-cur_server_time/ent_audit_dead_time-cur_server_time

    private String stu_task_submit_pic_url;
    private String task_user_text;
    private List<StuTaskSubmitPicUrlJsonEntity> stu_task_submit_pic_url_json;
    private List<StuTaskSubmitUserTextJsonEntity> stu_task_submit_user_text_json;

    public static class StuTaskSubmitPicUrlJsonEntity {
        /**
         * task_submit_pic_url : https://wodan-idc.oss-cn-hangzhou.aliyuncs.com/product/Upload/shijianke-server/user/image/2020-12-11/14d122d4f1d841c1ad450e22208779d0.png
         */

        private String task_submit_pic_url;

        public String getTask_submit_pic_url() {
            return task_submit_pic_url;
        }

        public void setTask_submit_pic_url(String task_submit_pic_url) {
            this.task_submit_pic_url = task_submit_pic_url;
        }
    }

    public static class StuTaskSubmitUserTextJsonEntity {
        /**
         * task_text_value : 1231
         * task_text_name : sizhangkua
         */

        private String task_text_value;
        private String task_text_name;

        public String getTask_text_value() {
            return task_text_value;
        }

        public void setTask_text_value(String task_text_value) {
            this.task_text_value = task_text_value;
        }

        public String getTask_text_name() {
            return task_text_name;
        }

        public void setTask_text_name(String task_text_name) {
            this.task_text_name = task_text_name;
        }
    }

    public int getShow_complain_btn() {
        return show_complain_btn;
    }

    public int getShow_reapply_btn() {
        return show_reapply_btn;
    }

    public String getTask_trade_audit_remark() {
        return task_trade_audit_remark;
    }

    public void setTask_trade_audit_remark(String task_trade_audit_remark) {
        this.task_trade_audit_remark = task_trade_audit_remark;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public long getCur_server_time() {
        return cur_server_time;
    }

    public void setCur_server_time(long cur_server_time) {
        this.cur_server_time = cur_server_time;
    }

    public int getIs_qr_submit() {
        return is_qr_submit;
    }

    public void setIs_qr_submit(int is_qr_submit) {
        this.is_qr_submit = is_qr_submit;
    }

    public int getLeft_can_apply_count() {
        return left_can_apply_count;
    }

    public void setLeft_can_apply_count(int left_can_apply_count) {
        this.left_can_apply_count = left_can_apply_count;
    }

    public long getStu_submit_left_time() {
        return stu_submit_left_time;
    }

    public void setStu_submit_left_time(long stu_submit_left_time) {
        this.stu_submit_left_time = stu_submit_left_time;
    }

    public long getEnt_audit_dead_time() {
        return ent_audit_dead_time;
    }

    public void setEnt_audit_dead_time(long ent_audit_dead_time) {
        this.ent_audit_dead_time = ent_audit_dead_time;
    }

    public int getTask_trade_finish_type() {
        return task_trade_finish_type;
    }

    public void setTask_trade_finish_type(int task_trade_finish_type) {
        this.task_trade_finish_type = task_trade_finish_type;
    }

    public int getMark_type() {
        return mark_type;
    }

    public void setMark_type(int mark_type) {
        this.mark_type = mark_type;
    }

    public String getMark_type_name() {
        return mark_type_name;
    }

    public void setMark_type_name(String mark_type_name) {
        this.mark_type_name = mark_type_name;
    }

    public boolean isShowComplainBtn() {
        return show_complain_btn == 1;
    }

    public void setShow_complain_btn(int show_complain_btn) {
        this.show_complain_btn = show_complain_btn;
    }

    public boolean isShowReapplyBtn() {
        return show_reapply_btn == 1;
    }

    public void setShow_reapply_btn(int show_reapply_btn) {
        this.show_reapply_btn = show_reapply_btn;
    }

    public String getStatus_name() {
        return status_name;
    }

    public void setStatus_name(String status_name) {
        this.status_name = status_name;
    }

    public int getStu_account_id() {
        return stu_account_id;
    }

    public void setStu_account_id(int stu_account_id) {
        this.stu_account_id = stu_account_id;
    }

    public int getStu_apply_salary() {
        return stu_apply_salary;
    }

    public void setStu_apply_salary(int stu_apply_salary) {
        this.stu_apply_salary = stu_apply_salary;
    }

    public long getStu_apply_time() {
        return stu_apply_time;
    }

    public void setStu_apply_time(long stu_apply_time) {
        this.stu_apply_time = stu_apply_time;
    }

    public long getStu_submit_dead_time() {
        return stu_submit_dead_time;
    }

    public void setStu_submit_dead_time(long stu_submit_dead_time) {
        this.stu_submit_dead_time = stu_submit_dead_time;
    }

    public String getStu_true_name() {
        return stu_true_name;
    }

    public void setStu_true_name(String stu_true_name) {
        this.stu_true_name = stu_true_name;
    }

    public int getTask_apply_id() {
        return task_apply_id;
    }

    public void setTask_apply_id(int task_apply_id) {
        this.task_apply_id = task_apply_id;
    }

    public int getTask_id() {
        return task_id;
    }

    public void setTask_id(int task_id) {
        this.task_id = task_id;
    }

    public int getTask_submit_type() {
        return task_submit_type;
    }

    public void setTask_submit_type(int task_submit_type) {
        this.task_submit_type = task_submit_type;
    }

    public int getTask_trade_status() {
        return task_trade_status;
    }

    public void setTask_trade_status(int task_trade_status) {
        this.task_trade_status = task_trade_status;
    }

    public HomeTaskEntity getZhai_task() {
        return zhai_task;
    }

    public void setZhai_task(HomeTaskEntity zhai_task) {
        this.zhai_task = zhai_task;
    }

    @Override
    public int getItemType() {
        return type;
    }


    public String getStu_task_submit_pic_url() {
        return stu_task_submit_pic_url;
    }

    public void setStu_task_submit_pic_url(String stu_task_submit_pic_url) {
        this.stu_task_submit_pic_url = stu_task_submit_pic_url;
    }

    public String getTask_user_text() {
        return task_user_text;
    }

    public void setTask_user_text(String task_user_text) {
        this.task_user_text = task_user_text;
    }

    public List<StuTaskSubmitPicUrlJsonEntity> getStu_task_submit_pic_url_json() {
        return stu_task_submit_pic_url_json;
    }

    public void setStu_task_submit_pic_url_json(List<StuTaskSubmitPicUrlJsonEntity> stu_task_submit_pic_url_json) {
        this.stu_task_submit_pic_url_json = stu_task_submit_pic_url_json;
    }

    public List<StuTaskSubmitUserTextJsonEntity> getStu_task_submit_user_text_json() {
        return stu_task_submit_user_text_json;
    }

    public void setStu_task_submit_user_text_json(List<StuTaskSubmitUserTextJsonEntity> stu_task_submit_user_text_json) {
        this.stu_task_submit_user_text_json = stu_task_submit_user_text_json;
    }
}

