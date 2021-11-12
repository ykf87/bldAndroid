package com.jiankang.gouqi.ui.my.entity;


import java.io.Serializable;

public class TradeDetailEntity  implements Serializable {

	private static final long serialVersionUID = -3652917405195980840L;

	/**
	 * 账户id
	 */
	public long account_money_id;

	/**
	 * 流水记录id
	 */
	public long account_money_detail_list_id;
	/** 流水类型：1.充值 2提现 3发工资 4.付工资 5 抢单保证金 **/
	public int money_detail_type;
	/** <string>流水标题 **/
	public String money_detail_title;
	/** <long> 从1970年1月1日至今的秒数 **/
	public long create_time;
	public long update_time;
	/** <long>如果此明细与岗位有关，本字段不为空 **/
	public long job_id;
	/** <int>岗位类型，1为普通岗位，2为抢单岗位 **/
	public int job_type;
	/** <int>明细产生的金额，单位为分，不包含小数 **/
	public int actual_amount;
	/** <int>是否呈现小红点，1表示是，0表示否 **/
	public int small_red_point;
	/** <int>流水的聚合次数（仅对于企业为用户支付工资有效，数字表示支付次数） **/
	public int aggregation_number;
	/**
	 * 任务id
	 */
	public Long task_id;

	// 招聘余额相关。。。。
	/**
	 * 招聘余额流水标题
	 */
	public String virtual_money_detail_title;
	/**
	 * 招聘余额流水记录id
	 */
	public long detail_list_id;

	/**
	 * 招聘余额流水类型
	 */
	public int virtual_money_detail_type;

}
