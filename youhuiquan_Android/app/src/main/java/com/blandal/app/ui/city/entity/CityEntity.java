package com.blandal.app.ui.city.entity;

import android.text.TextUtils;

import java.io.Serializable;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.blandal.app.entity.BaseEntity;
import com.blandal.app.entity.CityChildAreaEntity;


public class CityEntity extends BaseEntity implements Serializable {
	public static final int ITEM_LOCATION_VIEW = 1;
	public static final int ITEM_HOT_VIEW = 2;
	public static final int ITEM_NORMAL_VIEW = 3;
	private final static Pattern section = Pattern.compile("[a-zA-Z]");
	/**
	 * 城市实体类
	 */
	private static final long serialVersionUID = -1507380206833962018L;
	public CityEntity(String pJianpin, int iId, String iPinyin_first_letter,
                      String iName, String iCityId, String pSpelling, boolean isSelect) {
		pinyin_first_letter = iPinyin_first_letter;
		name = iName;
		id = iId;
		cityId = iCityId;
		jianpin = pJianpin;
		spelling = pSpelling;
		this.mIsSelect = isSelect;
	}

	public CityEntity() {

	}

	public CityEntity(String name) {
		this.name = name;
	}

	public String jianpin;
	public String cityId;
	public String spelling;
	public int id;
	public String pinyin_first_letter;
	public String name;
	public List<CityChildAreaEntity> childArea;
	public boolean mIsSelect;

	public String getJianpin() {
		return jianpin;
	}

	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getSpelling() {
		return spelling;
	}

	public void setSpelling(String spelling) {
		this.spelling = spelling;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPinyin_first_letter() {
		return pinyin_first_letter;
	}

	public void setPinyin_first_letter(String pinyin_first_letter) {
		this.pinyin_first_letter = pinyin_first_letter;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<CityChildAreaEntity> getChildArea() {
		return childArea;
	}

	public void setChildArea(List<CityChildAreaEntity> childArea) {
		this.childArea = childArea;
	}

	public boolean isSelect() {
		return mIsSelect;
	}

	public void setIsSelect(boolean isSelect) {
		this.mIsSelect = isSelect;
	}

	/***
	 * 获取悬浮栏文本，（#、定位、热门 需要特殊处理）
	 * @return
	 */
	public String getSection(){
		if (TextUtils.isEmpty(pinyin_first_letter)) {
			return "#";
		} else {
			String c = pinyin_first_letter;
			Matcher m = section.matcher(c);
			if (m.matches()) {
				return c.toUpperCase();
			} else if (TextUtils.equals(c, "定") || TextUtils.equals(c, "热")) {
				//在添加定位和热门数据时设置的section就是‘定’、’热‘开头
				return pinyin_first_letter;
			} else {
				return "#";
			}
		}
	}
}