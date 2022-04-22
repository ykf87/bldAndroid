package com.xlx.speech.voiceread;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.xlx.speech.voicereadsdk.bean.AdReward;
import com.xlx.speech.voicereadsdk.bean.AdSlot;
import com.xlx.speech.voicereadsdk.bean.VoiceConfig;
import com.xlx.speech.voicereadsdk.entrance.CheckAdStatusListener;
import com.xlx.speech.voicereadsdk.entrance.SpeechVoiceSdk;
import com.xlx.speech.voicereadsdk.entrance.VoiceAdListener;
import com.xlx.speech.voicereadsdk.entrance.VoiceAdLoadListener;
import com.xlx.speech.voicereadsdk.entrance.VoiceAdPluginLoadListener;

import org.json.JSONArray;
import org.json.JSONObject;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * VoicereadPlugin
 */
public class VoicereadPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    public static final String EVENT_CHANNEL_NAME = "voiceread_event";
    private MethodChannel methodChannel;
    private Activity activity;
    private Map<String, EventChannel.EventSink> eventSinks = new HashMap<>();
    private EventChannel eventChannel;

    public VoicereadPlugin() {
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "voiceread");
        methodChannel.setMethodCallHandler(this);
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), EVENT_CHANNEL_NAME);
        eventChannel.setStreamHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if ("init".equals(call.method)) {
            onInitCall(call, result);
        } else if ("loadVoiceAd".equals(call.method)) {
            onLoadVoiceAdCall(call, result);
        } else if ("showVoiceAd".equals(call.method)) {
            onShowVoiceAdCall(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void onInitCall(@NonNull MethodCall call, @NonNull Result result) {
        SpeechVoiceSdk.init(activity.getApplicationContext(), new VoiceConfig
                .Builder()
                .appId(call.argument("appId"))
                .appSecret(call.argument("appSecret"))
                .debug(call.hasArgument("debug") ? call.argument("debug") : false)
                .build());
        result.success(null);
    }

    private List<Float> iCPMList = new ArrayList<>();

    private void onLoadVoiceAdCall(@NonNull MethodCall call, @NonNull Result result) {
        SpeechVoiceSdk.getAdManger().loadVoiceAdFromPlugin(activity, new AdSlot
                .Builder()
                .resourceId(call.hasArgument("resourceId") ? call.argument("resourceId") : "")
                .setUserId(call.hasArgument("userId") ? call.argument("userId") : "")
                .setMediaExtra(call.hasArgument("mediaExtra") ? call.argument("mediaExtra") : "")
                .build(), new VoiceAdPluginLoadListener() {
            @Override
            public void onAdLoadSuccess(float eCPM, float iCPMOne, float iCPMTwo, int maxReadNum, int surplusReadNum) {
                Map<String, Object> callback = new HashMap<>();
                callback.put("eventType", "onAdLoadSuccess");

                iCPMList.clear();
                iCPMList.add(iCPMOne);
                iCPMList.add(iCPMTwo);

                Map<String, Object> data = new HashMap();
                data.put("eCPM", eCPM);
                data.put("iCPMOne", iCPMOne);
                data.put("iCPMTwo", iCPMTwo);
                data.put("maxReadNum", maxReadNum);
                data.put("surplusReadNum", surplusReadNum);
                callback.put("params", data);

                result.success(callback);
            }


            @Override
            public void onAdLoadError(int errorCode, String errorMsg) {
                Map<String, Object> callback = new HashMap<>();
                callback.put("eventType", "onAdLoadError");

                Map<String, Object> data = new HashMap();
                data.put("errorCode", errorCode);
                data.put("errorMsg", errorMsg);
                callback.put("params", data);

                result.success(callback);
            }
        });
    }

    private void onShowVoiceAdCall(@NonNull MethodCall call, @NonNull Result result) {
        SpeechVoiceSdk.getAdManger().showVoiceAd(activity, new VoiceAdListener() {
            @Override
            public void onAdShow() {
                callBack("onAdShow");
            }

            @Override
            public void onAdError(int i) {
                Map<String, Object> data = new HashMap<>();
                data.put("errorCode", i);
                callBack("onAdError", data);
            }

            @Override
            public void onAdClose() {
                callBack("onAdClose");
            }

            @Override
            public void onRewardVerify(String logId, float iCPM, int stepNum) {
                Map<String, Object> data = new HashMap<>();
                data.put("logId", logId);
                data.put("iCPM", iCPM);
                data.put("stepNum", stepNum);
                callBack("onRewardVerify", data);
            }


            @Override
            public AdReward getRewardInfo(float icpm, AdReward adReward, int stepNum) {
                //因为原生调用 Flutter 是异步的，如果这里直接去调 Flutter 代码获取 AdReward，会出现数据不对的情况(数据传递在异步结果之前)
                boolean hasRewardInfo = call.hasArgument("rewardInfo");
                if (hasRewardInfo) {
                    try {
                        List rewardInfo = call.argument("rewardInfo");
                        int index = iCPMList.indexOf(icpm);
                        if (index < 0) {
                            // index 小于 0 会出现在体验未完成界面放弃任务的情况。这种情况会加载新的广告，iCPM 会变化
                            if (rewardInfo.size() > 0) {
                                //这里根据之前设置的数据根据比例算出当前 iCPM 对应的奖励
                                return calcReward(rewardInfo, icpm);
                            }
                        } else {
                            Map<String, Object> rewardObj = (Map<String, Object>) rewardInfo.get(index);
                            return new AdReward(Float.parseFloat(rewardObj.get("rewardCount").toString()), rewardObj.get("rewardName").toString());
                        }
                    } catch (Throwable t) {
                        t.printStackTrace();
                    }
                }
                return adReward;
            }

            private AdReward calcReward(List rewardInfo, float icpm) {
                float minDiff = Float.MAX_VALUE;
                int findIndex = 0;
                for (int i = 0; i < rewardInfo.size(); i++) {
                    float indexDiff = Math.abs(iCPMList.get(i) - icpm);
                    if (iCPMList.get(i) > 0 && indexDiff < minDiff) {
                        minDiff = indexDiff;
                        findIndex = i;
                    }
                }
                Map<String, Object> rewardObj = (Map<String, Object>) rewardInfo.get(findIndex);
                float rewardCount = new BigDecimal(rewardObj.get("rewardCount").toString())
                        .multiply(new BigDecimal(icpm))
                        .divide(new BigDecimal(iCPMList.get(findIndex)), 2, RoundingMode.DOWN)
                        .floatValue();
                return new AdReward(rewardCount, rewardObj.get("rewardName").toString());
            }


            private void callBack(String type) {
                callBack(type, null);
            }

            private void callBack(String type, Map<String, Object> params) {
                Map<String, Object> callback = new HashMap<>();
                callback.put("eventType", type);
                callback.put("params", params);
                sendLoadVoiceAdEvent(callback);
            }
        });
        result.success(null);
    }

    public void sendLoadVoiceAdEvent(Map<String, Object> params) {
        EventChannel.EventSink eventSink = eventSinks.get("showVoiceAd");
        if (eventSink != null) {
            eventSink.success(params);
        }
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSinks.put(arguments.toString(), events);
    }

    @Override
    public void onCancel(Object arguments) {
        if (arguments != null) {
            eventSinks.remove(arguments.toString());
        }
    }
}
