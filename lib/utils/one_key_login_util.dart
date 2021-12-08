import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shanyan/shanYanUIConfig.dart';
import 'package:shanyan/shanyan.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/constant/third_key.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:SDZ/widget/common_widgets.dart';

class OneKeyLoginUtil {
  static const CODE = 1000;
  static const CANCEL = 1011;

  factory OneKeyLoginUtil() => getInstance();

  static OneKeyLoginUtil get instance => getInstance();

  static late OneKeyLoginUtil _instance;
  static bool _isInstanceCreated = false;
  OneKeyLoginManager? _oneKeyLoginManager;

  /// 初始化是否成功
  bool _isInitSuccess = false;

  /// 预取号是否成功
  bool _isGetPhoneSuccess = false;

  OneKeyLoginUtil._internal() {
    if (_isInstanceCreated == false) {
      _oneKeyLoginManager = new OneKeyLoginManager();
    }
  }

  void init() {
    _oneKeyLoginManager
        ?.init(
            appId: defaultTargetPlatform == TargetPlatform.iOS
                ? ThirdKey.SY_IOS_ID
                : ThirdKey.SY_ANROID_ID)
        .then((value) {
      if (value.code == CODE) {
        _isInitSuccess = true;
        getPhoneInfo((res) {});
      }
    });
  }

  static OneKeyLoginUtil getInstance() {
    if (_isInstanceCreated == false) {
      _instance = OneKeyLoginUtil._internal();
    }
    _isInstanceCreated = true;
    return _instance;
  }

