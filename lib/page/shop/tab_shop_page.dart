import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/page/shop/item/grid_item.dart';
import 'package:SDZ/page/shop/item/shop_goods_item.dart';
import 'package:SDZ/page/shop/shopModuleLogic.dart';
import 'package:SDZ/page/shop/widget/goods_sort_menu.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/popup_window.dart';
import 'package:SDZ/widget/double_click.dart';

class TabShopPage extends StatefulWidget {
  @override
  _TabShopPageState createState() => _TabShopPageState();
}

class _TabShopPageState extends State<TabShopPage> {
  final GlobalKey _buttonKey = GlobalKey();
  final GlobalKey _bodyKey = GlobalKey();
  final ShopModuleLogic shopModuleLogic = Get.put(ShopModuleLogic());

  initState() {
    super.initState();
    // getHttp().then((val){
    //   setState(() {
    //     formList = val['result'].toList();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '商店',
          style: TextStyle(
              color: Colours.text_131313,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<ShopModuleLogic>(
        init: ShopModuleLogic(),
        builder: (control) {
          return Container(
            key: _bodyKey,
            color: Colors.white,
            child: EasyRefresh.custom(
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
                  setState(() {
                    control.list.removeRange(3, control.list.length - 1);
                  });
                });
              },
              onLoad: () async {
                await Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    control.list.add(ShopEntity(
                        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
                        '啦啦啦啦',
                        1,
                        false));
                    control.list.add(ShopEntity(
                        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
                        '啦啦啦啦',
                        1,
                        false));
                    control.list.add(ShopEntity(
                        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
                        '啦啦啦啦',
                        1,
                        false));
                    control.list.add(ShopEntity(
                        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
                        '啦啦啦啦',
                        1,
                        false));
                  });
                });
              },
              slivers: [
                //=====网格菜单=====//
                SliverPadding(
                    padding: EdgeInsets.only(top: 10),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          //创建子widget
                          var action = actions[index];
                          return GridItem(
                              item: action,
                              onTap: () {
                                ToastUtils.toast('点击-->${action.title}');
                              });
                        },
                        childCount: actions.length,
                      ),
                    )),
                // SliverAppBar(
                //   pinned: true,
                //   expandedHeight: 30.0,
                //   flexibleSpace: FlexibleSpaceBar(
                //     title: Text('复仇者联盟'),
                //     background: Image.network(
                //       'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                //       fit: BoxFit.fitHeight,
                //     ),
                //   ),
                // ),
                _buildPersistentHeader(),
                //商铺列表
                SliverPadding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
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
                          return ShopGoodsItem(control.list[index]);
                        },
                        childCount: control.list.length,
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    ));
  }

  //吸顶 筛选
  Widget _buildPersistentHeader() => SliverPersistentHeader(
      pinned: true,
      delegate: _SliverDelegate(
        minHeight: 50,
        maxHeight: 50,
        child: Container(
          height: 50,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                children: [
                  DoubleClick(
                      key: _buttonKey,
                      onTap: () {
                        _showSortMenu();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            Text(
                              '服务类型',
                              style: TextStyle(
                                  color: Colours.text_717888, fontSize: 14),
                            ),
                            Image(
                              image: AssetImage("assets/images/down.png"),
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      )),
                  DoubleClick(
                      onTap: () {
                        _showSortMenu();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Text(
                              '卖家等级',
                              style: TextStyle(
                                  color: Colours.text_717888, fontSize: 14),
                            ),
                            Image(
                              image: AssetImage("assets/images/down.png"),
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      )),
                  DoubleClick(
                      onTap: () {
                        _showSortMenu();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Obx(() => Text(
                                  '${Get.find<ShopModuleLogic>().selTime}',
                                  style: TextStyle(
                                      color: Colours.text_717888, fontSize: 14),
                                )),
                            Image(
                              image: AssetImage("assets/images/down.png"),
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      )),
                ],
              )),
              Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: GetBuilder<ShopModuleLogic>(
                    init: ShopModuleLogic(),
                    builder: (control) {
                      return DoubleClick(
                        onTap: () {
                          control.selNewer();
                        },
                        child: Text(
                          '最新',
                          style: TextStyle(
                              color: control.isNewer
                                  ? Colours.red
                                  : Colours.text_717888,
                              fontSize: 12),
                        ),
                      );
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 5),
                  child: GetBuilder<ShopModuleLogic>(
                    init: ShopModuleLogic(),
                    builder: (control) {
                      return DoubleClick(
                        onTap: () {
                          control.selHoter();
                        },
                        child: Text(
                          '最热',
                          style: TextStyle(
                              color: control.isHoter
                                  ? Colours.red
                                  : Colours.text_717888,
                              fontSize: 12),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
      ));
  final List<String> _sortList = [
    '全部商品',
    '个人护理',
    '饮料',
    '沐浴洗护',
    '厨房用具',
    '休闲食品',
    '生鲜水果',
    '酒水',
    '家庭清洁'
  ];

  void _showSortMenu() {
    // 获取点击控件的坐标
    final RenderBox button =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox body =
        _bodyKey.currentContext!.findRenderObject() as RenderBox;

    showPopupWindow<void>(
      context: context,
      offset: const Offset(0.0, 12.0),
      anchor: button,
      child: GoodsSortMenu(
        data: _sortList,
        height: body.size.height - button.size.height,
        sortIndex: 5,
        onSelected: (index, name) {
          // provider.setSortIndex(index);
          ToastUtils.toast('选择分类: $name');
        },
      ),
    );
  }

  final List<ActionItem> actions = [
    ActionItem('发布需求', '发布需求'),
    ActionItem('浏览历史', '浏览历史'),
    ActionItem('标示设计', '标示设计'),
    ActionItem('红人营销', '红人营销'),
    ActionItem('短视频', '短视频'),
    ActionItem('有声书', '有声书'),
    ActionItem('插画艺术', '插画艺术'),
    ActionItem('星盘占卜', '星盘占卜'),
    ActionItem('小红书', '小红书'),
    ActionItem('电商服务', '电商服务'),
  ];
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
