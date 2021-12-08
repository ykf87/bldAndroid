package com.zhairenwu.plugin

import android.app.Activity
import android.content.Context
import android.view.View
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*
import android.util.Log

import com.tencent.mm.opensdk.constants.ConstantsAPI
import com.tencent.mm.opensdk.modelbase.BaseReq
import com.tencent.mm.opensdk.modelbase.BaseResp
import com.tencent.mm.opensdk.modelbiz.SubscribeMessage
import com.tencent.mm.opensdk.modelbiz.WXLaunchMiniProgram
import com.tencent.mm.opensdk.modelbiz.WXOpenBusinessView
import com.tencent.mm.opensdk.modelbiz.WXOpenBusinessWebview
import com.tencent.mm.opensdk.modelmsg.SendAuth
import com.tencent.mm.opensdk.modelmsg.ShowMessageFromWX
import com.tencent.mm.opensdk.modelmsg.WXAppExtendObject
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage
import com.tencent.mm.opensdk.openapi.IWXAPI
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler
import com.tencent.mm.opensdk.openapi.WXAPIFactory



/**
 * 唤起小程序
 */
class CallWecahtPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    companion object {
        const val CHANNEL = "com.zhairenwu.plugin/wechat"
        const val METHOD_SHOW_WECHAT = "showWechat"
    }

    private var context: Context? = null
    private var methodChannel: MethodChannel? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.context = binding.applicationContext
        this.methodChannel = MethodChannel(binding.binaryMessenger, CHANNEL)
        this.methodChannel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.context = null
        this.methodChannel!!.setMethodCallHandler(null)
        this.methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            METHOD_SHOW_WECHAT -> {
                showWechat(result)
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

    /**
     * 唤起微信小程序
     */
    private fun showWechat(result: MethodChannel.Result) {
        Log.e("66666", "66666");

        val appId = "wxb4b3fae3e93ede6e" // 填移动应用(App)的 AppId，非小程序的 AppID

        val api: IWXAPI = WXAPIFactory.createWXAPI(this.activity, appId)

        val req: WXLaunchMiniProgram.Req =  WXLaunchMiniProgram.Req()
        req.userName = "gh_dca728b1224c" // 填小程序原始id

        //req.path = path ////拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。

        req.miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE // 可选打开 开发版，体验版和正式版

        api.sendReq(req)
    }

}