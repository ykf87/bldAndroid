package com.blandal.app.ui.my.entity;

import com.blandal.app.ui.login.entity.LoginEntity;

public class CenterEntity {

    /**
     * user : {"id":"1","email":"12154545","nickname":"吴系挂","groupid":2,"reg_time":"1436864169","last_login_time":"0","jinbi":0}
     * nav : []
     */

    /**
     * id : 1
     * email : 12154545
     * nickname : 吴系挂
     * groupid : 2
     * reg_time : 1436864169
     * last_login_time : 0
     * jinbi : 0
     */

    private String id;
    private String email;
    private String nickname;
    private int groupid;
    private String reg_time;
    private String last_login_time;
    private int jifen;
    private LoginEntity.BankEntity bank;
    public String phone;

    public LoginEntity.BankEntity getBank() {
        return bank;
    }
    public void setBank(LoginEntity.BankEntity bank) {
        this.bank = bank;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getGroupid() {
        return groupid;
    }

    public void setGroupid(int groupid) {
        this.groupid = groupid;
    }

    public String getReg_time() {
        return reg_time;
    }

    public void setReg_time(String reg_time) {
        this.reg_time = reg_time;
    }

    public String getLast_login_time() {
        return last_login_time;
    }

    public void setLast_login_time(String last_login_time) {
        this.last_login_time = last_login_time;
    }

    public int getJifen() {
        return jifen;
    }

    public void setJifen(int jifen) {
        this.jifen = jifen;
    }

}


