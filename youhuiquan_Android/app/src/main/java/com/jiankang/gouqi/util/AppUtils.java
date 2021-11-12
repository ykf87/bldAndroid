package com.jiankang.gouqi.util;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.ActivityManager;
import android.content.ContentUris;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Environment;
import android.provider.DocumentsContract;
import android.provider.MediaStore;
import android.provider.Settings;
import android.view.View;
import android.view.ViewGroup;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import com.jiankang.gouqi.common.activity.UWebActivity;
import com.jiankang.gouqi.service.ApiService;
import com.jiankang.gouqi.interfaces.AppInterfaces;
import com.jiankang.gouqi.entity.ActivityCallbackInterfaceEntity;


//跟App相关的辅助类
@SuppressLint("WorldReadableFiles")
public class AppUtils {

    private AppUtils() {
        /* cannot be instantiated */
        throw new UnsupportedOperationException("cannot be instantiated");

    }

    /**
     * 页面需要执行的回调方法
     */
    private static List<ActivityCallbackInterfaceEntity> mActivityCallbackInterfaceEntity;

    /**
     * 设置页面回调触发的回调接口
     */
    public static void setActivityInterface(Context pContext, Class<?> callActivity,
                                            AppInterfaces.ActivityCallBackInterface pActivityCallBackInterface, boolean pIsManuallyCall) {
        synchronized (AppUtils.class) {
            if (pContext == null || callActivity == null
                    || pActivityCallBackInterface == null) {
                return;
            }
            if (mActivityCallbackInterfaceEntity == null) {
                mActivityCallbackInterfaceEntity = new ArrayList<>();
            }
            mActivityCallbackInterfaceEntity
                    .add(new ActivityCallbackInterfaceEntity(pContext,
                            callActivity, pActivityCallBackInterface,
                            pIsManuallyCall));
        }
    }

