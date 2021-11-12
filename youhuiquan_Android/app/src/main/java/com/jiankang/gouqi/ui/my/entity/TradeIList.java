package com.jiankang.gouqi.ui.my.entity;

import java.io.Serializable;
import java.util.List;

import com.jiankang.gouqi.entity.QueryParamEntity;


/**
 * 钱袋子流水，招聘余额实体类
 * 
 * @author Administrator
 * 
 */
public class TradeIList  implements Serializable {

	private static final long serialVersionUID = 276417145339778448L;

	/**
	 * 账户余额
	 */
	public int acct_amount;

	/**
	 * 招聘余额
	 */
	public int recruitment_amount;

	/**
	 * 账户招聘冻结款余额
	 */
	public int recruitment_frozen_amount;

	/**
	 * 是否设置过钱袋子密码
	 * 0 未设置密码
	 */
	public int has_set_bag_pwd;

	public List<TradeDetailEntity> detail_list;
	public QueryParamEntity query_param;
	/**
	 * 预付款
	 */
	public int advance_amount;


	public int added;//几分
	public long created_at;
	public int id;



}
