import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/generated/json/base/json_convert_content.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/7 13:59
/// @Description: 

class BaseEntity<T> {

  T? data;
  String? message;
  int? code;

  BaseEntity({this.data, this.message, this.code});

  bool get isSuccess => code == ApiStatus.SUCCESS;

  BaseEntity.fromJson(Object obj){
    Map<String, dynamic> json = obj as Map<String, dynamic>;
    if(json['data'] != null && json['data'] != 'null'){
      data = JsonConvert.fromJsonAsT<T>(json['data']);
    }
    message = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['msg'] = this.message;
    data['code'] = this.code;
    return data;
  }
}