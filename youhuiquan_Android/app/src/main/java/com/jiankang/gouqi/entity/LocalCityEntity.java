package com.jiankang.gouqi.entity;

import java.util.List;


public class LocalCityEntity {


    private int errCode;
    private String errMsg;
    private ContentCityBean content;

    public static class ContentCityBean {

        private List<DevCityBean> cities;

        public List<DevCityBean> getCities() {
            return cities;
        }

        public void setCities(List<DevCityBean> cities) {
            this.cities = cities;
        }

        public static class DevCityBean {
            /**
             * "hot_cities":0,//是否是热门城市
             * "id":211,//城市id
             * "jianpin":"fz",//城市简拼
             * "name":"福州",//城市名称
             * "pinyin_first_letter":"f",//城市名称拼音首字母
             * "spelling":"fuzhou"//城市名称拼音
             */

            private int hot_cities;
            private String id;
            private String name;
            private String pinyin_first_letter;
            private String spelling;
            private String jianpin;

            public int getHot_cities() {
                return hot_cities;
            }

            public void setHot_cities(int hot_cities) {
                this.hot_cities = hot_cities;
            }

            public String getId() {
                return id;
            }

            public void setId(String id) {
                this.id = id;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public String getPinyin_first_letter() {
                return pinyin_first_letter;
            }

            public void setPinyin_first_letter(String pinyin_first_letter) {
                this.pinyin_first_letter = pinyin_first_letter;
            }

            public String getSpelling() {
                return spelling;
            }

            public void setSpelling(String spelling) {
                this.spelling = spelling;
            }

            public String getJianpin() {
                return jianpin;
            }

            public void setJianpin(String jianpin) {
                this.jianpin = jianpin;
            }
        }


    }

    public int getErrCode() {
        return errCode;
    }

    public void setErrCode(int errCode) {
        this.errCode = errCode;
    }

    public String getErrMsg() {
        return errMsg;
    }

    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }

    public ContentCityBean getContent() {
        return content;
    }

    public void setContent(ContentCityBean content) {
        this.content = content;
    }
}
