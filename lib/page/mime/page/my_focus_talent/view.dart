import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:SDZ/event/change_home_tab_event.dart';
import 'package:SDZ/page/mime/list/fans_item.dart';
import 'package:SDZ/page/mime/page/my_collect/item/collect_item_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';

import 'item/focus_item_widget.dart';
import 'logic.dart';
import 'state.dart';

class MyFocusTalentPage extends StatefulWidget {
  @override
  _MyFocusTalentPageState createState() => _MyFocusTalentPageState();
}

class _MyFocusTalentPageState extends State<MyFocusTalentPage> {
  final MyFocusTalentLogic logic = Get.put(MyFocusTalentLogic());
  final My_focus_talentState state = Get.find<MyFocusTalentLogic>().state;

  @override
  void dispose() {
    super.dispose();
    state.userCenterEventBus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyFocusTalentLogic>(
        init: MyFocusTalentLogic(),
        builder: (control) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '我关注的达人',
                style: TextStyle(color: Colours.bg_ffffff, fontSize: 20),
              ),
              leading: IconButton(
                color: Colors.white,
                tooltip: null,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_outlined),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
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
                          margin: EdgeInsets.only(top: 96),
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
                              Text(
                                '您还没有关注的达人哦~',
                                style: TextStyle(
                                    color: Colours.text_main, fontSize: 14),
                              ),
                              SizedBox(height: 28),
                              Container(
                                height: 36,
                                width: 98,
                                decoration: BoxDecoration(
                                    color: Colours.color_main_red,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18.0))),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      EventBusUtils.getInstance()
                                          .fire(ChangeHomeTabEvent(0));
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '浏览达人',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      : SizedBox.shrink(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SwipeActionCell(
                        ///这个key是必要的
                        key: ValueKey(state.list[index]),
                        trailingActions: [
                          SwipeAction(
                              nestedAction: SwipeNestedAction(
                                nestedWidth: 140,

                                ///自定义你nestedAction 的内容 二次确认删除
                                content: comfirmDel(),
                              ),

                              ///将原本的背景设置为透明，因为要用你自己的背景
                              color: Colors.transparent,

                              ///设置了content就不要设置title和icon了  删除
                              content: del(),
                              onTap: (handler) async {
                                control.cancleFocus(index);
                              }),
                        ],
                        child: FocusItemWidget(
                            state.list[index], FocusItemWidget.TYPE_FOCUS),
                      );
                    },
                    childCount: state.list.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget comfirmDel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colours.color_main_red,
      ),
      width: 133,
      height: 56,
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/ic_delete.svg",
              height: 17,
              width: 17,
              color: Colors.white,
            ),
            SizedBox(
              width: 3,
            ),
            Text('取消该关注', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget del() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colours.color_main_red,
      ),
      child: Center(
        child: SvgPicture.asset(
          "assets/svg/ic_delete.svg",
          height: 17,
          width: 17,
          color: Colors.white,
        ),
      ),
    );
  }
}
