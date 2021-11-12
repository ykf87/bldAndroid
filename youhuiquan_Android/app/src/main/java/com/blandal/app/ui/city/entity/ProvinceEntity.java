package com.blandal.app.ui.city.entity;

import java.io.Serializable;
import java.util.List;

/**
 * 省份
 * @author: ljx
 * @createDate: 2020/5/19 15:29
 */
public class ProvinceEntity implements Serializable {

	private static final long serialVersionUID = -659304208668236745L;

	public String provinceName;
	public List<CityEntity> cities;

}
