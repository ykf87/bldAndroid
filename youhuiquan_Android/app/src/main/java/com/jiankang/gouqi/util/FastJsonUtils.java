package com.jiankang.gouqi.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

/**
 * FastJson工具类
 */
public class FastJsonUtils {


    private static final SerializeConfig config;

    static {
        config = new SerializeConfig();
//        config.put(java.util.Date.class, new JSONLibDataFormatSerializer()); // 使用和json-lib兼容的日期输出格式
//        config.put(java.sql.Date.class, new JSONLibDataFormatSerializer()); // 使用和json-lib兼容的日期输出格式
    }

    private static final SerializerFeature[] features = {SerializerFeature.WriteMapNullValue, // 输出空置字段
            SerializerFeature.WriteNullListAsEmpty, // list字段如果为null，输出为[]，而不是null
            SerializerFeature.WriteNullNumberAsZero, // 数值字段如果为null，输出为0，而不是null
            SerializerFeature.WriteNullBooleanAsFalse, // Boolean字段如果为null，输出为false，而不是null
            SerializerFeature.WriteNullStringAsEmpty // 字符类型字段如果为null，输出为""，而不是null
    };

    /**
     * 转成json字符串:有规范的转
     *
     * @param object
     * @return
     */
    public static String convertObjectToJSON(Object object) {
        if (object instanceof Map) {
            Map<String, Object> queryObject = (Map<String, Object>) object;
            return collectToString(queryObject);
        }
        return JSON.toJSONString(object, config, features);
    }

    /**
     * 转成json字符串：无规范，如list为空时结果为null
     *
     * @param object
     * @return
     */
    public static String toJSONNoFeatures(Object object) {
        return JSON.toJSONString(object, config);
    }

    /**
     * 转成单个Object
     *
     * @param text
     * @return
     */
    public static Object toBean(String text) {
        return JSON.parse(text);
    }

    /**
     * 解析具体某个对象
     *
     * @param text
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T toBean(String text, Class<T> clazz) {
        return JSON.parseObject(text, clazz);
    }


    /**
     * 解析具体某个对象
     *
     * @param text
     * @param type
     * @param <T>
     * @return
     */
    public static <T> T toBean(String text, Type type) {
        return JSON.parseObject(text, type);
    }


    /**
     * 解析具体某个对象
     *
     * @param text
     * @param typeReference
     * @param <T>
     * @return
     */
    public static <T> T toBean(String text, TypeReference<T> typeReference) {
        return JSON.parseObject(text, typeReference);
    }

    /**
     * 转换为数组
     *
     * @param text
     * @return
     */
    public static <T> Object[] toArray(String text) {
        return toArray(text, null);
    }

    /**
     * 转换为数组
     *
     * @param text
     * @param clazz
     * @return
     */
    public static <T> Object[] toArray(String text, Class<T> clazz) {
        return JSON.parseArray(text, clazz).toArray();
    }

    /**
     * 转换为List
     *
     * @param text
     * @param clazz
     * @return
     */
    public static <T> List<T> toList(String text, Class<T> clazz) {
        return JSON.parseArray(text, clazz);
    }

    /**
     * 转换为List
     *
     * @param text
     * @param type
     * @return
     */
    public static List<Object> toList(String text, Type[] type) {
        return JSON.parseArray(text, type);
    }


    /**
     * 将string转化为序列化的json字符串
     *
     * @return
     */
    public static Object textToJson(String text) {
        Object objectJson = JSON.parse(text);
        return objectJson;
    }

    /**
     * json字符串转化为map
     *
     * @param s
     * @return
     */
    public static <K, V> Map<K, V> stringToCollect(String s) {
        Map<K, V> m = (Map<K, V>) JSONObject.parseObject(s);
        return m;
    }

    /**
     * 转换JSON字符串为对象
     *
     * @param jsonData
     * @param clazz
     * @return
     */
    public static Object convertJsonToObject(String jsonData, Class<?> clazz) {
        return JSONObject.parseObject(jsonData, clazz);
    }

    /**
     * 转换JSON字符串为对象
     *
     * @param jsonData
     * @param type
     * @return
     */
    public static Object convertJsonToObject(String jsonData, Type type) {
        return JSONObject.parseObject(jsonData, type);
    }

    /**
     * 将map转化为string
     *
     * @param m
     * @return
     */
    public static <K, V> String collectToString(Map<K, V> m) {
        String s = JSONObject.toJSONString(m);
        return s;
    }
}
