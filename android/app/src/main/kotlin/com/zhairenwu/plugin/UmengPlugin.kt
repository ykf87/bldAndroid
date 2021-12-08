package com.zhairenwu.plugin

import android.app.Activity
import com.umeng.analytics.MobclickAgent
import com.umeng.commonsdk.UMConfigure
import com.zhairenwu.constant.Constant
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @Author: ljx
 * @CreateDate: 2021/8/27 11:34
 * @Description: 友盟插件
 */
class UmengPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    companion object {
        const val CHANNEL = "com.zhairenwu.plugin/umeng"
        const val INIT = "init"
        const val SIGN_IN = "signIn"
        const val SIGN_OFF = "signOff"
        const val PAGE_COLLECTION_MODE_AUTO = "pageCollectionModeAuto"
    }

    private var methodChannel: MethodChannel? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.methodChannel = MethodChannel(binding.binaryMessenger, CHANNEL)
        this.methodChannel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.methodChannel!!.setMethodCallHandler(null)
        this.methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            INIT -> {
                UMConfigure.init(this.activity!!, Constant.UMENG_KEY, Constant.UMENG_CHANNEL, UMConfigure.DEVICE_TYPE_PHONE, null)
                result.success("umeng init success")
            }
            SIGN_IN -> {
                MobclickAgent.onProfileSignIn(call.argument("id"))
            }
            SIGN_OFF -> {
                MobclickAgent.onProfileSignOff()
            }
            PAGE_COLLECTION_MODE_AUTO -> {
                MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.AUTO)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromActivity() {
        this.activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }
}