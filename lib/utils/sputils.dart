import 'package:shared_preferences/shared_preferences.dart';
import 'package:SDZ/utils/provider.dart';

class SPUtils {
  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  SPUtils._internal();

  static SharedPreferences? _spf;

  static Future<SharedPreferences> init() async {
    if (_spf == null) {
      _spf = await SharedPreferences.getInstance();
    }
    return _spf!;
  }

  ///主题
  static Future<bool> saveThemeIndex(int? value) {
    return _spf!.setInt('key_theme_color', value ?? 0);
  }

  static int getThemeIndex() {
    if (_spf!.containsKey('key_theme_color')) {
      return _spf!.getInt('key_theme_color') ?? 3;
    }
    return 3;
  }

  ///语言
  static Future<bool> saveLocale(String locale) {
    return _spf!.setString('key_locale', locale);
  }

  static String getLocale() {
    String? locale = _spf!.getString('key_locale');
    return locale ?? LOCALE_FOLLOW_SYSTEM;
  }

  ///昵称
  static Future<bool> saveNickName(String nickName) {
    return _spf!.setString('key_nickname', nickName);
  }

  static String getNickName() {
    return _spf!.getString('key_nickname') ?? '';
  }

  ///是否同意隐私协议
  static Future<bool> saveIsAgreePrivacy(bool isAgree) {
    return _spf!.setBool('key_agree_privacy', isAgree);
  }

  static bool isAgreePrivacy() {
    return _spf!.getBool('key_agree_privacy') ?? false;
  }

  ///是否已登陆
  static bool isLogined() {
    // String nickName = getNickName();
    // return nickName != null && nickName.isNotEmpty;
    return getUserId().isNotEmpty;
  }

  /// 设置deviceid
  static Future<bool> setDeviceId(String deviceId) {
    return _spf!.setString('deviceId', deviceId);
  }

  static String getDeviceId() {
    String? name = _spf!.getString('deviceId');
    return name ?? '';
  }

  /// 设置mac
  static Future<bool> setMacId(String macid) {
    return _spf!.setString('macid', macid);
  }

  static String getMacId() {
    return _spf!.getString('macid') ?? '';
  }

  /// 设置userToken
  static Future<bool> setUserToken(String userToken) {
    return _spf!.setString('userToken', userToken);
  }

  static String getUserToken() {
    return _spf!.getString('userToken') ?? '';
  }

  /// 设置用户id
  static Future<bool> setUserId(String userId) {
    return _spf!.setString('userId', userId);
  }

  static String getUserId() {
    return _spf!.getString('userId') ?? '';
  }

  /// 设置用户昵称
  static Future<bool> setUserNickName(String nickName) {
    return _spf!.setString('userNickName', nickName);
  }

  static String get userNickName => _spf!.getString('userNickName') ?? '';

  /// 设置头像
  static Future<bool> setAvatar(String avatar) {
    return _spf!.setString('avatar', avatar);
  }

  static String getAvatar() {
    return _spf!.getString('avatar') ?? '';
  }

  /// 设置手机号
  static Future<bool> setUserAccount(String userAccount) {
    return _spf!.setString('userAccount', userAccount);
  }

  static String getUserAccount() {
    return _spf!.getString('userAccount') ?? '';
  }

  /// 设置协议是否已读
  /// agree 是否同意协议
  static Future<bool> setAgreementRead(bool agree) =>
      _spf!.setBool('agreementRead', agree);

  static bool get isAgreementRead => _spf!.getBool('agreementRead') ?? false;

  /// 是否完善个人信息
  static Future<bool> setFinishPerfectUserInfo() =>
      _spf!.setBool('finishPerfectUserInfo', true);

  static bool getFinishPerfectUserInfo() =>
      _spf!.getBool('finishPerfectUserInfo') ?? false;

  /// 广告页权限只在首次安装申请
  static Future<bool> setSplashPermissionRequested() =>
      _spf!.setBool('splashPermissionRequested', true);

  static bool getSplashPermissionRequested() =>
      _spf!.getBool('splashPermissionRequested') ?? false;

  /// 通知权限申请
  static Future<bool> setNotificationPermissionRequested() =>
      _spf!.setBool('notificationPermissionRequested', true);

  static bool getNotificationPermissionRequested() =>
      _spf!.getBool('notificationPermissionRequested') ?? false;

  /// 蒙版引导
  static Future<bool> setMaskGuide() => _spf!.setBool('maskGuide', true);

  static bool getMaskGuide() => _spf!.getBool('maskGuide') ?? false;

  /// 是否首次切换达人列表
  static bool get isFirstToggleTalentList =>
      _spf!.getBool('isFirstToggleTalentList') ?? false;

  static Future<bool> setIsFirstToggleTalentList() =>
      _spf!.setBool('isFirstToggleTalentList', true);

  /// 设置搜索关键词到本地
  static Future<bool> setSearchKeywordList(String keyword) =>
      _spf!.setString('searchListKeyword', keyword);

  /// 获取本地搜索关键词
  static String get searchKeywordList =>
      _spf!.getString('searchListKeyword') ?? '';

  /// 设置推送code
  static Future<bool> setPushCode(String code) =>
      _spf!.setString('setPushCode', code);

  static String get pushCode => _spf!.getString('pushCode') ?? '';

  /// 保存筛选条件
  static Future<bool> setSearchOptions(String key, String options) =>
      _spf!.setString(key, options);

  static String getSearchOptions(key) => _spf!.getString(key) ?? '';

  //保存代理开关
  static Future<bool> setProxySwitch(bool proxySwitch) {
    return _spf!.setBool('proxySwitch', proxySwitch);
  }

  //获取代理开关
  static bool getProxySwitch() {
    return _spf!.getBool('proxySwitch') ?? false;
  }

  //保存代理IP
  static Future<bool> setProxyIp(String proxyIp) {
    return _spf!.setString('proxyIp', proxyIp);
  }

  //获取代理IP
  static String getProxyIp() {
    return _spf!.getString('proxyIp') ?? "";
  }

  /// 记录进入后台时当前时间
  static Future<bool> setAppBackgroundTime() {
    return _spf!.setInt('appBackgroundTime', new DateTime.now().millisecondsSinceEpoch);
  }

  /// 获取进入后台时当前时间
  static get appBackgroundTime => _spf!.getInt('appBackgroundTime');
}