    /**
     * 触发页面回调,必须主线程执行
     */
    public static void callActivityInterface(Context pContext, boolean pIsManuallyCall, Object obj) {
        if (pContext == null || !DisplayUtil.isMainThread()) {
            return;
        }
        synchronized (AppUtils.class) {
            if (mActivityCallbackInterfaceEntity == null) {
                return;
            }
            String currClassName = pContext.getClass().getName();
            List<ActivityCallbackInterfaceEntity> delCallbackInterface = null;
            try {
                for (ActivityCallbackInterfaceEntity m : mActivityCallbackInterfaceEntity) {
                    if (!currClassName.equals(m.callActivityName)) {
                        continue;
                    }

                    // 触发场景不等于 设置的时候，直接回收
                    if (pIsManuallyCall && !m.isManuallyCall) {
                        continue;
                    }

                    if (delCallbackInterface == null) {
                        delCallbackInterface = new ArrayList<>();
                    }

                    delCallbackInterface.add(m);

                    if (!pIsManuallyCall && m.isManuallyCall) {
                        continue;
                    }

                    if (!(m.mContext instanceof Activity)) {
                        continue;
                    }
                    if (((Activity) m.mContext).isFinishing()) {
                        continue;
                    }
                    m.mActivityCallBackInterface.callback(obj);
                }

                if (delCallbackInterface != null) {
                    for (ActivityCallbackInterfaceEntity m : delCallbackInterface) {
                        mActivityCallbackInterfaceEntity.remove(m);
                    }
                    delCallbackInterface.clear();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * @param context
     * @param tel
     * @see拨打电话
     */
    public static void callPhone(Context context, String tel) {
        try {
            Intent intent = new Intent("android.intent.action.CALL",
                    Uri.parse("tel:" + tel));
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
        } catch (android.content.ActivityNotFoundException ane) {
        } catch (Exception e) {
        }
    }

    /**
     * @param mContext2
     * @param tel
     * @see跳转至拨打电话页面
     */
    public static void intentToCallPhone(Context mContext2, String tel) {
        try {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:"
                    + tel));
            mContext2.startActivity(intent);
        } catch (android.content.ActivityNotFoundException ane) {
        } catch (Exception e) {
        }
    }

    /**
     * @param context
     * @return 得到需要分配的缓存大小，这里用八分之一的大小来做
     * @description
     */
    public int getMemoryCacheSize(Context context) {
        try {
            // Get memory class of this device, exceeding this amount will throw
            // an
            // OutOfMemory exception.
            int memClass = ((ActivityManager) context
                    .getSystemService(Context.ACTIVITY_SERVICE))
                    .getMemoryClass();

            // Use 1/8th of the available memory for this memory cache.
            return 1024 * 1024 * memClass / 8;
        } catch (Exception ee) {
            return 5;
        }
    }

    /**
     * 退出当前app
     *
     * @param context
     */
    @SuppressWarnings({"static-access", "deprecation"})
    public static void exitApp(Context context) {
        int currentVersion = VERSION.SDK_INT;
        if (currentVersion > VERSION_CODES.ECLAIR_MR1) {
            Intent startMain = new Intent(Intent.ACTION_MAIN);
            startMain.addCategory(Intent.CATEGORY_HOME);
            startMain.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(startMain);
            System.exit(0);
        } else {// android2.1
            ActivityManager am = (ActivityManager) context
                    .getSystemService(context.ACTIVITY_SERVICE);
            am.restartPackage(context.getPackageName());
        }
    }

    /**
     * 原生的分享 获取手机内所有支持分享并且已经安装的程序分享文字内容给好友
     */
    public static void shareToFriend(Context context, String sendMsg,
                                     String Title) {
        Intent intent = new Intent(Intent.ACTION_SEND);
        // intent.setType("image/*");
        intent.setType("text/plain");
        intent.putExtra(Intent.EXTRA_TEXT, sendMsg);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        // intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
        context.startActivity(Intent.createChooser(intent, Title));
    }

    /**
     * 去应用市场评分
     */
    public static void scoreApp(Context context) {
        try {
            Uri uri = Uri.parse("market://details?id="
                    + context.getPackageName());
            Intent intentScore = new Intent(Intent.ACTION_VIEW, uri);
            intentScore.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intentScore);
        } catch (Exception e) {
            ToastShow.showMsg(context, "您尚未安装任何应用市场哦...请先下载安装");
        }
    }


    /**
     * 浏览器下载更新版本
     *
     * @param urlPath  下载更新版本地址
     * @param mContext
     */
    public static void updateInBrowse(String urlPath, Context mContext) {
        Intent intent = new Intent();
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.setAction("android.intent.action.VIEW");
        Uri content_url = Uri.parse(urlPath);
        intent.setData(content_url);
        mContext.startActivity(intent);
    }

    /**
     * 获取应用程序名称
     */
    public static String getAppName(Context context) {
        try {
            PackageManager packageManager = context.getPackageManager();
            PackageInfo packageInfo = packageManager.getPackageInfo(
                    context.getPackageName(), 0);
            int labelRes = packageInfo.applicationInfo.labelRes;
            return context.getResources().getString(labelRes);
        } catch (NameNotFoundException e) {
        }
        return null;
    }

    /**
     * 获取版本号
     */
    public static int getVersion(Context context) {
        try {
            PackageInfo pi = context.getPackageManager().getPackageInfo(
                    context.getPackageName(), 0);
            return pi.versionCode;
        } catch (NameNotFoundException e) {
            return 0;
        }
    }

    /**
     * [获取应用程序版本名称信息]
     *
     * @param context
     * @return 当前应用的版本名称
     */
    public static String getVersionName(Context context) {
        try {
            PackageManager packageManager = context.getPackageManager();
            PackageInfo packageInfo = packageManager.getPackageInfo(
                    context.getPackageName(), 0);
            return packageInfo.versionName;
        } catch (NameNotFoundException e) {
        }
        return "";
    }

    public static String mServerUrl;

    /**
     * 获取状态栏的高度
     *
     * @param context
     * @return
     */
    public static int getStatusBarHeight(Context context) {
        Class<?> c = null;
        Object obj = null;
        Field field = null;
        int x = 0, statusBarHeight = 0;
        try {
            c = Class.forName("com.android.internal.R$dimen");
            obj = c.newInstance();
            field = c.getField("status_bar_height");
            x = Integer.parseInt(field.get(obj).toString());
            statusBarHeight = context.getResources().getDimensionPixelSize(x);
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        return statusBarHeight;
    }

    /**
     * 获取标题元素
     *
     * @param pView
     * @return
     */
    public static View getTopView(View pView) {
//		List<View> views = getAllChildViews(pView);
//		for (View v : views) {
//			if (v instanceof LineTop || v instanceof LineTop2
//					|| "AppTopView".equals(v.getTag())) {
//				views.clear();
//				return v;
//			}
//		}
//		views.clear();
        return null;
    }

    /**
     * 获取某个view的所有子元素
     *
     * @param view
     * @return
     */
    public static List<View> getAllChildViews(View view) {
        List<View> allchildren = new ArrayList<View>();
        if (view instanceof ViewGroup) {
            ViewGroup vp = (ViewGroup) view;
            for (int i = 0; i < vp.getChildCount(); i++) {
                View viewchild = vp.getChildAt(i);
                allchildren.add(viewchild);
                allchildren.addAll(getAllChildViews(viewchild));
            }
        }
        return allchildren;
    }

    /**
     * 根据Uri获取图片绝对路径，解决Android4.4以上版本Uri转换
     *
     * @param context
     * @param imageUri
     * @author yaoxing
     * @date 2014-10-12
     */
    @TargetApi(19)
    public static String getImageAbsolutePath(Activity context, Uri imageUri) {
        if (context == null || imageUri == null)
            return null;
        if (VERSION.SDK_INT >= VERSION_CODES.KITKAT
                && DocumentsContract.isDocumentUri(context, imageUri)) {
            if (isExternalStorageDocument(imageUri)) {
                String docId = DocumentsContract.getDocumentId(imageUri);
                String[] split = docId.split(":");
                String type = split[0];
                if ("primary".equalsIgnoreCase(type)) {
                    return Environment.getExternalStorageDirectory() + "/"
                            + split[1];
                }
            } else if (isDownloadsDocument(imageUri)) {
                String id = DocumentsContract.getDocumentId(imageUri);
                Uri contentUri = ContentUris.withAppendedId(
                        Uri.parse("content://downloads/public_downloads"),
                        Long.valueOf(id));
                return getDataColumn(context, contentUri, null, null);
            } else if (isMediaDocument(imageUri)) {
                String docId = DocumentsContract.getDocumentId(imageUri);
                String[] split = docId.split(":");
                String type = split[0];
                Uri contentUri = null;
                if ("image".equals(type)) {
                    contentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
                } else if ("video".equals(type)) {
                    contentUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
                } else if ("audio".equals(type)) {
                    contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
                }
                String selection = MediaStore.Images.Media._ID + "=?";
                String[] selectionArgs = new String[]{split[1]};
                return getDataColumn(context, contentUri, selection,
                        selectionArgs);
            }
        } // MediaStore (and general)
        else if ("content".equalsIgnoreCase(imageUri.getScheme())) {
            // Return the remote address
            if (isGooglePhotosUri(imageUri))
                return imageUri.getLastPathSegment();
            return getDataColumn(context, imageUri, null, null);
        }
        // File
        else if ("file".equalsIgnoreCase(imageUri.getScheme())) {
            return imageUri.getPath();
        }
        return null;
    }

    public static String getDataColumn(Context context, Uri uri,
                                       String selection, String[] selectionArgs) {
        Cursor cursor = null;
        String column = MediaStore.Images.Media.DATA;
        String[] projection = {column};
        try {
            cursor = context.getContentResolver().query(uri, projection,
                    selection, selectionArgs, null);
            if (cursor != null && cursor.moveToFirst()) {
                int index = cursor.getColumnIndexOrThrow(column);
                return cursor.getString(index);
            }
        } finally {
            if (cursor != null)
                cursor.close();
        }
        return null;
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is ExternalStorageProvider.
     */
    public static boolean isExternalStorageDocument(Uri uri) {
        return "com.android.externalstorage.documents".equals(uri
                .getAuthority());
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is DownloadsProvider.
     */
    public static boolean isDownloadsDocument(Uri uri) {
        return "com.android.providers.downloads.documents".equals(uri
                .getAuthority());
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is MediaProvider.
     */
    public static boolean isMediaDocument(Uri uri) {
        return "com.android.providers.media.documents".equals(uri
                .getAuthority());
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is Google Photos.
     */
    public static boolean isGooglePhotosUri(Uri uri) {
        return "com.google.android.apps.photos.content".equals(uri
                .getAuthority());
    }

    public static void openNotificationSettings(AppCompatActivity activity) {
        if (VERSION.SDK_INT >= VERSION_CODES.P) {
            Intent intent = new Intent();
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.setAction("android.settings.APPLICATION_DETAILS_SETTINGS");
            intent.setData(Uri.fromParts("package", activity.getPackageName(), null));
            activity.startActivity(intent);
        } else if (VERSION.SDK_INT >= VERSION_CODES.O) {
            Intent intent = new Intent();
            intent.setAction(Settings.ACTION_APP_NOTIFICATION_SETTINGS);
            intent.putExtra(Settings.EXTRA_APP_PACKAGE, activity.getPackageName());
            intent.putExtra(Settings.EXTRA_CHANNEL_ID, activity.getApplicationInfo().uid);
            activity.startActivity(intent);
        } else if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            Intent intent = new Intent();
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");
            intent.putExtra("app_package", activity.getPackageName());
            intent.putExtra("app_uid", activity.getApplicationInfo().uid);
            activity.startActivity(intent);
        } else {
            Intent intent = new Intent();
            intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
            intent.addCategory(Intent.CATEGORY_DEFAULT);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.setData(Uri.parse("package:" + activity.getPackageName()));
            activity.startActivity(intent);
        }
    }

    public static void checkIsNotificationEnabled(final AppCompatActivity activity) {

//		try {
//			if (!NotificationManagerCompat.from(activity).areNotificationsEnabled()
//					&& StringUtils.isNullOrEmpty(UserShared.getData(activity,"push_settings"))) {
//
//				final Confirm confirm = new Confirm(activity,"取消","去设置","打开通知，即可实时接收重要消息提醒");
//				confirm.setBtnOkClick(new Confirm.MyBtnOkClick() {
//					@Override
//					public void btnOkClickMet() {
//					}
//				});
//
//				confirm.setBtnCancelClick(new Confirm.MyBtnCancelClick() {
//					@Override
//					public void btnCancelClickMet() {
//						openNotificationSettings(activity);
//					}
//				});
//
//				UserShared.setData(activity,"push_settings","1");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
    }

    /**
     * 跳转到应用详情界面
     */
    public static void gotoAppDetailIntent(Context context) {
        Intent intent = new Intent();
        intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        intent.setData(Uri.parse("package:" + context.getPackageName()));
        context.startActivity(intent);
    }

    /**
     * 跳转到应用内部的wap页面
     *
     * @param context
     * @param url
     */
    public static void toWap(Context context, String url) {
        mainToWap(context, url, false, false, "");
    }

    /**
     * 跳转到应用内部的wap页面
     *
     * @param context
     * @param url
     */
    public static void toWap(Context context, String url, String mfield) {
        mainToWap(context, url, false, false, mfield);
    }

    /**
     * 跳转到应用内部的wap页面 是否分享
     */
    public static void toWapShare(Context context, String url, String mfield) {
        mainToWap(context, url, false, true, mfield);
    }

    /**
     * 跳转到应用内部的wap页面
     *
     * @param context
     * @param url
     */
    private static void mainToWap(Context context, String url,
                                  boolean isOpenDialog, boolean isShared, String mfield) {
        String serverUrl = ApiService.BASE_URL + url;
        if (StringUtils.isNotNullOrEmpty(mfield)) {
            if (serverUrl.indexOf("?") == -1) {
                serverUrl += "?" + mfield;
            } else {
                serverUrl += "&" + mfield;
            }
        }
        Intent webIntent = new Intent(context, UWebActivity.class);
        webIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        webIntent.putExtra("isOpenDialog", isOpenDialog);
        webIntent.putExtra("isShared", isShared);
        webIntent.putExtra("url", serverUrl);
        context.startActivity(webIntent);
    }

    public static void toWebView(Context context, String url, boolean isRequestFocus) {
        Intent webIntent = new Intent(context, UWebActivity.class);
        webIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        webIntent.putExtra("isOpenDialog", false);
        webIntent.putExtra("isShared", false);
        webIntent.putExtra("url", url);
        webIntent.putExtra("isRequestFocus", isRequestFocus);
        context.startActivity(webIntent);
    }

    public static void toWeb(Context context, String url, boolean isShared) {
        Intent webIntent = new Intent(context, UWebActivity.class);
        webIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        webIntent.putExtra("isOpenDialog", false);
        webIntent.putExtra("isShared", isShared);
        webIntent.putExtra("url", url);
        webIntent.putExtra("isRequestFocus", false);
        context.startActivity(webIntent);
    }

    /**
     *赚钱计划
     * @param url
     */
    public static void toWeb(Context mContext, String url) {
        Intent webIntent = new Intent(mContext, UWebActivity.class);
        webIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        webIntent.putExtra("isOpenDialog", false);
        webIntent.putExtra("isShared", true);
        webIntent.putExtra("url", url);
        webIntent.putExtra("isRequestFocus", false);
        webIntent.putExtra("type", 2);
        webIntent.putExtra("isDealUrl", true);
        mContext.startActivity(webIntent);
    }


    /**
     * 打开移动网络设置界面
     */
    public static void openSettingDataRoaming(Activity activity) {
        activity.startActivity(new Intent(Settings.ACTION_DATA_ROAMING_SETTINGS));
    }

    public static Uri file2uri(Context context, File file){
        if (VERSION.SDK_INT >= VERSION_CODES.N) {
            return FileProvider.getUriForFile(context, context.getPackageName()+".fileprovider", file);
        } else {
            return Uri.fromFile(file);
        }
    }


    /**
     * 获取截图的文件地址
     *
     * @return
     */
    public static Uri getTempUri() {
        File f = new File(Environment.getExternalStorageDirectory(),
                "jiankezhongbao");
        try {
            f.createNewFile();
        } catch (Exception e) {
            return null;
        }
        return Uri.fromFile(f);
    }
}


