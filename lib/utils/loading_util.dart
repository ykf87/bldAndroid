
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:SDZ/constant/plugin_constant.dart';

/// 加载中提示工具类
class LoadingUtil {

  // factory LoadingUtil() => getInstance();
  // static LoadingUtil get instance => getInstance();
  //
  // static LoadingUtil? _instance;
  //
  // MethodChannel _methodChannel;
  //
  // LoadingUtil._internal() {
  //   _methodChannel = MethodChannel(PluginChannel.LOADING);
  // }
  //
  // static LoadingUtil getInstance() {
  //   if(_instance == null) {
  //     _instance = LoadingUtil._internal();
  //   }
  //   return _instance;
  // }

  /// 显示
  /// loadingText 加载提示文本
  Future show({loadingText = "加载中..."}) async {
    EasyLoading.show(status: loadingText, dismissOnTap: false, maskType: EasyLoadingMaskType.none);
    // _methodChannel.invokeMethod(PluginMethod.SHOW_LOADING, {"text": loadingText});
  }

  /// 隐藏
  Future dismiss() async {
    // _methodChannel.invokeMethod(PluginMethod.DISMISS_LOADING);
    EasyLoading.dismiss();
  }
}