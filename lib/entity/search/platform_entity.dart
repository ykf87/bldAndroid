/// @Author: ljx
/// @CreateDate: 2021/9/9 9:53
/// @Description: 

class PlatformEntity {
  int? type;

  String? title;

  String? svgPath;

  bool isSelect;

  PlatformEntity(this.title, this.svgPath, this.type, {this.isSelect = false});
}