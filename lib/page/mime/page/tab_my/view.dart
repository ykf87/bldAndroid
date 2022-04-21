import 'package:SDZ/page/login/new_login_page.dart';
import 'package:SDZ/page/mime/page/about_page.dart';
import 'package:SDZ/page/mime/page/feed_back/view.dart';
import 'package:SDZ/page/mime/page/my_order/view.dart';
import 'package:SDZ/page/mime/page/my_wallet/view.dart';
import 'package:SDZ/page/signModule/lottery/lottery/view.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/widget/clipper_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/view/ad_banner_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/widget/double_click.dart';

import '../setting_page.dart';
import 'logic.dart';
import 'state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:SDZ/page/mime/page/setting_page.dart';
import 'package:SDZ/page/mime/widget/line_text_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/login_util.dart';

class TabMyPage extends StatefulWidget {
  @override
  _TabMyPageState createState() => _TabMyPageState();
}

class _TabMyPageState extends State<TabMyPage> {
  final Tab_myLogic logic = Get.put(Tab_myLogic());
  final Tab_myState state = Get.find<Tab_myLogic>().state;
  int clickCount = 0;
  int lastTime = 0;

  @override
  void initState() {
    super.initState();
    logic.getData();
    logic.initEvent();
    state.isLogin = SPUtils.isLogined();
  }

