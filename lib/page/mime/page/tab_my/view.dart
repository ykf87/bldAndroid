import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/widget/web_view_page.dart';
import 'package:SDZ/env.dart';
import 'package:SDZ/page/mime/page/config/config_view.dart';
import 'package:SDZ/page/mime/page/my_focus_talent/view.dart';
import 'package:SDZ/page/mime/page/pr_visiting_card/view.dart';
import 'package:SDZ/page/mime/page/publish_announcement/view.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/common_widgets.dart';
import 'package:SDZ/widget/double_click.dart';

import '../setting_page.dart';
import 'logic.dart';
import 'state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:SDZ/page/mime/page/base_info_page.dart';
import 'package:SDZ/page/mime/page/my_browse_records/view.dart';
import 'package:SDZ/page/mime/page/my_collect/view.dart';
import 'package:SDZ/page/mime/page/setting_page.dart';
import 'package:SDZ/page/mime/widget/count_title_widget.dart';
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
    return GetBuilder<Tab_myLogic>(
      init: Tab_myLogic(),
      builder: (logic) {
        return Container(
          child:  Scaffold(
            backgroundColor: Colors.transparent,
            body: new Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image:DecorationImage(
                        image: AssetImage("assets/images/personinfo_head_bg.png"),
                        fit: BoxFit.cover,
                      )),
                  width: double.infinity,
                  height: 140,
                ),
                new ListView(
                  children: <Widget>[
                    getPersonInfoWidget( context),
                    topMenuWidget(),
                    // orderWidget,
                    LineTextWidget(leftText: '我的积分',bgColor: Colours.bg_ffffff,leftImg:"my_points.png",),
                    LineTextWidget(leftText: '我的钱包',bgColor: Colours.bg_ffffff,leftImg:"account_balance.png",),
                    LineTextWidget(leftText: '关于我们',bgColor: Colours.bg_ffffff,leftImg:"ic_about.svg",),
                    LineTextWidget(leftText: '设置',bgColor: Colours.bg_ffffff,leftImg:"ic_setting.svg",),
                    LineTextWidget(leftText: '常用功能',bgColor: Colours.bg_ffffff,leftImg:"my_points.png",),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
  ///顶部个人信息
  getPersonInfoWidget(context){
    return new Container(
        margin: const EdgeInsets.only( bottom: 10.0),
        //color: Colors.white,
        child: new InkWell(
          onTap: () {
          },
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 30.0,
                      bottom: 30.0),
                  child: state.userCenterEntity.avatar == null?new Image.asset("assets/images/ic_logo.jpg",
                    width: 60.0,
                    height: 60.0,):CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: ImageUtils.getImageProvider(
                        state.userCenterEntity.avatar ?? ""),
                  )),
              new Stack(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: new Text("昵称",
                        style: new TextStyle(fontSize: 20.0, color:const Color(0xFFffffff)),)),

                  new Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 29.0),
                      child: new Text(state.userCenterEntity.nickname??'',
                        style: new TextStyle(fontSize: 12.0,
                            color:const Color(0xFFffffff)))),

                  new Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 50.0),
                      child: new Text("177****0000",
                        style: new TextStyle(fontSize: 12.0,
                            color:const Color(0xFFffffff)))),
                ]),
            ],
          ),
        )

    );

  }

  /// 上图下文样式
  Widget _menuWidget(String title,String icon){
    return Container(
      child: Column(
        children: [
          icon.endsWith('.svg')?SvgPicture.asset(
            "assets/svg/${icon}",
          ):new Image.asset("assets/images/${icon}",
            width: 25.0,
            height: 25.0,),
          SizedBox(height: 6,),
          Text(title,
              style: TextStyle(color: Colours.text_121212, fontSize: 14)),
        ],
      ),
    );
  }

  Widget topMenuWidget(){
    return Container(
        padding: const EdgeInsets.only( bottom: 10.0),
        margin: const EdgeInsets.only( bottom: 10.0),
        color: Colors.white,
        child:new Row(
          //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[

            Expanded(
                flex: 1,
                child:
                new GestureDetector(
                  onTap: (){

                  },
                  child: _menuWidget("会员卡","vip.png"),
                )),
            Expanded(
                flex: 1,
                child:
                new GestureDetector(
                  onTap: (){

                  },
                  child: _menuWidget("优惠券","coupon.png"),
                )),
            Expanded(
                flex: 1,
                child:
                new GestureDetector(
                  onTap: (){

                  },
                  child: _menuWidget("购物车","shopping_cart.png"),
                )),
            Expanded(
                flex: 1,
                child:
                new GestureDetector(
                  onTap: (){

                  },
                  child: _menuWidget("收藏","my_collect.png"),
                )),
          ],
        )
    );
  }

  Widget orderWidget=new Container(
      padding: const EdgeInsets.only( bottom: 10.0,top: 10.0),
      margin: const EdgeInsets.only( bottom: 10.0),
      color: Colors.white,
      child:new Column(
        //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(

                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(top: 0.0,bottom: 15.0,left: 15.0),
                        child: new Text("我的订单",
                          style: new TextStyle(fontWeight: FontWeight.w700  ,fontSize: 14.0, color:const Color(0xFF333333)),)),

                  ],
                ),
                new GestureDetector(
                    onTap: (){
                    },
                    child:
                    new Row(
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 15.0),
                            child: new Text("查看全部订单",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                        new Padding(
                            padding: const EdgeInsets.only(right: 15.0,left: 10.0,bottom: 15.0),
                            child: new Image.asset("assets/images/ic_next.png",
                                width: 20.0,
                                color: Colours.color_black45,
                                height: 20.0)),
                      ],
                    ))
              ],
            ),

            new Row( children: <Widget>[
              Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                      },
                      child:
                      new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: new Image.asset("assets/images/wallet.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待付款",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),  Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                      },
                      child:new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("assets/images/daifahuo_icon.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待发货",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),   Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                      },
                      child:new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("assets/images/receiving.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待收货",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),   Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                      },
                      child:
                      new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("assets/images/evaluate.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待评价",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),   Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                      },
                      child:
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("assets/images/aftersale.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("退款/售后",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      )))],
            )])


  );

}
