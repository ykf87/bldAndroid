package com.zhairenwu

import android.app.Activity
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull;
import com.umeng.commonsdk.UMConfigure
import com.zhairenwu.constant.Constant
import com.zhairenwu.plugin.PickerPlugin
import com.zhairenwu.plugin.LoadingPlugin
import com.zhairenwu.plugin.UmengPlugin
import com.zhairenwu.plugin.CallWecahtPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterEngine.plugins.add(PickerPlugin())
        flutterEngine.plugins.add(LoadingPlugin())
        flutterEngine.plugins.add(UmengPlugin())
        flutterEngine.plugins.add(UmengsharePlugin())
        flutterEngine.plugins.add(CallWecahtPlugin())
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
//            var lp = window.attributes;
//            lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
//            window.attributes = lp
//        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
//            var decorView = window.decorView
//            var option = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
//            decorView.systemUiVisibility = option
            window.navigationBarColor = Color.TRANSPARENT
            window.statusBarColor = Color.TRANSPARENT
        }
        // 友盟预初始化
        UMConfigure.preInit(this, Constant.UMENG_KEY, Constant.UMENG_CHANNEL)
        com.umeng.umeng_common_sdk.UmengCommonSdkPlugin.setContext(this)
        Log.d("wuwx", Constant.UMENG_CHANNEL)
    }
}
