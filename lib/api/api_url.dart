import 'package:SDZ/env.dart';

class ApiUrl {
//  static const String base_url = 'http://test-wefree-gateway.shijianke.com/server/';
//  static const String base_url = 'http://sim-wefree-gateway.shijianke.com/';



  static String getBaseUrl() {
    return 'http://api.act.jutuike.com/';
  }

  /// 用户协议
  /// 1 苹果 2 安卓
  static String getUserProtocal({bool isIOS: true}) {
    return '';
  }

  /// 用户隐私
  /// 1 苹果 2 安卓
  static String getUserPolicy({bool isIOS: true}) {
    return '';
  }

  /// 退出登录
  static const String logout = 'logout';

  /// OSS 文件上传之前进行获取配置信息
  static const String getOssConfig = 'config/oss';


  /// 达人领域列表
  static const String tag_kol_skills = 'tag/kol/skills';

  /// 意见反馈
  static const String suggestion_feedback = 'suggestion/feedback';

  /// 达人列表搜索
  static const String kol_list = 'kol/list';

  /// 关注达人
  static const String kol_following = 'kol/following';

  /// 登录验证码
  static const String sms_code = 'sms/code';

  /// 登录
  static const String login = 'login';

  /// 继续登录
  static const String login_continue = 'login/continue';

  /// 完善信息
  static const String user_info = 'user/info';

  static const String feedback = 'suggestion/feedback';

  /// 我的收藏列表
  static const String collections = 'card/collection/personal';

  // ///取消收藏
  // static const String cancleCollect = 'kol/card/collection';

  /// 我的关注列表
  static const String followers = 'user/personal/followers';

  /// 取消关注
  static const String cancleFocus = 'kol/following';

  ///更新我的基础信息
  static const String updateBaseInfo = 'user/profile/basis';

  ///我的基础信息
  static const String getbaseInfo = 'user/profile/basis';

  ///浏览记录
  static const String history = 'user/view/history';

  ///查看我的PR名片
  static const String prCard = 'card/pr/detail';

  ///PR擅长领域
  static const String prskills = 'tag/pr/skills';

  ///修改PR 卡片
  static const String modifyPRCard = 'card/pr/detail';

  ///修改基础信息
  static const String modifyBaseInfo = 'user/profile/basis';

  ///注销
  static const String cancellationPhone = 'user/account';

  ///个人中心
  static const String userCenter = 'user/profile/homepage';

  /// 达人主页
  static const String talentHomepage = 'kol/homepage';

  ///关注达人
  static const String following = 'kol/following';

  /// 达人名片详情
  static const String talentDetail = 'card/kol/detail';

  /// 名片收藏
  static const String collection = 'card/collection';

  /// 更新头像
  static const String info = 'user/info';


  ///聚推客相关api

  ///电商聚合商品列表API接口
  static const String query_goods = 'union/query_goods';
}
