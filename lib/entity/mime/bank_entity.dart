import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/bank_entity.g.dart';


@JsonSerializable()
class BankEntity {

	BankEntity();

	factory BankEntity.fromJson(Map<String, dynamic> json) => $BankEntityFromJson(json);

	Map<String, dynamic> toJson() => $BankEntityToJson(this);

  String? id;
  String? email;
  String? phone;
  String? number;
  String? bankname;
}
