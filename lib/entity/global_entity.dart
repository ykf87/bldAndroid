import 'package:SDZ/generated/json/base/json_convert_content.dart';

class GlobalEntity with JsonConvert<GlobalEntity> {
   String? appname;
   String? version;
   String? versions;
   String? service;
   String? isadv;//是否开启广告
}
