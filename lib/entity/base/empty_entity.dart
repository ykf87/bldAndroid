import 'package:SDZ/generated/json/base/json_field.dart';
import 'package:SDZ/generated/json/empty_entity.g.dart';


/// @Author: ljx
/// @CreateDate: 2021/9/9 11:43
/// @Description: 不关心返回数据，只关心接口是否成功
@JsonSerializable()
class EmptyEntity {

	EmptyEntity();

	factory EmptyEntity.fromJson(Map<String, dynamic> json) => $EmptyEntityFromJson(json);

	Map<String, dynamic> toJson() => $EmptyEntityToJson(this);


}