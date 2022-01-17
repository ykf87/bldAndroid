import 'package:SDZ/generated/json/base/json_convert_content.dart';

class TelephoneBillEntity with JsonConvert<TelephoneBillEntity> {
  String? h5_url;
  String? h5;
  String? jtk_url;
  String? short_url;///话费链接
  String? short_click_url;///滴滴短链
}
