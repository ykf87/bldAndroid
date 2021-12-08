import 'dart:async';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:SDZ/constant/wechat_constant.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/event/show_shared_poster_dialog.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/fluex_share.dart';
import 'package:SDZ/utils/umeng_shared_utils.dart';
import 'package:SDZ/utils/umengshare.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'double_click.dart';

class sharedDialog extends StatefulWidget {
  // final Function(int value) onSelect;
  // late int sharedType;//1:达人主页分享（普通分享） 2：海报分享

  // sharedDialog({Key? key, this.sharedType = 1})
  //     : super(key: key);
  int? accountId;
  int sharedType = 1;//1:达人主页 2：名片
  MyBrowseRecordEntity? talentHomeEntity;
  MyCollectEntity? cardEntity;

  sharedDialog(this.accountId, this.sharedType,
      {this.talentHomeEntity, this.cardEntity});

  @override
  _sharedDialogState createState() => _sharedDialogState();
}

class _sharedDialogState extends State<sharedDialog> {
  String title = '';
  String des = '';
  String thumb = '';
  String path = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.sharedType == UmengSharedUtils.SHARED_TYPE_TALENT_HOME
        ? '我在#真香通告#上发现一个不错的达人，快来看看吧。'
        : '@${widget.cardEntity?.cardName ?? ''}，在#${widget.cardEntity?.getCardTypeName()}#上有${widget.cardEntity?.fansNum}粉丝，赞藏${widget.cardEntity!.likesNum}，快来看看吧。';
    des = widget.sharedType == UmengSharedUtils.SHARED_TYPE_TALENT_HOME
        ? '我在#真香通告#上发现一个不错的达人，快来看看吧。'
        : '@${widget.cardEntity?.cardName ?? ''}，在#${widget.cardEntity?.getCardTypeName()}#上有${widget.cardEntity?.fansNum}粉丝，赞藏${widget.cardEntity!.likesNum}，快来看看吧。';
    thumb = widget.sharedType == UmengSharedUtils.SHARED_TYPE_TALENT_HOME
        ? widget.talentHomeEntity?.avatar ?? ''
        : widget.cardEntity?.cardAvatar ?? '';
    path = widget.sharedType == UmengSharedUtils.SHARED_TYPE_TALENT_HOME
        ? '/packageA/pages/kol-main-page/kol-main-page?id=${widget.accountId}'
        : '/packageA/pages/kol-card-attion-detail-preview/kol-card-attion-detail-preview?id=${widget.cardEntity?.cardId}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.dark_bg_color2,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 30),
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  height: 110,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DoubleClick(
                          onTap: () async{
                            if (widget.accountId == 0) {
                              ToastUtils.toast('数据获取失败，请重试');
                              return;
                            }
                              // 检测是否安装微信
                              var isWeChatInstalled =
                                  await fluwx.isWeChatInstalled;
                              print('微信是否安装：${isWeChatInstalled}');
                              if (!isWeChatInstalled) {
                                ToastUtils.toast('请先安装微信');
                                return;
                              }

                              FluWxShare.shareMiniApp(
                                  WechatConstant.WX_USERNAME,
                                  title,
                                  des,
                                  thumb,
                                  WechatConstant.WX_MINI_PROGRAME_URL,
                                  path);
                              Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(list[0].url, width: 60, height: 60),
                                SizedBox(height: 12),
                                Text(list[0].name)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DoubleClick(
                          onTap: () async{
                            if (widget.accountId == 0) {
                              ToastUtils.toast('数据获取失败，请重试');
                              return;
                            }

                            Navigator.pop(context);
                            EventBusUtils.getInstance().fire(
                                ShowSharedDialogEvent(
                                    widget.talentHomeEntity == null
                                        ? ShowSharedDialogEvent.TALENT_CARD
                                        : ShowSharedDialogEvent.TALENT_HOME));

                          },
                          child:Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(list[1].url, width: 60, height: 60),
                                SizedBox(height: 12),
                                Text(list[1].name)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),


                  // GridView(
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     mainAxisSpacing: 10,
                  //     crossAxisSpacing: 5,
                  //     childAspectRatio: 0.68,
                  //   ),
                  //   children: list.map((item) {
                  //     return DoubleClick(
                  //       onTap: () async {
                  //         if (widget.accountId == 0) {
                  //           ToastUtils.toast('数据获取失败，请重试');
                  //           return;
                  //         }
                  //         if (item.name.contains('微信')) {
                  //           // 检测是否安装微信
                  //           var isWeChatInstalled =
                  //               await fluwx.isWeChatInstalled;
                  //           print('微信是否安装：${isWeChatInstalled}');
                  //           if (!isWeChatInstalled) {
                  //             ToastUtils.toast('请先安装微信');
                  //             return;
                  //           }
                  //
                  //           FluWxShare.shareMiniApp(
                  //               WechatConstant.WX_USERNAME,
                  //               title,
                  //               des,
                  //               thumb,
                  //               WechatConstant.WX_MINI_PROGRAME_URL,
                  //               path);
                  //           Navigator.pop(context);
                  //         } else if (item.name.contains('朋友圈')) {
                  //           // 检测是否安装微信
                  //           var isWeChatInstalled =
                  //               await fluwx.isWeChatInstalled;
                  //           print('微信是否安装：${isWeChatInstalled}');
                  //           if (!isWeChatInstalled) {
                  //             ToastUtils.toast('请先安装微信');
                  //             return;
                  //           }
                  //
                  //           FluWxShare.sharedWeb(
                  //               WeChatScene.TIMELINE,
                  //               title,
                  //               des,
                  //               thumb,
                  //               WechatConstant.WX_MINI_PROGRAME_URL);
                  //           Navigator.pop(context);
                  //         } else if (item.name.contains('海报')) {
                  //           ToastUtils.toast('海报生成中...',
                  //               duration: Duration(milliseconds: 2000));
                  //           Navigator.pop(context);
                  //           new Timer(Duration(seconds: 2), () {
                  //             EventBusUtils.getInstance().fire(
                  //                 ShowSharedDialogEvent(
                  //                     widget.talentHomeEntity == null
                  //                         ? ShowSharedDialogEvent.TALENT_CARD
                  //                         : ShowSharedDialogEvent.TALENT_HOME));
                  //           });
                  //         }
                  //       },
                  //       child: Container(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             SvgPicture.asset(item.url, width: 60, height: 60),
                  //             SizedBox(height: 12),
                  //             Text(item.name)
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 2,
                  width: double.infinity,
                  child: Divider(color: Colours.color_dialog_line),
                ),
                DoubleClick(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      height: 60,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colours.dark_bg_color2,
                      child: Text('取消',
                          style: TextStyle(color: Colors.white, fontSize: 16))),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  _createGridViewItem(Color color) {
    return Container(
      height: 80,
      color: color,
    );
  }

  final List<Item> list = [
    Item('assets/svg/ic_wechat.svg', '微信好友'),
    Item('assets/svg/ic_moments.svg', '分享海报'),
    // Item('assets/svg/ic_poster.svg', '分享海报'),
  ];
}

class Item {
  String url;
  String name;

  Item(this.url, this.name);
}
