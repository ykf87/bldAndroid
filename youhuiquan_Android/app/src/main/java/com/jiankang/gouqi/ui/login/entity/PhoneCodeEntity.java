package com.jiankang.gouqi.ui.login.entity;

import java.io.Serializable;

import com.jiankang.gouqi.entity.BaseEntity;


public class PhoneCodeEntity extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9082662601180249186L;
	private String sms_authentication_code;

	public String getSms_authentication_code() {
		return sms_authentication_code;
	}

	public void setSms_authentication_code(String sms_authentication_code) {
		this.sms_authentication_code = sms_authentication_code;
	}
}
