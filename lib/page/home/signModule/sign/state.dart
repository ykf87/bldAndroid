import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/sign/gift_list_entity.dart';
import 'package:SDZ/entity/sign_info_entity.dart';
import 'package:flutter/cupertino.dart';

class SignState {
  SignState() {
    ///Initialize variables
  }
  SignInfoEntity? signInfoEntity ;//签到信息
  bool isBtnEnable = false;
  String btnText = "未选择签到奖品";
  String tipsText = "请先选择签到奖品再进行签到~";
  // final List<GoodsEntity> list = [];
  final List<GiftEntity> list = [];

  ScrollController listScroll = new ScrollController();

}
