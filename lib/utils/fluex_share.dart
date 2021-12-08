import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart';
import 'package:SDZ/utils/wf_log_util.dart';



///集成U盟分享SDK (2021.09.16  小程序，web，图片分享改用fluex)
class FluWxShare {
  FluWxShare._();


  /// 分享图片
  ///
  /// @platform 分享平台
  ///
  /// @thumb 缩略图或图标 注：图片链接或本地图片路径
  ///
  /// @desc 分享的图片 注：图片链接或本地图片路径
  ///
  /// 返回参数说明 um_status : SUCCESS 成功 ERROR 失败 CANCEL 用户取消
  static Future<dynamic> shareImage(
      WeChatScene platform, String thumb, String image) async {
    // Map<dynamic,dynamic> result = await _channel.invokeMethod('shareImage',{'platform':platform.index,"thumb":thumb,"image":image});
    // return result;
    shareToWeChat(WeChatShareImageModel(
      WeChatImage.network(image),
      thumbnail: WeChatImage.network(image),
      scene: platform,
    ));
  }


  static void sharedWeb( WeChatScene platform,
      String title,
      String desc,
      String thumb,
      String link){
    WFLogUtil.d('title${title}');
    WFLogUtil.d('desc${desc}');
    WFLogUtil.d('thumb${thumb}');
    WFLogUtil.d('link${link}');
    title =  title.replaceAll('真香通告', 'Wefree');
    desc =  desc.replaceAll('真香通告', 'Wefree');
    var model = WeChatShareWebPageModel(
      link,
      title: title,
      thumbnail: WeChatImage.network(thumb),
      scene:platform,
    );
    shareToWeChat(model);
  }

  /// 分享小程序（只能分享给微信好友）
  ///
  /// @username 小程序id 如：gh_d43f693ca31f
  ///
  /// @title 标题
  ///
  /// @desc 分享描述文本
  ///
  /// @thumb 小程序消息封面图片，小于128k 注：图片链接或本地图片路径
  ///
  /// @url 兼容低版本的网页链接
  ///
  /// @path 小程序页面路径 如：/pages/media
  ///
  /// 注：当分享为图片类型的时候可以是图片链接或本地图片路径
  ///
  /// 返回参数说明 um_status : SUCCESS 成功 ERROR 失败 CANCEL 用户取消
  static Future<dynamic> shareMiniApp(String username, String title,
      String desc, String thumb, String url, String path) async {
    var model = WeChatShareMiniProgramModel(
        webPageUrl: url,
        userName: username,
        title: title,
        description: desc,
        thumbnail: WeChatImage.network(thumb),
        path: path);
    shareToWeChat(model);
  }

}
