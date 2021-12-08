package com.zhairenwu.plugin;

import android.content.Context;

import androidx.annotation.NonNull;

import com.blankj.utilcode.util.DeviceUtils;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * @Author: ljx
 * @CreateDate: 2021/7/27 15:15
 * @Description:
 * @UpdateUser: 更新者
 * @UpdateDate: 2021/7/27 15:15
 * @UpdateRemark: 更新说明
 */
public class DeviceProviderPlugin implements MethodChannel.MethodCallHandler, FlutterPlugin {

    public static final String CHANNEL = "com.zhairenwu.plugin/device";
    private MethodChannel methodChannel;
    private Context context;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new DeviceProviderPlugin());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if ("getMacPath".equals(call.method)) {
            result.success(DeviceUtils.getMacAddress());
        }else {
            result.notImplemented();
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        this.context = applicationContext;
        methodChannel = new MethodChannel(messenger, CHANNEL);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        context = null;
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }
}
