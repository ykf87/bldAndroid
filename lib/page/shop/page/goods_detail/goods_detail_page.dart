import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:SDZ/page/shop/item/group_item.dart';
import 'package:SDZ/page/shop/item/interested_people_item.dart';
import 'package:SDZ/page/shop/item/shop_goods_item.dart';
import 'package:SDZ/page/shop/page/goods_detail/logic.dart';
import 'package:SDZ/page/shop/page/personal_home_page/view.dart';
import 'package:SDZ/page/shop/widget/expand_text_widget.dart';
import 'package:SDZ/page/shop/widget/select_goods_type_sheet_widget.dart';
import 'package:SDZ/page/shop/widget/seller_detail_sheet_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/shared_utils.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/widget/double_click.dart';

class GoodsDetailPage extends StatefulWidget {
  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage>
    with TickerProviderStateMixin {
  final GoodsDetailLogic goodsDetailLogic = Get.put(GoodsDetailLogic());
  late ScrollController _scrollController;

  bool isExpand = true;
  bool isInit = true;
  var top = 0.0;
  var _expandedHeight = 300.0;
  late StateSetter tabbarSetter;

  var goodsTypeList = ["基础版", "中级版", "高级版"];
  late TabController _tabController;
  int currentTabIndex = 0;

  GlobalKey personalDesTextKey = GlobalKey(); //个人简介

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: goodsTypeList.length);
    _tabController.addListener(() {
      setState(() {
        currentTabIndex = _tabController.index;
      });
    });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > _expandedHeight - 80.0) {
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
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailLogic>(
      init: GoodsDetailLogic(),
      builder: (control) {
        return MaterialApp(
          home: Scaffold(
              body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 60),
                color: Colors.white,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      tabbarSetter = setState;
                      return SliverAppBar(
                          pinned: true,
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
                          actions: [
                            IconButton(
                              color: isExpand ? Colors.white : Colors.black,
                              tooltip: null,
                              onPressed: () {
                                Get.to(PersonalHomePagePage());
                              },
                              icon: Icon(Icons.collections),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                            IconButton(
                              color: isExpand ? Colors.white : Colors.black,
                              tooltip: null,
                              onPressed: () {
                                // MobUtils.sharedWechat();
                                // UmengSharedUtils.showSharedDialog(context);
                              },
                              icon: Icon(Icons.share),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            )
                          ],
                          backgroundColor: Colors.white,
                          expandedHeight: _expandedHeight,
                          flexibleSpace: LayoutBuilder(builder:
                              (BuildContext context,
                                  BoxConstraints constraints) {
                            // print('constraints=' + constraints.toString());
                            top = constraints.biggest.height;
                            if (top < 90) {
                              // if (isExpand && !isInit) {
                              //   control.setAppBarExpanded(false);
                              //   isExpand = !isExpand;
                              // }
                            } else if (top < _expandedHeight) {
                              // if (!isExpand && !isInit) {
                              //   control.setAppBarExpanded(true);
                              //   isExpand = !isExpand;
                              // }
                            }
                            isInit = false;
                            return FlexibleSpaceBar(
                                centerTitle: true,
                                background: Image.network(
                                  "http://img.haote.com/upload/20180918/2018091815372344164.jpg",
                                  fit: BoxFit.cover,
                                ));
                          }));
                    }),
                    sellerInfoWidget(),
                    webHtml,
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(

                      child: goodsTypeWidget(),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                      key: personalDesTextKey,
                      child: ExpandableText(
                        '测试长文字折叠测试长文字折叠测试长文字折叠测试长文字长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠测试长文字折叠',
                        style: TextStyle(fontSize: 14, height: 1.5),
                        maxLines: 3,
                        expandText: '展开',
                        collapseText: '收起',
                        onExpandedChanged: (bool isExpand) {
                          if (isExpand) {

                          } else {

                          }
                        },
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      ///常见问题
                      child: normalQuestionWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      ///评论
                      child: commentWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      ///猜你喜欢
                      child: guessLikeWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      ///感兴趣的人
                      child: InterestedWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      ///最近浏览
                      child: recentScanWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colours.bg_fff4f5f9,
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      ///社群
                      child: groupWidget(),
                    ),
                  ],
                ),
              ),

              ///底部购买按钮
              Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        DoubleClick(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                ImageIcon(
                                  AssetImage('assets/images/testi.png'),
                                  size: 15,
                                ),
                                SizedBox(height: 10),
                                Text('立即沟通',
                                    style: TextStyle(
                                        color: Colours.text_131313,
                                        fontSize: 11))
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: DoubleClick(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SelectGoodsTypeSheetWidget(
                                      onSelect: (value) {
                                        control.setSelect(value);
                                        Get.toNamed(
                                            '/shop/page/commit_order/commit_order_page',
                                            arguments: {
                                              "goodsId": 999,
                                              'selectValue': value
                                            });
                                      },
                                      selcetValue: control.selectValue,
                                    );
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colours.text_131313,
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Center(
                                child: Text(
                                  '购买服务',
                                  style: TextStyle(
                                      color: Colours.bg_ffffff, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )),
        );
      },
    );
  }

  Widget webHtml = SliverToBoxAdapter(
      child: Html(
    data: """<div>
        <p>富文本!</p>
        <h3>Features</h3>
        <ul>
          <li>It actually works</li>
          <li>It exists</li>
          <li>It doesn't cost much!</li>
        </ul>
        <!--You can pretty much put any html in here!-->
      </div>""",
  ));

  ///商家头像名称
  Widget sellerInfoWidget() {
    return SliverToBoxAdapter(
      child: DoubleClick(
        onTap: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SellerDetailSheetWidget();
              });
        },
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 35,
                height: 35,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      ImageUtils.getImageProvider(SPUtils.getAvatar()),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "大萨达撒多",
                  style: TextStyle(
                    color: Colours.text_131313,
                    fontSize: 18,
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage('assets/images/ic_arrow_right.png'),
                  size: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///商品价格分类
  Widget goodsTypeWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 45,
            child: TabBar(
                indicatorColor: Colors.transparent,
                controller: _tabController,
                unselectedLabelColor: Colours.text_717888,
                labelColor: Colours.text_131313,
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                tabs: goodsTypeList.map((text) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(text),
                  );
                }).toList()),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 300,
            child: TabBarView(
              controller: _tabController,
              children: goodsTypeList.map((e) {
                int index = goodsTypeList.indexOf(e);
                return goodsInfoWidget(index);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  ///商品规格信息
  Widget goodsInfoWidget(int index) {
    Widget rowStyle = Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text('完整封面（2张授权库的图片）、格式设计章节、副标题和项目符号列表、3张图片',
                  style: TextStyle(color: Colours.text_131313, fontSize: 13))),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: ImageIcon(
              AssetImage('assets/images/ic_arrow_right.png'),
              color: Colours.text_1BC8CB,
              size: 15,
            ),
          )
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          rowStyle,
          rowStyle,
          rowStyle,
          rowStyle,
          rowStyle,
        ],
      ),
    );
  }

  ///常见问题
  Widget normalQuestionWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                '常见问题',
                style: TextStyle(
                    color: Colours.text_131313,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
              ImageIcon(
                AssetImage('assets/images/ic_arrow_right.png'),
                size: 15,
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageIcon(
                AssetImage('assets/images/ic_arrow_right.png'),
                size: 15,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(
                '你以前做过这项工作吗？',
                style: TextStyle(color: Colours.text_131313, fontSize: 15),
              )),
            ],
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageIcon(
                AssetImage('assets/images/ic_arrow_right.png'),
                size: 15,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(
                '是的，我为当地艺术家和企业家做过高质量的封面，主要都是回头这是我交付每件艺术品的目…',
                style: TextStyle(color: Colours.text_131313, fontSize: 15),
              )),
            ],
          ),
        ],
      ),
    );
  }

  ///评论模块
  Widget commentWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                '全部评论',
                style: TextStyle(
                    color: Colours.text_131313,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
              ImageIcon(
                AssetImage('assets/images/ic_arrow_right.png'),
                size: 15,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      ImageUtils.getImageProvider(SPUtils.getAvatar()),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                children: [
                  Row(children: [
                    Expanded(
                        child: Text(
                      '笑笑糖·3月14日',
                      style:
                          TextStyle(color: Colours.text_717888, fontSize: 12),
                    )),
                    Icon(
                      Icons.star,
                      color: Colours.text_FFB31E,
                      size: 15,
                    ),
                    Text('5.0',
                        style:
                            TextStyle(color: Colours.text_FFB31E, fontSize: 12))
                  ]),
                  SizedBox(height: 10),
                  Text('这是一个很负责人的设计师，和他沟通合作很顺畅，整个合作特别顺利。',
                      style: TextStyle(color: Colours.text_131313, height: 1.3))
                ],
              ))
            ],
          )
        ],
      ),
    );
  }

  ///猜你喜欢
  Widget guessLikeWidget() {
    final Widget listView = ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: ShopGoodsItem(ShopEntity(
              'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
              '啦啦啦啦',
              1,
              false)),
        );
      },
      // itemBuilder: (context, index) => item,
    );

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('你可能还会喜欢',
              style: TextStyle(
                  color: Colours.text_131313,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          SizedBox(height: 20),
          Container(
            height: 255,
            child: listView,
          )
        ],
      ),
    );
  }

  ///可能感兴趣的人
  Widget InterestedWidget() {
    final Widget listView = ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: InterestedPeopleItem(InterestedEntity(
              'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
              '啦啦啦啦',
              1,
              false)),
        );
      },
      // itemBuilder: (context, index) => item,
    );

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('你可能感兴趣的人',
              style: TextStyle(
                  color: Colours.text_131313,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 2, top: 2, bottom: 2),
            height: 255,
            child: listView,
          )
        ],
      ),
    );
  }

  ///最近浏览过
  Widget recentScanWidget() {
    final Widget listView = ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: ShopGoodsItem(ShopEntity(
              'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
              '啦啦啦啦',
              1,
              false)),
        );
      },
      // itemBuilder: (context, index) => item,
    );

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('最近浏览过的',
              style: TextStyle(
                  color: Colours.text_131313,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          SizedBox(height: 20),
          Container(
            height: 255,
            child: listView,
          )
        ],
      ),
    );
  }

  ///技能和兴趣社群
  Widget groupWidget() {
    final Widget listView = ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: GroupItem(GroupItemEntity(
              'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
              '啦啦啦啦',
              1,
              false)),
        );
      },
      // itemBuilder: (context, index) => item,
    );

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text('技能和兴趣社群',
                      style: TextStyle(
                          color: Colours.text_131313,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              ImageIcon(
                AssetImage('assets/images/ic_arrow_right.png'),
                size: 15,
              )
            ],
          ),
          Container(
            child: listView,
          )
        ],
      ),
    );
  }
}
