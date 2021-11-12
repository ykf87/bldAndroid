package com.blandal.app.util;

import android.app.Activity;
import android.app.Application;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

public class ExitApplication extends Application {

	private List<Activity> list = new ArrayList<Activity>();

	private static ExitApplication ea;

	public static ExitApplication getInstance() {
		if (null == ea) {
			ea = new ExitApplication();
		}
		return ea;
	}

	public void addActivity(Activity activity) {
		list.add(activity);
	}

	public void removeActivity(Activity activity){
		if (list.contains(activity)){
			list.remove(activity);
		}
	}

	/**
	 * 结束到指定 Activity
	 *
	 * @param clz           Activity 类
	 * @param isIncludeSelf 是否结束该 activity 自己
	 * @param isLoadAnim    是否启动动画
	 */
	public boolean finishToActivity(@NonNull final Class<?> clz,
										   final boolean isIncludeSelf,
										   final boolean isLoadAnim) {
		List<Activity> activities = list;
		for (int i = activities.size() - 1; i >= 0; --i) {
			Activity aActivity = activities.get(i);
			if (aActivity.getClass().equals(clz)) {
				if (isIncludeSelf) {
					finishActivity(aActivity, isLoadAnim);
				}
				return true;
			}
			finishActivity(aActivity, isLoadAnim);
		}
		return false;
	}

	/**
	 * 结束 Activity
	 *
	 * @param activity   activity
	 * @param isLoadAnim 是否启动动画
	 */
	public void finishActivity(@NonNull final Activity activity, final boolean isLoadAnim) {
		activity.finish();
		if (!isLoadAnim) {
			activity.overridePendingTransition(0, 0);
		}
	}

	public boolean containActivity(Class<?> cls){
		try {
			for (Activity activity:list) {
				if (activity.getClass().equals(cls)) {
					return true;
				}
			}
			return false;
		}catch (Exception e){
			return false;
		}
	}

	public void exit() {
		if (list == null || list.size() < 1) {
			return;
		}
		for (Activity activity : list) {
			activity.finish();
		}
		System.exit(0);
	}

	public void exit2() {
		if (list == null || list.size() < 1) {
			return;
		}
		for (Activity activity : list) {
			activity.finish();
		}
	}
}
