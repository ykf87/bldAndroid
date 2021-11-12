package com.jiankang.gouqi.util.lifephotosbrowse;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;

import androidx.viewpager.widget.ViewPager;

import com.jiankang.gouqi.base.BaseActivity;


/**
 * Hacky fix for Issue #4 and
 * http://code.google.com/p/android/issues/detail?id=18990
 * 
 * ScaleGestureDetector seems to mess up the touch events, which means that
 * ViewGroups which make use of onInterceptTouchEvent throw a lot of
 * IllegalArgumentException: pointerIndex out of range.
 * 
 * There's not much I can do in my code for now, but we can mask the result by
 * just catching the problem and ignoring it.
 * 
 * @author Chris Banes
 */
public class HackyViewPager extends ViewPager {

	BaseActivity baseActivity;

	public HackyViewPager(Context context) {
		super(context);
	}

	public HackyViewPager(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	/**
	 * 设置父类
	 * 
	 * @param pBaseActivity
	 */
	public void setBaseActivity(BaseActivity pBaseActivity) {
		baseActivity = pBaseActivity;
	}

	@Override
	public boolean dispatchTouchEvent(MotionEvent ev) {
		if (baseActivity != null) {
			if (ev.getAction() == MotionEvent.ACTION_DOWN) {
				baseActivity.setEnableGesture(false);
			} else if (ev.getAction() == MotionEvent.ACTION_CANCEL
					|| ev.getAction() == MotionEvent.ACTION_UP) {
				baseActivity.setEnableGesture(true);
			}
		}
		return super.dispatchTouchEvent(ev);
	}

	@Override
	public boolean onInterceptTouchEvent(MotionEvent ev) {
		try {
			return super.onInterceptTouchEvent(ev);
		} catch (IllegalArgumentException e) {
			return false;
		}
	}

}
