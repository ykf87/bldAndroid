
class SessionEntity{
  int? errCode;
  String? errMsg;
  Session? content;

  SessionEntity(this.errCode, this.errMsg, this.content);

  bool get isSuccess => 0 == errCode;

  SessionEntity.fromJson(Map<String,dynamic> map) {
    this.errCode = map["errCode"];
    this.errMsg = map["errMsg"];
    this.content = map['content'] != null ? Session.fromJson(map['content']) : null;
  }

}

class Session {
  String? challenge;
  String? pub_key_exp;
  String? pub_key_modulus;
  String? sessionId;
  String? userToken;
  int? expire_time;

  Session(this.challenge, this.pub_key_modulus, this.userToken, this.sessionId, this.pub_key_exp, this.expire_time);

  Session.fromJson(Map<String, dynamic> map) {
    this.challenge = map['challenge'];
    this.pub_key_exp = map['pub_key_exp'];
    this.pub_key_modulus = map['pub_key_modulus'];
    this.sessionId = map['sessionId'];
    this.userToken = map['userToken'];
    this.expire_time = map['expire_time'];
  }
}