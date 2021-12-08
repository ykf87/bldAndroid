import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/page/home/repository/index_goods_repository.dart';
import 'package:SDZ/page/home/widget/banner.dart';
import 'package:SDZ/page/home/widget/gridmenu/view.dart';
import 'package:SDZ/page/home/widget/index_tabbar.dart';
import 'package:SDZ/page/home/widget/searchbar.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/widget/edit_page_handle.dart';
import 'package:SDZ/widget/loading_more_list_indicator.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';



class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with TickerProviderStateMixin {

  late TabController tabController;
  IndexGoodsRepository indexGoodsRepository = IndexGoodsRepository();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_listenTabbar);
  }

  void _listenTabbar(){

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EditePageHandle(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ExtendedNestedScrollView(
          controller: _scrollController,
          body: renderViews(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const IndexHomeAppbar(),
              SliverPadding(
                  padding: const EdgeInsets.only(top: 12),
                  sliver: const SliverToBoxAdapter(child: IndexCarousel(),)),
              const GridMenuComponent(),
              SliverPersistentHeader(
                delegate: IndexTabbar(tabController),
                pinned: true,
              ),
            ];
          },
        ),
      ),
    );
  }

  Widget renderViews() {
    return TabBarView(
      children: [_buildGoodsList(), Container(),  _buildGoodsList()],
      controller: tabController,
    );
  }
  Widget _buildGoodsList() {
    return LoadingMoreList(ListConfig<CardItemEntity>(
      extendedListDelegate:
      const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemBuilder: (context, item, index) {
        return WaterfallGoodsCard(item);
      },
      sourceList: indexGoodsRepository,
      padding: const EdgeInsets.only(left: 12, right: 12),
//      lastChildLayoutType: LastChildLayoutType.foot,
      indicatorBuilder: (context, state) {
        return LoadingMoreListCostumIndicator(state, isSliver: false);
      },
    ));
  }
}

