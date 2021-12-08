class SaveImgEntity {
  late int filePath;
  late String errorMessage;
  late bool isSuccess;

  SaveImgEntity(this.filePath, this.errorMessage, this.isSuccess);

  SaveImgEntity.fromJson(Map<String, dynamic> map) {
    this.filePath = map["filePath"];
    this.errorMessage = map["errorMessage"];
    this.isSuccess = map["isSuccess"];
  }
}

