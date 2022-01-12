
import 'dart:io';

import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/custom_route.dart';
import 'package:SDZ/widget/text_image_button.dart';
import 'package:get/get.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/18 10:06
/// @Description: 协议弹窗
class AgreementDialog extends BaseDialog {

  final Function? onTap;

  AgreementDialog({Key? key, this.onTap});

  @override
  getState() => _AgreementDialogState();
}

class _AgreementDialogState extends BaseDialogState<AgreementDialog> {

  @override
  double radius() => 12.0;

  @override
  Color color() => Colours.color_181A23;

  @override
  double maxWidth() => MediaQuery.of(context).size.width * 0.9;

  @override
  Widget initBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset(SvgPath.img_default_page, width: 162,),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Center(
              child: Text('欢迎使用省得赚 APP', style: TextStyle(fontSize: 24, color: Colors.white),),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 12.0, color: Colors.white, height: 1.5) ,
                      text: '       我们非常重视保护您的个人信息和隐私安全，请您认真阅读并理解',
                      children: [
                        TextSpan(
                          style: TextStyle(fontSize: 12.0, color: Colours.color_FF1F35, height: 1.5) ,
                          text: '《用户协议》',
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Get.to(WebViewPage(url: ApiUrl.agreement_url));
                            Get.to(() => PrivacyPolicyPage(false));
                          },
                        ),
                        TextSpan(
                          style: TextStyle(fontSize: 12.0, color: Colors.white, height: 1.5) ,
                          text: '和',
                        ),
                        TextSpan(
                          style: TextStyle(fontSize: 12.0, color: Colours.color_FF1F35, height: 1.5) ,
                          text: '《隐私政策》',
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Get.to(()=>WebViewPage(url: ApiUrl.policy_url));
                            Get.to(() => PrivacyPolicyPage(true));
                          },
                        ),
                        TextSpan(
                          style: TextStyle(fontSize: 12.0, color: Colors.white, height: 1.5) ,
                          text: '，以了解我们是如何规范地收集和使用您的个人信息。',
                        ),
                      ]
                  ),
                ),
                Text('       为了提供更优质的服务，在使用应用的过程中，部分功能需要您开启以下权限：', style: TextStyle(fontSize: 12.0, color: Colors.white, height: 1.5))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: TextImageButton(
              iconType: 3,
              svgPath: SvgPath.ic_phone,
              size: const Size(16, 16),
              text: '设备信息',
              textStyle: TextStyle(color: Colors.white, fontSize: 16),
              margin: 8,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 24),
            child: Text('用于标识您的身份，保障您正常使用我们的服务及您的账号安全。', style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12, height: 1.5),),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: TextImageButton(
              iconType: 3,
              svgPath: SvgPath.ic_storage,
              size: const Size(16, 16),
              text: '存储权限',
              textStyle: TextStyle(color: Colors.white, fontSize: 16),
              margin: 8,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 24),
            child: Text('用于您的信息完善、缓存图片、视频、降低流量消耗。', style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12, height: 1.5),),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Text('点击【同意】即表示您已阅读并同意前述协议及约定。', style: TextStyle(color: Colors.white, fontSize: 12),),
          ),
          Container(
            margin: const EdgeInsets.only(top: 28),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 44,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    22))),
                        backgroundColor:MaterialStateProperty.all(
                            Colors.white),
                      ),
                      child: Text('不同意',style: TextStyle(fontSize: 16, color: Colours.text_121212),),
                      onPressed: (){
                        Navigator.of(context).pop();
                        widget.onTap?.call(0);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 44,
                    child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      22))),
                          backgroundColor:MaterialStateProperty.all(
                              Colours.color_FF1F35),
                      ),
                      child: Text('同意',style: TextStyle(fontSize: 16, color: Colors.white),),
                      onPressed: (){
                        Navigator.of(context).pop();
                        widget.onTap?.call(1);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}