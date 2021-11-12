package com.jiankang.gouqi.ui.login.entity;

import java.io.Serializable;

import com.jiankang.gouqi.entity.BaseEntity;


public class LoginCheckEntity extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1179045251775705600L;

	public int result;//【1不弹窗；0进行弹窗】
	//启动APP补充信息：必填项缺失类型  0：校验通过（result返回true时） 1：基础信息  2：求职意向    3：工作经历
	//在岗位列表中：  0  全部检查通过后返回数据；  1求职状态必填项不完整返回数据 ；  2 求职类型必填项不完整返回数据；
	//报名成功后弹窗：:0  无意义 全部检查通过后返回数据；  1工作经历必填项不完整返回数据 ；  2 求职意向必填项不完整返回数据
	public int type;
	public LoginCheckDetailEntity fields;
}
