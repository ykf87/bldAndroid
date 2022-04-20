import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/ad_task_entity.g.dart';

import 'package:SDZ/res/colors.dart';
import 'package:flutter/cupertino.dart';

@JsonSerializable()
class AdTaskEntity {

	AdTaskEntity();

	factory AdTaskEntity.fromJson(Map<String, dynamic> json) => $AdTaskEntityFromJson(json);

	Map<String, dynamic> toJson() => $AdTaskEntityToJson(this);

  int id = 0;
  String? title;
  int max = 0; //一天最多可以看几次
  int min = 0; // 为1时表示每一次都有奖励，min为max时表示要全部完成一次性奖励
  int prize = 0; //省币奖励
  int times = 0; //表示当前做了多少次任务
  String? videoId;
  int resType = 0;
  int platform = 1; //1:穿山甲 2：优量汇

  int leftCout() {
    return max - times;
  }

  String getImg() {
    if (resType == 0) {
      return "assets/images/integral_bg_waterfall_flow_1";
    }
    if (resType == 1) {
      return "assets/images/integral_bg_waterfall_flow_2";
    }
    if (resType == 2) {
      return "assets/images/integral_bg_waterfall_flow_3";
    }
    if (resType == 3) {
      return "assets/images/integral_bg_waterfall_flow_4";
    }
    return "assets/images/integral_bg_waterfall_flow_1";
  }

  Color getTextColor() {
    if (resType == 1) {
      return Colours.color_water_blue;
    }
    if (resType == 2) {
      return  Colours.color_water_red;
    }
    if (resType == 3) {
      return Colours.color_water_yellow;
    }
    if (resType == 4) {
      return Colours.color_water_green;
    }
    return Colours.color_water_blue;
  }
}
