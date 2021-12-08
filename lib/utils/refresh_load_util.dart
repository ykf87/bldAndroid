import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/constant/refres_status.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/19 13:51
/// @Description: 刷新加载工具类

class RefreshLoadUtil {

  static ClassicalHeader getClassicalHeader () {
    return ClassicalHeader(
      refreshText: '下拉可以刷新',
      refreshReadyText: '释放立即刷新',
      refreshingText: '正在刷新...',
      refreshedText: '刷新完成',
      refreshFailedText: '刷新失败',
      infoText: '上次更新 %T',
      noMoreText: '没有更多数据'
    );
  }

  static ClassicalFooter getClassicalFooter() {
    return ClassicalFooter(
      loadText: '上拉可以加载',
      loadReadyText: '释放立即加载',
      loadingText: '正在加载...',
      loadedText: '加载完成',
      loadFailedText: '加载失败',
      infoText: '上次加载 %T',
      noMoreText: '没有更多数据'
    );
  }

  static WeFreeFooter getWeFreeFooter() {
    return WeFreeFooter(
        loadText: '上拉可以加载',
        loadReadyText: '释放立即加载',
        loadingText: '正在加载...',
        loadedText: '加载完成',
        loadFailedText: '加载失败',
        noMoreText: '我是有底线的',
        infoText: '',
        textColor: Colours.color_6A6E7E
    );
  }

  /// 设置刷新控制器状态
  /// controller 刷新加载控制器
  /// refreshStatus 刷新加载状态
  /// data 数据
  /// pageSize 每页size
  static setRefreshStatus(EasyRefreshController controller, int refreshStatus, {List? data, int pageSize = RefreshStatus.PAGE_ZERO}) {
    if(refreshStatus == RefreshStatus.NORMAL || refreshStatus == RefreshStatus.REFRESH) {
      controller.resetLoadState();
      controller.finishRefresh();
    }
    if(refreshStatus == RefreshStatus.MORE){
      controller.finishLoad(noMore: data == null ? true : data.length == pageSize);
    }
  }
}