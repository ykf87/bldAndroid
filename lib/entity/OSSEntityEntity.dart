class OSSEntityEntity {
  int? errCode;
  String? errMsg;
  late Global content;

  OSSEntityEntity(this.errCode, this.errMsg, this.content);

  bool get isSuccess => 0 == errCode;

  OSSEntityEntity.fromJson(Map<String, dynamic> map) {
    this.errCode = map["errCode"];
    this.errMsg = map["errMsg"];
    this.content =
        (map['content'] != null ? Global.fromJson(map['content']) : null)!;
  }
}

class Global {

   String? accessKeyId;//表示Android/iOS应用初始化OSSClient获取的 AccessKeyId
   String? accessKeySecret;//表示Android/iOS应用初始化OSSClient获取AccessKeySecret
   String? endpoint;//访问的endpoint地址
   String? securityToken;//表示Android/iOS应用初始化的Token
   String? bucket;
   String? host;//OSS 文件头部链接
   String? Expiration;//

  Global(this.accessKeyId, this.accessKeySecret, this.endpoint, this.securityToken, this.bucket, this.host,this.Expiration);

  Global.fromJson(Map<String, dynamic> map) {
    this.accessKeyId = map['AccessKeyId'];
    this.accessKeySecret = map['AccessKeySecret'];
    this.endpoint = map['endpoint'];
    this.securityToken = map['SecurityToken'];
    this.bucket = map['bucket'];
    this.host = map['host'];
    this.Expiration = map['Expiration'];
  }
}

