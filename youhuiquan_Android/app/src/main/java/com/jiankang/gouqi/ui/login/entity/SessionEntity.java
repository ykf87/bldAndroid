package com.jiankang.gouqi.ui.login.entity;

import java.io.Serializable;
import java.util.List;

import com.jiankang.gouqi.entity.BaseEntity;


public class SessionEntity extends BaseEntity implements Serializable {

	private static final long serialVersionUID = -7686486715039119493L;
	private String challenge;
	private String pub_key_exp;
	private String pub_key_modulus;
	private String sessionId;
	private String userToken;
	private long expire_time;

	public long getExpire_time() {
		return expire_time;
	}

	public void setExpire_time(long expire_time) {
		this.expire_time = expire_time;
	}

	public List<ThridPartyAccountEntity> getThridPartyAccountList() {
		return thridPartyAccountList;
	}

	public void setThridPartyAccountList(
			List<ThridPartyAccountEntity> thridPartyAccountList) {
		this.thridPartyAccountList = thridPartyAccountList;
	}

	public String getUserToken() {
		return userToken;
	}

	public void setUserToken(String userToken) {
		this.userToken = userToken;
	}

	public List<ThridPartyAccountEntity> thridPartyAccountList;

	public String getChallenge() {
		return challenge;
	}

	public void setChallenge(String challenge) {
		this.challenge = challenge;
	}

	public String getPub_key_exp() {
		return pub_key_exp;
	}

	public void setPub_key_exp(String pub_key_exp) {
		this.pub_key_exp = pub_key_exp;
	}

	public String getPub_key_modulus() {
		return pub_key_modulus;
	}

	public void setPub_key_modulus(String pub_key_modulus) {
		this.pub_key_modulus = pub_key_modulus;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
}
