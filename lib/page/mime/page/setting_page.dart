import 'dart:io';

import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/event.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/exit_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/user_entity.dart';
import 'package:SDZ/env.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/mime/page/about_page.dart';
import 'package:SDZ/page/mime/page/account_safe/view.dart';
import 'package:SDZ/page/mime/page/feed_back/view.dart';
import 'package:SDZ/page/mime/widget/line_text_widget.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/clear_cache_utils.dart';
import 'package:SDZ/utils/jpush_util.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/widget/double_click.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with WidgetsBindingObserver {
  late String headUrl;
  String cacheSize = '';
  bool flag = false;
  bool isNotificationEnable = false;

  String version = '';
  String number = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    headUrl = SPUtils.getAvatar();
    getCacheSize();
    getNotification();
    getPlatformInfo();
  }

  getPlatformInfo() async {
    version = await Env.getVersion();
    number = await Env.getVersionNumber();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('设置',
              style: TextStyle(color: Colours.text_121212, fontSize: 20)),
          leading: IconButton(
            color: Colors.black,
            tooltip: null,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_outlined),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          elevation: 0,
        ),
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              LineTextWidget(
                                  leftImg: 'ic_protocol.svg',
                                  bgColor: Colours.bg_ffffff,
                                  leftText: '用户协议',
                                  rightText: '',
                                  onPressed: () {
                                    Get.to(() => PrivacyPolicyPage(false));
                                  }),
                              LineTextWidget(
                                  leftImg: 'ic_protocol.svg',
                                  bgColor: Colours.bg_ffffff,
                                  leftText: '隐私政策',
                                  rightText: '',
                                  onPressed: () {
                                    Get.to(() => PrivacyPolicyPage(true));
                                  }),
                              LineTextWidget(
                                  leftImg: 'ic_clear.svg',
                                  bgColor: Colours.bg_ffffff,
                                  leftText: '清除缓存',
                                  rightText: cacheSize,
                                  onPressed: () {
                                    showDialog<void>(
                                        context: context,
                                        builder: (_) => ExitDialog(
                                            onPressed: () {
                                              ClearCacheUtils.clearCache();
                                              setState(() {
                                                cacheSize = '0.00B';
                                              });
                                            },
                                            content: '您确定要清除缓存吗'));
                                  }),
                              LineTextWidget(
                                  leftImg: 'ic_about_us.svg',
                                  bgColor: Colours.bg_ffffff,
                                  leftText: '关于我们',
                                  rightText: '',
                                  onPressed: () {
                                    Get.to(AboutWeFreePage());
                                  }),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SPUtils.isLogined()
                  ?
              Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            DoubleClick(
                              onTap: () {
                                showDialog<void>(
                                    context: context,
                                    builder: (_) => ExitDialog(
                                        onPressed: () {
                                          // logout();
                                          LoginUtil.logout();
                                        },
                                        content: '确认退出当前账号？'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colours.color_FF193C,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                height: 45,
                                margin: EdgeInsets.only(
                                    left: 12, right: 12, top: 20, bottom: 40),
                                child: Center(
                                  child: Text(
                                    '退出登录',
                                    style: TextStyle(
                                        color: Colours.bg_ffffff, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        getNotification();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  ///退出登录
  void logout() {
    ApiClient.instance.delete(ApiUrl.getBLDBaseUrl()+ApiUrl.logout, onSuccess: (data) {
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        LoginUtil.logout();
      }
    });
  }

  void getCacheSize() async {
    cacheSize = (await ClearCacheUtils.loadCache())!;
    setState(() {});
  }

  void getNotification() async {
    isNotificationEnable = (await JPushUtil.instance.isNotificationEnabled());
    setState(() {});
  }
}
