import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/entity/Constants.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/page/home/goodsList/NewGoodsListPage.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/page/mime/page/feed_back/view.dart';
import 'package:SDZ/page/signModule/address/view.dart';
import 'package:SDZ/page/signModule/lottery/SubWidget/ScrollListView.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/styles.dart';
import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/utils/custom_scroll_behavior.dart';
import 'package:SDZ/widget/animate_number.dart';
import 'package:SDZ/widget/clipper_views.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';
import 'package:SDZ/widget/custome_card.dart';
import 'package:SDZ/widget/flip_card.dart';
import 'package:SDZ/widget/sign_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'FeedAdItem.dart';
import 'gift_item.dart';
import 'logic.dart';
import 'state.dart';

class SignPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final SignLogic logic = Get.put(SignLogic());
  final SignState state = Get.find<SignLogic>().state;

  bool isShowEmpty = Constants.opensign;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getGiftList();
    logic.getSignInfo();
    logic.initEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    logic.loginEventBus?.cancel();
    logic.refreshEventBus?.cancel();
    logic.adRewardEventBus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark));
    return GetBuilder<SignLogic>(
        init: SignLogic(),
        builder: (logic) {
          return isShowEmpty
              ? Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bg_empty_fly.png',
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('签到活动暂未开始，敬请期待~'),
                    SizedBox(
                      height: 28,
                    ),
                  ],
                ))
              : Container(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: [
                        Container(
                          child: ClipPath(
                            clipper: SignClipper(),
                            child: Container(
                              height: Adaptor.height(240),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0xFFFE8C00),
                                  const Color(0xFFF83600),
                                ]),
                              ),
                              child: null,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.fromLTRB(
                                  12,
                                  16,
                                  0,
                                  0,
                                ),
                                margin: EdgeInsets.only(bottom: 6),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          padding: EdgeInsets.only(top: 5),
                                          height: 28,
                                          width: 210,
                                          child:
                                              (state.signInfoEntity != null &&
                                                      state.signInfoEntity
                                                              ?.geted.length !=
                                                          0)
                                                  ? ScrollListView(
                                                      list: state.signInfoEntity
                                                              ?.geted ??
                                                          [],
                                                    )
                                                  : Container(),
                                        )),
                                        GestureDetector(
                                          onTap: () {
                                            logic.showRule(context);
                                          },
                                          child: Container(
                                            height: Adaptor.height(28),
                                            padding: EdgeInsets.fromLTRB(
                                              Adaptor.width(12),
                                              0,
                                              Adaptor.width(6),
                                              0,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFF7648),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Adaptor.width(14)),
                                                bottomLeft: Radius.circular(
                                                    Adaptor.width(14)),
                                              ),
                                            ),
                                            child: Text(
                                              '签到规则',
                                              style: TextStyle(
                                                fontSize: Adaptor.sp(12),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    state.signInfoEntity?.signed == null
                                        ? Container()
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '连签',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Adaptor.sp(22),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                state.signInfoEntity?.signed
                                                        ?.needDay
                                                        ?.toString() ??
                                                    '0',
                                                style: TextStyle(
                                                  color: Color(0xffF3F748),
                                                  fontSize: Adaptor.sp(24),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '天',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Adaptor.sp(21),
                                                  height: 1.1,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                child: ClipPath(
                                                  clipper: TopLeftClipper(),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                      Adaptor.width(16),
                                                      Adaptor.width(2),
                                                      Adaptor.width(8),
                                                      Adaptor.width(4),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffFEEBB1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Adaptor.width(2),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      '赢${state.signInfoEntity?.signed?.product?.name ?? '奖品'}',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffFF421A),
                                                        fontSize:
                                                            Adaptor.sp(11),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 80,
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: _buildSignInfo(),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: Adaptor.height(32),
                                      padding: EdgeInsets.fromLTRB(
                                        Adaptor.width(12),
                                        0,
                                        Adaptor.width(6),
                                        0,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFF7648),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Adaptor.width(16)),
                                          bottomRight: Radius.circular(
                                              Adaptor.width(16)),
                                        ),
                                      ),
                                      child: Text(
                                        '选择签到奖品',
                                        style: TextStyle(
                                          fontSize: Adaptor.sp(14),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(left: 12.0),
                              //   child: Text('请选择一项奖品，签到即可获得奖励',style: TextStyle(fontSize: 16,color:Color(0xffFC6E18),),),
                              // ),
                              SizedBox(
                                height: 6,
                              ),
                              Expanded(
                                  child: EasyRefresh.custom(
                                controller: state.refreshController,
                                header: WeFreeHeader(),
                                footer: WeFreeFooter(),
                                onRefresh: () async {
                                  await Future.delayed(Duration(seconds: 1),
                                      () {
                                    logic.doRefresh();
                                  });
                                },
                                onLoad: () async {
                                  await Future.delayed(Duration(seconds: 1),
                                      () {
                                    logic.doLoadMore();
                                  });
                                },
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 12, right: 12),
                                      margin: EdgeInsets.only(top: 12),
                                      child: StaggeredGridView.countBuilder(
                                        primary: false,
                                        shrinkWrap: true,
                                        crossAxisCount: 4,
                                        itemCount: state.list.length,
                                        itemBuilder: (context, i) {
                                          return Container(
                                            child: state.list[i].isAd
                                                ? FeedAdItem(MediaQuery.of(context).size.width,adType: 2,)
                                                : GiftItem(state.list[i], () {
                                                    logic.commitGift(
                                                        state.list[i], context);
                                                  }),
                                          );
                                        },
                                        staggeredTileBuilder: (index) =>
                                            new StaggeredTile.fit(2),
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              // Expanded(
                              //   child: ScrollConfiguration(
                              //     behavior: CustomScrollBehavior(),
                              //     child: Container(
                              //       padding: EdgeInsets.only(left: 12, right: 12),
                              //       child: SingleChildScrollView(
                              //         child: Column(
                              //           children: [
                              //             StaggeredGridView.countBuilder(
                              //               primary: false,
                              //               shrinkWrap: true,
                              //               crossAxisCount: 4,
                              //               itemCount: state.list.length,
                              //               itemBuilder: (context, i) {
                              //                 return Container(
                              //                   child: GiftItem(state.list[i], () {
                              //                     logic.commitGift(
                              //                         state.list[i], context);
                              //                   }),
                              //                 );
                              //               },
                              //               staggeredTileBuilder: (index) =>
                              //                   new StaggeredTile.fit(2),
                              //               mainAxisSpacing: 12,
                              //               crossAxisSpacing: 12,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        });
  }

  Widget _buildSignInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(
            Adaptor.width(12),
            0,
            Adaptor.width(12),
            Adaptor.width(0),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Adaptor.width(4)),
          ),
          child: _buildSignView(),
        ),
      ],
    );
  }

  Widget _buildSignView() {
    return CCard(
      child: Container(
        margin: EdgeInsets.fromLTRB(
          Adaptor.width(8),
          Adaptor.width(12),
          Adaptor.width(8),
          Adaptor.width(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                Adaptor.width(10),
                0,
                Adaptor.width(10),
                Adaptor.width(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '每日签到',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: Adaptor.sp(14),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: Adaptor.width(11),
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 80,
                padding: EdgeInsets.all(Adaptor.width(10)),
                child: ListView.builder(
                    controller: state.listScroll,
                    itemCount: state.signInfoEntity?.signed?.needDay,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return signCard(index + 1);
                    })),
            // Container(
            //   padding: EdgeInsets.all(Adaptor.width(10)),
            //   child:GridView.count(
            //     shrinkWrap: true,
            //     //水平子Widget之间间距
            //     crossAxisSpacing: 10.0,
            //     //垂直子Widget之间间距
            //     mainAxisSpacing: 30.0,
            //     //GridView内边距
            //     padding: EdgeInsets.all(10.0),
            //     //一行的Widget数量
            //     crossAxisCount:getSign(),
            //     //子Widget宽高比例
            //     childAspectRatio: 0.7,
            //     //子Widget列表
            //     children: _signCards(),
            //   )
            // ),
            // Container(
            //   padding: EdgeInsets.all(Adaptor.width(10)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: _signCards(),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              child: Text(
                state.tipsText,
                style: TextStyle(
                  color: 1 > 0 ? Colors.black38 : Color(0xffFF421A),
                  fontSize: Adaptor.sp(13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                logic.signClick();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, Adaptor.width(10), 0, 0),
                alignment: Alignment.center,
                child: Container(
                  height: Adaptor.height(38),
                  width: Adaptor.width(238),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: !state.isBtnEnable
                            ? [Colours.bg_f7f8f8, Colours.bg_f7f8f8]
                            : [
                                Color(0xffFC6E18),
                                Color(0xffFF421A),
                              ]),
                    borderRadius: BorderRadius.circular(Adaptor.width(5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        state.btnText,
                        style: TextStyle(
                          color: state.isBtnEnable
                              ? Colors.white
                              : Colours.color_999999,
                          fontSize: Adaptor.sp(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  int getSign() {
    if (state.signInfoEntity == null || state.signInfoEntity?.signed == null) {
      return 7;
    } else {
      if (state.signInfoEntity!.signed!.needDay > 9) {
        return 6;
      } else {
        return 7;
      }
    }
  }

  ///签到卡片
  List<Widget> _signCards() {
    List<Widget> cards = [];
    int needSignDay = 7;
    int hasSignDay = 0;
    if (state.signInfoEntity == null || state.signInfoEntity?.signed == null) {
      needSignDay = 7;
      hasSignDay = 0;
    } else {
      needSignDay = state.signInfoEntity!.signed!.needDay;
      hasSignDay = state.signInfoEntity!.signed!.days!; //已签到
    }
    for (int i = 1; i <= needSignDay; i++) {
      cards.add(
        FlipCard(
          key: i == 1 ? cardKey : null,
          flipOnTouch: false,
          direction: FlipDirection.HORIZONTAL,
          front: SignCard(
              title: '$i天', hasSigned: i <= hasSignDay, index: i, throttle: 11),
          back: SignCard(
              title: '$i天', hasSigned: i <= hasSignDay, index: i, throttle: 1),
          onFlip: () {},
          onFlipDone: (bool isFront) {},
        ),
      );
    }
    return cards;
  }

  Widget signCard(int i) {
    int needSignDay = 7;
    int hasSignDay = 0;
    if (state.signInfoEntity == null || state.signInfoEntity?.signed == null) {
      needSignDay = 7;
      hasSignDay = 0;
    } else {
      needSignDay = state.signInfoEntity!.signed!.needDay;
      hasSignDay = state.signInfoEntity!.signed!.days!; //已签到
    }
    return FlipCard(
      key: i == 1 ? cardKey : null,
      flipOnTouch: false,
      direction: FlipDirection.HORIZONTAL,
      front: SignCard(
          title: '$i天', hasSigned: i <= hasSignDay, index: i, throttle: 11),
      back: SignCard(
          title: '$i天', hasSigned: i <= hasSignDay, index: i, throttle: 1),
      onFlip: () {},
      onFlipDone: (bool isFront) {},
    );
  }
}
