import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart';
import 'package:SDZ/constant/plugin_constant.dart';
import 'package:SDZ/env.dart';

class CallWechatUtil {
  static const MethodChannel _channel =
      const MethodChannel(PluginChannel.CALL_WECHAT);

  ///唤起小程序
  static void CallBackWechat({String? path}) {
    launchWeChatMiniProgram(
        username: "gh_dca728b1224c",
        path: path ?? '',
        miniProgramType: getWechatMiniProgramType());
  }

  static WXMiniProgramType getWechatMiniProgramType() {
    if (Env.envType == EnvType.EnvType_Dev) {
      return WXMiniProgramType.PREVIEW;
    } else if (Env.envType == EnvType.EnvType_Test) {
      return WXMiniProgramType.PREVIEW;
    } else if (Env.envType == EnvType.EnvType_Pre_Release) {
      return WXMiniProgramType.RELEASE;
    } else if (Env.envType == EnvType.EnvType_Release) {
      return WXMiniProgramType.RELEASE;
    }

    return WXMiniProgramType.PREVIEW;
  }
}
