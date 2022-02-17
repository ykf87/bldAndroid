import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:SDZ/page/home/tab_home.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/core/utils/click.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/index_logic.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/utils/provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:SDZ/utils/sputils.dart';
import 'mime/page/tab_my/view.dart';
import 'mime/page/tab_task/task/view.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with WidgetsBindingObserver {
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<LoginEvent>? _bus;

  var _currentIndex = 0; //当前选中页面索引

  // 页面列表
  final List<Widget> _pages = [
    // const IndexHome(),
    // IndexHomeV2(),
    TabHomePage(),
    AdTaskPage(),
    // JiujiuIndexHome(scrollController: jiujiuController),
    // const CategoryIndexPage(),
    // FavoriteIndexHome(),
    // const DynamicIndex(),
    TabMyPage()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      CSJUtils.showInterstitialAd();
    });

    this.initData();
  }

  initData() async {
    await initDeviceId();
    changeTab();
  }

  // 获取deviceid
  static Future<void> initDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      WFLogUtil.d('1>>>>>>>>>${iosInfo.identifierForVendor}');
      WFLogUtil.d(
          '1>>>>>>>>>${iosInfo.identifierForVendor.runtimeType.toString()}');
      await SPUtils.setDeviceId(iosInfo.identifierForVendor ?? '');
      var a = SPUtils.getDeviceId();
      WFLogUtil.d('2>>>>>>>>>${a}');
      if (a == '') {
        var rng = new Random(); //随机数生成类
        var rng_time = rng.nextInt(100);
        var time = DateTime.now().millisecondsSinceEpoch + rng_time;
        var timetmp = 'FAKE_DEVICE_ID_${time}';
        await SPUtils.setDeviceId(timetmp);
      }
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      WFLogUtil.d('1>>>>>>>>>${androidInfo.androidId}');
      WFLogUtil.d('1>>>>>>>>>${androidInfo.androidId.runtimeType.toString()}');
      await SPUtils.setDeviceId(androidInfo.androidId ?? '');
      var a = SPUtils.getDeviceId();
      if (a == '') {
        var rng = new Random(); //随机数生成类
        var rng_time = rng.nextInt(100);
        var time = DateTime.now().millisecondsSinceEpoch + rng_time;
        var timetmp = 'FAKE_DEVICE_ID_${time}';
        await SPUtils.setDeviceId(timetmp);
      }
    }
  }

  @override
  void dispose() {
    // Get.find<NoticeRedLogic>().cancelLoop();
    WidgetsBinding.instance?.removeObserver(this);
    _bus?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {

      /// 在前台
      case AppLifecycleState.inactive:
        {
          WFLogUtil.d('在前台');
        }
        break;

      /// 后台切前台
      case AppLifecycleState.resumed:
        {
          WFLogUtil.d('后台切前台');
        }
        break;

      /// 前台切后台
      case AppLifecycleState.paused:
        {
          Utils.setAppBackgroundTime();
          WFLogUtil.d('前台切后台');
        }
        break;

      /// APP结束
      case AppLifecycleState.detached:
        {
          WFLogUtil.d('APP结束');
        }
        break;
    }
  }

  @override
  Future<bool> didPushRoute(String route) {
    WFLogUtil.d('didPushRoute ' + route);
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    WFLogUtil.d('didPopRoute ');
    return super.didPopRoute();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    const kNavIconSize = 18.0;
    return GetBuilder<IndexLogic>(builder: (logic) {
      return Consumer(
          builder: (BuildContext context, AppStatus status, Widget? child) {
        return WillPopScope(
            child: SafeArea(
              top: false,
              child: Scaffold(
                key: _scaffoldKey,
                bottomNavigationBar: BottomNavigationBar(
                    selectedItemColor: Colours.color_main_red,
                    type: BottomNavigationBarType.fixed,
                    //当前页面索引
                    currentIndex: _currentIndex,
                    //按下后设置当前页面索引
                    onTap: ((index) {
                      if (index == 1 && !LoginUtil.isLogin()) {
                        LoginUtil.toLogin();
                        return;
                      }
                      setState(() {
                        _currentIndex = index;
                        if (index == 2) {
                          SystemChrome.setSystemUIOverlayStyle(
                              const SystemUiOverlayStyle(
                                  statusBarColor: Colors.transparent,
                                  statusBarIconBrightness: Brightness.dark));
                        } else {
                          SystemChrome.setSystemUIOverlayStyle(
                              const SystemUiOverlayStyle(
                                  statusBarColor: Colors.white,
                                  statusBarIconBrightness: Brightness.dark));
                        }
                      });
                    }),
                    items: [
                      BottomNavigationBarItem(
                          label: '首页',
                          icon: _currentIndex == 0
                              ? Image.asset(
                                  'assets/nav/home.png',
                                  width: kNavIconSize,
                                  height: kNavIconSize,
                                )
                              : Image.asset(
                                  'assets/nav/home-n.png',
                                  height: kNavIconSize,
                                  width: kNavIconSize,
                                )),
                      // BottomNavigationBarItem(
                      //     label: '9.9包邮',
                      //     icon: _currentIndex == 1
                      //         ? Image.asset(
                      //       'assets/nav/jiujiu.png',
                      //       width: kNavIconSize,
                      //       height: kNavIconSize,
                      //     )
                      //         : Image.asset(
                      //       'assets/nav/jiujiu-n.png',
                      //       height: kNavIconSize,
                      //       width: kNavIconSize,
                      //     )),
                     BottomNavigationBarItem(
                          label: '福利',
                          icon: _currentIndex == 1
                              ? Image.asset(
                                  'assets/nav/fenlei.png',
                                  width: kNavIconSize,
                                  height: kNavIconSize,
                                )
                              : Image.asset(
                                  'assets/nav/fenlei-n.png',
                                  height: kNavIconSize,
                                  width: kNavIconSize,
                                )),
                      BottomNavigationBarItem(
                          label: '我的',
                          icon: _currentIndex == 2
                              ? Image.asset(
                                  'assets/nav/my.png',
                                  width: kNavIconSize,
                                  height: kNavIconSize,
                                )
                              : Image.asset(
                                  'assets/nav/my-n.png',
                                  height: kNavIconSize,
                                  width: kNavIconSize,
                                )),
                    ]),
                body: IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                ),
                // body: Stack(
                //   children: [
                //     Container(
                //       margin:
                //           EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                //       // height: height - kBottomNavigationBarHeight,
                //       child: IndexedStack(
                //         index: state.curTabIndex,
                //         children: getTabWidget(context),
                //       ),
                //     ),
                //     Positioned(
                //         bottom: 0,
                //         left: 0,
                //         right: 0,
                //         child: Container(
                //           color: Colours.bg_ffffff,
                //           height: 44,
                //           child: Row(
                //             children: [
                //               bottomTabWidget(0, '首页'),
                //               bottomTabWidget(1, '我的'),
                //             ],
                //           ),
                //         )),
                //     Positioned(
                //         bottom: -20,
                //         left: 0,
                //         right: 0,
                //         child: Container(
                //           color: Colours.bg_ffffff,
                //           height: 1,
                //         ))
                //   ],
                // ),
              ),
            ),
            //监听导航栏返回,类似onKeyEvent
            onWillPop: () =>
                ClickUtils.exitBy2Click(status: _scaffoldKey.currentState));
      });
    });
  }

  void changeTab() {}

  Widget bottomTabWidget(int index, String title) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        state.curTabIndex = index;
        logic.tabChange(state.curTabIndex);
        setState(() {});
        WFLogUtil.d('切换tab==$state.curTabIndex');
      },
      child: Container(
        color: Colours.bg_ffffff,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                title,
                style: TextStyle(
                    color: index == state.curTabIndex
                        ? Colours.color_main_red
                        : Colours.text_main,
                    fontSize: 18),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Visibility(
                    visible: state.curTabIndex == index,
                    child: Container(
                      width: 20,
                      height: 5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3.0),
                          ),
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
                    )))
          ],
        ),
      ),
    ));
  }
}
