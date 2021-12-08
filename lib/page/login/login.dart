import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/login/code_login.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/custom_textinput_formatter.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/one_key_login_util.dart';
import 'package:SDZ/utils/phone_formatter.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/text_image_button.dart';

class LoginPage extends BaseStatefulWidget {

  final bool? isMessageTab;

  LoginPage({this.isMessageTab = false});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseStatefulState<LoginPage> with SingleTickerProviderStateMixin {
  var toMain = false;
  late TextEditingController _controller;
  bool _isChecked = false;
  bool _nextBtnEnable = false;
  StreamSubscription<LoginEvent>? _bus;

  @override
  void initData() {
    super.initData();
    _bus = EventBusUtils.getInstance().on<LoginEvent>().listen((event) {
      if (event.mLogin == LoginEvent.LOGIN_TYPE_LOGIN && Navigator.canPop(context)) {
        Get.back();
      }
    });
    _controller = new TextEditingController(text: Utils.splitPhoneNumber(SPUtils.getUserAccount()));
    _nextBtnEnable = SPUtils.getUserAccount().isNotEmpty;

    var map = Get.arguments;
    toMain = map['tomain'];

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   FocusScope.of(context).requestFocus(focusNode);
    // });
  }

  @override
  void onDispose() {
    super.onDispose();
    _controller.dispose();
    _bus?.cancel();
  }

  ///跳转验证码页
  void toCodeLogin() {
    onCloseKeyboard();
    if(_controller.text.isEmpty) {
      ToastUtils.toast('请输入手机号');
      return;
    }
    String phone = _controller.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    if(!Utils.isMobile(phone)) {
      ToastUtils.toast('请输入正确的手机号');
      return;
    }
    if(!_isChecked) {
      ToastUtils.toast('请先阅读并勾选同意协议后再登录');
      return;
    }
    Map<String, dynamic> map = {'telephone': phone, 'type':1};
    ApiClient.instance.post(ApiUrl.sms_code, data: map, onSuccess: (data){
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        ToastUtils.toast('验证码已发送，请注意查收');
        Get.to(()=>CodeLoginPage(phone: phone, isMessageTab: widget.isMessageTab!,), arguments: {'tomain':toMain});
      }
    });
  }

  @override
  void initNavigatorClickListener() {
    super.initNavigatorClickListener();
    onCloseKeyboard();
    if(!toMain && Navigator.canPop(context)) {
      Get.back();
    } else {
      Get.offAll(() => MainHomePage());
    }
  }

  @override
  bool interceptNavigatorBackClick() => true;

