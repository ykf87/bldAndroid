import 'package:flutter/foundation.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:SDZ/constant/third_key.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/26 11:39
/// @Description: 极光推送工具类
class JPushUtil {
  factory JPushUtil() => getInstance();
  static JPushUtil get instance => getInstance();

  static JPushUtil? _instance;

  JPush? _jPush;

  static JPushUtil getInstance() {
    if(_instance == null) {
      _instance = JPushUtil._internal();
    }
    return _instance!;
  }

  JPushUtil._internal() {
    if(_jPush == null) {
      _jPush = new JPush();
    }
  }

  JPush getJPush() {
    return _jPush!;
  }

  /// 推送初始化
  JPushUtil init() {
    if(_jPush != null) {
      _jPush!.setup(appKey: ThirdKey.JPUSH_ANDROID_KEY, channel: 'developer-default', production: true, debug: kDebugMode);
    }
    return this;
  }

  /// 获取 registrationId
  JPushUtil getRegistrationID(Function fun) {
    if(_jPush != null) {
      _jPush!.getRegistrationID().then((value) {
        fun.call(value);
      });
    }
    return this;
  }

  /// 停止推送
  void stopPush() {
    if(_jPush != null) {
      _jPush!.stopPush();
    }
  }

  /// 恢复推送
  void resumePush() {
    if(_jPush != null) {
      _jPush!.resumePush();
    }
  }

  /// 设置别名 一个 App应用只有一个别名
  /// alias 别名
  /// fun 回调
  JPushUtil setAlias(String alias, {Function? fun}) {
    if(_jPush != null) {
      _jPush!.setAlias(alias).then((value) {
        fun?.call(value);
      });
    }
    return this;
  }

  /// 删除别名
  /// fun 回调
  JPushUtil deleteAlias({Function? fun}) {
    if(_jPush != null) {
      _jPush!.deleteAlias().then((value) {
        fun?.call(value);
      });
    }
    return this;
  }

  /// 添加tags
  /// tags
  /// fun 回调
  JPushUtil addTags(List<String> tags, {Function? fun}) {
    if(_jPush != null) {
      _jPush!.addTags(tags).then((value) {
        fun?.call(value);
      });
    }
    return this;
  }

  /// 重置tags
  /// tags
  /// fun 回调
  JPushUtil setTags(List<String> tags, {Function? fun}) {
    if(_jPush != null) {
      _jPush!.setTags(tags).then((value) {
        fun?.call(value);
      });
    }
    return this;
  }

  /// 删除tags
  /// tags
  /// fun 回调
  JPushUtil deleteTags(List<String> tags, {Function? fun}) {
    if(_jPush != null) {
      _jPush!.deleteTags(tags).then((value) {
        fun?.call(value);
      });
    }
    return this;
  }

  /// 清空所有tags
  void clearTags() {
    if(_jPush != null) {
      _jPush!.cleanTags().then((value) {});
    }
  }

  /// 获取当前tags
  JPushUtil getTags(Function fun) {
    if(_jPush != null) {
      _jPush!.getAllTags().then((value) {
        fun.call(value);
      });
    }
    return this;
  }

  /// 通知是否开启
  Future<bool> isNotificationEnabled() async {
    if(_jPush != null) {
      return _jPush!.isNotificationEnabled();
    }
    return false;
  }

  /// 打开通知设置页面
  void openSettingNotification() {
    if(_jPush != null) {
      _jPush!.openSettingsForNotification();
    }
  }
}