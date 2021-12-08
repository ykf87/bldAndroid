import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/CallWechat.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'logic.dart';
import 'state.dart';

///发通告
class PublishAnnouncementPage extends StatelessWidget {
  final Publish_announcementLogic logic = Get.put(Publish_announcementLogic());
  final Publish_announcementState state =
      Get.find<Publish_announcementLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(Utils.getSvgUrl('ic_close_publish.svg'),width: 20,height: 20,),
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/bg_punlish_mask.png"))),
        child: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset(
                Utils.getSvgUrl('ic_publish_right.svg'),
                width: 160,
                height: 190,
              ),
              right: 0,
              top: 87,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Utils.getSvgUrl('ic_logo_wefree.svg'),
                          width: 51, height: 20),
                      SizedBox(width: 8),
                      SvgPicture.asset(Utils.getSvgUrl('ic_close.svg'),
                          width: 12, height: 12),
                      SizedBox(width: 8),
                      SvgPicture.asset(Utils.getSvgUrl('ic_text_zhenxiang.svg'),
                          width: 32, height: 17),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  SvgPicture.asset(Utils.getSvgUrl('ic_word.svg'),
                      width: 290, height: 115),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Utils.getSvgUrl('ic_dot.svg'),width: 7,height: 7,color: Colours.text_afb3c3,),
                      SizedBox(width: 12,),
                      Text(
                        '10W+全平台达人资源',
                        style: TextStyle(fontSize: 14, color: Colours.text_afb3c3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Utils.getSvgUrl('ic_dot.svg'),width: 7,height: 7,color: Colours.text_afb3c3,),
                      SizedBox(width: 12,),
                      Text(
                        '品牌宣传，网红单品打造',
                        style: TextStyle(fontSize: 14, color: Colours.text_afb3c3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Utils.getSvgUrl('ic_dot.svg'),width: 7,height: 7,color: Colours.text_afb3c3,),
                      SizedBox(width: 12,),
                      Text(
                        '达人报名快，对接更高效',
                        style: TextStyle(fontSize: 14, color: Colours.text_afb3c3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Utils.getSvgUrl('ic_dot.svg'),width: 7,height: 7,color: Colours.text_afb3c3,),
                      SizedBox(width: 12,),
                      Text(
                        '自动读取数据，在线批量结款',
                        style: TextStyle(fontSize: 14, color: Colours.text_afb3c3),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                left: 42,
                right: 42,
                bottom: 40,
                child: DoubleClick(
                  onTap: () async{
                    var isWeChatInstalled =
                        await fluwx.isWeChatInstalled;
                    if (!isWeChatInstalled) {
                      ToastUtils.toast('请先安装微信');
                      return;
                    }

                    CallWechatUtil.CallBackWechat();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 48,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(24.0)),
                        gradient: LinearGradient(
                            //渐变位置
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              0.0,
                              1.0
                            ],
                            colors: [
                              Colours.color_main_red,
                              Colours.bg_pr_start,
                            ])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Utils.getSvgUrl('ic_applets.svg'),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 6,),
                        Text(
                          '商家推广、达人接单',
                          style: TextStyle(fontSize: 16, color: Colours.bg_ffffff),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
