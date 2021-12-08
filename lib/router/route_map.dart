import 'package:flutter/material.dart';
import 'package:SDZ/core/widget/web_view_page.dart';
import 'package:SDZ/init/splash.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/login/one_key_login.dart';
import 'package:SDZ/page/menu/about.dart';
import 'package:SDZ/page/login/login.dart';
import 'package:SDZ/page/menu/settings.dart';
import 'package:SDZ/page/menu/sponsor.dart';
import 'package:get/get.dart';
import 'package:SDZ/page/mime/page/config/config_view.dart';
import 'package:SDZ/page/mime/page/pr_visiting_card/view.dart';
import 'package:SDZ/page/shop/page/commit_order/commit_order_page.dart';
import 'package:SDZ/page/shop/page/personal_home_page/view.dart';

class RouteMap {
  ///GetX 页面
  ///搜索
  static final String getSearch = "/search";
  static final String talentPage = "/talent/talentPage";
  static final String talentBusinessCardPage = "/talent/TalentCardDetailPage";
  static final String chatPage = "/chat";
  static final String talentHomePage = "/talent/TalentHomePagePage";
  static final String prPage = "/mime/page/pr_visiting_card/PrVisitingCardPage";
  static final String talentReportPage = "/talent/talentReportPage";


  static List<GetPage> getPages = [
    GetPage(name: '/', page: () => SplashPage()),
//    GetPage(name: '/', page: () => TalentReportPage()),
    // GetPage(name: '/', page: () => ConversationPage()),
    // GetPage(name: '/', page: () => MainHomePage()),//暂时先直接进入主页面
    GetPage(name: '/configPage', page: () => ConfigPage()),//测试页面
    GetPage(name: '/login', page: () => OneKeyLoginPage()),
    GetPage(name: '/home', page: () => MainHomePage()),
    GetPage(name: '/web', page: () => WebViewPage()),
    GetPage(name: '/menu/sponsor-page', page: () => SponsorPage()),
    GetPage(name: '/menu/settings-page', page: () => SettingsPage()),
    GetPage(name: '/menu/about-page', page: () => AboutPage()),
    GetPage(name: '/shop/page/commit_order/commit_order_page', page: () => CommitOrderPage()),
  ];

  /// 页面切换动画
  static Widget getTransitions(
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
              //1.0为右进右出，-1.0为左进左出
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }
}
