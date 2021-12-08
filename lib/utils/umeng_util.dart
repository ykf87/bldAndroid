import 'package:flutter/services.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';
import 'package:SDZ/constant/plugin_constant.dart';
import 'package:SDZ/constant/third_key.dart';
import 'package:SDZ/env.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/27 11:43
/// @Description: 友盟工具类

class UmengUtil {

  factory UmengUtil() => getInstance();
  static UmengUtil get instance => getInstance();

  static UmengUtil? _instance;

  MethodChannel? _methodChannel;

  UmengUtil._internal() {
    _methodChannel = MethodChannel(PluginChannel.UMENG);
  }

  static UmengUtil getInstance() {
    if(_instance == null) {
      _instance = UmengUtil._internal();
    }
    return _instance!;
  }

  void init() {
    // _methodChannel!.invokeMethod(PluginMethod.UMENT_INIT);
    UmengCommonSdk.initCommon(ThirdKey.UMENG_ANDROID_KEY, ThirdKey.UMENG_IOS_KEY, Env.getChannelName());
    pageCollectionModeAuto();
  }

  /// 自动采集页面信息
  static void pageCollectionModeAuto() {
    UmengCommonSdk.setPageCollectionModeAuto();
  }

  static void onProfileSignIn(String id) {
    UmengCommonSdk.onProfileSignIn(id);
  }

  static void onProfileSignOff() {
    UmengCommonSdk.onProfileSignOff();
  }
}