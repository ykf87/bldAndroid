/// @Author: ljx
/// @CreateDate: 2021/9/28 9:38
/// @Description: 
class RefreshEvent {

  /// 刷新首页数据
  static const INDEX = 1;

  int? type;

  RefreshEvent(int type) {
    this.type = type;
  }
}