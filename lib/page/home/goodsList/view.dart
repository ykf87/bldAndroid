import 'package:SDZ/base/get/get_save_state_view.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/widget/pull_smart_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';

import 'logic.dart';
import 'state.dart';

class GoodsListPage extends GetSaveView<GoodsListLogic>{
  final GoodsListLogic logic = Get.put(GoodsListLogic());
  final GoodsListState state = Get.find<GoodsListLogic>().state;

  String source = '';
  GoodsListPage(this.source);
  @override
  void initState() {
    // TODO: implement initState
    state.source = source;
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SafeArea(
    //       top: true,
    //       child: Column(
    //         children: [
    //           Expanded(
    //               child: Container(
    //                   color: Colors.white,
    //                   child: RefreshWidget<GoodsListLogic>(
    //                     child:StaggeredGridView.countBuilder(
    //                       primary: false,
    //                       shrinkWrap: true,
    //                       crossAxisCount: 4,
    //                       itemCount: state.list.length,
    //                       itemBuilder: (context, i) {
    //                         return Container(
    //                           child: WaterfallGoodsCard(state.list[i]),
    //                         );
    //                       },
    //                       staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
    //                       mainAxisSpacing: 12,
    //                       crossAxisSpacing: 12,
    //                     )
    //
    //                       )))
    //         ],
    //       )),
    // );


    return GetBuilder<GoodsListLogic>(
        init: GoodsListLogic(),
        builder: (control) {
          return EasyRefresh.custom(
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
                          '暂无数据~',
                          style: TextStyle(
                              color: Colours.text_main, fontSize: 14),
                        ),
                      ],
                    ))
                    : SizedBox.shrink(),
              ),
              SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    margin: EdgeInsets.only(top: 12),
                    child: StaggeredGridView.countBuilder(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: state.list.length,
                      itemBuilder: (context, i) {
                        return Container(
                          child: WaterfallGoodsCard(state.list[i]),
                        );
                      },
                      staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                  )),
            ],
          );
        });
  }
}

