import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/ali_oss_entity.g.dart';


@JsonSerializable()
class AliOssEntity {

	AliOssEntity();

	factory AliOssEntity.fromJson(Map<String, dynamic> json) => $AliOssEntityFromJson(json);

	Map<String, dynamic> toJson() => $AliOssEntityToJson(this);

	String? securityToken;
	String? expiration;
	String? accessKeyId;
	String? accessKeySecret;
	String? domain;
	String? bucket;
}
