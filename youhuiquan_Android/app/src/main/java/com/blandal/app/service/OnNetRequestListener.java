package com.blandal.app.service;

/**
 * 网络请求回调接口
 *
 * @author: ljx
 * @createDate: 2020/6/9 13:34
 */
public interface OnNetRequestListener<T> {

    /**
     * 请求成功
     *
     * @param response 返回的数据实体类信息 泛型定义 ApiResponse<T>
     */
    void onSuccess(T response);

    /**
     * 请求失败
     *
     * @param t 异常
     */
    void onFailure(Throwable t);
}
