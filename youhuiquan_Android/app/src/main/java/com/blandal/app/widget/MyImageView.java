package com.blandal.app.widget;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Canvas;
import android.os.Build;
import android.util.AttributeSet;

/**
 * 重写ImageView，避免引用已回收的bitmap异常
 * 
 * @author chengzhangwei
 * 
 */
@SuppressLint("NewApi")
public class MyImageView extends androidx.appcompat.widget.AppCompatImageView {

	/**
	 * 是否重新刷新图片
	 */
	boolean mIsAfresh = false;

	/**
	 * 是否重新刷新图片
	 */
	public boolean isAfresh() {
		return mIsAfresh;
	}
	
	public MyImageView(Context context) {
		super(context);
	}

	public MyImageView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public void setgrayscale(float grayscale) {
		// 3.0版
		if (Build.VERSION.SDK_INT > Build.VERSION_CODES.HONEYCOMB) {
			super.setAlpha(grayscale);
		} else {
		}
	}

	@Override
	protected void onDraw(Canvas canvas) {
		try {
			super.onDraw(canvas);
			mIsAfresh = false;
		} catch (Exception e) {
			mIsAfresh = true;
			System.out
					.println("MyImageView  -> onDraw() Canvas: trying to use a recycled bitmap");
		}
	}
}
