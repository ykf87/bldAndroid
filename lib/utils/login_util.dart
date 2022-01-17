import 'dart:ffi';

import 'package:get/get.dart';
import 'package:SDZ/core/utils/event.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/login/login.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/one_key_login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/31 16:59
/// @Description: 登录工具类
class LoginUtil {

  static dynamic _getArguments({bool toMain = false, bool isMessageTab = false}) => {'tomain': toMain, 'isMessageTab': isMessageTab};

  /// 是否登录
  static bool isLogin() {
    return SPUtils.isLogined();
  }

  /// 跳转登录
  static void toLogin({bool toMain = false, bool isMessageTab = false}) {
    if(OneKeyLoginUtil.instance.getPhoneSuccess()) {
      Get.toNamed('/login', arguments: _getArguments(toMain: toMain, isMessageTab: isMessageTab));
    }else{
      Get.to(LoginPage(isMessageTab: isMessageTab), arguments: _getArguments(toMain: toMain));
    }
  }

  /// 跳转登录
  /// 删除之前所有页面
  static void offLogin({bool toMain = false}) {
    if(OneKeyLoginUtil.instance.getPhoneSuccess()) {
      Get.offAllNamed('/login', arguments: _getArguments(toMain: toMain));
    }else{
      Get.offAll(() => LoginPage(), arguments: _getArguments(toMain: toMain));
    }
  }

  ///退出登录
  static void logout(){
    UmengUtil.onProfileSignOff();
    SPUtils.setUserId('');
    // SPUtils.setUserAccount('');
    SPUtils.setUserToken('');
    SPUtils.setUserNickName('');
    SPUtils.setAvatar('');
    Get.offAll(() => MainHomePage());
    print("--------发送LOGIN_TYPE_LOGINOUT事件-------------");
    // XEvent.post(
    //     '退出登录', new LoginEvent(LoginEvent.LOGIN_TYPE_LOGINOUT));
    EventBusUtils.getInstance()
        .fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGINOUT));
  }

  /// 互提下线
  static void tokenLoginOut() {
    UmengUtil.onProfileSignOff();
    SPUtils.setUserId('');
    SPUtils.setUserToken('');
    SPUtils.setUserNickName('');
    SPUtils.setAvatar('');
    EventBusUtils.getInstance()
        .fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGINOUT));
    toLogin();
  }
}