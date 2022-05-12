import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/page/mime/page/my_wallet/view.dart';
import 'package:SDZ/page/mime/page/tab_task/task/task_item.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/VideoUtils.dart';
import 'package:SDZ/utils/YLHUtils.dart';
import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/shared_utils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import 'logic.dart';
import 'new_task_item.dart';
import 'state.dart';

class AdTaskPage extends StatefulWidget {
  @override
  _AdTaskPageState createState() => _AdTaskPageState();
}

class _AdTaskPageState extends State<AdTaskPage> with WidgetsBindingObserver {
  final AdTaskLogic logic = Get.put(AdTaskLogic());
  final AdTaskState state = Get.find<AdTaskLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    logic.getData();
    logic.getUserInfo();
    logic.initEvent();
  }

  @override
  void dispose() {
    super.dispose();
    // 移除生命周期监听
    WidgetsBinding.instance?.removeObserver(this);
    logic.loginEventBus?.cancel();
    logic.adRewardEventBus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdTaskLogic>(
        init: AdTaskLogic(),
        builder: (control) {
          return Container(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                toolbarHeight: 50,
                title: Center(
                    child: Text(
                  '省币中心',
                  style: TextStyle(color: Colours.color_333333, fontSize: 20),
                )),
                actions: [
                  // DoubleClick(
                  //   child: Row(
                  //     children: [
                  //       Image(
                  //         image: AssetImage(
                  //             "assets/images/integral_icon_integral_star_coin_small.png"),
                  //         height: 20,
                  //         width: 20,
                  //       ),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       Text(
                  //         (state.userCenterEntity?.jifen ?? 0).toString(),
                  //         style: TextStyle(color: Colours.text, fontSize: 16),
                  //       ),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       DoubleClick(
                  //         onTap: () {
                  //           Get.to(MyWalletPage());
                  //         },
                  //         child: Container(
                  //           width: 36,
                  //           height: 16,
                  //           decoration: BoxDecoration(
                  //               color: Colours.color_main_red,
                  //               borderRadius: BorderRadius.circular(14)),
                  //           child: Center(
                  //             child: Text(
                  //               '提现',
                  //               style: TextStyle(
                  //                   color: Colours.bg_ffffff, fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       // SizedBox(
                  //       //   width: 16,
                  //       // ),
                  //       // DoubleClick(
                  //       //   onTap: () {
                  //       //     SystemNavigator.pop();
                  //       //   },
                  //       //   child: Container(
                  //       //     width: 36,
                  //       //     height: 16,
                  //       //     decoration: BoxDecoration(
                  //       //         color: Colours.color_main_red,
                  //       //         borderRadius: BorderRadius.circular(14)),
                  //       //     child: Center(
                  //       //       child: Text(
                  //       //         '退出',
                  //       //         style: TextStyle(
                  //       //             color: Colours.bg_ffffff, fontSize: 10),
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //       SizedBox(
                  //         width: 16,
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
              body: EasyRefresh.custom(
                controller: state.refreshController,
                header: WeFreeHeader(),
                footer: WeFreeFooter(),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1), () {
                    control.doRefresh();
                  });
                },
                onLoad: () async {
                  await Future.delayed(Duration(seconds: 1), () {
                    control.doLoadMore();
                  });
                },
                slivers: state.isShowEmpty
                    ? [
                        SliverToBoxAdapter(
                          child: state.isShowEmpty
                              ? Container(
                                  margin: EdgeInsets.only(top: 150),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/not_login_bg.png',
                                        height: 120,
                                        width: 120,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      LoginUtil.isLogin()
                                          ? Text('暂无任务~')
                                          : DoubleClick(
                                              onTap: () {
                                                LoginUtil.toLogin(
                                                    toMain: false);
                                              },
                                              child: Column(
                                                children: [
                                                  Text('登录后即可做任务赚钱'),
                                                  Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Colours
                                                          .text_FF1F35_start,
                                                    ),
                                                    height: 36,
                                                    margin: EdgeInsets.only(
                                                        left: 12,
                                                        right: 12,
                                                        top: 20,
                                                        bottom: 40),
                                                    child: Center(
                                                      child: Text(
                                                        '去登录',
                                                        style: TextStyle(
                                                            color: Colours
                                                                .bg_ffffff,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                    ],
                                  ))
                              : SizedBox.shrink(),
                        )
                      ]
                    : [
                        SliverToBoxAdapter(
                            child: Container(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          margin: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              topWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 3,
                                    height: 15,
                                    color: Colours.color_red_E3615F,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '每日任务',
                                    style: TextStyle(
                                        color: Colours.color_333333,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              // taskListWidget()
                            ],
                          ),
                        )),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return DoubleClick(
                                onTap: () {
                                  if (!LoginUtil.isLogin()) {
                                    LoginUtil.toLogin();
                                    return;
                                  }
                                  logic.isDoReward = true;
                                  state.curEntity = state.list[index];
                                  if (state.curEntity?.platform == 0) {
                                    SharedUtils.showSharedDialog(context);
                                  } else if (state.curEntity?.platform == 1) {
                                    CSJUtils.showRewardVideoAd();
                                  } else if (state.curEntity?.platform == 2) {
                                    FlutterQqAds.showRewardVideoAd(
                                      YLHUtils.YLHVideoId,
                                      playMuted: false,
                                      customData: 'customData',
                                      userId: 'userId',
                                    );
                                  } else if (state.curEntity?.platform == 3) {
                                    VideoUtils.loadVoiceAd((logId) {
                                      print("TTTTTTTTT==logid=$logId");
                                      logic.videoSuccess(
                                          state.curEntity!.id.toString(),
                                          logId: logId);
                                      // control.doRefresh();
                                    },
                                        type: 'default',
                                        tid: state.curEntity?.id.toString(),
                                        taskId: state.curEntity!.id.toString());
                                  }
                                },
                                child: Container(
                                  child: NewTaskItem(
                                    state.list[index],
                                    isOptions: true,
                                  ),
                                ),
                              );
                            },
                            childCount: state.list.length,
                          ),
                        ),
                      ],
              ),
            ),
          );
        });
  }

  Widget topWidget() {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 12),
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: new DecorationImage(
            image: new ExactAssetImage('assets/images/bg_task1.jpg'),
            fit: BoxFit.cover,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(MyWalletPage());
                },
                child: Container(
                  height: Adaptor.height(28),
                  padding: EdgeInsets.fromLTRB(
                    Adaptor.width(16),
                    0,
                    Adaptor.width(6),
                    0,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colours.color_orange_EB4736,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Adaptor.width(14)),
                      bottomLeft: Radius.circular(Adaptor.width(14)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '明细',
                        style: TextStyle(
                          fontSize: Adaptor.sp(12),
                          color: Colors.white,
                        ),
                      ),
                      Image(
                        image: AssetImage("assets/images/ic_next.png"),
                        width: 20,
                        height: 20,
                        color: Colours.bg_ffffff,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            '我的省币',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SvgPicture.asset(
                Utils.getSvgUrl('ic_coin.svg'),
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                (state.userCenterEntity?.jifen ?? 0).toString(),
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ],
          )
        ],
      ),
    );
  }
}
