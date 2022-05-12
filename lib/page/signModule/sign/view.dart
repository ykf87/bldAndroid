import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/entity/Constants.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/page/home/goodsList/NewGoodsListPage.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/page/mime/page/feed_back/view.dart';
import 'package:SDZ/page/mime/page/my_order/view.dart';
import 'package:SDZ/page/signModule/address/view.dart';
import 'package:SDZ/page/signModule/lottery/SubWidget/ScrollListView.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/styles.dart';
import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/utils/custom_scroll_behavior.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
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
                      backgroundColor: Colours.color_yellow_FFDE9F,
                      body: EasyRefresh.custom(
                        controller: state.refreshController,
                        header: WeFreeHeader(),
                        footer: WeFreeFooter(),
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1), () {
                            logic.doRefresh();
                          });
                        },
                        onLoad: () async {
                          await Future.delayed(Duration(seconds: 1), () {
                            logic.doLoadMore();
                          });
                        },
                        slivers: [
                          ///顶部规则图标等
                          SliverToBoxAdapter(
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.fromLTRB(
                                12,
                                16,
                                0,
                                0,
                              ),
                              margin: EdgeInsets.only(bottom: 6, top: 20),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(child: Container()),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(MyOrderPage());
                                        },
                                        child: SvgPicture.asset(
                                          Utils.getSvgUrl('ic_gift.svg'),
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          logic.showRule(context);
                                        },
                                        child: SvgPicture.asset(
                                          Utils.getSvgUrl('ic_rule.svg'),
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: _buildSignInfo(),
                            ),
                          ),

                          ///抽奖
                        SPUtils.getAdShow()?  SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(WebViewPage(
                                    url: 'https://app.blandal.com/sweepstake',
                                    title: '幸运大转盘'));
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: 16, left: 12, right: 12),
                                  child: Constants.activitiesImg.isNotEmpty
                                      ? Container(
                                          width: double.infinity,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.all(
                                            //     Radius.circular(12)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  Constants.activitiesImg),
                                              fit: BoxFit.cover,
                                            ),
                                          ))
                                      : Image.asset(
                                          'assets/images/bg_luckydraw.png',
                                          width: double.infinity,
                                          height: 80,
                                        )),
                            ),
                          ):SliverToBoxAdapter(),
                          SliverToBoxAdapter(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colours.color_yellow_FBF4E4,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              padding: EdgeInsets.only(left: 12, right: 12),
                              margin:
                                  EdgeInsets.only(top: 12, left: 12, right: 12),
                              child: Column(
                                children: [
                                  textBanner(),
                                  StaggeredGridView.countBuilder(
                                    primary: false,
                                    shrinkWrap: true,
                                    crossAxisCount: 4,
                                    itemCount: state.list.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        child: state.list[i].isAd
                                            ? FeedAdItem(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                adType: 2,
                                              )
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                );
        });
  }

  Widget textBanner() {
    return (state.signInfoEntity != null &&
            state.signInfoEntity?.geted.length != 0)
        ? Container(
            decoration: const BoxDecoration(
              color: Colours.color_yellow_FAF8F2,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            padding: EdgeInsets.only(top: 5, left: 12),
            margin: EdgeInsets.only(top: 12),
            height: 38,
            width: double.infinity,
            child: Row(
              children: [
                SvgPicture.asset(
                  Utils.getSvgUrl('ic_notification.svg'),
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child:ScrollListView(
                  list: state.signInfoEntity?.geted ?? ["恭喜 叶** 获得 马卡龙成人小头软毛牙刷","恭喜 l** 获得 挂钩5个装","恭喜 图** 获得 MAC 焦点小眼影","恭喜 2** 获得 马卡龙成人小头软毛牙刷","恭喜 啦** 获得 切菜神器","恭喜 史** 获得 迷你风扇卡通棒棒糖"],
                )),
              ],
            ))
        : Container();
  }

  ///签到模块
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
          padding: EdgeInsets.fromLTRB(
            Adaptor.width(8),
            Adaptor.width(12),
            Adaptor.width(8),
            Adaptor.width(16),
          ),
          decoration: const BoxDecoration(
            color: Colours.color_yellow_FBF4E4,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: _buildSignView(),
        ),
      ],
    );
  }

  Widget _buildSignView() {
    return CCard(
      borderRadius: 12,
      child: Container(
        decoration: const BoxDecoration(
          color: Colours.color_yellow_FBF4E4,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            state.signInfoEntity?.signed == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.fromLTRB(
                      Adaptor.width(10),
                      0,
                      Adaptor.width(10),
                      Adaptor.width(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '连签',
                          style: TextStyle(
                            color: Colours.color_text_7A5F2B,
                            fontSize: Adaptor.sp(22),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          state.signInfoEntity?.signed?.needDay?.toString() ??
                              '0',
                          style: TextStyle(
                            color: Color(0xffE6765F),
                            fontSize: Adaptor.sp(24),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '天',
                          style: TextStyle(
                            color: Colours.color_text_7A5F2B,
                            fontSize: Adaptor.sp(21),
                            height: 1.1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          child: ClipPath(
                            clipper: TopLeftClipper(),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                Adaptor.width(16),
                                Adaptor.width(2),
                                Adaptor.width(8),
                                Adaptor.width(4),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFEEBB1),
                                borderRadius: BorderRadius.circular(
                                  Adaptor.width(2),
                                ),
                              ),
                              child: Text(
                                '赢${state.signInfoEntity?.signed?.product?.name ?? '奖品'}',
                                style: TextStyle(
                                  color: Color(0xffE6765F),
                                  fontSize: Adaptor.sp(11),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
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
            Container(
              alignment: Alignment.center,
              child: Text(
                state.tipsText,
                style: TextStyle(
                  color: Colours.color_text_7A5F2B,
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
