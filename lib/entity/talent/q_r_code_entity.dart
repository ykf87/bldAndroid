import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/q_r_code_entity.g.dart';


@JsonSerializable()
class QRCodeEntity {

	QRCodeEntity();

	factory QRCodeEntity.fromJson(Map<String, dynamic> json) => $QRCodeEntityFromJson(json);

	Map<String, dynamic> toJson() => $QRCodeEntityToJson(this);

	String? url;
}
