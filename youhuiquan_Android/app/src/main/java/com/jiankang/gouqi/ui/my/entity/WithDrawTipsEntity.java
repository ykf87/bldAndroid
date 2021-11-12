package com.jiankang.gouqi.ui.my.entity;

import java.io.Serializable;

/**
 * @author: ljx
 * @createDate: 2020/12/3  16:19
 */
public class WithDrawTipsEntity implements Serializable {


    /**
     * single_withdaw_min : 1
     * alipay_bind_status : 0银行卡绑定状态 0未绑定 1已绑定
     * total_amount : 0
     * alipay_withdraw_hours : 24提现到账小时数
     * cur_month_withdraw_money : 0
     * "alipay_account": "15727207027",// 绑定后下发
     * "alipay_user_name": "xxxx",// 绑定后下发
     * desc : 提现须知：
     1.银行卡单次最低提现金额1元;请务必核实银行卡账号与该账号所属人真实姓名信息；
     2.银行卡提现实时到账，最晚不超过24小时；若24小时内未到账，请及时联系客服4001689788；
     3.钱袋子每日提现限额3000元，每月提现限额10000元。
     * cur_day_withdraw_money : 0
     */

    private int single_withdaw_min;
    private int alipay_bind_status;
    private int total_amount;
    private int alipay_withdraw_hours;
    private int cur_month_withdraw_money;
    private String alipay_account;
    private String alipay_user_name;
    private String desc;
    private int cur_day_withdraw_money;

    public int getSingle_withdaw_min() {
        return single_withdaw_min;
    }

    public void setSingle_withdaw_min(int single_withdaw_min) {
        this.single_withdaw_min = single_withdaw_min;
    }

    public int getAlipay_bind_status() {
        return alipay_bind_status;
    }

    public void setAlipay_bind_status(int alipay_bind_status) {
        this.alipay_bind_status = alipay_bind_status;
    }

    public String getAlipay_user_name() {
        return alipay_user_name;
    }

    public void setAlipay_user_name(String alipay_user_name) {
        this.alipay_user_name = alipay_user_name;
    }

    public String getAlipay_account() {
        return alipay_account;
    }

    public void setAlipay_account(String alipay_account) {
        this.alipay_account = alipay_account;
    }

    public int getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(int total_amount) {
        this.total_amount = total_amount;
    }

    public int getAlipay_withdraw_hours() {
        return alipay_withdraw_hours;
    }

    public void setAlipay_withdraw_hours(int alipay_withdraw_hours) {
        this.alipay_withdraw_hours = alipay_withdraw_hours;
    }

    public int getCur_month_withdraw_money() {
        return cur_month_withdraw_money;
    }

    public void setCur_month_withdraw_money(int cur_month_withdraw_money) {
        this.cur_month_withdraw_money = cur_month_withdraw_money;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getCur_day_withdraw_money() {
        return cur_day_withdraw_money;
    }

    public void setCur_day_withdraw_money(int cur_day_withdraw_money) {
        this.cur_day_withdraw_money = cur_day_withdraw_money;
    }
}
