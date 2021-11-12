package com.blandal.app.ui.city.entity;

import com.chad.library.adapter.base.entity.JSectionEntity;

/**
 * 城市选择首拼组头
 *
 * @author: ljx
 * @createDate: 2020/7/6 8:59
 */
public class CitySectionEntity extends JSectionEntity {

    private boolean isHeader;
    private CityEntity cityEntity;

    public CitySectionEntity(boolean isHeader, CityEntity cityEntity) {
        this.isHeader = isHeader;
        this.cityEntity = cityEntity;
    }

    public CityEntity getCityEntity() {
        return cityEntity;
    }

    @Override
    public boolean isHeader() {
        return isHeader;
    }

}