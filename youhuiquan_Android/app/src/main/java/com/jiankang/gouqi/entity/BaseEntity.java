package com.jiankang.gouqi.entity;

import java.io.Serializable;

public class BaseEntity implements Serializable {

	private static final long serialVersionUID = -3069880467676035022L;

	/**
	 * 初始化错误信息
	 * 
	 * @param pErrCode
	 * @param pErrDesc
	 */
	public void init(int pErrCode, String pErrDesc, String pReqJson) {
		setAppErrCode(pErrCode);
		setAppErrDesc(pErrDesc);
		setAppReqJson(pReqJson);
	}

	/**
	 * 错误code
	 */
	private int appErrCode;

	/**
	 * 错误描述
	 */
	private String appErrDesc;

	/**
	 * 获取到的请求数据
	 */
	private String appReqJson;

	/**
	 * 获取app请求json数据
	 */
	public String getAppReqJson() {
		return appReqJson;
	}

	/**
	 * 设置app请求json数据
	 */
	public void setAppReqJson(String appReqJson) {
		this.appReqJson = appReqJson;
	}

	/**
	 * 获取错误code
	 * 
	 * @return
	 */
	public int getAppErrCode() {
		return appErrCode;
	}

	/**
	 * 设置错误code
	 * 
	 * @return
	 */
	public void setAppErrCode(int appErrCode) {
		this.appErrCode = appErrCode;
	}

	/**
	 * 获取错误描述
	 * 
	 * @return
	 */
	public String getAppErrDesc() {
		if (appErrDesc == null) {
			return "未知错误";
		}
		return appErrDesc;
	}

	/**
	 * 设置错误描述
	 * 
	 * @param appErrDesc
	 */
	public void setAppErrDesc(String appErrDesc) {
		this.appErrDesc = appErrDesc;
	}

	/**
	 * 是否请求成功
	 * 
	 * true:成功 false:失败
	 */
	public boolean isSucc() {
		if (appErrCode == 0) {
			return true;
		}
		return false;
	}
}
