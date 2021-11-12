package com.blandal.app.service;

import com.alibaba.fastjson.TypeReference;

import com.blandal.app.util.FastJsonUtils;

/**
 * 服务器返回结果
 *
 * @author: ljx
 * @createDate: 2020/6/12 10:29
 */
public class ApiResponse<T> {
    /**
     * 错误代码200表示成功，其它不成功
     */
    public final static int ERR_CODE_SUCC = 200;
    /**
     * 错误代码401表示token不存在或已超时
     */
    public final static int ERR_CODE_TOKEN = 401;
    public final static int ERR_ILLEGAL_SEQ_VALUE = 7;
    public final static int ERR_NO_EXISTS_USER = 8;
    /**
     * 错误代码-15表示未登录或登录已过期
     */
    public final static int ERR_CODE_LOGIN = 15;
    /**
     * 错误代码-59 验证码间隔小于60s
     */
    public final static int ERR_CODE_FAIL = 59;

    /**
     * 错误码
     */
    private int code;
    /**
     * 错误信息
     */
    private String msg;

    private T data;

    private String dataJson;

    public String getDataJson() {
        return dataJson;
    }

    public void setDataJson(String dataJson) {
        this.dataJson = dataJson;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        if (data == null && dataJson != null) {
            return FastJsonUtils.toBean(dataJson, new TypeReference<T>() {
            }.getType());
        }
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public boolean isSuccess(){
        return this.code == ERR_CODE_SUCC;
    }
}
