package com.blandal.app.service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.google.gson.JsonSyntaxException;

import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * GSON 辅助类
 * 
 * @author ChenJun
 * @time 2014年1月2日 15:19:37
 * @param <T>
 */
public class GsonHelper<T> {

	/**
	 * 将对象转换为 JSON
	 * 
	 * @param src
	 * @param typeOfSrc
	 * @return
	 */
	public String toJson(Object src, Type typeOfSrc) {

		// 实例化GSON
		GsonBuilder gsonb = new GsonBuilder();

		// 日期类型适配器
		DateTypeAdapter dateTypeAdapter = new DateTypeAdapter();

		// 注册日期类型适配器
		gsonb.registerTypeAdapter(Date.class, dateTypeAdapter);

		Gson gson = gsonb.create();

		return gson.toJson(src, typeOfSrc);
	}

	/**
	 * 将JSON转换成 T
	 * 
	 * @param json
	 * @return
	 */
	public T fromJsonToEntity(String json, Class<T> clazz) {

		// 实例化GSON
		GsonBuilder gsonb = new GsonBuilder();

		// 日期类型适配器
		DateTypeAdapter dateTypeAdapter = new DateTypeAdapter();

		// 注册日期类型适配器
		gsonb.registerTypeAdapter(Date.class, dateTypeAdapter);

		Gson gson = gsonb.create();

		// 转换操作
		try {
			return gson.fromJson(json, clazz);
		} catch (JsonSyntaxException e) {
			//DisplayUtil.outLog("数据异常：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 将JSON转换成 T
	 * 
	 * @param json
	 * @return
	 */
	public T fromJsonToEntity(String json, Type type) {

		// 实例化GSON
		GsonBuilder gsonb = new GsonBuilder();

		// 日期类型适配器
		DateTypeAdapter dateTypeAdapter = new DateTypeAdapter();

		// 注册日期类型适配器
		gsonb.registerTypeAdapter(Date.class, dateTypeAdapter);

		Gson gson = gsonb.create();

		// 转换操作
		return gson.fromJson(json, type);
	}

	/**
	 * 将JSON转换成List<T>
	 * 
	 * @param json
	 * @return
	 */
	public List<T> fromJsonToList(String json, Type type) {

		// 实例化GSON
		GsonBuilder gsonb = new GsonBuilder();

		// 日期类型适配器
		DateTypeAdapter dateTypeAdapter = new DateTypeAdapter();

		// 注册日期类型适配器
		gsonb.registerTypeAdapter(Date.class, dateTypeAdapter);

		Gson gson = gsonb.create();

		// 转换操作
		return gson.fromJson(json, type);
	}

	/**
	 * 日期类型适配器 使用GSON反序列化时对日期的操作需要用到这个适配器
	 * 
	 * @author ChenJun
	 * @time 2011-07-07 15:25:27
	 */
	private static class DateTypeAdapter implements JsonSerializer<Date>,
			JsonDeserializer<Date> {

		private final DateFormat dateFormat;

		private DateTypeAdapter() {
			dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",
					Locale.CHINA);
			dateFormat.setTimeZone(TimeZone.getTimeZone("GMT+8"));
		}

		@Override
		public synchronized JsonElement serialize(Date date, Type type,
				JsonSerializationContext jsonSerializationContext) {
			return new JsonPrimitive(dateFormat.format(date));
		}

		@Override
		public Date deserialize(JsonElement json, Type typeOfT,
				JsonDeserializationContext context) throws JsonParseException {
			String JSONDateToMilliseconds = "\\/(Date\\((.*?)(\\+.*)?\\))\\/";
			Pattern pattern = Pattern.compile(JSONDateToMilliseconds);
			Matcher matcher = pattern.matcher(json.getAsJsonPrimitive()
					.getAsString());
			String result = matcher.replaceAll("$2");
			return new Date(Long.valueOf(result));
		}
	}
}