  @override
  void dispose() {
    super.dispose();
    state.loginEventBus?.cancel();
    state.userCenterEventBus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return GetBuilder<Tab_myLogic>(
      init: Tab_myLogic(),
      builder: (logic) {
        return Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: new Stack(
              children: <Widget>[
                Container(
                  child: ClipPath(
                    clipper: SignClipper(),
                    child: Container(
                      height: Adaptor.height(240),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colours.color_login_77A7EF,
                          Colours.color_login_77A7EF,
                        ]),
                      ),
                      child: null,
                    ),
                  ),
                ),
                Container(
                  child: new ListView(
                    children: <Widget>[
                      getPersonInfoWidget(context),
                      // topMenuWidget(),
                      // orderWidget,
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.only(right: 16, left: 16),
                        child: Column(
                          children: [
                            LineTextWidget(
                              leftText: '我的订单',
                              isRadius: true,
                              bgColor: Colours.bg_ffffff,
                              leftImg: "ic_order.png",
                              onPressed: () {
                                if (!LoginUtil.isLogin()) {
                                  LoginUtil.toLogin();
                                  return;
                                }
                                Get.to(MyOrderPage());
                                // Get.to(NewLoginPage());
                              },
                            ),
                            LineTextWidget(
                              leftText: '我的钱包',
                              isRadius: true,
                              bgColor: Colours.bg_ffffff,
                              leftImg: "account_balance.png",
                              onPressed: () {
                                if (!LoginUtil.isLogin()) {
                                  LoginUtil.toLogin();
                                  return;
                                }
                                Get.to(MyWalletPage());
                              },
                            ),
                            LineTextWidget(
                              leftText: '关于我们',
                              bgColor: Colours.bg_ffffff,
                              leftImg: "ic_about.svg",
                              onPressed: () {
                                Get.to(AboutWeFreePage());
                              },
                            ),
                            LineTextWidget(
                              leftText: '意见反馈',
                              bgColor: Colours.bg_ffffff,
                              leftImg: "my_points.png",
                              onPressed: () {
                                Get.to(FeedBackPage());
                              },
                            ),
                            LineTextWidget(
                              leftText: '设置',
                              bgColor: Colours.bg_ffffff,
                              leftImg: "ic_setting.svg",
                              onPressed: () {
                                Get.to(SettingPage());
                              },
                            ),
                          ],
                        ),
                      ),
                      SPUtils.getAdShow()
                          ? Container(
                              margin: EdgeInsets.only(top: 16),
                              child: SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: AdBannerWidget(
                                  posId: CSJUtils.CSJBannerId,
                                  width: 1300,
                                  height: 150,
                                  interval: 30,
                                  show: true,
                                ),
                              ),
                            )
                          : Container(),
                      // LineTextWidget(leftText: '常用功能',bgColor: Colours.bg_ffffff,leftImg:"my_points.png",),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ///顶部个人信息
  getPersonInfoWidget(context) {
    return new Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        //color: Colors.white,
        child: new InkWell(
          onTap: () {},
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 30.0, bottom: 30.0),
                  child: !SPUtils.isLogined()
                      ? new Image.asset(
                          "assets/images/default.png",
                          width: 60.0,
                          height: 60.0,
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage: ImageUtils.getImageProvider(
                              state.userCenterEntity.avatar ?? ""),
                        )),
              SPUtils.isLogined()
                  ? new Stack(children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text(
                            '欢迎您',
                            style: new TextStyle(
                                fontSize: 20.0, color: const Color(0xFFffffff)),
                          )),
                      new Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 29.0),
                          child: new Text('',
                              style: new TextStyle(
                                  fontSize: 12.0,
                                  color: const Color(0xFFffffff)))),
                      new Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 40.0),
                          child: new Text(
                              SPUtils.isLogined()
                                  ? state.userCenterEntity.phone?.replaceFirst(
                                          new RegExp(r'\d{4}'), '****', 3) ??
                                      ''
                                  : '',
                              style: new TextStyle(
                                  fontSize: 12.0,
                                  color: const Color(0xFFffffff)))),
                    ])
                  : DoubleClick(
                      onTap: () {
                        LoginUtil.toLogin();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text(
                          "点此登录",
                          style: new TextStyle(
                              fontSize: 20.0, color: const Color(0xFFffffff)),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }

  /// 上图下文样式
  Widget _menuWidget(String title, String icon) {
    return Container(
      child: Column(
        children: [
          icon.endsWith('.svg')
              ? SvgPicture.asset(
                  "assets/svg/${icon}",
                )
              : new Image.asset(
                  "assets/images/${icon}",
                  width: 25.0,
                  height: 25.0,
                ),
          SizedBox(
            height: 6,
          ),
          Text(title,
              style: TextStyle(color: Colours.text_121212, fontSize: 14)),
        ],
      ),
    );
  }

  Widget topMenuWidget() {
    return Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        color: Colors.white,
        child: new Row(
          //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 1,
                child: new GestureDetector(
                  onTap: () {},
                  child: _menuWidget("会员卡", "vip.png"),
                )),
            Expanded(
                flex: 1,
                child: new GestureDetector(
                  onTap: () {},
                  child: _menuWidget("优惠券", "coupon.png"),
                )),
            Expanded(
                flex: 1,
                child: new GestureDetector(
                  onTap: () {},
                  child: _menuWidget("购物车", "shopping_cart.png"),
                )),
            Expanded(
                flex: 1,
                child: new GestureDetector(
                  onTap: () {},
                  child: _menuWidget("收藏", "my_collect.png"),
                )),
          ],
        ));
  }

  Widget orderWidget = new Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      child: new Column(
          //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 15.0, left: 15.0),
                        child: new Text(
                          "我的订单",
                          style: new TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: const Color(0xFF333333)),
                        )),
                  ],
                ),
                new GestureDetector(
                    onTap: () {},
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 15.0),
                            child: new Text(
                              "查看全部订单",
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF333333)),
                            )),
                        new Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0, left: 10.0, bottom: 15.0),
                            child: new Image.asset("assets/images/ic_next.png",
                                width: 20.0,
                                color: Colours.color_black45,
                                height: 20.0)),
                      ],
                    ))
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: new GestureDetector(
                        onTap: () {},
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: new Image.asset(
                                    "assets/images/wallet.png",
                                    width: 30.0,
                                    height: 30.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: new Text(
                                    "待付款",
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: const Color(0xFF333333)),
                                  )),
                            ]))),
                Expanded(
                    flex: 1,
                    child: new GestureDetector(
                        onTap: () {},
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: new Image.asset(
                                    "assets/images/daifahuo_icon.png",
                                    width: 30.0,
                                    height: 30.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: new Text(
                                    "待发货",
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: const Color(0xFF333333)),
                                  )),
                            ]))),
                Expanded(
                    flex: 1,
                    child: new GestureDetector(
                        onTap: () {},
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: new Image.asset(
                                    "assets/images/receiving.png",
                                    width: 30.0,
                                    height: 30.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: new Text(
                                    "待收货",
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: const Color(0xFF333333)),
                                  )),
                            ]))),
                Expanded(
                    flex: 1,
                    child: new GestureDetector(
                        onTap: () {},
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: new Image.asset(
                                    "assets/images/evaluate.png",
                                    width: 30.0,
                                    height: 30.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: new Text(
                                    "待评价",
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: const Color(0xFF333333)),
                                  )),
                            ]))),
                Expanded(
                    flex: 1,
                    child: new GestureDetector(
                        onTap: () {},
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: new Image.asset(
                                    "assets/images/aftersale.png",
                                    width: 30.0,
                                    height: 30.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: new Text(
                                    "退款/售后",
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: const Color(0xFF333333)),
                                  )),
                            ])))
              ],
            )
          ]));
}
