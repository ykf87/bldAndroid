package com.blandal.app.common.activity;

import android.Manifest;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;

import com.blandal.app.R;
import com.blandal.app.base.BaseActivity;


/**
 * 兼容Android 8。0 APP 安装apk权限申请界面
 */

public class AndroidOPermissionActivity extends BaseActivity {

    public static final int INSTALL_PACKAGES_REQUESTCODE = 1;

    private AlertDialog mAlertDialog;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_o_permission);

        // 弹窗
        if (Build.VERSION.SDK_INT >= 26) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.REQUEST_INSTALL_PACKAGES}, INSTALL_PACKAGES_REQUESTCODE);
        } else {
            finish();
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case INSTALL_PACKAGES_REQUESTCODE:
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    callActivityInterface(1);
                    finish();
                } else {
                    //startInstallPermissionSettingActivity();
                    showDialog();
                }
                break;

        }
    }

    private void showDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.app_name);
        builder.setCancelable(false);
        builder.setMessage("为了正常安装apk，请点击设置按钮，允许安装未知来源应用");
        builder.setPositiveButton("设置", new DialogInterface.OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                startInstallPermissionSettingActivity();
                mAlertDialog.dismiss();
            }
        });
        builder.setNegativeButton("取消", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                callActivityInterface(2);
                mAlertDialog.dismiss();
                finish();
            }
        });
        mAlertDialog = builder.create();
        mAlertDialog.show();
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private void startInstallPermissionSettingActivity() {
        //注意这个是8.0新API
        Intent intent = new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Uri.parse("package:" + getPackageName()));
        startActivityForResult(intent, 1);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1 && resultCode == RESULT_OK) {
            // 授权成功
            callActivityInterface(1);
        } else {
            // 授权失败
            callActivityInterface(2);
        }
        finish();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

}