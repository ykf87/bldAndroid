import 'package:get/get.dart';
import 'package:SDZ/page/shop/item/shop_goods_item.dart';


class ShopModuleLogic extends GetxController {

  bool _isNewer = false; //最新
  bool _isHoter = false; //最热

  var selTime = '交付时间'.obs;

  bool get isNewer => _isNewer;

  bool get isHoter => _isHoter;

  //选中最新
  void selNewer() {
    _isNewer = !isNewer;
    _isHoter = false;
    selTime.value ='24小时';
    update();
  }

  //选中最新
  void selHoter() {
    _isHoter = !_isHoter;
    _isNewer = false;
    selTime.value ='交付时间';
    update();
  }

  final List<ShopEntity> list = [
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '啦啦啦啦',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哈哈哈哈',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '糖果',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '阿杜',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '勒布朗',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
    ShopEntity(
        'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
        '哒哒哒哒',
        1,
        false),
  ];
}