  ShanYanUIConfig getIOSUIConfig({bool isBottom = false}) {
    ShanYanUIConfig uiConfig = ShanYanUIConfig();

    ///是否自动销毁
    ///是否自动销毁 true：是 false：不是
    uiConfig.ios.isFinish = true;

    ///授权页背景配置三选一，支持图片，gif图，视频
    ///普通图片
    uiConfig.ios.setAuthBGImgPath = isBottom ? "ic_login_bg" : "img_bg";

    ///授权页状态栏 设置状态栏是否隐藏
    uiConfig.ios.setStatusBarHidden = false;

    ///设置导航栏标题文字
    uiConfig.ios.setNavText = '';

    ///设置导航栏标题文字颜色
    uiConfig.ios.setNavTextColor = "#FFFFFF";

    ///设置导航栏标题文字大小
    uiConfig.ios.setNavTextSize = 16;

    ///设置导航栏返回按钮图标靠右
    uiConfig.ios.setNavReturnImgPath = 'nav_button_white';
    uiConfig.ios.setNavReturnImgHidden = false;
    uiConfig.ios.setNavBackBtnAlimentRight = true;

    ///设置导航栏是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.ios.setAuthNavHidden = true;

    ///设置导航栏是否透明（true：透明；false：不透明）
    uiConfig.ios.setAuthNavTransparent = false;

    ///授权页logo
    ///设置logo图片
    uiConfig.ios.setLogoImgPath = "ic_wefree_logo";

    ///设置logo顶
    uiConfig.ios.layOutPortrait.setLogoTop = 120;

    ///设置logo宽度
    uiConfig.ios.layOutPortrait.setLogoWidth = 120;

    ///设置logo高度
    uiConfig.ios.layOutPortrait.setLogoHeight = 80;

    ///设置logo是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.ios.setLogoHidden = isBottom;

    ///设置logo相对屏幕左侧X偏移
    uiConfig.ios.layOutPortrait.setLogoCenterX = 0;

    ///授权页号码栏
    ///设置号码栏字体颜色
    uiConfig.ios.setNumberColor = "#FFFFFF";

    uiConfig.ios.layOutPortrait.setNumFieldTop = isBottom ? 32 : 373;

    ///设置号码栏相对于屏幕底部x偏移
    uiConfig.ios.layOutPortrait.setNumFieldCenterX = 0;

    ///设置号码栏字体大小
    uiConfig.ios.setNumberSize = 32;

    ///设置号码栏字体是否加粗（true：加粗；false：不加粗）
    uiConfig.ios.setNumberBold = true;

    ///授权页登录按钮
    ///设置登录按钮文字
    // uiConfig.setLogBtnText = '';
    ///设置登录按钮文字颜色
    uiConfig.ios.setLogBtnTextColor = "#FFFFFF";

    ///设置授权登录按钮颜色
    uiConfig.ios.setLoginBtnBgColor = "#FF193C";

    uiConfig.ios.setLoginBtnCornerRadius = 8;

    ///设置登录按钮相对于标题栏下边缘Y偏移(与setLogBtnOffsetBottomY二选一)
    uiConfig.ios.layOutPortrait.setLogBtnTop = isBottom ? 118 : 456;

    ///设置登录按钮相对于屏幕底部Y偏移
    uiConfig.ios.layOutPortrait.setLogBtnCenterX = 0;

    ///设置登录按钮字体大小
    uiConfig.ios.setLoginBtnTextSize = 16;

    ///设置登录按钮高度
    uiConfig.ios.layOutPortrait.setLogBtnHeight = 44;

    ///设置登录按钮宽度
    uiConfig.ios.layOutPortrait.setLogBtnWidth =
        (ScreenUtil.getInstance().screenWidth - 40).toInt();

    ///设置登录按钮字体是否加粗（true：加粗；false：不加粗）
    uiConfig.ios.setLoginBtnTextBold = false;

    ///授权页隐私栏
    ///设置开发者隐私条款1，包含两个参数：1.名称 2.URL
    uiConfig.ios.setAppPrivacyFirst = ['用户协议', ApiUrl.getUserProtocal(isIOS: true)];

    ///设置开发者隐私条款2
    uiConfig.ios.setAppPrivacySecond = ['隐私政策', ApiUrl.getUserPolicy(isIOS: true)];

    ///设置协议名称是否显示书名号《》，默认显示书名号（true：不显示；false：显示
    uiConfig.ios.setPrivacySmhHidden = false;

    ///设置隐私栏字体大小
    uiConfig.ios.setPrivacyTextSize = 12;

    ///设置height
    uiConfig.ios.layOutPortrait.setPrivacyHeight = 50;

    ///设置隐私条款相对于授权页面标题栏下边缘y偏移
    uiConfig.ios.layOutPortrait.setPrivacyTop = isBottom ? 177 : 512;

    ///设置隐私条款相对屏幕左侧右侧偏移
    uiConfig.ios.layOutPortrait.setPrivacyLeft = 20;
    uiConfig.ios.layOutPortrait.setPrivacyRight = 20;

    ///设置隐私条款文字左对齐
    uiConfig.ios.setAppPrivacyTextAlignment = iOSTextAlignment.left;

    ///设置隐私条款的CheckBox是否选中（true：选中；false：未选中）
    uiConfig.ios.setPrivacyState = false;

    ///设置隐私条款的CheckBox未选中时图片
    uiConfig.ios.setUncheckedImgPath = "ic_privacy_unSelect";

    ///设置隐私条款的CheckBox选中时图片
    uiConfig.ios.setCheckedImgPath = "ic_privacy_select";

    ///设置隐私条款的CheckBox是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.ios.setCheckBoxHidden = false;

    ///设置checkbox的宽高，包含两个参数：1.宽 2.高
    uiConfig.ios.setCheckBoxWH = [18, 40];

    ///设置隐私条款名称外的文字,包含五个参数
    // uiConfig.setPrivacyText = [];
    ///设置协议栏字体是否加粗（true：加粗；false：不加粗）
    uiConfig.ios.setPrivacyTextBold = false;

    ///未勾选协议时toast提示文字
    // uiConfig.androidPortrait.setPrivacyCustomToastText = '请勾选协议';
    ///协议是否显示下划线
    // uiConfig.androidPortrait.setPrivacyNameUnderline = false;

    ///运营商协议是否为最后一个显示
    uiConfig.ios.setOperatorPrivacyAtLast = false;

    ///授权页slogan
    ///设置slogan文字颜色
    // uiConfig.androidPortrait.setSloganTextColor = '';
    ///设置slogan文字字体大小
    uiConfig.ios.setSloganTextSize = 12;

    ///设置slogan相对于屏幕top偏移
    uiConfig.ios.layOutPortrait.setSloganTop = isBottom ? 95 : 434;

    ///设置slogan是否隐藏（ios不允许隐藏）
    // uiConfig.ios.setSloganHidden = true;

    ///设置slogan相对屏幕左侧X偏移
    uiConfig.ios.layOutPortrait.setSloganCenterX = 0;

    ///设置slogan文字字体是否加粗（true：加粗；false：不加粗）
    uiConfig.ios.setSloganTextBold = false;

    ///创蓝slogan
    ///设置创蓝slogan相对于标题栏下边缘y偏移(与setShanYanSloganOffsetBottomY二选一)
    uiConfig.ios.layOutPortrait.setShanYanSloganBottom = 0;

    ///设置创蓝slogan相对屏幕底部Y偏移
    uiConfig.ios.layOutPortrait.setShanYanSloganCenterY = 0;

    ///设置创蓝slogan相对屏幕左侧X偏移
    uiConfig.ios.layOutPortrait.setShanYanSloganCenterX = 0;

    ///设置创蓝slogan文字颜色
    // uiConfig.androidPortrait.setShanYanSloganTextColor = 0;
    ///设置创蓝slogan文字字体大小
    uiConfig.ios.setShanYanSloganTextSize = 12;

    ///设置创蓝slogan是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.ios.setShanYanSloganHidden = true;

    ///设置创蓝slogan文字字体是否加粗（true：加粗；false：不加粗）
    uiConfig.ios.setShanYanSloganTextBold = false;

    ///协议页导航栏
    ///设置协议页导航栏背景颜色
    // uiConfig.androidPortrait.setPrivacyNavColor ='#ffffff';
    uiConfig.ios.setAppPrivacyWebNavigationBarStyle = iOSBarStyle.styleDefault;

    ///设置协议页导航栏标题文字颜色
    uiConfig.ios.setPrivacyNavTextColor = '#ffffff';

    ///设置协议页导航栏标题文字大小
    uiConfig.ios.setPrivacyNavTextSize = 20;
    uiConfig.ios.setAuthTypeUseWindow = isBottom;
    uiConfig.ios.setAuthWindowModalTransitionStyle = isBottom
        ? iOSModalTransitionStyle.coverVertical
        : iOSModalTransitionStyle.flipHorizontal;
    uiConfig.ios.setAppPrivacyWebModalPresentationStyle = isBottom
        ? iOSModalPresentationStyle.overFullScreen
        : iOSModalPresentationStyle.fullScreen;

    /// 弹窗中心位置
    uiConfig.ios.layOutPortrait.setAuthWindowOrientationCenterX =
        ScreenUtil.getInstance().screenWidth * 0.5;
    if (isBottom) {
      uiConfig.ios.layOutPortrait.setAuthWindowOrientationOriginY =
          ScreenUtil.getInstance().screenHeight - 354;
    } else {
      uiConfig.ios.layOutPortrait.setAuthWindowOrientationCenterY =
          ScreenUtil.getInstance().screenHeight * 0.5;
    }
    uiConfig.ios.layOutPortrait.setAuthWindowOrientationWidth =
        ScreenUtil.getInstance().screenWidth;
    uiConfig.ios.layOutPortrait.setAuthWindowOrientationHeight =
        isBottom ? 354 : ScreenUtil.getInstance().screenHeight;

    ///添加自定义控件----新手机号将自动为您完成账号注册
    ShanYanCustomWidgetIOS textWidget =
        ShanYanCustomWidgetIOS('text', ShanYanCustomWidgetType.TextView);

    ///自定义控件内容
    textWidget.textContent = '新手机号将自动为您完成账号注册';

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    textWidget.centerX = 0;

    ///自定义控件距离导航栏顶部偏移量，单位dp
    textWidget.top = isBottom ? 74 : 415;
    textWidget.textFont = 12.0;

    ///自定义控件文字颜色
    textWidget.textColor = isBottom ? '#8F9296' : '#A1A3AC';

    ///自定义控件背景颜色
    textWidget.backgroundColor = '#00000000';

    ///点击自定义控件是否自动销毁授权页
    textWidget.isFinish = false;

    ///添加自定义控件----其他登录
    ShanYanCustomWidgetIOS smsLoginWidget =
        ShanYanCustomWidgetIOS('smsLogin', ShanYanCustomWidgetType.Button);

    ///自定义控件内容
    smsLoginWidget.textContent = '其他方式登录';

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    Size size = Utils.boundingTextSize('其他方式登录', TextStyle(fontSize: 12));
    smsLoginWidget.left =
        (ScreenUtil.getInstance().screenWidth - size.width - 20) ~/ 2 + 20;

    ///自定义控件距离屏幕底部偏移量，单位dp
    smsLoginWidget.bottom = isBottom ? 40 : 100;

    ///自定义控件文字大小，单位sp
    smsLoginWidget.textFont = 12.0;

    ///自定义控件文字颜色
    smsLoginWidget.textColor = '#FFFFFF';

    ///自定义控件背景图片
    // smsLoginWidget.backgroundImgPath = "ic_phone";
    ///点击自定义控件是否自动销毁授权页
    smsLoginWidget.isFinish = true;

    ///添加自定义控件----图标
    ShanYanCustomWidgetIOS iconWidget =
        ShanYanCustomWidgetIOS('icon', ShanYanCustomWidgetType.Button);

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    iconWidget.left =
        (ScreenUtil.getInstance().screenWidth - size.width - 20) ~/ 2;

    ///自定义控件距离屏幕底部偏移量，单位dp
    iconWidget.bottom = isBottom ? 46 : 106;

    ///自定义控件宽度，单位dp
    iconWidget.width = 16;

    ///自定义控件高度，单位
    iconWidget.height = 16;

    ///自定义控件背景图片
    iconWidget.backgroundImgPath = "ic_phone";

    ///点击自定义控件是否自动销毁授权页
    iconWidget.isFinish = true;

    ///添加自定义控件----图标
    ShanYanCustomWidgetIOS iconclose =
        ShanYanCustomWidgetIOS('icon', ShanYanCustomWidgetType.Button);

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    iconclose.right = 20;

    ///自定义控件距离屏幕底部偏移量，单位dp
    iconclose.top = 50;

    ///自定义控件宽度，单位dp
    iconclose.width = 16;

    ///自定义控件高度，单位
    iconclose.height = 16;

    ///自定义控件背景图片
    iconclose.backgroundImgPath = "ic_close";

    ///点击自定义控件是否自动销毁授权页
    iconclose.isFinish = true;

    if (isBottom) {
      iconclose.top = 20;
    }

    ///自定义控件集合
    uiConfig.ios.widgets = [textWidget, smsLoginWidget, iconWidget, iconclose];

    return uiConfig;
  }

