
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/search/platform_entity.dart';
import 'package:SDZ/utils/sputils.dart';

class Utils {
  static String QRCodeUrl = '';

  /// 校验手机号
  static bool isMobile(String phone) {
    return new RegExp("^[1][0-9]\\d{9}\$").hasMatch(phone);
  }

  /// 分割手机号
  /// isHidden 是否隐藏中间位数
  static String splitPhoneNumber(String str, {bool isHidden = false}) {
    if(str.isEmpty){
      return str;
    }
    Pattern regex = RegExp(r'(1\w{2})(\w{4})(\w{4})');
    return str.replaceAllMapped(
        regex, (match) => '${match[1]} ${isHidden ? '****' : match[2]} ${match[3]}');
  }

  /// 计算文本宽高
  static Size boundingTextSize(String? text, TextStyle style,  {int maxLines = 2^31, double maxWidth = double.infinity}) {
    if (text == null || text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: style), maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }


  /// 隐藏键盘
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static String getSvgUrl(String path){
    return 'assets/svg/$path';
  }

  /// 封装formData
  static FormData getFormData(Map<String, dynamic> data) {
    return FormData.fromMap(data);
  }

  /// 格式化粉丝数
  static String formatterFansNumber(int fansNumber) {
    if(fansNumber <= 1000) {
      return '$fansNumber';
    }
    if(fansNumber > 1000 && fansNumber < 10000) {
      return '${(fansNumber/1000.0).toStringAsFixed(0)}k+';
    }
    return '${(fansNumber~/10000.0).toStringAsFixed(0)}w+';
  }

  static String formatterNumber(int fansNumber) {
    if(fansNumber <= 1000) {
      return '$fansNumber';
    }
    if(fansNumber > 1000 && fansNumber < 10000) {
      return '${(fansNumber/1000.0).toStringAsFixed(0)}k';
    }
    return '${(fansNumber~/10000.0).toStringAsFixed(0)}w';
  }

  /// 获取平台列表
  static List<PlatformEntity> getPlatformEntityList() {
    return [
      PlatformEntity('小红书', SvgPath.ic_xiaohongshu, 1),
      PlatformEntity('淘宝', SvgPath.ic_taobao, 3),
      PlatformEntity('抖音', SvgPath.ic_tiktok, 2)
    ];
  }

  /// 保存筛选条件
  static void saveSearchOptions(String key, String options){
    SPUtils.setSearchOptions(key, options);
  }

  /// 获取筛选条件
  static String getSearchOptions(String key){
    return SPUtils.getSearchOptions(key);
  }

  /// 清空筛选条件
  static void clearSearchOptions(String key){
    saveSearchOptions(key, '');
  }

  static String getBigImage(MyBrowseRecordEntity entity) {
    if(entity.album == null || entity.album!.length == 0) {
      return entity.avatar!;
    }
    return "${entity.album![0]}?x-oss-process=image/resize,w_400";
  }

//  static String getBigImage(MyBrowseRecordEntity entity) {
//    if(entity.album == null || entity.album!.length == 0) {
//      return entity.avatar!;
//    }
//    return "${entity.album![0]}?x-oss-process=image/resize,w_400";
//  }

  static String getImageUrl(MyBrowseRecordEntity entity) {
    if(entity.album == null || entity.album!.length == 0) {
      return entity.avatar!;
    }
    return "${entity.album![0]}";
  }

  /// 记录进入后台时当前时间
  static setAppBackgroundTime() {
    SPUtils.setAppBackgroundTime();
  }

  /// 获取进入后台时当前时间
  static get getAppBackgroundTime => SPUtils.appBackgroundTime;
}