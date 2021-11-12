package com.jiankang.gouqi.util.lifephotosbrowse;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Canvas;
import android.util.AttributeSet;

import com.luck.picture.lib.photoview.PhotoView;


/**
 * 重写ImageView，避免引用已回收的bitmap异常
 * 
 * @author chengzhangwei
 * 
 */
@SuppressLint("NewApi")
public class MyPhotoView extends PhotoView {

	public MyPhotoView(Context context) {
		super(context);
	}

	public MyPhotoView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	@Override
	protected void onDraw(Canvas canvas) {
		try {
			super.onDraw(canvas);
		} catch (Exception e) {
			System.out
					.println("MyImageView  -> onDraw() Canvas: trying to use a recycled bitmap");
		}
	}
}
