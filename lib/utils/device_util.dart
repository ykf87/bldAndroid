import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

/// 设备信息工具类
class DeviceUtil {

  static Future<dynamic> getAndroidDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    return androidDeviceInfo;
  }

  static Future<dynamic> getIOSDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    return iosDeviceInfo;
  }

  /// 获取设备的model
  static Future<String?> get platformModel async {
    if(Platform.isAndroid){
      AndroidDeviceInfo data = await getAndroidDeviceInfo();
      return data.model;
    }
    if(Platform.isIOS){
      IosDeviceInfo data = await getIOSDeviceInfo();
      return data.model;
    }
    return '';
  }

  /// 获取设备的brand
  static Future<String?> get platformBrand async {
    if(Platform.isAndroid){
      AndroidDeviceInfo data = await getAndroidDeviceInfo();
      return "${data.brand}-${data.model}";
    }
    if(Platform.isIOS){
      IosDeviceInfo data = await getIOSDeviceInfo();
      String test = data.name??"";
      if (containCN(test)) {
        test = data.model??"";
      }

      return "${test}-${data.utsname.machine}";
    }
    return '';
  }

  static bool containCN(String? str) {
    final reg = RegExp('[\u4e00-\u9fa5]+');
//    print('$str 是否中文:${reg.hasMatch(str??"")}');
    return reg.hasMatch(str??"");
  }

  /// 获取设备的androidId
  static Future<String?> get platformId async {
    if(Platform.isAndroid){
      AndroidDeviceInfo data = await getAndroidDeviceInfo();
      return data.androidId;
    }
    // if(Platform.isIOS){
    //   IosDeviceInfo data = await getIOSDeviceInfo();
    //   return data.name;
    // }
    return '';
  }

  /// 获取设备的version
  static Future<String?> get platformVersion async {
    if(Platform.isAndroid){
      AndroidDeviceInfo data = await getAndroidDeviceInfo();
      return data.version.release;
    }
    if(Platform.isIOS){
      IosDeviceInfo data = await getIOSDeviceInfo();
      return data.systemVersion;
    }
    return '';
  }

  /// 获取设备id
  static Future<String?> get deviceId async {
    if(Platform.isAndroid){
      AndroidDeviceInfo data = await getAndroidDeviceInfo();
      return data.androidId;
    }
    if(Platform.isIOS){
      IosDeviceInfo data = await getIOSDeviceInfo();
      return data.identifierForVendor;
    }
    return null;
  }}