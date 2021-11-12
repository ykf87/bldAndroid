package com.jiankang.gouqi.entity;

import java.io.Serializable;

public class LoginEntity extends BaseEntity implements Serializable {
	/**
	 *
	 */
	private static final long serialVersionUID = 5326887028741272698L;
	/**
	 * 动态密码(只有动态验证码登录才返回)
	 */
	public String dynamic_password;

	public String true_name;
	//用户头像url字段
	public String avatar;

	//是否需要协议弹窗
	public int is_need_pop;

	//0登录，1注册
	public int is_register;

	public String phone_num;


	/**
	 * id : 1
	 * avatar :
	 * phone : 136****1794
	 * nickname : 吴系挂
	 * level : 普通用户
	 * reg_time : 1436864169
	 * last_login_time : 0
	 * jinbi : 0
	 * token : sddkfjoroefdkj
	 */

	private String id;
	private String phone;
	private String nickname;
	private String level;
	private String reg_time;
	private String last_login_time;
	private int jinbi;
	private String token;
	public BankEntity bank;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
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

	public int getJinbi() {
		return jinbi;
	}

	public void setJinbi(int jinbi) {
		this.jinbi = jinbi;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	class BankEntity{
		public int id;
		public String name;
		public String phone;
		public String inumberd;
		public String bankname;
	}
}
