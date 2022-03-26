import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/page/home/goodsList/NewGoodsListPage.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/styles.dart';
import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/utils/custom_scroll_behavior.dart';
import 'package:SDZ/widget/animate_number.dart';
import 'package:SDZ/widget/clipper_views.dart';
import 'package:SDZ/widget/custome_card.dart';
import 'package:SDZ/widget/flip_card.dart';
import 'package:SDZ/widget/sign_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'gift_item.dart';
import 'logic.dart';
import 'state.dart';

class SignPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState()  => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final SignLogic logic = Get.put(SignLogic());
  final SignState state = Get.find<SignLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getGiftList();
    logic.getData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return GetBuilder<SignLogic>(
        init: SignLogic(),
        builder: (logic) {
          return Container(
            child:  Scaffold(
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
                    padding: EdgeInsets.only(top:30),
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
                          margin: EdgeInsets.only(bottom:6),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {

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
                                          topLeft: Radius.circular(Adaptor.width(14)),
                                          bottomLeft:
                                          Radius.circular(Adaptor.width(14)),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    state.signInfoEntity?.signed?.days?.toString()??'0',
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
                                          '赢奖品',
                                          style: TextStyle(
                                            color: Color(0xffFF421A),
                                            fontSize: Adaptor.sp(11),
                                          ),
                                        ),
                                      ),
                                    ),
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
                        SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {

                              },
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
                                    topRight: Radius.circular(Adaptor.width(16)),
                                    bottomRight:
                                    Radius.circular(Adaptor.width(16)),
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
                        SizedBox(height: 6,),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: CustomScrollBehavior(),
                            child: Container(
                              padding: EdgeInsets.only(left: 12,right: 12),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    StaggeredGridView.countBuilder(
                                      primary: false,
                                      shrinkWrap: true,
                                      crossAxisCount: 4,
                                      itemCount: state.list.length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          child: GiftItem(state.list[i],(){
                                            logic.commitGift();
                                          }),
                                        );
                                      },
                                      staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
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
              padding: EdgeInsets.all(Adaptor.width(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _signCards(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                '恭喜您获得积分奖励',
                style: TextStyle(
                  color: 1 > 0
                      ? Colors.black38
                      : Color(0xffFF421A),
                  fontSize: Adaptor.sp(13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, Adaptor.width(10), 0, 0),
                alignment: Alignment.center,
                child:
                Container(
                  height: Adaptor.height(38),
                  width: Adaptor.width(238),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xffFC6E18),
                      Color(0xffFF421A),
                    ]),
                    borderRadius: BorderRadius.circular(Adaptor.width(5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '今日已签到',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Adaptor.sp(16),
                        ),
                      ),
                      // if (model.signing)
                      //   Padding(
                      //     padding: EdgeInsets.only(left: Adaptor.width(6)),
                      //     child: SpinKitRing(
                      //       color: Colors.white,
                      //       lineWidth: Adaptor.width(1.2),
                      //       size: Adaptor.width(16),
                      //     ),
                      //   )
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
  List<Widget> _signCards() {
    List<Widget> cards = [];
    for (int i = 1; i <= 7; i++) {
      cards.add(
        FlipCard(
          key: i ==  1 ? cardKey : null,
          flipOnTouch: false,
          direction: FlipDirection.HORIZONTAL,
          front: SignCard(
              title: '$i天',
              hasSigned: false,
              index: i,
              throttle: 11),
          back: SignCard(
              title: '$i天',
              hasSigned: false,
              index: i,
              throttle: 1), onFlip: () {

        }, onFlipDone: (bool isFront) {  },
        ),
      );
    }
    return cards;
  }

}
