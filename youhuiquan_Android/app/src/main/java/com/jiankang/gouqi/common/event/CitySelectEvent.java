package com.jiankang.gouqi.common.event;

/**
 * 城市选择后事件
 *
 * @author: ljx
 * @createDate: 2020/7/17 18:01
 */
public class CitySelectEvent {
    private int mCityId;
    private String mCityName;

    public CitySelectEvent(int cityId, String cityName) {
        mCityId = cityId;
        mCityName = cityName;
    }

    public int getCityId() {
        return mCityId;
    }

    public String getCityName() {
        return mCityName;
    }
}
