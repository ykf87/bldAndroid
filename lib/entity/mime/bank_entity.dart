import 'package:SDZ/generated/json/base/json_convert_content.dart';

class BankEntity with JsonConvert<BankEntity> {
  String? id;
  String? email;
  String? phone;
  String? number;
  String? bankname;
}
