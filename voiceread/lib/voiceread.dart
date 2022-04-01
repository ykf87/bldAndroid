
import 'dart:async';

import 'package:flutter/services.dart';

class Voiceread {

  static const MethodChannel _channel = MethodChannel('voiceread');

  static const EventChannel _eventChannel = EventChannel("voiceread_event");


  static void init({required String appId, required String appSecret, bool debug = false}) async {
    Map<String, dynamic> params = <String, dynamic>{
      "appId": appId,
      "appSecret" : appSecret,
      "debug": debug
    };
    final String? result = await _channel.invokeMethod('init', params);
  }

  static void checkAdStatus({required String resourceId, required VoiceAdListener listener}) async {
    Map<String, String> params = <String, String>{
      "resourceId": resourceId,
    };
    final Map<dynamic, dynamic> result = await _channel.invokeMethod('checkAdStatus', params);
    listener(result["eventType"], result["params"]);
  }

  static loadVoiceAd({required String resourceId, String userId = "", String mediaExtra = "", required VoiceAdListener listener}) async {
    Map<String, String> params = <String, String>{
      "resourceId": resourceId,
      "userId": userId,
      "mediaExtra": mediaExtra
    };
    final Map<dynamic, dynamic> result = await _channel.invokeMethod('loadVoiceAd', params);
    listener(result["eventType"], result["params"]);
  }

  static void showVoiceAd({List<Map<String, dynamic>>? rewardInfo, required VoiceShowListener listener}) async {
    _eventChannel.receiveBroadcastStream("showVoiceAd").listen((event) {
      String eventType = event["eventType"];
      listener(eventType, event["params"]);
    });
    _channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "getRewardInfo") {
        return listener("getRewardInfo", call.arguments);
      }
      return null;
    });
    Map<dynamic, dynamic> params = <dynamic, dynamic>{
      "rewardInfo": rewardInfo
    };
    await _channel.invokeMethod('showVoiceAd', params);
  }

}

typedef VoiceAdListener = void Function(String eventType, Map<dynamic, dynamic>? params);

typedef VoiceShowListener = Map<String, dynamic>? Function(String eventType, Map<dynamic, dynamic>? params);