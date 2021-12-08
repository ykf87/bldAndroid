/// @Author: ljx
/// @CreateDate: 2021/9/16 15:06
/// @Description: 
class SearchOptionsEntity {

  String? minFans;

  String? maxFans;

  /// 平台id list
  List? platformList;

  /// 达人领域标签 list
  List? skillTagList;

  SearchOptionsEntity({this.maxFans, this.minFans, this.platformList, this.skillTagList});
}