
import 'dart:io';
import 'dart:ui';

import 'package:SDZ/core/utils/toast.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/search/platform_entity.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String QRCodeUrl = '';

  ///获取应用包信息
  static Future<PackageInfo> getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  ///处理链接
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      ToastUtils.error("暂不能处理这条链接:$url");
    }
  }

  //=============package_info==================//



  ///获取应用包信息
  static Future<Map<String, dynamic>> getPackageInfoMap() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return <String, dynamic>{
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }

  //=============date_format==================//

  static String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  static String formatDateTime(DateTime dateTime) =>
      formatDate(dateTime, [yyyy, '-', mm, '-', dd]);


  // 显示一条消息
  static void showMessage(String msg) {
    final _context = Get.context;
    if (_context != null) {
      ScaffoldMessenger.of(_context).removeCurrentSnackBar();
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  void log(String msg) {
    Logger().i(msg);
  }

  // 选择文件
  Future<File?> selectFile() async {
    if (!GetPlatform.isWeb && GetPlatform.isWindows) {
      // final file = OpenFilePicker()
      //   ..filterSpecification = {
      //     '图片文件 (*.jpg; *.png)': '*.jpg;*.png',
      //   }
      //   ..defaultFilterIndex = 0
      //   ..defaultExtension = 'jpg'
      //   ..title = '选择图片上传';

      // final result = file.getFile();
      // if (result != null) {
      //   return result;
      // }
    } else if (GetPlatform.isAndroid) {
      // var _imagePicker =
      //     await ImagePicker().pickImage(source: ImageSource.gallery);
      // var file = File(_imagePicker!.path);
      // return file;
      return null;
    }
  }

  //处理图片不带http
  String imageHeaderHandle(String url) {
    if (url.indexOf('//') == 0) {
      return 'https:$url';
    }
    return url;
  }

  // 复制
  static void copy(String? text, {String? message}) {
    Clipboard.setData(ClipboardData(text: text));
    showMessage(message ?? '复制成功');
  }

  static Future<void> navToBrowser(String url) async {
    if (await canLaunch(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(url);
    } else {
      copy(url, message: '跳转url失败,链接已复制到剪贴板');
    }
  }

  // 跳转到浏览器
  Future<void> openLink(String url, {String urlYs = ''}) async {
    await urlToApp(url, urlYs);
  }

  /// url 跳转到 app  使用约束
  Future<void> urlToApp(String url, String urlYs) async {
    /// 如果是windows平台,直接跳转到浏览器打开链接
    if (GetPlatform.isWindows) {
      await launch(url);
      return;
    }
    var _url = url;
    _url = '$urlYs${urlHandle(url)}';
    if (await canLaunch(_url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(_url);
    } else {
      if (weChatBro) {
        // 如果是微信浏览器
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          final _newUrl = url.replaceAll('https://', '');
          showMessage('打开url失败,即将尝试删除https://后打开 $_newUrl');
          if (await canLaunch(_newUrl)) {
            await launch(_newUrl);
          } else {
            showMessage('打开url失败');
            copy(url, message: '打开URL失败,链接已复制到剪贴板,请在浏览器访问');
          }
        }
      } else {
        await launch(url);
      }
    }
  }

  // 打开淘宝
  Future<void> openTaobao(String url) async {
    await urlToApp(url, 'taobao://');
  }

 static String urlHandle(String url) {
    var _url = url;
    if (_url.indexOf('http://') == 0) {
      _url = _url.replaceAll('http://', '');
    } else if (_url.indexOf('https://') == 0) {
      _url = _url.replaceAll('https://', '');
    }
    return _url;
  }

  /// 判断是否为微信浏览器
  bool get weChatBro => false;


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


  ///处理图片链接不带头部
  static String magesProcessor(String url){
    return url.contains('https:') || url.contains('http:')?url:'https:$url';
  }

}