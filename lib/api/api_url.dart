import 'package:SDZ/env.dart';

class ApiUrl {
//  static const String base_url = 'http://test-wefree-gateway.shijianke.com/server/';
//  static const String base_url = 'http://sim-wefree-gateway.shijianke.com/';



  static String getJTKBaseUrl() {
    return 'http://api.act.jutuike.com/';
  }

  static String getBLDBaseUrl() {
    return 'http://47.111.106.204/api/';
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
  ///商品推广转链
  static const String recommend = 'union/convert';
  ///饿了么外卖接口，饿了么生鲜接口
  static const String elm = 'http://api.jutuike.com/Ele/act';
  static const String mobile = 'http://api.jutuike.com/recharge/mobile';
  static const String electricity = 'http://api.jutuike.com/electricity/act';
  static const String didi = 'http://api.jutuike.com/didi/act';///1-打车、2-加油 -3货运 4-花小猪
  static const String meituan = 'http://api.jutuike.com/Meituan/act';///活动类型 1-外卖 2-商超 3-优选 4-优选1.99促销页 5-优选秒杀栏目活动 6-酒店 7- 美团优选新人活动页 8-外卖品质商家活动 默认1


  /// bld 相关api
  static const String task = 'task';
  /// 全局配置信息
   static final String getGlobalConfig = "config";
  /// 首页分类
   static final String getClassifyList = "cate";
  /// 首页列表
   static final String getHomeList = "list";
  /// 登录
   static final String login = "login";
  /// 详情
   static final String articleDetail = "info/";
   static final String register = "sigin";
   static final String cancle = "logout";///注销
   static final String center = "center";
   static final String collect = "heart";
   static final String reset = "reset";
   static final String help = "help";
   static final String bankList = "bank";
   static final String videoSuccess = "plaied";
   static final String agreement = "agreement";
  /// 积分明细
   static final String jifen = "jifen";
  /// 绑定银行卡
   static final String bindBank = "card";
  /// 银行卡账号提现
   static final String alipayWithdraw = "tixian";
  /// 赠品列表
   static final String giftList = "signins/giveaways";
  /// 领取赠品
   static final String giveget = "signins/giveget";
   ///选择签到奖品
   static final String chooseGift = "signins/choose";
  ///签到主页信息
   static final String signedInfo = "signins/signed";
   ///签到
   static final String doSign = "signins/signe";
  ///订单列表
  static final String orderList = "user/orders";
}
