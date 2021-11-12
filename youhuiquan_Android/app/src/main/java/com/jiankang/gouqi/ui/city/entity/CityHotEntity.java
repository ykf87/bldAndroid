package com.jiankang.gouqi.ui.city.entity;

import java.io.Serializable;

import com.jiankang.gouqi.entity.BaseEntity;


/**
 * 热门城市
 * @author: ljx
 * @createDate: 2020/5/19 15:28
 */
public class CityHotEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 4350322343269943815L;
    private int cityId;
    private String cityName;

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }
}
