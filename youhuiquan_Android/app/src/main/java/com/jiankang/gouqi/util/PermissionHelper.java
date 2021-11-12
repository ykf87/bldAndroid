package com.jiankang.gouqi.util;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.text.TextUtils;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;

import com.yanzhenjie.permission.Action;
import com.yanzhenjie.permission.AndPermission;
import com.yanzhenjie.permission.Rationale;
import com.yanzhenjie.permission.RequestExecutor;
import com.yanzhenjie.permission.option.Option;
import com.yanzhenjie.permission.runtime.Permission;

import java.util.List;

import com.jiankang.gouqi.dialog.CommonDialog;


public class PermissionHelper {

    public interface DeniedPermissionListener {
        void PermissionDeniedListener(List<String> permissions);

        void SettingDeniedListener(List<String> permissions);
    }
    public interface PermissionCallback{
        void hasPermission();
        void noPermission();
    }

    @SuppressLint("WrongConstant")
    public static void CheckPermission(final Object cxt, String[] list, Action Granted, Action Denied, Rationale rationale) {
        Option request = null;
        if (cxt instanceof Activity) {
            Activity activity = (Activity) cxt;
            request = AndPermission.with(activity);
        } else if (cxt instanceof Fragment) {
            Fragment fragment = (Fragment) cxt;
            request = AndPermission.with(fragment);
        }

        request
                .runtime()
                .permission(list)
                .rationale(rationale)
                .onGranted(Granted)
                .onDenied(Denied)
                .start();
    }

    public static void CheckPermission(final Context cxt, String[] list, final PermissionCallback permissionCallback) {
        CheckPermission(cxt, list, new Action() {
            @Override
            public void onAction(Object data) {
                if (permissionCallback != null) {
                    permissionCallback.hasPermission();
                }
            }
        }, new Action<List<String>>() {

            @Override
            public void onAction(final List<String> permissions) {
                if (permissionCallback != null) {
                    permissionCallback.noPermission();
                }
            }
        }, new DefaultRationale());

    }


    public static final class DefaultRationale implements Rationale<List<String>> {

        @Override
        public void showRationale(Context context, List<String> permissions, final RequestExecutor executor) {
            // 这里使用一个Dialog询问用户是否继续授权。
            // 这里的对话框可以自定义，只要调用rationale.resume()就可以继续申请。
            List<String> permissionNames = Permission.transformText(context, permissions);
            String message = "允许以下权限以便程序继续执行：\n" + TextUtils.join("权限\n", permissionNames) + "权限";

            openPermissionDialog(context, executor, message);
        }

    }


    public static String getPermissionNames(Context context, List<String> permissions) {
        List<String> permissionNames = Permission.transformText(context, permissions);
        String message = "此功能需要" + TextUtils.join("权限，", permissionNames) + "权限";
        return message;
    }

    private static void openPermissionDialog(Object context, final RequestExecutor executor, final String permissionDes) {
        CommonDialog permissionDialog = CommonDialog.newInstance("提示", permissionDes, "取消", "确定");
        permissionDialog.setOnDialogClickListener(new CommonDialog.OnDialogClickListener() {
            @Override
            public void onStartBtnDefaultCancelClick() {
                executor.cancel();
            }

            @Override
            public void onEndBtnDefaultConfirmClick() {
                executor.execute();
            }
        });
        FragmentManager fragmentManager = null;
        if (context instanceof AppCompatActivity) {
            AppCompatActivity activity = (AppCompatActivity) context;
            fragmentManager = activity.getSupportFragmentManager();
        } else if (context instanceof Fragment) {
            Fragment fragment = (Fragment) context;
            fragmentManager = fragment.getChildFragmentManager();
        }
        if (fragmentManager != null){
            permissionDialog.show(fragmentManager, "permissionDialog");
        }

    }
}
