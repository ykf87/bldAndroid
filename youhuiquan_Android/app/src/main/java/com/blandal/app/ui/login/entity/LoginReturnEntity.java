package com.blandal.app.ui.login.entity;

import java.io.Serializable;

import com.blandal.app.entity.BaseEntity;


public class LoginReturnEntity extends BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7412353620438615887L;
	public int oauth_id;
	public boolean isSucc;
	public String error;
	public int id;
}
