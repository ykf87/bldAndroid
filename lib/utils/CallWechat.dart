import 'package:SDZ/constant/wechat_constant.dart';
import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart';
import 'package:SDZ/constant/plugin_constant.dart';
import 'package:SDZ/env.dart';

class CallWechatUtil {
  static const MethodChannel _channel =
      const MethodChannel(PluginChannel.CALL_WECHAT);

  ///唤起小程序
  static void CallBackWechat({String? path,String? appId}) {
    //分享微信
    registerWxApi(
        appId: appId??'',
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: WechatConstant.UNIVERSAL_LINK).then((value) =>launchWeChatMiniProgram(
        username: "gh_dca728b1224c",
        path: path ?? '',
        miniProgramType:WXMiniProgramType.RELEASE));

  }

  static WXMiniProgramType getWechatMiniProgramType() {
    return WXMiniProgramType.RELEASE;
  }
}
