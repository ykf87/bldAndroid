/**
 * 
 */
package com.jiankang.gouqi.util;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Build;
import android.os.Environment;
import android.os.StrictMode;
import android.provider.Settings.Secure;
import android.telephony.TelephonyManager;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 系统工具类
 * 
 * @author Administrator
 * 
 */

/**
 * @author Administrator
 * 
 */
@SuppressLint("SimpleDateFormat")
public class SystemUtil {
	/**
	 * 
	 */
	public SystemUtil() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 每个Activiy创建的时候加载此方法
	 * 
	 * 
	 * 从Android 2.3开始提供了一个新的类StrictMode，可以帮助开发者改进他们的Android应用，
	 * StrictMode可以用于捕捉发生在应用程序主线程
	 * 中耗时的磁盘、网络访问或函数调用，可以帮助开发者使其改进程序，使主线程处理UI和动画在磁盘读写和网络操作时变得更平滑，
	 * 避免主线程被阻塞，导致ANR窗口的发生。
	 */
	@SuppressLint("NewApi")
	public static void isSDK() {
		try {
			if (hasGingerbread()) {
				StrictMode
						.setThreadPolicy(new StrictMode.ThreadPolicy.Builder()
								.detectDiskReads().detectDiskWrites()
								.detectNetwork().penaltyLog().build());
				StrictMode.setVmPolicy(new StrictMode.VmPolicy.Builder()
						.detectLeakedSqlLiteObjects()
						.detectLeakedClosableObjects().penaltyLog()
						.penaltyDeath().build());
			}
		} catch (Exception e) {
		}
	}

	/**
	 * 判断SDK版本是不是3.0以上
	 * 
	 * @return
	 */
	private static boolean hasGingerbread() {
		return Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB;
	}

	/**
	 * 判断有没有SDcard
	 * 
	 * @return true有，false没有
	 * 
	 */
	public static boolean isSDcard() {
		String state = Environment.getExternalStorageState();
		if (state.equals(Environment.MEDIA_MOUNTED)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 创建文件夹
	 */
	public static void mkFile(String fileDir) {
		File file = new File(fileDir);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	/**
	 * 创建文件
	 * 
	 * @param fileDir
	 *            文件夹路径
	 * @param fileName
	 *            文件名称
	 */
	public static void mkDocument(String fileDir, String fileName) {
		File file = new File(fileDir, fileName);
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {

			}
		}
	}

	/**
	 * 比较时间大小方法.
	 * 
	 * @param startTime
	 * @param endTime
	 * @return 返回两个时间相差分钟
	 */
	public static long timegap(String startTime, String endTime) {

		DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

		try {

			Date start = df.parse(startTime);
			Date end = df.parse(endTime);
			long diff = end.getTime() - start.getTime();// 求出相差毫秒
			long min = diff / (1000 * 60);// 求出相差分钟

			return min;

		} catch (Exception e) {
		}
		return 0;

	}

	/**
	 * System.out.println方法.用于打印信息. 发布时注释该方法的打印. 所以只有开发时打印信息使用该方法. 打印报错信息不使用该方法.
	 */
	public static void sysOut(String s) {
		System.out.println(s);
	}

	private static int mVersionCode = 0;

	/**
	 * 获取版本号
	 */
	public synchronized static int getVersion(Context context) {
		if (mVersionCode > 0) {
			return mVersionCode;
		}
		try {
			PackageInfo pi = context.getPackageManager().getPackageInfo(
					context.getPackageName(), 0);
			mVersionCode = pi.versionCode;
		} catch (NameNotFoundException e) {
			mVersionCode = 0;
		}
		return mVersionCode;
	}

	/**
	 * 获取版本号
	 */
	public static String getVersionNm(Context context) {
		try {
			PackageInfo pi = context.getPackageManager().getPackageInfo(
					context.getPackageName(), 0);
			return pi.versionName;
		} catch (NameNotFoundException e) {
			return "1.0.0";
		}
	}

	/**
	 * 获取操作系统名字
	 * 
	 * @return
	 */
	public static String getSysName() {
		String romType = Build.PRODUCT;
		return romType;
	}

	@SuppressWarnings("static-access")
	public static String GetDeviceName() {
		return new Build().MODEL;
	}

	/**
	 * 获取Imei 用android代替
	 * 
	 * @return
	 */
	public static String getAndroidId(Context mContext) {
		String android_id = "";
		try {
			android_id = Secure.getString(mContext.getContentResolver(),
					Secure.ANDROID_ID);
		} catch (Exception e) {
		}
		return android_id;
	}

	private static String IMEI = null;
	/**
	 * @param slotId  slotId为卡槽Id，它的值为 0、1；
	 * @return
	 */
	public static String getIMEI(Context context, int slotId) {
		if (IMEI != null) {
			return IMEI;
		}
		try {
			TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
			Method method = manager.getClass().getMethod("getImei", int.class);
			String imei = (String) method.invoke(manager, slotId);
			IMEI = imei;
			return imei;
		} catch (Exception e) {
			IMEI = "";
			return "";
		}
	}


	//获取安卓版本
	public static int getOSVersion(){
		return Build.VERSION.SDK_INT;
	}
	//手机品牌
	public static String getDeviceBrand(){
		return Build.BRAND;
	}
	//手机型号
	public static String getDeviceModel(){
		return Build.MODEL;
	}
}
