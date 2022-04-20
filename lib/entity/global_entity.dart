import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/global_entity.g.dart';

@JsonSerializable()
class GlobalEntity {
  GlobalEntity();

  factory GlobalEntity.fromJson(Map<String, dynamic> json) =>
      $GlobalEntityFromJson(json);

  Map<String, dynamic> toJson() => $GlobalEntityToJson(this);

  String? appname;
  String? version;
  String? versions;
  String? service;
  String? isadv; //是否开启广告
  int? opensign; //是否开启签到 1：开
  int? globaladv; //其他广告
  int? jiliadv; //激励
}
