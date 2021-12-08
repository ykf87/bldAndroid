
class UserEntity {
  int? errCode;
  String? errMsg;
  User? content;

  UserEntity(this.errCode, this.errMsg, this.content);

  bool get isSuccess => 0 == errCode;

  UserEntity.fromJson(Map<String,dynamic> map) {
    this.errCode = map["errCode"];
    this.errMsg = map["errMsg"];
    this.content = map['content'] != null ? User.fromJson(map['content']) : null;
  }
}

class User {
  int? id;
  String? dynamic_password;
  String? true_name;
  String? profile_url;
  int? is_need_pop;
  int? is_register;
  String? phone_num;

  User(this.id, this.dynamic_password, this.true_name, this.profile_url, this.is_need_pop, this.is_register, this.phone_num);

  User.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.dynamic_password = map['dynamic_password'];
    this.true_name = map['true_name'];
    this.profile_url = map['profile_url'];
    this.is_need_pop = map['is_need_pop'];
    this.is_register = map['is_register'];
    this.phone_num = map['phone_num'];
  }
}