  @override
  Widget initDefaultBuild(BuildContext context) {
    return WillPopScope(child: Column(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Center(
                    child: Text('请输入手机号码', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold,),)
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Center(
                    child: Text('新手机号将自动为您完成账号注册', style: TextStyle(color: Colours.color_6A6E7E, fontSize: 14),)
                ),
              ),
              getInputWidget(),
              getLoginButtonWidget(),
              getAgreementWidget(),
            ],
          ),
        ),
        // getOtherLoginWidget()
      ],
    ), onWillPop: () => _callback());
  }
  var _contentPadding = EdgeInsets.only(bottom: 8);


  Future<bool> _callback() async {
    FocusScope.of(context).unfocus(); //取消焦点
    return true;
  }

  /// 手机号
  Widget getInputWidget() {
    return Container(
        margin: const EdgeInsets.only(left: 20, top: 32, right: 20),
        padding: const EdgeInsets.only(top: 5),
        height: 56,
        decoration: BoxDecoration(
            color: Colours.color_181A23,
            borderRadius: BorderRadius.circular((8))
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              maxLines: 1,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              // autofocus: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(13),
                CustomTextInputFormatter(
                  filterPattern: RegExp("[0-9]"),
                ),
                PhoneFormatter()
              ],
              onChanged: (text) {
                _nextBtnEnable = text.isNotEmpty;
                _contentPadding = EdgeInsets.zero;
                setState(() {

                });
              },
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                hintText: '请输入手机号码',
                hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B, textBaseline: TextBaseline.alphabetic),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            _controller.text.isNotEmpty && focusNode.hasFocus ? Positioned(child: IconButton(
              iconSize: 20,
              icon: Icon(Icons.cancel),
              color: Colors.grey,
              onPressed: () {
                // _contentPadding = EdgeInsets.only(bottom: 8);
                _controller.clear();
                _nextBtnEnable = false;
                setState(() {
                });
              },
            ), bottom: 6, top: 3,) : Text(''),
          ]
        )
    );
  }

  /// 协议
  Widget getAgreementWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextImageButton(
            margin: 5.0,
            iconType: 3,
            svgPath: _isChecked ? SvgPath.ic_select : SvgPath.ic_unselect,
            size: Size(14, 14),
            text: '已详细阅读并同意',
            textStyle: TextStyle(color: Colours.color_6A6E7E, fontSize: 12),
            onTap: (){
              setState(() {
                _isChecked = !_isChecked;
              });
            },
          ),
          RichText(
            text: TextSpan(
                text: '《用户协议》',
                style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12),
                recognizer: TapGestureRecognizer()..onTap = () {
                  FocusScope.of(context).unfocus(); //取消焦点
                  Get.to(()=> WebViewPage(url: Platform.isAndroid ? ApiUrl.getUserProtocal(isIOS: false) : ApiUrl.getUserProtocal(isIOS: true), title: '用户协议',));
                },
                children: [
                  TextSpan(text: '与', style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12)),
                  TextSpan(
                    text: '《隐私政策》',
                    style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      FocusScope.of(context).unfocus(); //取消焦点
                      Get.to(()=> WebViewPage(url: Platform.isAndroid ? ApiUrl.getUserPolicy(isIOS: false) : ApiUrl.getUserPolicy(isIOS: true), title: '隐私政策'));
                    },
                  ),
                ]
            ),
          )
        ],
      ),
    );
  }

  /// 登录按钮
  Widget getLoginButtonWidget() {
    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.only(left: 20, top: 32, right: 20),
      child: ElevatedButton(
        onPressed: _nextBtnEnable ? (){
          toCodeLogin();
        } : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_nextBtnEnable ? Colours.color_FF193C : Colours.color_232632),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: Text(
          '下一步', style: TextStyle(fontSize: 16, color: _nextBtnEnable ? Colors.white : Colours.color_6A6E7E),
        ),
      ),
    );
  }

  /// 其他登录方式
  Widget getOtherLoginWidget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 50,
                child: Divider(
                  color: Colours.color_E7EAED,
                  height: 0.5,
                ),
              ),
              Text('其他登录方式', style: TextStyle(color: Colours.text_131313, fontSize: 12),),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 50,
                child: Divider(
                  color: Colours.color_E7EAED,
                  height: 0.5,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 20,
              child: CachedNetworkImage(
                imageUrl: 'https://img2.baidu.com/it/u=4056752832,1076975199&fm=26&fmt=auto&gp=0.jpg',
                width: 40,
                height: 40,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 一键登录
  Widget getOneKeyLoginWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: OutlinedButton(
        onPressed: () {
          if(OneKeyLoginUtil.instance.getOneKeyLoginInitSuccess()) {
            OneKeyLoginUtil.instance.openLoginAuth((res) {

            }, fail: () {
              ToastUtils.toast('一键登录失败，请换其他登录方式');
            });
          }else{
            ToastUtils.toast('一键登录失败，请换其他登录方式');
          }
        },
        child: Text(
          '一键登录',
          style: TextStyle(
              color: Colors.amber,
              fontSize: 14
          ),
        ),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            side: MaterialStateProperty.all(BorderSide(width: 1.0, color: Colors.amber)),
            shape: MaterialStateProperty.all(StadiumBorder(
                side: BorderSide(
                  style: BorderStyle.solid,
                )
            ))
        ),
      ),
    );
  }
}