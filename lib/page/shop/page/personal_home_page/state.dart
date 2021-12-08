import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:SDZ/page/shop/item/shop_goods_item.dart';

class PersonalHomePageState {
  bool isFocus =false;
  GlobalKey personalDesTextKey = GlobalKey();//个人简介
  double personalDesTextHeightNor = 0;//收起时个人简介文本高度
  double personalDesTextHeight = 0;//收起时个人简介文本高度
  EasyRefreshController refreshController = EasyRefreshController();

  var findTitles = ["推荐", "插画", "音频", "文书写作", "红人", "短视频"];

  List<String> listResume = [
    '中国传媒大学',
    '浙江·杭州',
  ];

  List<String> listSkill = [
    '盗墓笔记',
    '鬼吹灯',
    '这个书名是凑的',
    '藏海花',
    '这个书名是凑的',
    '藏海花',
    '沙海',
    '藏海花',

  ];

  List<String> tabTitle = [
    '商品','笔记','喜欢'
  ];

  final List<ShopEntity> goodsList = [
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

  PersonalHomePageState() {
    ///Initialize variables

  }
}
