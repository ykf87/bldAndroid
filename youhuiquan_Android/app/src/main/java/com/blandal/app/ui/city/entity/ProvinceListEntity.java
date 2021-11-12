package com.blandal.app.ui.city.entity;

import java.io.Serializable;
import java.util.List;

import com.blandal.app.entity.BaseEntity;


/**
 * 省市区数据
 * @author: ljx
 * @createDate: 2020/5/19 15:28
 */
public class ProvinceListEntity extends BaseEntity implements Serializable {

	private static final long serialVersionUID = -659304208668236745L;

	public List<ProvinceEntity> provinces;
	public List<CityHotEntity> hotCitys;


}
