package com.blandal.app.util;

import com.google.gson.Gson;

import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Type;

/**
 * 
 * 版权所有 (c)2014, 福州窝蛋网络科技有限公司
 * <p>
 * 文件名称 ：
 * <p>
 * 内容摘要 ：
 * <p>
 * 作者 ：郑志翔
 * <p>
 * 创建时间 ：2014-8-13 15：17
 * <p>
 * 当前版本号：v3.0
 * <p>
 * 历史记录 :
 * <p>
 * 日期 :
 * <p>
 * 修改人：
 * <p>
 * 描述 :使用Google的Gson实现对象和json字符串之间的转换
 */

public final class JsonUtils {

	private static Gson gson = new Gson();

	private JsonUtils() {
	}

	/**
	 * 对象转换成json字符串
	 * 
	 * @param obj
	 * @return
	 */
	public static String toJson(Object obj) {
		if (obj == null) {
			return "";
		}
		return gson.toJson(obj);
	}

	/**
	 * json字符串转成对象
	 * 
	 * @param str
	 * @param type
	 * @return
	 */
	public static <T> T fromJson(String str, Type type) {

		return gson.fromJson(str, type);
	}

	/**
	 * json字符串转成对象
	 * 
	 * @param str
	 * @param type
	 * @return
	 */
	public static <T> T fromJson(String str, Class<T> type) {

		return gson.fromJson(str, type);
	}

	/**
	 * 获取json串
	 * @param jsonObject
	 * @param key
	 * @return
	 */
	public static String getString(JSONObject jsonObject, String key) {
		try {
			return jsonObject.has(key) ? jsonObject.getString(key) : "";
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * gJsonByString
	 * 
	 * @param key
	 * @param content
	 * @return
	 */
	public static String gJsonByString(String key, String content) {
		if (StringUtils.isNullOrEmpty(key)
				|| StringUtils.isNullOrEmpty(content)) {
			return "";
		}
		String rVal = "";
		JSONObject json;
		try {
			json = new JSONObject(content);
			if (json.isNull(key)) {
				return rVal;
			}
			return json.getString(key);
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * gJsonByString
	 * 
	 * @param key
	 * @param json
	 * @return
	 */
	public static String gJsonByString(String key, JSONObject json) {
		if (StringUtils.isNullOrEmpty(key) || json == null || json.isNull(key)) {
			return "";
		}
		try {
			return json.getString(key);
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * gJsonByInt
	 * 
	 * @param key
	 * @param content
	 * @return
	 */
	public static int gJsonByInt(String key, String content) {
		if (StringUtils.isNullOrEmpty(key)
				|| StringUtils.isNullOrEmpty(content)) {
			return 0;
		}
		int rVal = 0;
		JSONObject json;
		try {
			json = new JSONObject(content);
			if (json.isNull(key)) {
				return rVal;
			}
			return json.getInt(key);
		} catch (Exception e) {
			return rVal;
		}
	}

	/**
	 * gJsonByInt
	 * 
	 * @param key
	 * @param json
	 * @return
	 */
	public static int gJsonByInt(String key, JSONObject json) {
		if (StringUtils.isNullOrEmpty(key) || json == null || json.isNull(key)) {
			return 0;
		}
		try {
			return json.getInt(key);
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * gJsonByLong
	 * 
	 * @param key
	 * @param content
	 * @return
	 */
	public static long gJsonByLong(String key, String content) {
		if (StringUtils.isNullOrEmpty(key)
				|| StringUtils.isNullOrEmpty(content)) {
			return 0;
		}
		int rVal = 0;
		JSONObject json;
		try {
			json = new JSONObject(content);
			if (json.isNull(key)) {
				return rVal;
			}
			return json.getLong(key);
		} catch (Exception e) {
			return rVal;
		}
	}

	/**
	 * gJsonByLong
	 * 
	 * @param key
	 * @param json
	 * @return
	 */
	public static long gJsonByLong(String key, JSONObject json) {
		if (StringUtils.isNullOrEmpty(key) || json == null || json.isNull(key)) {
			return 0;
		}
		try {
			return json.getLong(key);
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * 把数据添加到json里面去
	 * 
	 * @param key
	 * @param content
	 * @return
	 */
	public static String addDataToJson(String key, String content,
                                       String jsonStr) {
		if (StringUtils.isNullOrEmpty(key)
				|| StringUtils.isNullOrEmpty(content)) {
			return "";
		}
		try {
			JSONObject json;
			if (StringUtils.isNullOrEmpty(jsonStr)) {
				json = new JSONObject();
			} else {
				json = new JSONObject(jsonStr);
			}
			if (json.isNull(key) == false)
				json.remove(key);
			json.put(key, content);
			return json.toString();
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * 把数据添加到json里面去
	 * 
	 * @param key
	 * @param content
	 * @return
	 */
	public static String addDataToJson(String key, String content,
                                       JSONObject json) {
		if (StringUtils.isNullOrEmpty(key)
				|| StringUtils.isNullOrEmpty(content)) {
			return "";
		}
		try {
			if (json.isNull(key) == false) {
				json.remove(key);
			}
			json.put(key, content);
			return json.toString();
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * String to JSONObject
	 * 
	 * @param jsonStr
	 * @return
	 */
	public static JSONObject strToJsonObj(String jsonStr) {
		if (StringUtils.isNullOrEmpty(jsonStr)) {
			return new JSONObject();
		}
		try {
			JSONObject json = new JSONObject(jsonStr);
			return json;
		} catch (Exception e) {
			return new JSONObject();
		}
	}

	/**
	 * 添加分页参数
	 * 
	 * @param mainParam
	 * @param pagNum
	 * @param pageSize
	 * @param timestamp
	 * @throws JSONException
	 */
	public static void addQueryParam(JSONObject mainParam, int pagNum,
                                     int pageSize, long timestamp) throws JSONException {
		JSONObject query_param = new JSONObject();
		if (timestamp > 0) {
			query_param.put("timestamp", timestamp);
		}
		query_param.put("page_size", pageSize);
		query_param.put("page_num", pagNum);
		mainParam.put("query_param", query_param);
	}
}
