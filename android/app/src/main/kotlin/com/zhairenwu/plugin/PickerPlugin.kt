package com.zhairenwu.plugin

import android.app.Activity
import android.content.Context
import android.view.View
import com.blankj.utilcode.util.TimeUtils
import com.lxj.xpopup.XPopup
import com.lxj.xpopup.widget.LoadingView
import com.lxj.xpopupext.listener.CityPickerListener
import com.lxj.xpopupext.listener.TimePickerListener
import com.lxj.xpopupext.popup.CityPickerPopup
import com.lxj.xpopupext.popup.TimePickerPopup
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

/**
 * @Author: ljx
 * @CreateDate: 2021/8/20 10:22
 * @Description: 选择器(日期 城市)
 */
class PickerPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    companion object {
        const val CHANNEL = "com.zhairenwu.plugin/picker"
        const val METHOD_SHOW_CITY_PICKER = "showCityPicker"
        const val METHOD_SHOW_DATE_PICKER = "showDatePicker"
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
            METHOD_SHOW_CITY_PICKER -> {
                showCityPicker(result)
            }
            METHOD_SHOW_DATE_PICKER -> {
                showDatePicker(result)
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

    /**
     * 显示城市选择
     */
    private fun showCityPicker(result: MethodChannel.Result) {
        val cityPicker = CityPickerPopup(this.activity!!)
        cityPicker.setCityPickerListener(object : CityPickerListener {
            override fun onCityConfirm(province: String, city: String, area: String, v: View?) {
                val map = mapOf("province" to province, "city" to city, "area" to area)
                result.success(map)
            }

            override fun onCityChange(province: String, city: String, area: String) {
            }
        })
        XPopup.Builder(this.activity!!).asCustom(cityPicker).show()
    }

    /**
     * 显示日期选择
     */
    private fun showDatePicker(result: MethodChannel.Result) {
        val datePicker = TimePickerPopup(this.activity!!)
                .setTimePickerListener(object: TimePickerListener {
                    override fun onTimeChanged(date: Date?) {
                    }

                    override fun onTimeConfirm(date: Date?, view: View?) {
                        val date = TimeUtils.date2String(date)
                        result.success(mapOf("date" to date))
                    }
                })
        XPopup.Builder(this.activity!!).asCustom(datePicker).show()
    }
}