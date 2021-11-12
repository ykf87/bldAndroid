package com.jiankang.gouqi.util;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.util.Log;
import android.widget.TextView;

import androidx.core.content.FileProvider;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.jiankang.gouqi.common.activity.AndroidOPermissionActivity;
import com.jiankang.gouqi.common.MyHandler;
import com.jiankang.gouqi.dialog.ConfirmUpdate;
import com.jiankang.gouqi.dialog.ProgressDialogShow;
import com.jiankang.gouqi.interfaces.AppInterfaces;
import com.jiankang.gouqi.interfaces.ObjectInterface;


@SuppressLint("WorldReadableFiles")
public class AppUpdateUtils {

    private MyHandler handler;

    private Context mContext;

    /**
     * 下载总量
     */
    private long downTotal = 0;

    /**
     * 升级时候的提示框
     */
    private TextView updTip;

    /**
     * app下载地址
     */
    private String appDownUrl;

    public static void installApkFromLocalPath(final Context mContext, final MyHandler handler, final String destPath, final String type) {

        boolean haveInstallPermission;
        // 兼容Android 8.0
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            //先获取是否有安装未知来源应用的权限
            haveInstallPermission = mContext.getPackageManager().canRequestPackageInstalls();
            if (!haveInstallPermission) {
                //没有权限
                AppUtils.setActivityInterface(mContext, AndroidOPermissionActivity.class,
                        new AppInterfaces.ActivityCallBackInterface() {
                            @Override
                            public void callback(Object obj) {
                                if (obj == null) {
                                    return;
                                }
                                if ("1".equals(obj.toString())) {
                                    //成功
                                    installApkFromLocalPath1(mContext, destPath, type);
                                } else if ("2".equals(obj.toString())) {
                                    //失败
                                    ToastShow.showMsg(mContext, "授权失败，无法安装应用", handler);
                                }
                            }
                        }, true);

                Intent intent1 = new Intent(mContext, AndroidOPermissionActivity.class);
                intent1.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                mContext.startActivity(intent1);

            } else {
                installApkFromLocalPath1(mContext, destPath, type);
            }
        } else {
            installApkFromLocalPath1(mContext, destPath, type);
        }
    }

    private static void installApkFromLocalPath1(Context mContext, String destPath, String type) {

        File apkFile = new File(destPath);

        Uri uri;
        try {
            Intent intent = new Intent();
            intent.setAction(Intent.ACTION_VIEW);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {//7.0启动姿势<pre name="code" class="html">
                // com.xxx.xxx.fileprovider为上述manifest中provider所配置相同；apkFile为问题1中的外部存储apk文件</pre>
                uri = FileProvider.getUriForFile(mContext, "com.zhaiwanzhuan.fileprovider", apkFile);
                Log.d("mytest", "7.0" + uri.toString());
                //intent.setAction(Intent.ACTION_INSTALL_PACKAGE);
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                //7.0以后，系统要求授予临时uri读取权限，安装完毕以后，系统会自动收回权限，次过程没有用户交互
            } else {//7.0以下启动姿势
                uri = Uri.fromFile(apkFile);
            }

            intent.setDataAndType(uri, type);
             mContext.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateApp(final String desc, String url, String version,
                          final boolean needUpdate) {
        appDownUrl = url;
        handler.mPost(new Runnable() {

            @Override
            public void run() {
                ConfirmUpdate update = new ConfirmUpdate(mContext, desc + "\n", version, needUpdate);
                update.setOkReturnMet(new ObjectInterface.ObjReturnMet3() {
                    @Override
                    public void callback() {
                        startDown();
                    }
                });
                update.setCancleReturnMet(new ObjectInterface.ObjReturnMet3() {
                    @Override
                    public void callback() {
                        // 必须升级
                        if (needUpdate) {
                            ExitApplication.getInstance().exit();
                        }
                    }
                });
            }
        });
    }

    // 开始升级
    private void startDown() {
        final String destPath = mContext.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS) + File.separator + "update/" + "updateApp.apk";
        File file = new File(mContext.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS) + File.separator + "update/");
        if (!file.exists()) {
            file.mkdirs();
        }

        updTip = ProgressDialogShow.showLoadDialog(mContext, false, "更新中...");

        new Thread(new Runnable() {

            @Override
            public void run() {

                boolean isOk = downloadApktoappDir(appDownUrl, destPath);

                ProgressDialogShow.dismissDialog(handler);

                if (isOk) {
                    handler.mPost(new Runnable() {

                        @Override
                        public void run() {
                            installApkFromLocalPath(mContext, handler, destPath, "application/vnd.android.package-archive");
                            //ExitApplication.getInstance().exit();
                        }
                    });
                } else {
                    ToastShow.showMsg(mContext, "升级失败,请稍后在试", handler);
                }
            }
        }).start();
    }

    @SuppressWarnings("deprecation")
    private boolean downloadApktoappDir(String path, String destPath) {
        URL url;
        FileOutputStream fos = null;
        BufferedInputStream bis = null;
        InputStream is = null;
        try {
            url = new URL(path);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Accept-Encoding", "identity");
            conn.setConnectTimeout(5000);
            // 获取到文件的大小
            final int size = conn.getContentLength();
            is = conn.getInputStream();

            fos = new FileOutputStream(destPath);
            bis = new BufferedInputStream(is);
            byte[] buffer = new byte[1024];
            int len;
            downTotal = 0;
            while ((len = bis.read(buffer)) != -1) {
                fos.write(buffer, 0, len);

                // 获取当前下载量
                downTotal += len;

                if (updTip != null) {
                    handler.mPost(new Runnable() {
                        @Override
                        public void run() {
                            long jd = downTotal * 100 / size;
                            updTip.setText("更新中..." + Math.abs(jd) + "%");
                        }
                    });
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
                if (bis != null) {
                    bis.close();
                }
                if (is != null) {
                    is.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    /**
     * 查询版本信息
     */
    public void selVersion(Context iContext, MyHandler iHandler,
                           final boolean isToast) {
//        handler = iHandler;
//        mContext = iContext;
//        try {
//            if (UserGlobal.mGlobalConfigInfo == null
//                    || UserGlobal.mGlobalConfigInfo.getVersion_info() == null) {
//                return;
//            }
//            final GlobalEntity.VersionInfoEntity clientVersionEntity = UserGlobal.mGlobalConfigInfo.getVersion_info();
//            int version = SystemUtil.getVersion(mContext);
//            if (clientVersionEntity.getVersion() > version) {
//                handler.mPost(new Runnable() {
//                    @Override
//                    public void run() {
//                        updateApp(clientVersionEntity.getVersion_desc(),
//                                clientVersionEntity.getUrl(), clientVersionEntity.getVersion_code(),
//                                clientVersionEntity.getNeed_force_update() == 1);
//                    }
//                });
//            } else {
//                if (isToast) {
//                    ToastShow.showMsg(mContext, "当前已经是最新版本", handler);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }
}
