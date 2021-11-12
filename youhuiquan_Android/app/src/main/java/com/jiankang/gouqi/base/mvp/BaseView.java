package com.jiankang.gouqi.base.mvp;

import autodispose2.AutoDisposeConverter;

/**
 * BaseView
 *
 * @author: ljx
 * @createDate: 2020/6/8 11:25
 */
public interface BaseView {

    /**
     * 绑定Android生命周期 防止RxJava内存泄漏
     *
     * @param <T>
     * @return
     */
    <T> AutoDisposeConverter<T> bindAutoDispose();

}
