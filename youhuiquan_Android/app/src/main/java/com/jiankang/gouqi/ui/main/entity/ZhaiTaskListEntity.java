package com.jiankang.gouqi.ui.main.entity;

import java.io.Serializable;
import java.util.List;

import com.jiankang.gouqi.ui.my.entity.QueryParamBean;

/**
 * @author: ljx
 * 首页列表
 * @createDate: 2020/11/17  14:54
 */
public class ZhaiTaskListEntity implements Serializable {

    /**
     * id : 1
     * cate : 1
     * cover : http image url
     * title : 吴系挂
     * key : main
     * viewed : 100
     * hearted : 10
     * created_at : 0
     */

    private int id;
    private int cate;
    private String cover;
    private String title;
    private String key;
    private int viewed;
    private int hearted;
    private String created_at;
    public boolean isCsjAd;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCate() {
        return cate;
    }

    public void setCate(int cate) {
        this.cate = cate;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public int getViewed() {
        return viewed;
    }

    public void setViewed(int viewed) {
        this.viewed = viewed;
    }

    public int getHearted() {
        return hearted;
    }

    public void setHearted(int hearted) {
        this.hearted = hearted;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }


    public int zhai_task_count;
    public List<HomeTaskEntity> zhai_task_list;
    public QueryParamBean query_param;
    public int getZhai_task_count() {
        return zhai_task_count;
    }

    public void setZhai_task_count(int zhai_task_count) {
        this.zhai_task_count = zhai_task_count;
    }

    public List<HomeTaskEntity> getZhai_task_list() {
        return zhai_task_list;
    }

    public void setZhai_task_list(List<HomeTaskEntity> zhai_task_list) {
        this.zhai_task_list = zhai_task_list;
    }

    public QueryParamBean getQuery_param() {
        return query_param;
    }

    public void setQuery_param(QueryParamBean query_param) {
        this.query_param = query_param;
    }
}
