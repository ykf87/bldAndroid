package com.blandal.app.common;

import android.os.Handler;
import android.os.Looper;

import java.util.ArrayList;
import java.util.List;

public class MyHandler extends Handler {

	private Object obj = new Object();

	private List<Runnable> runns;

	public MyHandler() {
		super(Looper.getMainLooper());
	}

	/**
	 * 页面是否被销毁
	 */
	public boolean isDestroy = false;

	/**
	 * 设置页面被销毁
	 */
	public void setDestroy() {

		this.isDestroy = true;

		// 销毁时候，把待处理的任务全部清除掉
		if (runns != null) {
			for (Runnable r : runns) {
				removeCallbacks(r);
			}
		}
	}

	/**
	 * 加入主线程运行
	 * 
	 * @param run
	 * @return
	 */
	public boolean mPost(Runnable run) {
		// 页面被销毁的情况下，返回false
		if (isDestroy) {
			return false;
		}

		return super.post(run);
	}

	/**
	 * 加入主线程运行
	 * 
	 * @param runr
	 * @return
	 */
	public void mPostDelayed(Runnable runr, long delayMillis) {
		synchronized (obj) {
			if (runns == null) {
				runns = new ArrayList<Runnable>();
			}
			// 页面被销毁的情况下，返回false
			if (isDestroy) {
				return;
			}
			runns.add(runr);
			super.postDelayed(runr, delayMillis);
		}
	}
}
