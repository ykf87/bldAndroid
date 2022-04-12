/// @Author: ljx
/// @CreateDate: 2021/9/28 9:38
/// 激励视频回调
/// @Description: 
class MyAdRewardEvent {
  static final TYPE_CSJ = 1;
  static final TYPE_YLH = 2;
  int adType = 1;
  MyAdRewardEvent(int adType){
    this.adType =  adType;
  }
}