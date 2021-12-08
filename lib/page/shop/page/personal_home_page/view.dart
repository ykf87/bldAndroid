import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:SDZ/page/shop/item/shop_goods_item.dart';
import 'package:SDZ/res/colors.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:SDZ/widget/double_click.dart';

import 'logic.dart';
import 'state.dart';

///个人主页
class PersonalHomePagePage extends StatefulWidget {
  @override
  _PersonalHomePagePageState createState() => _PersonalHomePagePageState();
}

class _PersonalHomePagePageState extends State<PersonalHomePagePage>
    with TickerProviderStateMixin {
  final PersonalHomePageLogic logic = Get.put(PersonalHomePageLogic());
  final PersonalHomePageState state = Get.find<PersonalHomePageLogic>().state;
  bool isExpand = true;

  var _expandedHeight = 460.0;
  late StateSetter tabbarSetter;
  late ScrollController _scrollController;

  late WidgetsBinding widgetsBinding;

  @override
  void initState() {
    _findTabController =
        TabController(vsync: this, length: state.findTitles.length);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > _expandedHeight - 60.0) {
          if (isExpand) {
            isExpand = false;
            this.tabbarSetter(() {});
          }
        } else {
          if (!isExpand) {
            isExpand = true;
            this.tabbarSetter(() {});
          }
        }
      });
    super.initState();

    widgetsBinding = WidgetsBinding.instance!;
    widgetsBinding.addPostFrameCallback((callback) {
      state.personalDesTextHeightNor = getPersonalDesTextHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalHomePageLogic>(
        init: PersonalHomePageLogic(),
        builder: (control) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    topBar(),
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: new _SliverAppBarDelegate(TabBar(
                          tabs:
                              state.tabTitle.map((f) => Tab(text: f)).toList(),
                          indicatorColor: Colours.text_131313,
                          unselectedLabelColor: Colours.text_717888,
                          labelColor: Colours.text_131313,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colours.text_131313,
                          ),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 15.0, color: Colours.text_717888),
                        ))),
                  ];
                },
                body: TabBarView(
                  // children: state.tabTitle.map((String name) {
                  //     shopList(PageStorageKey<String>(name));
                  // }).toList(),
                  children: [
                    shopList(PageStorageKey<String>(state.tabTitle[0])),
                    Container(
                        width: 100,
                        height: 100,
                        decoration:
                            BoxDecoration(color: Colours.gradient_blue)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///发现页
  late TabController _findTabController;



  //吸顶
  Widget _buildPersistentHeader() => SliverPersistentHeader(
      pinned: true,
      delegate: _SliverDelegate(
        minHeight: 50,
        maxHeight: 50,
       child: TabBar(
         controller: _findTabController,
         indicatorColor: Colors.transparent,
         isScrollable: true,
         unselectedLabelColor: Colours.text_717888,
         labelColor: Colours.text_131313,
         unselectedLabelStyle: TextStyle(
           fontSize: 14,
           fontWeight: FontWeight.normal,
         ),
         labelStyle: TextStyle(
           fontSize: 18,
           fontWeight: FontWeight.bold,
         ),
         tabs: state.findTitles.map((label) {
           return Text(
             label,
           );
         }).toList(),
       )
      ));

  ///商品列表
  Widget shopList(Key key) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return EasyRefresh.custom(
            controller: state.refreshController,
            header: ClassicalHeader(
              enableInfiniteRefresh: false,
              bgColor: Colors.transparent,
              infoColor: Colours.text_999999,
              float: false,
              enableHapticFeedback: true,
              refreshText: '释放立即刷新',
              refreshReadyText: '释放立即刷新',
              refreshingText: '   正在刷新...',
              refreshedText: '刷新完成',
              refreshFailedText: "刷新失败",
              noMoreText: '没有更多数据',
              infoText: '上次更新  %T',
            ),
            // header:MyMaterialHeader(),
            footer: MaterialFooter(),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                logic.doRefresh();
                state.refreshController
                    .finishRefresh(success: true, noMore: false);
              });
            },
            onLoad: () async {
              await Future.delayed(Duration(seconds: 1), () {
                // logic.doLoadMore();
                state.refreshController.finishLoad(success: true, noMore: true);
              });
            },
            key: key,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.68,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //创建子widget
                      return ShopGoodsItem(state.goodsList[index]);
                    },
                    childCount: state.goodsList.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ///顶部个人信息
  Widget topBar() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      tabbarSetter = setState;
      return SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          floating: true,
          elevation: 0,
          leading: IconButton(
            color: isExpand ? Colors.white : Colors.black,
            tooltip: null,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          centerTitle: false,
          title: isExpand ?SizedBox.shrink(): Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.transparent,
                backgroundImage: CachedNetworkImageProvider(
                    "https://img1.baidu.com/it/u=2579940132,1296036844&fm=11&fmt=auto&gp=0.jpg"),
              ),
              Text("李青峰",
                  style: TextStyle(color: Colours.text_131313, fontSize: 16)),
              Icon(
                Icons.fiber_manual_record,
                color: Colours.text_FF475C,
                size: 10,
              )
            ],
          ),
          actions: [
            DoubleClick(
              onTap: () {
                // Get.toNamed('/shop/page/test');
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    isExpand ?SizedBox.shrink():Text(
                      '关注',
                      style:
                          TextStyle(color: Colours.text_1BC8CB, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              color: isExpand ? Colors.white : Colors.black,
              tooltip: null,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.collections),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            IconButton(
              color: isExpand ? Colors.white : Colors.black,
              tooltip: null,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.looks_5),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            )
          ],
          expandedHeight: _expandedHeight,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                  padding: EdgeInsets.only(top: 82),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs8.sinaimg.cn%2Fbmiddle%2F4a90f018g6211c276d7f7&refer=http%3A%2F%2Fs8.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630749474&t=cac2eaf42d854e7d3302a205746a76c6",
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              width: 60,
                              height: 60,
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      "http://img.haote.com/upload/20180918/2018091815372344164.jpg")),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('李青峰',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    ImageIcon(
                                      AssetImage('assets/images/testi.png'),
                                      size: 15,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'WeFree号：267326393',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colours.text_BABDC7),
                                      textAlign: TextAlign.end,
                                    )),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 3, bottom: 3, left: 4, right: 4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colours.text_1BC8CB,
                                            width: 1),
                                      ),
                                      child: Center(
                                        child: Text('技能达人',
                                            style: TextStyle(
                                                color: Colours.text_1BC8CB,
                                                fontSize: 10)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          key: state.personalDesTextKey,
                          child: ExpandableText(
                              '这里显示个人简介这里显示个人简介这里显示个人简介这里显示个人简介这里显示个人简介这里显示个人简介这里显示个人这里显示个人简介这里显示个人简介这里显示个人',
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1.3,
                                  color: Colors.white),
                              maxLines: 2,
                              linkColor: Colours.color_7D8184,
                              expandText: '展开',
                              collapseText: '收起',
                              onExpandedChanged: (bool isExpand) {
                            if (isExpand) {
                              _expandedHeight = _expandedHeight + 20;
                            } else {
                              _expandedHeight = _expandedHeight - 20;
                            }
                            this.tabbarSetter(() {});
                          }),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            children: _generateList(state.listResume),
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text('专业技能',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))),
                            DoubleClick(
                              onTap: () {},
                              child: Text('展开',
                                  style: TextStyle(
                                      color: Colours.color_7D8184,
                                      fontSize: 12)),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            children: _generateList(state.listSkill),
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: DoubleClick(
                              onTap: () {
                                logic.setFocus();
                                // setState((){});
                              },
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colours.text_1BC8CB,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0))),
                                  child: Center(
                                      child: Text(state.isFocus ? '已关注' : '关注',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)))),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colours.bg_b3131313,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0))),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            );
          }));
    });
  }

  //获取个人描述文本高度
  double getPersonalDesTextHeight() {
    return state.personalDesTextKey.currentContext!.size!.height;
  }

  ///标签列表
  List<Widget> _generateList(List<String> list) {
    return list.map((item) => labelWidget(item)).toList();
  }

  ///标签样式
  Widget labelWidget(String text) {
    return Container(
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
      decoration: BoxDecoration(
          color: Colours.text_1BC8CB,
          // color: Colours.bg_b3131313,
          borderRadius: BorderRadius.all(Radius.circular(2.0))),
      child:
          Text(text, style: TextStyle(color: Colours.bg_ffffff, fontSize: 12)),
    );
  }

  ///商品列表
  Widget ShopList() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: GridView(
        physics: new NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          childAspectRatio: 0.68,
        ),
        children: state.goodsList.map((item) {
          return ShopGoodsItem(item);
        }).toList(),
      ),
    );
  }

  ///笔记列表
  Widget noteList() {
    return Container(
      height: 500,
    );
  }

  ///喜欢列表
  Widget? likeList() {}
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colours.bg_ffffff,
      child: tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}


class _SliverDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverDelegate(
      {required this.minHeight,
        required this.maxHeight,
        required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
