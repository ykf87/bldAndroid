import 'package:package_info/package_info.dart';
import 'package:SDZ/utils/device_util.dart';

/// 项目环境变量
enum EnvType {
  /// 开发环境
  EnvType_Dev,

  /// 测试环境
  EnvType_Test,

  /// 仿真环境
  EnvType_Pre_Release,

  /// 正式环境
  EnvType_Release
}

/// 项目请求日志类型
enum RequestLogLevel {
  /// 不输出
  RequestLogLevel_None,

  /// 全部日志内容
  RequestLogLevel_FullLog,

  /// url信息
  RequestLogLevel_UrlLog,

  /// url 和 返回值
  RequestLogLevel_Url_Data_log
}

/// 渠道包
enum ChannelType {
  /// 不定义
  ChannelType_None,

  /// 苹果
  ChannelType_iOS,

  /// 应用宝
  ChannelType_YingYongBao,

  /// 小米
  ChannelType_XiaoMi,

  /// 华为
  ChannelType_HuaWei,

  /// Oppo
  ChannelType_Oppo,

  /// Vivo
  ChannelType_Vivo,

  /// meizu
  ChannelType_Meizu,

  /// 豌豆荚
  ChannelType_Wdj,

  /// 百度
  ChannelType_Baidu,
}

class Env {
  /// 项目环境(打包会自动替换)
  static const EnvType envType = EnvType.EnvType_Dev;

  /// 项目请求日志类型(打包会自动替换)
  static const RequestLogLevel requestLogLevel =
      RequestLogLevel.RequestLogLevel_FullLog;

  /// 发布渠道(打包会自动替换)
  static const ChannelType channelType = ChannelType.ChannelType_None;

  /// 获取环境名称
  static String getPackeType() {
    var txt = "";
    switch (Env.envType) {
      case EnvType.EnvType_Dev:
        txt = "开发/测试环境";
        break;
      case EnvType.EnvType_Test:
        txt = "开发/测试环境";
        break;
      case EnvType.EnvType_Pre_Release:
        txt = "仿真环境环境";
        break;
      case EnvType.EnvType_Release:
        txt = "正式环境";
        break;
    }

    return txt;
  }

  /// 获取渠道名称
  static String getChannelName() {
    var channel = "";
    switch (Env.channelType) {
      case ChannelType.ChannelType_None:
        channel = "unknown";
        break;
      case ChannelType.ChannelType_iOS:
        channel = "apple-store";
        break;
      case ChannelType.ChannelType_YingYongBao:
        channel = "android-yyb";
        break;
      case ChannelType.ChannelType_XiaoMi:
        channel = "android-xiaomi";
        break;
      case ChannelType.ChannelType_HuaWei:
        channel = "android-huawei";
        break;
      case ChannelType.ChannelType_Oppo:
        channel = "android-oppo";
        break;
      case ChannelType.ChannelType_Vivo:
        channel = "android-vivo";
        break;
      case ChannelType.ChannelType_Meizu:
        channel = "android-meizu";
        break;
      case ChannelType.ChannelType_Wdj:
        channel = "android-wandoujia";
        break;
      case ChannelType.ChannelType_Baidu:
        channel = "android-baidu";
        break;
    }
    return channel;
  }

  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version; //版本号
    return version;
  }

  static Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber; //版本构建号
    return buildNumber;
  }

  /// 获取设备详细名称
  static Future<String> getDeivceName() async {
    var txt = await DeviceUtil.platformBrand;
    return txt ?? "";
  }
}
