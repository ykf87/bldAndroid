package com.blandal.app.ui.my.entity;

import java.io.Serializable;

/**
 * @author: ljx
 * @createDate: 2020/11/19  15:36
 */
public  class QueryParamBean implements Serializable {
    /**
     * page_num : 1
     * page_size : 10
     * timestamp : 1605770833479
     */

    private int page_num;
    private int page_size;
    private long timestamp;

    public int getPage_num() {
        return page_num;
    }

    public void setPage_num(int page_num) {
        this.page_num = page_num;
    }

    public int getPage_size() {
        return page_size;
    }

    public void setPage_size(int page_size) {
        this.page_size = page_size;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }
}