  ShanYanUIConfig getUIConfig({bool isBottom = false}) {
    ShanYanUIConfig uiConfig = ShanYanUIConfig();

    ///是否自动销毁
    ///是否自动销毁 true：是 false：不是
    uiConfig.androidPortrait.isFinish = true;

    ///授权页背景配置三选一，支持图片，gif图，视频
    ///普通图片
    uiConfig.androidPortrait.setAuthBGImgPath =
        isBottom ? 'one_key_login_dialog_bg' : 'transparent';

    ///GIF图片（只支持本地gif图，需要放置到drawable文件夹中）
    // uiConfig.androidPortrait.setAuthBgGifPath = '';
    ///视频背景
    // uiConfig.androidPortrait.setAuthBgVideoPath = 'http://rbv01.ku6.com/7lut5JlEO-v6a8K3X9xBNg.mp4';

    ///授权页状态栏
    ///授权页状态栏 设置状态栏是否隐藏
    uiConfig.androidPortrait.setStatusBarHidden = false;

    ///设置状态栏背景颜色
    uiConfig.androidPortrait.setStatusBarColor = '#FFFFFF';

    ///设置状态栏字体颜色是否为白色
    uiConfig.androidPortrait.setLightColor = false;

    ///设置虚拟键是否透明
    uiConfig.androidPortrait.setVirtualKeyTransparent = true;

    ///授权页导航栏
    ///设置是否全屏显示（true：全屏；false：不全屏）默认不全屏
    uiConfig.androidPortrait.setFullScreen = false;

    ///设置导航栏背景颜色
    uiConfig.androidPortrait.setNavColor = '#00000000';

    ///设置导航栏标题文字
    uiConfig.androidPortrait.setNavText = '';

    ///设置导航栏标题文字颜色
    uiConfig.androidPortrait.setNavTextColor = '#FFFFFF';

    ///设置导航栏标题文字大小
    uiConfig.androidPortrait.setNavTextSize = 16;

    ///设置导航栏返回按钮图标
    uiConfig.androidPortrait.setNavReturnImgPath = 'ic_close';

    ///设置导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setNavReturnImgHidden = false;

    ///设置导航栏返回按钮宽度
    uiConfig.androidPortrait.setNavReturnBtnWidth = 16;

    ///设置导航栏返回按钮高度
    uiConfig.androidPortrait.setNavReturnBtnHeight = 16;

    ///设置导航栏返回按钮距离屏幕右侧X偏移
    uiConfig.androidPortrait.setNavReturnBtnOffsetRightX = 10;

    ///设置导航栏返回按钮距离屏幕左侧X偏移
    uiConfig.androidPortrait.setNavReturnBtnOffsetX = 0;

    ///设置导航栏返回按钮距离屏幕上侧Y偏移
    uiConfig.androidPortrait.setNavReturnBtnOffsetY = 10;

    ///设置导航栏是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setAuthNavHidden = false;

    ///设置导航栏是否透明（true：透明；false：不透明）
    uiConfig.androidPortrait.setAuthNavTransparent = true;

    ///设置导航栏字体是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setNavTextBold = false;

    ///授权页logo
    ///设置logo图片
    uiConfig.androidPortrait.setLogoImgPath = 'ic_wefree_logo';

    ///设置logo宽度
    uiConfig.androidPortrait.setLogoWidth = 140;

    ///设置logo高度
    // uiConfig.androidPortrait.setLogoHeight = 46;

    ///设置logo相对于标题栏下边缘y偏移(与setLogoOffsetBottomY二选一)
    uiConfig.androidPortrait.setLogoOffsetY = 82;

    ///设置logo相对于屏幕底部y偏移
    // uiConfig.androidPortrait.setLogoOffsetBottomY = 0;
    ///设置logo是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setLogoHidden = isBottom;

    ///设置logo相对屏幕左侧X偏移
    // uiConfig.androidPortrait.setLogoOffsetX = 0;

    ///授权页号码栏
    ///设置号码栏字体颜色
    uiConfig.androidPortrait.setNumberColor = '#FFFFFF';

    ///设置号码栏相对于标题栏下边缘y偏移(与setNumFieldOffsetBottomY二选一)
    uiConfig.androidPortrait.setNumFieldOffsetY = isBottom ? 0 : 325;

    ///设置号码栏相对于屏幕底部y偏移
    // uiConfig.androidPortrait.setNumFieldOffsetBottomY = 0;
    ///设置号码栏宽度
    // uiConfig.androidPortrait.setNumFieldWidth = 0;
    ///设置号码栏高度
    // uiConfig.androidPortrait.setNumFieldHeight = 0;
    ///设置号码栏字体大小
    uiConfig.androidPortrait.setNumberSize = 32;

    ///设置号码栏相对屏幕左侧X偏移
    // uiConfig.androidPortrait.setNumFieldOffsetX = 0;
    ///设置号码栏字体是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setNumberBold = true;

    ///授权页登录按钮
    ///设置登录按钮文字
    // uiConfig.setLogBtnText = '';
    ///设置登录按钮文字颜色
    uiConfig.androidPortrait.setLogBtnTextColor = '#FFFFFF';

    ///设置授权登录按钮图片
    uiConfig.androidPortrait.setLogBtnImgPath = 'one_key_login_bg';

    ///设置登录按钮相对于标题栏下边缘Y偏移(与setLogBtnOffsetBottomY二选一)
    uiConfig.androidPortrait.setLogBtnOffsetY = isBottom ? 92 : 405;

    ///设置登录按钮相对于屏幕底部Y偏移
    // uiConfig.setLogBtnOffsetBottomY = 0;
    ///设置登录按钮字体大小
    uiConfig.androidPortrait.setLogBtnTextSize = 16;

    ///设置登录按钮高度
    uiConfig.androidPortrait.setLogBtnHeight = 44;

    ///设置登录按钮宽度
    uiConfig.androidPortrait.setLogBtnWidth =
        (ScreenUtil.getInstance().screenWidth - 40).toInt();

    ///设置登录按钮相对屏幕左侧X偏移
    // uiConfig.androidPortrait.setLogBtnOffsetX = 0;
    ///设置登录按钮字体是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setLogBtnTextBold = false;

    ///授权页隐私栏
    ///设置开发者隐私条款1，包含两个参数：1.名称 2.URL
    uiConfig.androidPortrait.setAppPrivacyOne = [
      '用户协议',
      ApiUrl.getUserProtocal(isIOS: false)
    ];

    ///设置开发者隐私条款2
    uiConfig.androidPortrait.setAppPrivacyTwo = [
      '隐私政策',
      ApiUrl.getUserPolicy(isIOS: false)
    ];

    ///设置开发者隐私条款3
    // uiConfig.androidPortrait.setAppPrivacyThree = [
    //   '协议3',
    //   'https://www.baidu.com'
    // ];

    ///设置协议名称是否显示书名号《》，默认显示书名号（true：不显示；false：显示
    uiConfig.androidPortrait.setPrivacySmhHidden = false;

    ///设置隐私栏字体大小
    uiConfig.androidPortrait.setPrivacyTextSize = 12;

    ///设置隐私条款文字颜色，包含两个参数：1.基础文字颜色 2.协议文字颜色
    uiConfig.androidPortrait.setAppPrivacyColor =
        isBottom ? ['#8F9296', '#8F9296'] : ['#A1A3AC', '#A1A3AC'];

    ///设置隐私条款相对于授权页面底部下边缘y偏移(与setPrivacyOffsetY二选一)
    // uiConfig.androidPortrait.setPrivacyOffsetBottomY = isBottom ? 35 : 110;

    ///设置隐私条款相对于授权页面标题栏下边缘y偏移
    uiConfig.androidPortrait.setPrivacyOffsetY = isBottom ? 150 : 465;

    ///设置隐私条款相对屏幕左侧X偏移
    uiConfig.androidPortrait.setPrivacyOffsetX = 20;

    ///设置隐私条款文字左对齐（true：左对齐；false：居中）
    uiConfig.androidPortrait.setPrivacyOffsetGravityLeft = true;

    ///设置隐私条款的CheckBox是否选中（true：选中；false：未选中）
    uiConfig.androidPortrait.setPrivacyState = false;

    ///设置隐私条款的CheckBox未选中时图片
    uiConfig.androidPortrait.setUncheckedImgPath = 'ic_unselect';

    ///设置隐私条款的CheckBox选中时图片
    uiConfig.androidPortrait.setCheckedImgPath = 'ic_select';

    ///设置隐私条款的CheckBox是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setCheckBoxHidden = false;

    ///设置checkbox的宽高，包含两个参数：1.宽 2.高
    uiConfig.androidPortrait.setCheckBoxWH = [15, 15];

    ///设置checkbox的间距，包含四个参数：1.左间距 2.上间距 3.右间距 4.下间距
    uiConfig.androidPortrait.setCheckBoxMargin = [10, 5, 0, 20];

    ///设置隐私条款名称外的文字,包含五个参数
    // uiConfig.setPrivacyText = [];
    ///设置协议栏字体是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setPrivacyTextBold = false;

    ///未勾选协议时toast提示文字
    // uiConfig.androidPortrait.setPrivacyCustomToastText = '请勾选协议';
    ///协议是否显示下划线
    uiConfig.androidPortrait.setPrivacyNameUnderline = false;

    ///运营商协议是否为最后一个显示
    uiConfig.androidPortrait.setOperatorPrivacyAtLast = false;

    ///授权页slogan
    ///设置slogan文字颜色
    // uiConfig.androidPortrait.setSloganTextColor = '';
    ///设置slogan文字字体大小
    uiConfig.androidPortrait.setSloganTextSize = 12;

    ///设置slogan相对于标题栏下边缘y偏移(与setSloganOffsetBottomY二选一)
    uiConfig.androidPortrait.setSloganOffsetY = 0;

    ///设置slogan是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setSloganHidden = true;

    ///设置slogan相对屏幕底部Y偏移
    uiConfig.androidPortrait.setSloganOffsetBottomY = 0;

    ///设置slogan相对屏幕左侧X偏移
    uiConfig.androidPortrait.setSloganOffsetX = 0;

    ///设置slogan文字字体是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setSloganTextBold = false;

    ///创蓝slogan
    ///设置创蓝slogan相对于标题栏下边缘y偏移(与setShanYanSloganOffsetBottomY二选一)
    uiConfig.androidPortrait.setShanYanSloganOffsetY = 0;

    ///设置创蓝slogan相对屏幕底部Y偏移
    uiConfig.androidPortrait.setShanYanSloganOffsetBottomY = 0;

    ///设置创蓝slogan相对屏幕左侧X偏移
    uiConfig.androidPortrait.setShanYanSloganOffsetX = 0;

    ///设置创蓝slogan文字颜色
    // uiConfig.androidPortrait.setShanYanSloganTextColor = 0;
    ///设置创蓝slogan文字字体大小
    uiConfig.androidPortrait.setShanYanSloganTextSize = 12;

    ///设置创蓝slogan是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setShanYanSloganHidden = true;

    ///设置创蓝slogan文字字体是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setShanYanSloganTextBold = false;

    ///协议页导航栏
    ///设置协议页导航栏背景颜色
    uiConfig.androidPortrait.setPrivacyNavColor = '#ffffff';

    ///设置协议页导航栏标题文字是否加粗（true：加粗；false：不加粗）
    uiConfig.androidPortrait.setPrivacyNavTextBold = false;

    ///设置协议页导航栏标题文字颜色
    // uiConfig.androidPortrait.setPrivacyNavTextColor = '#ffffff';

    ///设置协议页导航栏标题文字大小
    uiConfig.androidPortrait.setPrivacyNavTextSize = 20;

    ///设置协议页导航栏返回按钮图标
    // uiConfig.androidPortrait.setPrivacyNavReturnImgPath = '';

    ///设置协议页导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）
    uiConfig.androidPortrait.setPrivacyNavReturnImgHidden = false;

    ///设置协议页导航栏返回按钮宽度
    uiConfig.androidPortrait.setPrivacyNavReturnBtnWidth = 20;

    ///设置协议页导航栏返回按钮高度
    uiConfig.androidPortrait.setPrivacyNavReturnBtnHeight = 20;

    ///设置协议页导航栏返回按钮距离屏幕右侧X偏移
    // uiConfig.androidPortrait.setPrivacyNavReturnBtnOffsetRightX = 0;
    ///设置协议页导航栏返回按钮距离屏幕左侧X偏移
    // uiConfig.androidPortrait.setPrivacyNavReturnBtnOffsetX = 0;
    ///设置协议页导航栏返回按钮距离屏幕上侧Y偏移
    // uiConfig.androidPortrait.setPrivacyNavReturnBtnOffsetY = 0;

    ///授权页loading
    ///设置授权页点击一键登录自定义loading
    // uiConfig.androidPortrait.setLoadingView = '';

    ///添加自定义控件----新手机号将自动为您完成账号注册
    ShanYanCustomWidget textWidget =
        ShanYanCustomWidget('text', ShanYanCustomWidgetType.TextView);

    ///自定义控件内容
    textWidget.textContent = '新手机号将自动为您完成账号注册';

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    // textWidget.left = 0;
    ///自定义控件距离导航栏顶部偏移量，单位dp
    textWidget.top = isBottom ? 40 : 367;

    ///自定义控件距离屏幕右边缘偏移量，单位dp
    // textWidget.right = 0;
    ///自定义控件距离屏幕底部偏移量，单位dp
    // textWidget.bottom = 0;
    ///自定义控件宽度，单位dp
    // textWidget.width = 0;
    ///自定义控件高度，单位
    // textWidget.height = 0;
    ///自定义控件文字大小，单位sp
    textWidget.textFont = 12.0;

    ///自定义控件文字颜色
    textWidget.textColor = isBottom ? '#8F9296' : '#A1A3AC';

    ///自定义控件背景颜色
    textWidget.backgroundColor = '#00000000';

    ///自定义控件背景图片
    // textWidget.backgroundImgPath = '';

    ///点击自定义控件是否自动销毁授权页
    textWidget.isFinish = false;

    ///添加自定义控件----其他登录
    ShanYanCustomWidget smsLoginWidget =
        ShanYanCustomWidget('smsLogin', ShanYanCustomWidgetType.TextView);

    ///自定义控件内容
    smsLoginWidget.textContent = '其他方式登录';

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    Size size = Utils.boundingTextSize('其他方式登录', TextStyle(fontSize: 12));
    smsLoginWidget.left =
        (ScreenUtil.getInstance().screenWidth - size.width - 20) ~/ 2 + 20;

    ///自定义控件距离导航栏顶部偏移量，单位dp
    // smsLoginWidget.top = 320;

    ///自定义控件距离屏幕右边缘偏移量，单位dp
    // smsLoginWidget.right = 0;
    ///自定义控件距离屏幕底部偏移量，单位dp
    smsLoginWidget.bottom = isBottom ? 25 : 40;

    ///自定义控件宽度，单位dp
    // smsLoginWidget.width = 0;
    ///自定义控件高度，单位
    // smsLoginWidget.height = 0;
    ///自定义控件文字大小，单位sp
    smsLoginWidget.textFont = 12.0;

    ///自定义控件文字颜色
    smsLoginWidget.textColor = '#FFFFFF';

    ///自定义控件背景颜色
    smsLoginWidget.backgroundColor = '#00000000';

    ///自定义控件背景图片
    // smsLoginWidget.backgroundImgPath = 'ic_phone';

    ///点击自定义控件是否自动销毁授权页
    smsLoginWidget.isFinish = true;

    ///添加自定义控件----图标
    ShanYanCustomWidget iconWidget =
        ShanYanCustomWidget('icon', ShanYanCustomWidgetType.TextView);

    ///自定义控件内容
    // iconWidget.textContent = '其他方式登录';

    ///自定义控件距离屏幕左边缘偏移量，单位dp
    iconWidget.left =
        (ScreenUtil.getInstance().screenWidth - size.width - 20) ~/ 2;

    ///自定义控件距离导航栏顶部偏移量，单位dp
    // iconWidget.top = 320;

    ///自定义控件距离屏幕右边缘偏移量，单位dp
    // iconWidget.right = 0;
    ///自定义控件距离屏幕底部偏移量，单位dp
    iconWidget.bottom = isBottom ? 25 : 40;

    ///自定义控件宽度，单位dp
    iconWidget.width = 16;

    ///自定义控件高度，单位
    // iconWidget.height = 0;
    ///自定义控件文字大小，单位sp
    // iconWidget.textFont = 12.0;

    ///自定义控件文字颜色
    // iconWidget.textColor = isBottom ? '#000000' : '#FFFFFF';

    ///自定义控件背景颜色
    iconWidget.backgroundColor = '#00000000';

    ///自定义控件背景图片
    iconWidget.backgroundImgPath = 'ic_phone';

    ///点击自定义控件是否自动销毁授权页
    iconWidget.isFinish = true;

    ///自定义控件集合
    uiConfig.androidPortrait.widgets = [textWidget, smsLoginWidget, iconWidget];

    /// dialog样式
    var width = ScreenUtil.getInstance().screenWidth.toStringAsFixed(0);
    var height = ScreenUtil.getInstance().screenHeight.toStringAsFixed(0);
    if (isBottom) {
      height =
          (ScreenUtil.getInstance().screenHeight / 2).toStringAsFixed(0);
    }
    uiConfig.androidPortrait.setDialogTheme = [
      width,
      height,
      '0',
      '0',
      isBottom ? 'true' : 'false'
    ];
    return uiConfig;
  }

