
import 'package:package_info_plus/package_info_plus.dart';

///APP信息工具类
class PackageUtil {

  /// 获取app名称
  static Future<String> get appName async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  /// 获取app包名
  static Future<String> get packageName async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  /// 获取app版本号
  static Future<String> get version async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 获取app构建版本号
  static Future<String> get buildNumber async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}