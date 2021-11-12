package com.jiankang.gouqi.common.enums;

/**
 * None(-1, ""), JianzhiLogin(1, "自平台登录"), OtherLogin(2, "其他的三方登录");
 */
public enum LoginTypeEnum {

	None(-1, ""), JianzhiLogin(1, "自平台登录"), OtherLogin(2, "其他的三方登录");
	private int code;
	private String desc;

	private LoginTypeEnum(int code, String desc) {
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
		for (LoginTypeEnum type : values()) {
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
	public static LoginTypeEnum valueOf(Integer code) {
		if (code == null) {
			return None;
		}
		for (LoginTypeEnum type : values()) {
			if (type.code == code) {
				return type;
			}
		}

		return LoginTypeEnum.None;
	}
}
