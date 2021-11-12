/*
 * Copyright 2017 JessYan
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.blandal.app.base.mvp;

import autodispose2.AutoDisposeConverter;

/**
 * 每个 View 都需要实现此类, 以满足规范
 *
 * @author: ljx
 * @createDate: 2020/6/8 15:45
 */
public interface IView {

    /**
     * 绑定Android生命周期 防止RxJava内存泄漏
     *
     * @param <T>
     * @return
     */
    <T> AutoDisposeConverter<T> bindAutoDispose();

    void closeLoadDialog();

    void showLoadDialog();

    void showLoadDialog(final String txtContent);

    void showMsg(final String txtContent);

}
