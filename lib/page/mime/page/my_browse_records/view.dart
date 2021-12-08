import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/event/change_home_tab_event.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';

import 'item/browse_record_item.dart';
import 'logic.dart';
import 'state.dart';

class MyBrowseRecordsPage extends StatefulWidget {
  @override
  _MyBrowseRecordsPageState createState() => _MyBrowseRecordsPageState();
}

class _MyBrowseRecordsPageState extends State<MyBrowseRecordsPage> {
  final Browse_recordsLogic logic = Get.put(Browse_recordsLogic());
  final Browse_recordsState state = Get.find<Browse_recordsLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getData();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Browse_recordsLogic>(
        init: Browse_recordsLogic(),
        builder: (control) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '浏览历史',
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
                  child:  state.isShowEmpty
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
                              Text('您还没有浏览过达人哦~'),
                              SizedBox(
                                height: 28,
                              ),
                              Container(
                                height: 36,
                                width: 100,
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
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      : SizedBox.shrink(),
                ),
                SliverToBoxAdapter(
                    child:Container(
                      padding: EdgeInsets.only(left: 12,right: 12),
                      margin: EdgeInsets.only(top: 12),
                      child:  StaggeredGridView.countBuilder(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        itemCount: state.list.length,
                        itemBuilder: (context, i) {
                          return Container(
                            child: BrowseRecordsItem(state.list[i],isOptions: true,),
                          );
                        },
                        staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
