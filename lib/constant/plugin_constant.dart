/// @Author: ljx
/// @CreateDate: 2021/8/20 10:42
/// @Description: 插件唯一标识

class PluginChannel {

  /// 选择器
  static const String PICKER = 'com.zhairenwu.plugin/picker';

  /// loading
  static const String LOADING = 'com.zhairenwu.plugin/loading';

  /// 友盟
  static const String UMENG = 'com.zhairenwu.plugin/umeng';
  /// 小程序
  static const String CALL_WECHAT = 'com.zhairenwu.plugin/wechat';
}

class PluginMethod {

  /// 显示城市选择
  static const String SHOW_CITY_PICKER = 'showCityPicker';
  /// 显示日期选择
  static const String SHOW_DATE_PICKER = 'showDatePicker';

  /// 显示加载提示
  static const String SHOW_LOADING = 'showLoading';
  /// 隐藏加载提示
  static const String DISMISS_LOADING = 'dismissLoading';

  /// 友盟初始化
  static const String UMENT_INIT = 'init';

  /// 友盟登录账号统计
  static const String UEMNT_SIGN_IN = 'signIn';

  /// 友盟退出账号统计
  static const String UEMNT_SIGN_OFF = 'signOff';

  /// 友盟页面自动统计
  static const String UEMNT_PAGE_COLLECTION_MODE_AUTO = 'pageCollectionModeAuto';
  /// 唤起小程序
  static const String SHOW_WECHAT = 'showWechat';
}