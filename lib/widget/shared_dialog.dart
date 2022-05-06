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
import 'package:SDZ/utils/shared_utils.dart';
import 'package:SDZ/utils/umengshare.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'double_click.dart';

class sharedDialog extends StatefulWidget {

  sharedDialog();

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
    title = 'https://zhuanlan.zhihu.com/p/454111586';
    des = 'https://zhuanlan.zhihu.com/p/454111586';
    thumb = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1113%2F052420110515%2F200524110515-2-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1653727250&t=9fedeb28dd84b94c81b3e8913cdb6338';
    path = 'https://zhuanlan.zhihu.com/p/454111586';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.bg_ffffff,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 10),
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
                              // 检测是否安装微信
                              var isWeChatInstalled =
                                  await fluwx.isWeChatInstalled;
                              print('微信是否安装：${isWeChatInstalled}');
                              if (!isWeChatInstalled) {
                                ToastUtils.toast('请先安装微信');
                                return;
                              }
                              FluWxShare.sharedWeb(
                                  WeChatScene.FAVORITE,
                                  title,
                                  des,
                                  thumb,
                                  path);
                              Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(list[0].url, width: 60, height: 60),
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

                          },
                          child:Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(list[1].url, width: 60, height: 60),
                                SizedBox(height: 12),
                                Text(list[1].name)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // SizedBox(
                //   height: 2,
                //   width: double.infinity,
                //   child: Divider(color: Colours.color_dialog_line),
                // ),
                DoubleClick(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      height: 60,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colours.bg_ffffff,
                      child: Text('取消',
                          style: TextStyle(color: Colours.color_333333, fontSize: 16))),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  final List<Item> list = [
    Item('assets/images/ic_wechat.png', '微信好友'),
    Item('assets/images/ic_wechat_moment.png', '分享海报'),
    // Item('assets/svg/ic_poster.svg', '分享海报'),
  ];
}

class Item {
  String url;
  String name;

  Item(this.url, this.name);
}
