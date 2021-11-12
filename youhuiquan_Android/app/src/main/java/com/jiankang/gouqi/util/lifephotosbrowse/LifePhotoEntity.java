package com.jiankang.gouqi.util.lifephotosbrowse;

import java.io.Serializable;

import com.jiankang.gouqi.entity.BaseEntity;


public class LifePhotoEntity extends BaseEntity implements Serializable {

	private static final long serialVersionUID = 4089415084665644514L;

	public LifePhotoEntity() {

	}

	public LifePhotoEntity(long id, String life_photo) {
		this.id = id;
		this.life_photo = life_photo;
	}

	public LifePhotoEntity(int pResId, boolean pIsAddBtn) {
		resId = pResId;
		IsAddBtn = pIsAddBtn;
	}

	private long id;// 生活照id

	private String life_photo;// 生活照url

	private int resId;

	// 客户端字段
	/**
	 * 是不是添加按钮（编辑页面）
	 */
	private boolean IsAddBtn;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getLife_photo() {
		return life_photo;
	}

	public void setLife_photo(String life_photo) {
		this.life_photo = life_photo;
	}

	public int getResId() {
		return resId;
	}

	public void setResId(int resId) {
		this.resId = resId;
	}

	public boolean isAddBtn() {
		return IsAddBtn;
	}

	public void setAddBtn(boolean addBtn) {
		IsAddBtn = addBtn;
	}
}
