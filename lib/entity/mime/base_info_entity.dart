import 'package:SDZ/generated/json/base/json_convert_content.dart';

class BaseInfoEntity with JsonConvert<BaseInfoEntity> {
  late String avatar;
  late String nickname;
  late String telephone;
  String? wechat;
  String? province = '';
  late String provinceCode;
  String? area = '';
  late String cityCode;
   String? address;
  late String areaCode;
  String? city = '';
}
