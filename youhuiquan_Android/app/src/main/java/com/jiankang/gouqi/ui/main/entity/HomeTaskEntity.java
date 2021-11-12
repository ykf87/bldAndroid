package com.jiankang.gouqi.ui.main.entity;

import java.io.Serializable;
import java.util.List;

/**
 * 首页任务item
 */

public class HomeTaskEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * apply_status : 0
     * city_ids :
     * city_names : 全国
     * cur_server_time : 1.605842968826E12
     * device_limit : 3
     * icon_classify : 0
     * icon_classify_str : 普通
     * show_fresh_icon : 1
     * show_hot_icon : 0
     * show_status : 1
     * task_classify_id : 9
     * task_classify_img_url : http://wodan-idc.oss-cn-hangzhou.aliyuncs.com/test/Upload/shijianke-mgr/zhaiTaskClassify/2016-02-18/5fe06417aaf14d89937e9852c62a8439.png
     * task_classify_name : 推广
     * task_dead_time : 1.6061472E12
     * task_fee : 70
     * task_has_apply_valid_num : 0
     * task_id : 738
     * task_left_can_apply_count : 30
     * task_num : 30
     * task_publish_time : 1.605582177E12
     * task_salary : 70
     * task_status : 3
     * task_submit_check_success_rate : 100
     * task_submit_checkfail_count : 0
     * task_submit_count : 0
     * task_submit_published_count : 0
     * task_title : vree16
     * task_user_picture : []
     * task_user_picture_json : []
     * task_user_text : [{"task_text_desc":"手机号","task_text_content":"123456","textType":1}]
     * task_user_text_json : [{"task_text_content":"123456","task_text_desc":"手机号","textType":1}]
     * task_uuid : 877c1043-33f9-4d73-a621-a90af9d9bd85
     * weight : 0
     */

    /**
     * id : 1
     * cate : 1
     * cover : http image url
     * title : 吴系挂
     * key : main
     * viewed : 100
     * hearted : 10
     * created_at : 0
     */

    private int id;
    private int cate;
    private String cover;
    private String title;
    private String key;
    private int viewed;
    private int hearted;
    private String created_at;


    private int apply_status;//1:去提交
    private String city_ids;
    private String city_names;
    private long cur_server_time;
    private int device_limit;
    private int icon_classify;
    private String icon_classify_str;
    private int show_fresh_icon;
    private int show_hot_icon;
    private int show_status;
    private int task_apply_id;
    private int task_classify_id;
    private String task_classify_img_url;
    private String task_classify_name;
    private long task_dead_time;
    private double task_fee;
    private int task_has_apply_valid_num;
    private int task_id;
    private int task_left_can_apply_count;
    private int task_num;
    private double task_publish_time;
    private int task_salary;
    private int task_status;
    private int task_submit_check_success_rate;
    private int task_submit_checkfail_count;
    private int task_submit_count;
    private int task_submit_published_count;
    private long task_close_time;//任务关闭时间
    private String task_title;
    private String task_user_picture;
    private String task_user_text;
    private String task_uuid;
    private int weight;
    private List<?> task_user_picture_json;
    private List<TaskUserTextJsonEntity> task_user_text_json;
    private long stu_submit_left_time;//剩余时间  task_submit_dead_time-cur_server_time
    private long task_submit_dead_time;//提交截止时间  task_submit_dead_time-cur_server_time
    public boolean isReadTask;


    public int getTask_apply_id() {
        return task_apply_id;
    }


    public long getStu_submit_left_time() {
        return stu_submit_left_time;
    }

    public void setStu_submit_left_time(long stu_submit_left_time) {
        this.stu_submit_left_time = stu_submit_left_time;
    }

    public long getTask_close_time() {
        return task_close_time;
    }

    public double getTask_fee() {
        return task_fee;
    }

    public int getTask_id() {
        return task_id;
    }

    public String getTask_title() {
        return task_title;
    }



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCate() {
        return cate;
    }

    public void setCate(int cate) {
        this.cate = cate;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public int getViewed() {
        return viewed;
    }

    public void setViewed(int viewed) {
        this.viewed = viewed;
    }

    public int getHearted() {
        return hearted;
    }

    public void setHearted(int hearted) {
        this.hearted = hearted;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public static class TaskUserTextJsonEntity {
        /**
         * task_text_content : 123456
         * task_text_desc : 手机号
         * textType : 1
         */

        private String task_text_content;
        private String task_text_desc;
        private int textType;

        public String getTask_text_content() {
            return task_text_content;
        }

        public void setTask_text_content(String task_text_content) {
            this.task_text_content = task_text_content;
        }

        public String getTask_text_desc() {
            return task_text_desc;
        }

        public void setTask_text_desc(String task_text_desc) {
            this.task_text_desc = task_text_desc;
        }

        public int getTextType() {
            return textType;
        }

        public void setTextType(int textType) {
            this.textType = textType;
        }
    }
}
