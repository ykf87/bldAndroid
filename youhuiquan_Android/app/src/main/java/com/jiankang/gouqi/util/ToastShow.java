package com.jiankang.gouqi.util;

import android.content.Context;
import android.os.Handler;
import android.widget.Toast;

import com.jiankang.gouqi.app.MyApplication;


/**
 * 提示信息
 * 
 */
public class ToastShow {

	private static Toast mToast;

	// private static ToastDialog mToastDialog;
	// private static TimeCount mTime;

	public static void showMsg(String text) {
		showToast(MyApplication.getContext(), text);
	}

	public static void showMsg(Context context, String text) {
		showToast(context, text);
	}

	public static void showMsg(final Context context, final String text,
                               Handler handler) {
		handler.post(new Runnable() {

			@Override
			public void run() {
				showToast(context, text);
			}
		});
	}

	public static void showLongMsg(Context context, String text) {
		showLongToast(context, text);
	}

	public static void showLongMsg(final Context context, final String text,
                                   Handler handler) {
		handler.post(new Runnable() {
			@Override
			public void run() {
				showLongToast(context, text);
			}
		});
	}

	public static void showLongToast(Context context, String text) {
		if (context == null) {
			return;
		}
		if (mToast != null){
			mToast.cancel();
		}
		mToast = Toast.makeText(context.getApplicationContext(),text, Toast.LENGTH_LONG);
		mToast.show();

		// mToastDialog=new ToastDialog(context);
		// mTime = new TimeCount(5000, 1000,mToastDialog);
		// mToastDialog.setToastContent(text);
		// mTime.start();//开始计时
	}

	public static void showToast(Context context, String text) {
		if (context == null) {
			return;
		}
		if (mToast != null){
			mToast.cancel();
		}
		mToast = Toast.makeText(context.getApplicationContext(),text, Toast.LENGTH_SHORT);
		mToast.show();

		// mToastDialog=new ToastDialog(context);
		// //e.g. x.new A()
		// mTime = new TimeCount(3000, 1000,mToastDialog);
		// mToastDialog.setToastContent(text);
		// mTime.start();//开始计时
	}

}
