package com.jiankang.gouqi.common.enums;

/**
 * 弹窗样式
 */
public enum ConfirmEnum {

	None(-1, ""), defaultEnum(1, "默认样式"), hope(2, "希望用户点击");

	private int code;
	private String desc;

	private ConfirmEnum(int code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	/**
	 * 判断值是否合法
	 * 
	 * @Description:
	 * @param code
	 * @return
	 */
	public static boolean isValid(Integer code) {
		for (ConfirmEnum type : values()) {
			if (type.code == code) {
				return true;
			}
		}
		return false;
	}

	/**
	 * valueOf
	 * 
	 * @Description:
	 * @param code
	 * @return
	 */
	public static ConfirmEnum valueOf(Integer code) {
		if (code == null) {
			return None;
		}
		for (ConfirmEnum type : values()) {
			if (type.code == code) {
				return type;
			}
		}

		// 默认样式
		return ConfirmEnum.defaultEnum;
	}
}
