import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/page/mime/page/tab_task/task/task_item.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class AdTaskPage extends StatefulWidget {
  @override
  _AdTaskPageState createState() => _AdTaskPageState();
}

class _AdTaskPageState extends State<AdTaskPage> {
  final AdTaskLogic logic = Get.put(AdTaskLogic());
  final AdTaskState state = Get.find<AdTaskLogic>().state;
  AdTaskEntity? curEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getData();
    setCSJAdEvent();
    setYLHAdEvent();
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
                toolbarHeight: 56,
                actions: [
                  DoubleClick(
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                              "assets/images/integral_icon_integral_star_coin_small.png"),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '0',
                          style: TextStyle(color: Colours.text, fontSize: 16),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 36,
                          height: 16,
                          decoration: BoxDecoration(
                              color: Colours.color_main_red,
                              borderRadius: BorderRadius.circular(14)),
                          child: Center(
                            child: Text(
                              '提现',
                              style: TextStyle(
                                  color: Colours.bg_ffffff, fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  )
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
                slivers: [
                  SliverToBoxAdapter(
                    child: state.isShowEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/img_collection_empty.svg',
                                  height: 120,
                                  width: 120,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('暂无任务~'),
                                SizedBox(
                                  height: 28,
                                ),
                              ],
                            ))
                        : SizedBox.shrink(),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    margin: EdgeInsets.only(top: 12),
                    child: StaggeredGridView.countBuilder(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: state.list.length,
                      itemBuilder: (context, i) {
                        return DoubleClick(
                          onTap: () {
                            curEntity = state.list[i];
                            if (curEntity?.platform == 1) {
                              CSJUtils.showRewardVideoAd();
                            } else {
                              FlutterQqAds.showRewardVideoAd(
                                CSJUtils.YLHVideoId,
                                playMuted: false,
                                customData: 'customData',
                                userId: 'userId',
                              );
                            }
                          },
                          child: Container(
                            child: TaskItem(
                              state.list[i],
                              isOptions: true,
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                  )),
                ],
              ),
            ),
          );
        });
  }

  /// 设置穿山甲广告监听
  Future<void> setCSJAdEvent() async {
    String _adEvent = '';
    CSJ.FlutterPangleAds.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is CSJ.AdErrorEvent) {
        // 错误事件
      }

      ///获取奖励
      if (event.action == CSJ.AdEventAction.onAdReward &&
          event.adId == CSJUtils.CSJVideoId) {
        if (curEntity != null) {
          logic.videoSuccess(curEntity!.id.toString());
          print('视频成功');
        }
      }
    });
  }

  /// 设置优量汇广告监听
  Future<void> setYLHAdEvent() async {
    FlutterQqAds.onEventListener((event) {
      // 普通广告事件
      String _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is AdErrorEvent) {
        // 错误事件
        _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
      } else if (event is AdRewardEvent &&
          event.adId == CSJUtils.YLHVideoId) {
        // 激励事件
        if (curEntity != null) {
          logic.videoSuccess(curEntity!.id.toString());
          print('视频成功');
        }
      }
      print('onEventListener:$_adEvent');
    });
  }
}