  /// 设置一键登录监听
  OneKeyLoginUtil setOneKeyLoginListener(Function success) {
    _oneKeyLoginManager?.setOneKeyLoginListener((res) {
      if (CODE == res.code) {
        ///一键登录成功
        success(res);
        _oneKeyLoginManager?.finishAuthControllerCompletion();
      } else if (CANCEL == res.code) {
        ///取消
        success(res);
      } else {
        ///一键登录失败
        _oneKeyLoginManager?.finishAuthControllerCompletion();
      }
    });
    return this;
  }

  /// 授权页点击事件监听
  OneKeyLoginUtil setAuthPageActionListener() {
    _oneKeyLoginManager?.setAuthPageActionListener((event) {
      if (1 == event.type) {
        ///隐私政策
        if (0 == event.code) {
          ///协议1
        } else if (1 == event.code) {
          ///协议2
        }
      } else if (2 == event.type) {
        ///checkbox
      } else if (3 == event.type) {
        ///一键登录
        if (0 == event.code) {
          ///checkbox 未选中
        }
      }
    });
    return this;
  }

  /// 自定义控件点击事件监听
  OneKeyLoginUtil addClickWidgetEventListener(Function success) {
    _oneKeyLoginManager?.addClikWidgetEventListener((eventId) {
      success(eventId);
    });
    return this;
  }

