package com.blandal.app.ui.city.entity;

import java.io.Serializable;
import java.util.List;

import com.blandal.app.entity.BaseEntity;
import com.blandal.app.entity.LocationInfoCitiesEntity;

public class CityListEntity extends BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1202042717255699870L;
	public String md5_hash;
	public List<LocationInfoCitiesEntity> cities;
}
