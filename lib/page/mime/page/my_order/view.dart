import 'package:SDZ/page/mime/page/my_browse_records/item/browse_record_item.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'item/order_item.dart';
import 'logic.dart';
import 'state.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final MyOrderLogic logic = Get.put(MyOrderLogic());
  final MyOrderState state = Get.find<MyOrderLogic>().state;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getData();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrderLogic>(
        init: MyOrderLogic(),
        builder: (control) {
          return Scaffold(
            backgroundColor: Colours.bg_f7f7f7,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '我的订单',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              leading: IconButton(
                color: Colors.black,
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
                          Text('您还没有订单哦~'),
                          SizedBox(
                            height: 28,
                          ),
                        ],
                      ))
                      : SizedBox.shrink(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    margin: EdgeInsets.only(top: 12),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.list.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return OrderItem(state.list[index]);
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}


