package com.jiankang.gouqi.ui.my.entity;

import java.io.Serializable;
import java.util.List;

import com.jiankang.gouqi.entity.BaseEntity;


public class ResumeInfoV200 extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 3253637217553498634L;

    public long resume_id;// 简历id
    public String true_name;// 姓名
    /**
     * 用户联系方式
     */
    public String telphone;
    /**
     * 用户账号
     */
    public String account_telphone;
    public int weight;// 体重kg
    public String user_profile_url;// 头像
    public String profile_url;// 头像
    public String lat;// 纬度
    public String lng;// 经度
    public String obode;// 常居住地址
    public int id_card_verify_status;// 实名认证状态: 1：未认证，2：认证中，3：已认证
    public int height;// 身高
    public Integer sex;// 枚举，具体定义请参考数据字典
    public int address_area_id;// 所在区域的id
    public int school_id;// 学校id
    public int city_id; // 城市ID, 整形数字类型.
    public int view_count; // 浏览次数 , 整形数字类型
    public String address_area_name;// 区域名称
    public String city_name;// 城市名称
    public String school_name;// 学校名称
    public int work_experice_count;// 履历统计值,<整形数字>即工作过的所有职位数.
    public int working_experience_small_red_point; // 工作经验红点
    public int evalu_byent_count; // 被雇主评价数统计“byent_level_sum” ; // 评价星级总和
    public int evalu_byent_level_avg;// 评价星级平均值
    public int my_apply_job_big_red_point; // 我的报名红点数
    public int break_promise_count; // 放鸽子数
    public int break_promise_small_red_point; // 放鸽子的红点
    // 以下 2015-04-10 添加的属性
    public int account_im_open_status;// 账户IM开通状态, 0 未开通 , 1 已开通 .
    // 2015-05-29 添加属性
    public int bind_wechat_status; // 是否绑定了微信 0：未绑定 1：已绑定
    public int left_apply_job_quota; // 是否有剩余投递职位的次数
    public int ent_evalu_status;// 企业评价状态 1:已评价 0:未评价,
    public int salary_num; // 需要支付的工资，shijianke_entQueryApplyJobList这个接口调用，并且list_type为5时，才下发这个字段，
    public long apply_job_id;// 申请职位id
    public int trade_loop_finish_type; // 交易闭环结束原因
    public long ent_default_refused_time; // 企业默认拒绝时间
    public long ent_default_refused_time_left; // 企业默认拒绝时间的毫秒数
    public int trade_loop_ent_evalu_level; // 交易闭环当前记录的雇主评价星级
    public int ent_evalu_level; // 交易闭环当前记录的雇主评价星级
    public String trade_loop_ent_evalu_content; // 交易闭环当前记录的雇主评价内容
    public int ent_big_red_point_status;// 雇主是否显示大红点
    public long ent_read_resume_time;// 企业阅读简历时间
    public int trade_loop_status;// 交易闭环状态
    public String id_card_no;// 身份证号
    public String account_id;
    public long stu_apply_resume_time;
    public int is_tick_off;
    // 用户未到职位原因： 1双方沟通一致 2 放鸽子'
    public int stu_absent_type;
    // 上岗时间时间戳数组（秒数）
    public List<Long> stu_work_time;
    // 1：多选时间 2：起始时间
    public int stu_work_time_type;
    public int is_can_evaluate;
    // 是否第一次抢单 0:不是 1;是
    public int is_first_grab_single;
    // <int>账户余额 单位分
    public int acct_amount;
    // <int>预付款余额
    public int advance_amount;
    // <int>保证金 单位分
    public int bond;
    // <int> 企业支付工资次数
    public int ent_pay_salary_num;
    // 评价内容
    public String ent_evalu_content;

    // 银行卡帐号
    public String alipay_user_name;

    // 银行卡帐号姓名
    public String alipay_user_true_name;

    // 出生日期
    public String birthday;
    public String birthmonth;

    public int social_activist_status;// <int>人脉王状态，请参考数据字典
    public String stu_id_card_no;// <String>学生证号
    public String stu_id_card_url;// <String>学生证链接
    public String health_cer_no;// <String>健康证号
    public String health_cer_url;// <String>健康链接

    // app内使用，非服务端下发,合并后的上岗时间
    public String my_stu_work_time_str;

    // 精确职位日到岗状态 0：未到岗 1：到岗2：未处理
    public int on_board_status;

    // //精确职位日未到岗原因 1：沟通一致 2：放鸽子
    public int day_stu_absent_type;


    /**
     * 首字母
     */
    public String name_first_letter;

    public String email;

    /**
     * 完工天数
     */
    public int social_activist_complete_day_count;
    /**
     * 赏金
     */
    public int social_activist_reward;
    /**
     * 是否绑定微信公众号
     */
    public int bind_wechat_public_num_status;
    /**
     * 用户确认上岗时间戳 毫秒单位
     */
    public long stu_confirm_work_time;

    /**
     * 是否选中（客户端字段）
     */
    public boolean isSel;

    /**
     * 内部字段，客户端发放薪水（单位分）
     */
    public int client_grant_salary;

    /**
     * 特定接口字段
     */
    public long stu_account_id;

    /**
     * 内部字段，表示是否前端自己加的数据
     */
    public boolean is_app_add_user;

    /**
     * 投递来源 1：平台报名 2：人员补录 3：人员推广
     */
    public int apply_job_source;

    /**
     * 是否申请个人服务
     */
    public int is_apply_service_personal;
    /**
     * 用户累计获得的任务薪资总额(财富值)，单位为分
     */
    public int task_salary_sum;
    /**
     * 用户申请中的任务数量
     */
    public int task_applying_count;

    /**
     * 是否订阅意向职位  1：是  0：否
     */
    public int is_subscribe_job;

    /**
     * 兼职通告-我的通告小红点 0 无  ，1+ 有
     */
    public int registration_service_personal_red_point;

    /**
     * 简历完整度
     */
    @Deprecated
    public String complete;

    /**
     * 简历完整度
     */
    public String complete_full_time;

    /**
     * 学历类型：1大专2本科3硕士4博士5其他
     */
    public Integer education;
    public String education_str;
    /**
     * 专业
     */
    public String profession;

    /**
     * 特长
     */
    public String specialty;

    /**
     * 学生类型，枚举，具体定义请参考数据字典
     */
    public Integer user_type;

    /**
     * 完工数
     */
    public int complete_work_num;
    /**
     * 简历是否公开：1是 0否
     */
    public int is_public;

    /**
     * 最近登录时间描述
     */
    public String last_login_time_str;
    /**
     * 意向职位分类描述
     */
    public String subscribe_job_classify_str;
    /**
     * 意向区域描述
     */
    public String subscribe_address_area_str;

    /**
     * 工作经历列表
     */
    public List<ResumeExperienceInfo> resume_experience_list;

    public String desc;

    public Integer age;
    /**
     * 用户简历被查看次数
     */
    public int resume_view_num;

    public int stu_query_ent_view_count;//查看过用户的人数
    public int stu_collect_job_count;//用户职位收藏数
    public int stu_focus_ent_count;//用户关注雇主数
    public int integral_balance; //积分

    public SubscribeJobInfo subscribe_job_info;


    public class SubscribeJobInfo extends BaseEntity implements Serializable {

        /**
         * 意向城市id (Subscribe_address_area_arr为空数值时会下发该字段)
         */
        public String subscribe_city_id;
        /**
         * 意向城市name
         */
        public String subscribe_city_name;
    }

    public class ResumeExperienceInfo extends BaseEntity implements Serializable {

        /**
         * 工作经历id
         */
        public long resume_experience_id;
        /**
         * 职位分类id
         */
        public long job_classify_id;
        /**
         * 职位分类名称
         */
        public String job_classify_name;

        /**
         * 职位名称
         */
        public String job_title;
        /**
         * 职位开始时间，时间戳
         */
        public long job_begin_time;
        /**
         * 职位结束时间，时间戳
         */
        public long job_end_time;
        /**
         * 工作内容
         */
        public String job_content;

        public String salary;

        //公司名称
        public String corp_name;

        public String job_begin_year_month;

        public String job_end_year_month;
    }

    public String wechat_number;
    public String start_work_time;
    public String start_work_time_new;//字段包含有应届生，年以前的
    public String province_name;

    public Integer expect_job_status;

    // 求职类型(1兼职,2全职,3在线工作,-1全部都可以)
    public int expect_job_type;
    //期望月薪最小值
    public int expect_salary_min;
    public int expect_salary_max;  //期望月薪最大值
    public  int expect_work_time_type;  // 工作时间(-1不限 1周末 2工作日 3寒暑假 4节假日)
    public String expect_work_time_start;  //工作时段开始 00:00
    public String expect_work_time_end;  //工作时段结束  02:00

    //工龄
    public String work_year;

    //是否需要完善资料 1，需要
    public int is_need_improve;
}
