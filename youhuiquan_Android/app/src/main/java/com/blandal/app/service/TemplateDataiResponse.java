package com.blandal.app.service;

/**
 * 服务器返回
 *
 * @author: ljx
 * @createDate: 2020/7/29 14:33
 */
public class TemplateDataiResponse {
    public static final int SUCCESS = 200;
    private int code;
    private String message;
    private TemplateDataListEntity data;

    /**
     * 判断是否成功
     *
     * @return
     */
    public boolean isSuccess() {
        return SUCCESS == code;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public TemplateDataListEntity getData() {
        return data;
    }

    public void setData(TemplateDataListEntity data) {
        this.data = data;
    }

    public static int getSUCCESS() {
        return SUCCESS;
    }
}
