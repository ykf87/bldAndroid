package com.blandal.app.ui.login.entity;

import java.io.Serializable;

import com.blandal.app.entity.BaseEntity;


public class LoginCheckDetailEntity extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1179045251775705600L;

	public int trueName;
	public int sex;
	public int birthday;
	public int cityId;
	public int startWorkTime;
	public int education;

	//type==2
	public int expectJobStatus,
			expectJobType,
			jobClassifyId,
			addressAreaId,
			expectSalaryMin,
			expectSalaryMax,
			expectWorkTimeType,
			expectWorkTimeStart,
			expectWorkTimeEnd;
	public Integer jobType;

	public int workExperienceInList;//工作经历列表
}
