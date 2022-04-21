import 'package:SDZ/generated/json/base/json_convert_content.dart';

class AliOssEntity with JsonConvert<AliOssEntity> {
	String? securityToken;
	String? expiration;
	String? accessKeyId;
	String? accessKeySecret;
	String? domain;
	String? bucket;
}
