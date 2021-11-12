package com.blandal.app.ui.city.entity;

import java.io.Serializable;

import com.blandal.app.entity.BaseEntity;

public class CityInfoCitiesEntity extends BaseEntity implements
        Serializable {

	private static final long serialVersionUID = 1L;

	public int id;
	public String pinyinFirstLetter;
	public String areaCode;
	public int status;
	public int hotCities;
	public String jianPin;
	public String spelling;
	public String name;

	/**
	 * 是否为开启抢单的城市，1表示开启，0表示不开启
	 */
	public int isGrabSingle;
	/**
	 * <int>,是否开启委托招聘，1 表示开启，0 表示不开启
	 */
	public int enableRecruitmentService;

	/**
	 * <int>,是否开启人脉王，1 表示开启，0 表示不开启
	 */
	public int socialActivistPortal;

	/**
	 * 城市关联客户经理QQ
	 */
	public String contactQQ;


	/**
	 * 服务商服务 0：关闭 1：开启
	 */
	public int enableTeamService;

	/**
	 * 个人服务 0：关闭 1：开启
	 */
	public int enablePersonalService;
	
	/**
     *  vip服务  0：关闭 1：开启  
     */
    public int enableVipService;
    /**
     * vip直通车服务  0：关闭 1：开启
     */
    public int enableThroughService;
    /**
     * 城市级别   1：一级城市 2：二级城市
     */
    public int level;
}
