class GlobalEntity {
  late int errCode;
  late String errMsg;
  late Global content;

  GlobalEntity(this.errCode, this.errMsg, this.content);

  bool get isSuccess => 0 == errCode;

  GlobalEntity.fromJson(Map<String, dynamic> map) {
    this.errCode = map["errCode"];
    this.errMsg = map["errMsg"];
    this.content =
        (map['content'] != null ? Global.fromJson(map['content']) : null)!;
  }
}

class Global {
  late BasicInfoEntity basic_info;
  late int task_audit_count;
  late int is_login;


  Global(this.basic_info, this.task_audit_count,this.is_login);

  Global.fromJson(Map<String, dynamic> map) {
    this.task_audit_count = map['task_audit_count'];
    this.basic_info = BasicInfoEntity.fromJson(map['basic_info']);
    this.is_login = map['is_login'];
  }
}

class BasicInfoEntity {
  int? account_id;
  int? enterprise_collect_count;
  int? job_collect_count;
  String? profile_url;
  String? telphone;
  String? true_name;
  int? verify_status;

  BasicInfoEntity(
      this.account_id,
      this.enterprise_collect_count,
      this.job_collect_count,
      this.profile_url,
      this.telphone,
      this.true_name,
      this.verify_status);

  BasicInfoEntity.fromJson(Map<String, dynamic> map) {
    this.account_id = map['account_id'];
    this.enterprise_collect_count = map['enterprise_collect_count'];
    this.true_name = map['true_name'];
    this.profile_url = map['profile_url'];
    this.job_collect_count = map['job_collect_count'];
    this.telphone = map['telphone'];
    this.verify_status = map['verify_status'];
  }
}