  /// 拉起授权页
  /// isBottom 是否底部弹窗
  OneKeyLoginUtil openLoginAuth(Function success,
      {bool isBottom = false, Function? fail}) {
    if (_isInitSuccess) {
      _oneKeyLoginManager?.setAuthThemeConfig(
          uiConfig: defaultTargetPlatform == TargetPlatform.iOS
              ? getIOSUIConfig(isBottom: isBottom)
              : getUIConfig(isBottom: isBottom));
      _oneKeyLoginManager?.openLoginAuth().then((res) {
        if (CODE == res.code) {
          ///拉起授权页成功
          success(res.token);
        } else {
          ///拉起授权页失败
          fail?.call();
        }
      });
    }
    return this;
  }

  /// 预取号
  OneKeyLoginUtil getPhoneInfo(Function fun, {Function? failFun}) {
    if (_isInitSuccess) {
      _oneKeyLoginManager?.getPhoneInfo().then((res) {
        _isGetPhoneSuccess = CODE == res.code;
        if (CODE == res.code) {
          fun.call(res);
        } else {
          failFun?.call(res);
        }
      });
    }
    return this;
  }

  /// 一键登录是否初始化成功
  bool getOneKeyLoginInitSuccess() {
    return _isInitSuccess;
  }

  void cancelAuth() {
    _oneKeyLoginManager?.finishAuthControllerCompletion();
  }

  /// 预取号成功
  bool getPhoneSuccess() {
    return _isGetPhoneSuccess;
  }
}
