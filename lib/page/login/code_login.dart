
import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/off_account_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/entity/session_entity.dart';
import 'package:SDZ/entity/user_entity.dart';
import 'package:SDZ/event/change_home_tab_event.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/reload_one_key_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/login/perfect_user_info.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/widget/pin_code_text_field.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/utils/utils.dart';

// ignore: must_be_immutable
class CodeLoginPage extends BaseStatefulWidget {

  final String? phone;

  final bool? isMessageTab;

  final bool? isContinueLogin;

  CodeLoginPage({this.phone, this.isMessageTab = false, this.isContinueLogin = false});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return CodeLoginPageState();
  }
}

class CodeLoginPageState extends BaseStatefulState<CodeLoginPage> {
  TextEditingController? _controller;

  int _mSeconds = 60;
  Timer? _timer;

  @override
  void onDispose() {
    super.onDispose();
    _controller?.dispose();
    if(_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  bool interceptNavigatorBackClick() => widget.isContinueLogin!;

  @override
  void initNavigatorClickListener() {
    EventBusUtils.getInstance().fire(ReLoadOneKeyLoginEvent(ReLoadOneKeyLoginEvent.LOGIN));
    Get.back();
  }

  @override
  void initData() {
    super.initData();
    _controller = TextEditingController(text: "");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      onStartCountDown();
    });
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return initView();
  }

  ///获取验证码
  void getPhoneCode() {
    Map<String, dynamic> map = {'telephone': widget.phone, 'type':1};
    ApiClient.instance.post(ApiUrl.sms_code, data: map, onSuccess: (data){
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        onStartCountDown();
      }
    });
  }

  /// 登录
  /// code 验证码
  void login(String code, {bool isContinueLogin = false}) {
    Map<String, dynamic> map = Map();
    map['telephone'] = widget.phone!;
    map['loginType'] = 2;
    map['code'] = code;
    map['pushCode'] = SPUtils.pushCode;
    ApiClient.instance.post(isContinueLogin ? ApiUrl.login_continue : ApiUrl.login, data: map, onSuccess: (data){
      BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        if(entity.data!.isCancel) {
          onShowOffAccountDialog();
          return;
        }
        ToastUtils.toast('登录成功');
        SPUtils.setUserId(entity.data?.accountId ?? '');
        SPUtils.setUserToken(entity.data?.token ?? '');
        SPUtils.setUserAccount(entity.data?.telephone ?? '');
        SPUtils.setUserNickName(entity.data?.nickname ?? '');
        SPUtils.setAvatar(entity.data?.avatar ?? '');
        EventBusUtils.getInstance().fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
        /// 友盟登录用户账号
        UmengUtil.onProfileSignIn(entity.data!.accountId ?? '');
        if(entity.data!.isNewUser){
          Get.offAll(()=>PerfectUserInfoPage(widget.phone ?? '', isMessageTab: widget.isMessageTab!,));
        }else{
          if(Get.arguments['tomain'] == null || Get.arguments['tomain']){
            Get.offAll(() => MainHomePage());
          }else{
            if(widget.isMessageTab!) {
              EventBusUtils.getInstance().fire(ChangeHomeTabEvent(1));
            }
            if(widget.isContinueLogin!){
              EventBusUtils.getInstance().fire(ReLoadOneKeyLoginEvent(ReLoadOneKeyLoginEvent.BACK));
            }
            Get.back();
          }
        }
      }
    });
  }

  /// 注销提示弹窗
  void onShowOffAccountDialog() {
    Get.dialog(OffAccountDialog(onTap: (){
      login(_controller!.text, isContinueLogin: true);
    }, onCancel: (){
     Get.back();
    }), barrierDismissible: false);
  }

  /// 倒计时
  void onStartCountDown() {
    if(_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if(_mSeconds < 1) {
          _timer!.cancel();
          _timer = null;
        }else{
          _mSeconds--;
        }
        setState(() {

        });
      });
    }
  }

  Widget initView() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 22),
            child: Center(
              child: Text(
                  '请输入短信验证码',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                  ),
            )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: '验证码已发送至',
                    style: TextStyle(fontSize: 14, color: Colours.color_6A6E7E),
                    children: [
                      TextSpan(
                          text: ' ${Utils.splitPhoneNumber(widget.phone!, isHidden: true)}',
                          style: TextStyle(fontSize: 14, color: Colors.white)
                      )
                    ]
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 30),
            child: PinCodeTextField(
              controller: _controller,
              pinBoxWidth: (MediaQuery.of(context).size.width - 80) / 6,
              pinBoxHeight: (MediaQuery.of(context).size.width - 80) / 6,
              maxLength: 6,
              highlight: true,
              showCursor: true,
              cursorColor: Colours.color_FF193C,
              ///下面三个属性控制获取焦点的输入框呼吸灯效果
              // highlightAnimation: true,
              // highlightAnimationBeginColor: Colours.color_FF193C,
              // // highlightAnimationEndColor: Colors.transparent,
              ///呼吸灯循环时间
              // highlightAnimationDuration: Duration(seconds: 1),
              pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold,),
              autofocus: true,
              wrapAlignment: WrapAlignment.start,
              keyboardType: TextInputType.number,
              pinBoxColor:Colours.color_181A23,
              highlightPinBoxColor: Colours.color_181A23,
              defaultBorderColor: Colours.color_181A23,
              highlightColor: Colours.color_6A6E7E,
              hasTextBorderColor: Colours.color_6A6E7E,
              pinBoxBorderWidth: 0.5,
              pinBoxRadius: 8,
              onDone: (value) {
                login(value, isContinueLogin: widget.isContinueLogin!);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: _mSeconds > 0 ? '$_mSeconds' + 's': '重新获取验证码',
                    style: TextStyle(color: Colours.color_FF193C, fontSize: 14),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      if(_mSeconds < 1) {
                        _mSeconds = 60;
                        getPhoneCode();
                      }
                    },
                    children: [
                      TextSpan(
                          text: _mSeconds > 0 ? ' 后重新发送': '',
                          style: TextStyle(fontSize: 14, color: Colours.color_6A6E7E),
                      )
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}