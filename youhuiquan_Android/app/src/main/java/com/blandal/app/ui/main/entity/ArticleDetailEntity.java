package com.blandal.app.ui.main.entity;

/**
 * @author: ljx
 * @createDate: 2021/7/21  10:06
 */
public class ArticleDetailEntity {


    /**
     * id : 1
     * cate : 1
     * cover : http image url
     * title : 吴系挂
     * key : main
     * content : sdffwekrwlk
     * viewed : 100
     * is_heart : false
     * hearted : 10
     * created_at : 0
     */

    private int id;
    private int cate;
    private String cover;
    private String title;
    private String key;
    private String content;
    private int viewed;
    private boolean is_heart;
    private int hearted;
    private long created_at;

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getViewed() {
        return viewed;
    }

    public void setViewed(int viewed) {
        this.viewed = viewed;
    }

    public boolean isIs_heart() {
        return is_heart;
    }

    public void setIs_heart(boolean is_heart) {
        this.is_heart = is_heart;
    }

    public int getHearted() {
        return hearted;
    }

    public void setHearted(int hearted) {
        this.hearted = hearted;
    }

    public long getCreated_at() {
        return created_at;
    }

    public void setCreated_at(long created_at) {
        this.created_at = created_at;
    }
}
