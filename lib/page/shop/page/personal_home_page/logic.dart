import 'package:get/get.dart';
import 'package:SDZ/page/shop/item/shop_goods_item.dart';

import 'state.dart';

class PersonalHomePageLogic extends GetxController {
  final state = PersonalHomePageState();


  void setFocus() {
    state.isFocus = !state.isFocus;
    update();
  }


  void doLoadMore() {
    state.goodsList.add(ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '啦啦啦啦',
        1,
        false));
    state.goodsList.add(ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '啦啦啦啦',
        1,
        false));
    state.goodsList.add(ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '啦啦啦啦',
        1,
        false));
    state.goodsList.add(ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '啦啦啦啦',
        1,
        false));
    update();
  }

  void doRefresh() {
    // state.goodsList.removeRange(3, state.goodsList.length - 1);
    update();
  }
}
