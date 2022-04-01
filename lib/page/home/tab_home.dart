import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/page/home/goods_detail/detail.dart';
import 'package:SDZ/page/home/repository/index_goods_repository.dart';
import 'package:SDZ/page/home/widget/banner.dart';
import 'package:SDZ/page/home/widget/gridmenu/view.dart';
import 'package:SDZ/page/home/widget/index_tabbar.dart';
import 'package:SDZ/page/home/widget/searchbar.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/widget/edit_page_handle.dart';
import 'package:SDZ/widget/loading_more_list_indicator.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/view/ad_banner_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'goodsList/NewGoodsListPage.dart';



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
          body: tabBarViews(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              IndexHomeAppbar(),
              SPUtils.getAdShow()?SliverToBoxAdapter(
                child:SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: AdBannerWidget(
                    posId: CSJUtils.CSJBannerId,
                    width: 1300,
                    height: 150,
                    interval: 30,
                    show: true,
                  ),
                ) ,
              ):SliverToBoxAdapter(),
              // SliverPadding(
              //     padding: const EdgeInsets.only(top: 12),
              //     sliver: const SliverToBoxAdapter(child: IndexBanner(),)),
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

  Widget tabBarViews() {
    return TabBarView(
      children: [NewGoodsListPage('taobao'),  NewGoodsListPage('pdd'), NewGoodsListPage('jd')],
      controller: tabController,
    );
  }

}
