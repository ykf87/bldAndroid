package com.zhairenwu.plugin

import android.app.Activity
import android.text.TextUtils
import com.contrarywind.timer.MessageHandler
import com.lxj.xpopup.XPopup
import com.lxj.xpopup.impl.LoadingPopupView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @Author: ljx
 * @CreateDate: 2021/8/20 13:54
 * @Description:
 */
class LoadingPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    companion object {
        const val CHANNEL = "com.zhairenwu.plugin/loading"
        const val SHOW_LOADING = "showLoading"
        const val DISMISS_LOADING = "dismissLoading"
    }

    private var methodChannel: MethodChannel? = null
    private var activity: Activity? = null
    private var loadingPopupView: LoadingPopupView? = null

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
            SHOW_LOADING -> {
                val text = call.argument<String>("text")
                if (text.isNullOrBlank()) {
                    show()
                }else{
                    show(text)
                }
                result.success("show success")
            }
            DISMISS_LOADING -> {
                dismiss()
                result.success("dismiss success")
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

    private fun show(text: String = "加载中...") {
        if (loadingPopupView != null && loadingPopupView!!.isShow) {
            return
        }
        if (loadingPopupView == null) {
            loadingPopupView = XPopup.Builder(this.activity!!)
                    .dismissOnBackPressed(false)
                    .dismissOnTouchOutside(false)
                    .isLightNavigationBar(false)
                    .asLoading(text)
                    .show() as LoadingPopupView
        }
    }

    private fun dismiss() {
        if (loadingPopupView != null && loadingPopupView!!.isShow) {
            loadingPopupView!!.smartDismiss()
            loadingPopupView = null
        }
    }
}