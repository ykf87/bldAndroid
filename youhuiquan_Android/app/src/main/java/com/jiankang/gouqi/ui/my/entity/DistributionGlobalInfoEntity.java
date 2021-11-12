package com.jiankang.gouqi.ui.my.entity;

import java.io.Serializable;

/**
 * @author: ljx
 * 获取分销首页全局信息
 * @createDate: 2020/12/4  13:53
 */
public class DistributionGlobalInfoEntity implements Serializable {

    /**
     * un_activate_reward : 0.0
     * total_reward : 0.0
     * billboard_img_url :
     * total_team_count : 0.0
     * activity_status : 0.0
     * is_login : 0.0
     * activated_count : 0.0
     */

    private double un_activate_reward;
    private double total_reward;
    private String billboard_img_url;
    private double total_team_count;
    private int activity_status;
    private double is_login;
    private double activated_count;

    public double getUn_activate_reward() {
        return un_activate_reward;
    }

    public void setUn_activate_reward(double un_activate_reward) {
        this.un_activate_reward = un_activate_reward;
    }

    public double getTotal_reward() {
        return total_reward;
    }

    public void setTotal_reward(double total_reward) {
        this.total_reward = total_reward;
    }

    public String getBillboard_img_url() {
        return billboard_img_url;
    }

    public void setBillboard_img_url(String billboard_img_url) {
        this.billboard_img_url = billboard_img_url;
    }

    public double getTotal_team_count() {
        return total_team_count;
    }

    public void setTotal_team_count(double total_team_count) {
        this.total_team_count = total_team_count;
    }

    public int getActivity_status() {
        return activity_status;
    }

    public void setActivity_status(int activity_status) {
        this.activity_status = activity_status;
    }

    public double getIs_login() {
        return is_login;
    }

    public void setIs_login(double is_login) {
        this.is_login = is_login;
    }

    public double getActivated_count() {
        return activated_count;
    }

    public void setActivated_count(double activated_count) {
        this.activated_count = activated_count;
    }
}
