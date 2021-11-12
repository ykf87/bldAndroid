package com.jiankang.gouqi.ui.login.entity;

import java.io.Serializable;

import com.jiankang.gouqi.entity.BaseEntity;


public class ThridPartyAccountEntity extends BaseEntity implements Serializable {
	private static final long serialVersionUID = -6545018525471477103L;
	public String appID;
	public String getUserInfoURL;
	public int id;
	public String name;
	public String scope;
}
