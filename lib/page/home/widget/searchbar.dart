// Flutter imports:
// Package imports:
import 'package:SDZ/page/home/sign/view.dart';
import 'package:SDZ/page/menu/about.dart';
import 'package:SDZ/page/search/search_page.dart';
import 'package:SDZ/widget/appbar_search.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

// Project imports:

/// 首页导航栏
class IndexHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const IndexHomeAppbar({Key? key}) : super(key: key);

  void navTo(BuildContext context) {
    Get.toNamed('/search/search_page');
  }

  @override
  Widget build(BuildContext context) {
    return SAppBarSearch(
      hintText: '输入关键字,例如:"男装"',
      onTap: () => navTo(context),
      readOnly: true,
      eve: 0,
      leadingWidth: 58,
      leading: DoubleClick(
        onTap: (){
          Get.to(SignPage());
        },
        child: Container(
          alignment: Alignment.center,
          child:Image(
            image: AssetImage("assets/images/ic_logo.jpg"),
            width: 40,
            height: 40,
          ),
        ),
      ),
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(48),
      //   child: Consumer(
      //     builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
      //       final loading = watch(indexRiverpod).indexLoading;
      //       final categoryWidgets = utils.widgetUtils.categoryTabs(context);
      //       return LayoutBuilder(
      //         builder: (BuildContext context, BoxConstraints constraints) {
      //           return Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               AnimatedContainer(
      //                 duration: const Duration(milliseconds: 800),
      //                 height: 46,
      //                 child: DefaultTabController(
      //                   length: 1 + categoryWidgets.length,
      //                   child: Container(
      //                     alignment: Alignment.centerLeft,
      //                     child: TabBar(
      //                       isScrollable: true,
      //                       tabs: [
      //                         const Tab(
      //                           text: '精选',
      //                         ),
      //                         ...categoryWidgets
      //                       ],
      //                       labelColor: Colors.black,
      //                       indicatorColor: Colors.transparent,
      //                       unselectedLabelColor: Colors.grey,
      //                       onTap: (int index) {
      //                         if (index == 0) {
      //                           return;
      //                         }
      //                         final category = context.read(categoryRiverpod).getCategoryByIndex(index - 1);
      //                         utils.widgetUtils.to(NewGoodsList(
      //                           category: category,
      //                           initIndex: context.read(categoryRiverpod).getIndexWithCategory(category),
      //                         ));
      //                       },
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               AnimatedSwitcher(
      //                 duration: const Duration(milliseconds: 300),
      //                 child: loading
      //                     ? const LinearProgressIndicator(
      //                         minHeight: 2.0,
      //                       )
      //                     : Container(
      //                         height: 2.0,
      //                       ),
      //               )
      //             ],
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
      isSliveWidget: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
