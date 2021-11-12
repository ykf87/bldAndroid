package com.blandal.app.ui.login.entity;

import java.io.Serializable;

import com.blandal.app.entity.BaseEntity;


public class WeiXinEntity extends BaseEntity implements Serializable {
	private static final long serialVersionUID = -7163863435020737698L;
	public String access_token;
	public long expires_in;
	public String refresh_token;
	public String openid;
}
