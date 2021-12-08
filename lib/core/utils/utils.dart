import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast.dart';

///常用工具类
class Utils {
  Utils._internal();

  //=============url_launcher==================//

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
  static Future<PackageInfo> getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

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

  String urlHandle(String url) {
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

}
Utils get utils => GetIt.instance.get<Utils>();