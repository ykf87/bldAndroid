package com.jiankang.gouqi.util;

import android.util.Log;

import com.jiankang.gouqi.BuildConfig;

//Logcat统一管理类
public class LogUtils {
	public static boolean isOutLog = BuildConfig.DEBUG;
	private LogUtils() {
		/* cannot be instantiated */
		throw new UnsupportedOperationException("cannot be instantiated");
	}

	private static final String TAG = "test";
	private static final String DATA_TAG = "gqjk_data";
	private static final String TDLX = "tdlx";

	// 下面四个是默认tag的函数
	public static void i(String msg) {
		if (msg == null) {
			return;
		}
		if (isOutLog)
			Log.i(TAG, msg);
	}

	public static void d(String msg) {
		if (msg == null) {
			return;
		}
		if (isOutLog)
			Log.d(TAG, msg);
	}

	public static void e(String msg) {
		if (msg == null) {
			return;
		}
		if (isOutLog)
			Log.e(TAG, msg);
	}

	public static void v(String msg) {
		if (msg == null) {
			return;
		}
		if (isOutLog)
			Log.v(TAG, msg);
	}

	public static void test(String msg) {
		if (msg == null) {
			return;
		}
		if (isOutLog)
			Log.v(DATA_TAG, msg);
	}

	public static void data(String msg) {
		if (msg == null) {
			return;
		}
		if (isOutLog)
			Log.v(DATA_TAG, msg);
	}

	// 下面是传入自定义tag的函数
	public static void i(String tag, String msg) {
		if (tag == null || msg == null) {
			return;
		}
		if (isOutLog)
			Log.i(tag, msg);
	}

	public static void d(String tag, String msg) {
		if (tag == null || msg == null) {
			return;
		}
		if (isOutLog)
			Log.i(tag, msg);
	}

	public static void e(String tag, String msg) {
		if (tag == null || msg == null) {
			return;
		}
		if (isOutLog)
			Log.i(tag, msg);
	}

	public static void v(String tag, String msg) {
		if (tag == null || msg == null) {
			return;
		}
		if (isOutLog)
			Log.i(tag, msg);
	}

	public static void t(String msg) {
		if (isOutLog) {
			Log.e(TDLX, msg);
		}
	}
}