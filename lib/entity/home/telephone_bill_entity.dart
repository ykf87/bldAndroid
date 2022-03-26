import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/telephone_bill_entity.g.dart';


@JsonSerializable()
class TelephoneBillEntity {

	TelephoneBillEntity();

	factory TelephoneBillEntity.fromJson(Map<String, dynamic> json) => $TelephoneBillEntityFromJson(json);

	Map<String, dynamic> toJson() => $TelephoneBillEntityToJson(this);

  String? h5_url;
  String? h5;
  String? jtk_url;
  String? short_url;///话费链接
  String? short_click_url;///滴滴短链
}
