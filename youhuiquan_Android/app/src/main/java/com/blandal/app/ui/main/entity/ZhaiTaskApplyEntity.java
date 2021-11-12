package com.blandal.app.ui.main.entity;

import org.json.JSONArray;

import java.io.Serializable;


public class ZhaiTaskApplyEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long task_apply_id; // 任务投递ID,添加的时候不需要.
    private Long task_id; // 任务ID
    private String task_uuid; // 任务uuID
    private int task_submit_type;
    private String stu_task_submit_content; // 文本任务提交内容
    private String stu_task_submit_pic_url; //截图任务提交内容,图片地址 json串
    private JSONArray stu_task_submit_pic_url_json; //截图任务提交内容,图片地址 json串

    private Long stu_apply_time; //用户申请任务时间
    private Long stu_submit_dead_time; //用户任务提交截止时间
    private Long stu_submit_time; //用户任务提交时间
    private Long ent_audit_dead_time; //雇主任务审核截止时间
    private Long cur_server_time; //服务器时间

    private Long ent_account_id;
    private int task_trade_status; // 任务交易状态： 1已申请 2已提交任务 3已结束
    private int task_trade_finish_type; // 任务交易结束原因: 1用户未提交任务 2雇主审核通过 3雇主未处理默认通过 4雇主审核未通过

    private HomeTaskEntity zhai_task; //任务相关信息
    private String stu_true_name;// 申请任务者姓名

    private int is_qr_submit; // 是否是二维码提交： 1是 0否 默认否
    private String qr_submit_nickname; // 二维码提交人昵称

    private int show_complain_btn; // 展示申诉按钮 0不展示 1展示
    private int show_reapply_btn; // 展示重新领取按钮 0不展示 1展示

    private String task_trade_audit_remark; // 雇主审核备注
    private String task_user_text; // 用户提交文本
    private JSONArray stu_task_submit_user_text_json; // 用户提交文本json
    private int left_can_apply_count; // 剩余可领取次数
    private int mark_type;//是否查看
    private String mark_type_name;//是否查看中文
    private String status_name;//申请状态中文
    private int stu_apply_salary;//任务申请时的工资
    private Long stu_account_id;
    // -------------------------------------------------------------------------------》

    public Long getTask_apply_id() {
        return task_apply_id;
    }

    public void setTask_apply_id(Long task_apply_id) {
        this.task_apply_id = task_apply_id;
    }

    public Long getTask_id() {
        return task_id;
    }

    public void setTask_id(Long task_id) {
        this.task_id = task_id;
    }

    public int getTask_submit_type() {
        return task_submit_type;
    }

    public void setTask_submit_type(int task_submit_type) {
        this.task_submit_type = task_submit_type;
    }

    public String getStu_task_submit_content() {
        return stu_task_submit_content;
    }

    public void setStu_task_submit_content(String stu_task_submit_content) {
        this.stu_task_submit_content = stu_task_submit_content;
    }

    public String getStu_task_submit_pic_url() {
        return stu_task_submit_pic_url;
    }

    public void setStu_task_submit_pic_url(String stu_task_submit_pic_url) {
        this.stu_task_submit_pic_url = stu_task_submit_pic_url;
    }

    public Long getStu_apply_time() {
        return stu_apply_time;
    }

    public void setStu_apply_time(Long stu_apply_time) {
        this.stu_apply_time = stu_apply_time;
    }

    public Long getStu_submit_dead_time() {
        return stu_submit_dead_time;
    }

    public void setStu_submit_dead_time(Long stu_submit_dead_time) {
        this.stu_submit_dead_time = stu_submit_dead_time;
    }

    public Long getStu_submit_time() {
        return stu_submit_time;
    }

    public void setStu_submit_time(Long stu_submit_time) {
        this.stu_submit_time = stu_submit_time;
    }

    public Long getEnt_audit_dead_time() {
        return ent_audit_dead_time;
    }

    public void setEnt_audit_dead_time(Long ent_audit_dead_time) {
        this.ent_audit_dead_time = ent_audit_dead_time;
    }

    public Long getEnt_account_id() {
        return ent_account_id;
    }

    public void setEnt_account_id(Long ent_account_id) {
        this.ent_account_id = ent_account_id;
    }

    public int getTask_trade_status() {
        return task_trade_status;
    }

    public void setTask_trade_status(int task_trade_status) {
        this.task_trade_status = task_trade_status;
    }

    public int getTask_trade_finish_type() {
        return task_trade_finish_type;
    }

    public void setTask_trade_finish_type(int task_trade_finish_type) {
        this.task_trade_finish_type = task_trade_finish_type;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public HomeTaskEntity getZhai_task() {
        return zhai_task;
    }

    public void setZhai_task(HomeTaskEntity zhai_task) {
        this.zhai_task = zhai_task;
    }

    public String getStu_true_name() {
        return stu_true_name;
    }

    public void setStu_true_name(String stu_true_name) {
        this.stu_true_name = stu_true_name;
    }

    public String getTask_uuid() {
        return task_uuid;
    }

    public void setTask_uuid(String task_uuid) {
        this.task_uuid = task_uuid;
    }

    public JSONArray getStu_task_submit_pic_url_json() {
        return stu_task_submit_pic_url_json;
    }

    public void setStu_task_submit_pic_url_json(
            JSONArray stu_task_submit_pic_url_json) {
        this.stu_task_submit_pic_url_json = stu_task_submit_pic_url_json;
    }

    public int getIs_qr_submit() {
        return is_qr_submit;
    }

    public void setIs_qr_submit(int is_qr_submit) {
        this.is_qr_submit = is_qr_submit;
    }

    public String getQr_submit_nickname() {
        return qr_submit_nickname;
    }

    public void setQr_submit_nickname(String qr_submit_nickname) {
        this.qr_submit_nickname = qr_submit_nickname;
    }

    public int getShow_complain_btn() {
        return show_complain_btn;
    }

    public void setShow_complain_btn(int show_complain_btn) {
        this.show_complain_btn = show_complain_btn;
    }

    public int getShow_reapply_btn() {
        return show_reapply_btn;
    }

    public void setShow_reapply_btn(int show_reapply_btn) {
        this.show_reapply_btn = show_reapply_btn;
    }

    public String getTask_trade_audit_remark() {
        return task_trade_audit_remark;
    }

    public void setTask_trade_audit_remark(String task_trade_audit_remark) {
        this.task_trade_audit_remark = task_trade_audit_remark;
    }

    public String getTask_user_text() {
        return task_user_text;
    }

    public void setTask_user_text(String task_user_text) {
        this.task_user_text = task_user_text;
    }

    public JSONArray getStu_task_submit_user_text_json() {
        return stu_task_submit_user_text_json;
    }

    public void setStu_task_submit_user_text_json(JSONArray stu_task_submit_user_text_json) {
        this.stu_task_submit_user_text_json = stu_task_submit_user_text_json;
    }

    public int getLeft_can_apply_count() {
        return left_can_apply_count;
    }

    public void setLeft_can_apply_count(int left_can_apply_count) {
        this.left_can_apply_count = left_can_apply_count;
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

    public String getStatus_name() {
        return status_name;
    }

    public void setStatus_name(String status_name) {
        this.status_name = status_name;
    }

    public Long getCur_server_time() {
        return cur_server_time;
    }

    public void setCur_server_time(Long cur_server_time) {
        this.cur_server_time = cur_server_time;
    }

    public int getStu_apply_salary() {
        return stu_apply_salary;
    }

    public void setStu_apply_salary(Integer stu_apply_salary) {
        this.stu_apply_salary = stu_apply_salary;
    }

    public Long getStu_account_id() {
        return stu_account_id;
    }

    public void setStu_account_id(Long stu_account_id) {
        this.stu_account_id = stu_account_id;
    }
}
