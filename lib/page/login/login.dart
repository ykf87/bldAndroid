import 'dart:async';
import 'dart:io';

import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/page/login/register.dart';
import 'package:SDZ/page/menu/register.dart';
import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
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

class _LoginPageState extends BaseStatefulState<LoginPage>
    with SingleTickerProviderStateMixin {
  var toMain = false;
  late TextEditingController _controller;
  bool _isChecked = false;
  bool _nextBtnEnable = false;
  StreamSubscription<LoginEvent>? _bus;
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();
  bool _checkSelected = false; //维护复选框开关状态

  @override
  void initData() {
    super.initData();
    _bus = EventBusUtils.getInstance().on<LoginEvent>().listen((event) {
      if (event.mLogin == LoginEvent.LOGIN_TYPE_LOGIN &&
          Navigator.canPop(context)) {
        Get.back();
      }
    });
    _controller = new TextEditingController(
        text: Utils.splitPhoneNumber(SPUtils.getUserAccount()));
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

  @override
  void initNavigatorClickListener() {
    super.initNavigatorClickListener();
    onCloseKeyboard();
    if (!toMain && Navigator.canPop(context)) {
      Get.back();
    } else {
      Get.offAll(() => MainHomePage());
    }
  }

  @override
  bool interceptNavigatorBackClick() => true;

  @override
  bool isShowNavigator() => false;

  @override
  Widget initDefaultBuild(BuildContext context) {
    // TODO: implement build
    Widget phoneInputWidget = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: new TextField(
        controller: _controllerPhone,
        maxLines: 1,
        maxLength: 11,
        onChanged: (String value) {
          // _userName=value;
        },
        style: new TextStyle(fontSize: 16.0, color: Colors.black),
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: new InputDecoration(
          hintText: '请输入手机号码',
          icon: new Image.asset(
            'assets/images/phone_icon.png',
            width: 20.0,
            height: 20.0,
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );
    Widget passwordInputWidget = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: new TextField(
        obscureText: true,
        keyboardType: TextInputType.number,
        controller: _controllerPwd,
        style: new TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: new InputDecoration(
          hintText: '请输入密码',
          icon: new Image.asset(
            'assets/images/password_icon.png',
            width: 20.0,
            height: 20.0,
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );

    Widget btnLoginWidget = new FlatButton(
        onPressed: () {
          toLogin();
        },
        child: new Container(
          height: 45.0,
          margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              gradient: new LinearGradient(
                  colors: [const Color(0xFFe9546b), const Color(0xFFd0465b)])),
          child: new Center(
              child: new Text(
            "登 录",
            textScaleFactor: 1.1,
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          )),
        ));

    ///注册
    void _signUpAction() {
      setState(() {
        Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new BldRegisterPage();
          },
        ));
      });
    }

    // DefaultTextStyle.merge允许您创建一个默认文本，由子控件和所有后续子控件继承的风格
    var reigistFindpass = DefaultTextStyle.merge(
        child: new Container(
            padding: new EdgeInsets.all(0.0),
            child:
                new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              new Column(children: [
                new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new FlatButton(
                    onPressed: _signUpAction,
                    child: new Text(
                      "免费注册",
                      style: TextStyle(
                        color: const Color(0xFF999999),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ]),
              // new Column(children: [
              //   new Container(
              //     width: 0.4,
              //     height: 20.0,
              //     decoration: new BoxDecoration(
              //       color: const Color(0xFF999999),
              //     ),
              //   ),
              // ]),
            ])));

    Widget agreementWidget = new Container(
      padding: new EdgeInsets.all(0.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            //padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new Checkbox(
              value: _checkSelected,
              activeColor: const Color(0xffe9546b),
              onChanged: (bool) {
                print(bool);
                setState(() {
                  _checkSelected = bool!;
                });
              },
            ),
          ),
          new Container(
            child: new Text(
              " 阅读并同意",
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: 12.0,
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              Get.to(() => PrivacyPolicyPage(false));
            },
            child: new Container(
              child: new Text(
                "《用户协议》",
                style: new TextStyle(
                  color: const Color(0xffe9546b),
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          new Container(
            child: new Text(
              " 和",
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: 12.0,
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              Get.to(() => PrivacyPolicyPage(true));
            },
            child: new Container(
              child: new Text(
                "《隐私政策》",
                style: new TextStyle(
                  color: const Color(0xffe9546b),
                  fontSize: 12.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
    Widget contentWidget = new Center(
      child: new Container(
        constraints: new BoxConstraints.expand(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 450.0,
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(
            color: Colors.white,
            width: 5.0,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '账号密码登录',
              style: new TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            phoneInputWidget,
            passwordInputWidget,
            btnLoginWidget,
            reigistFindpass,
            agreementWidget
          ],
        ),
      ),
    );
    Widget bgWidget = new Opacity(
        opacity: 0.98,
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/login_back.png'),
              fit: BoxFit.cover,
            ),
          ),
        ));

    return Container(
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          children: <Widget>[
            bgWidget,
            new ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 60.0, bottom: 50.0),
                  child: new Center(
                      child: new Image.asset(
                    'assets/images/ic_logo.jpg',
                    width: 50.0,
                    height: 50.0,
                  )),
                ),
                contentWidget,
              ],
            )
          ],
        ),
      ),
    );

    // return WillPopScope(child: Column(
    //   children: [
    //     Expanded(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             margin: const EdgeInsets.only(left: 20,top: 40),
    //             child: Text('欢迎登陆省得赚', style: TextStyle(color: Colors.black, fontSize:28),)
    //           ),
    //           SizedBox(height: 30,),
    //           inputWidget("请输入手机号",_controllerPhone),
    //           SizedBox(height: 10,),
    //           inputWidget("请输入密码",_controllerPwd,isPwd: true),
    //           getLoginButtonWidget(),
    //           // getAgreementWidget(),
    //         ],
    //       ),
    //     ),
    //     // getOtherLoginWidget()
    //   ],
    // ), onWillPop: () => _callback());
  }

  var _contentPadding = EdgeInsets.only(bottom: 8);

  Future<bool> _callback() async {
    FocusScope.of(context).unfocus(); //取消焦点
    return true;
  }

  Widget inputWidget(String hintText, TextEditingController controller,
      {isPwd = false}) {
    return Container(
      height: 44,
      width: double.infinity,
      margin: EdgeInsets.only(right: 20, top: 16, left: 20),
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colours.bg_f7f8f8,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Center(
        child: TextField(
          obscureText: isPwd,
          inputFormatters: [
            LengthLimitingTextInputFormatter(13),
            CustomTextInputFormatter(
              filterPattern: RegExp("[0-9]"),
            ),
            PhoneFormatter()
          ],
          onChanged: (text) {
            onTextChange();
          },
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 16, top: 10, right: 0, bottom: 12),
            hintText: hintText,
            hintStyle: TextStyle(color: Colours.text_gray_c, fontSize: 15),
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  /// 手机号
  Widget getInputWidget() {
    return Container(
        margin: const EdgeInsets.only(left: 20, top: 32, right: 20),
        padding: const EdgeInsets.only(top: 5),
        height: 56,
        decoration: BoxDecoration(
            color: Colours.bg_ffffff, borderRadius: BorderRadius.circular((8))),
        child: Stack(alignment: Alignment.centerRight, children: [
          TextField(
            maxLines: 1,
            focusNode: focusNode,
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
              setState(() {});
            },
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: _contentPadding,
              hintText: '请输入手机号码',
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colours.color_A1A3AC,
                  textBaseline: TextBaseline.alphabetic),
            ),
            style: TextStyle(fontSize: 24, color: Colours.text),
          ),
          _controller.text.isNotEmpty && focusNode.hasFocus
              ? Positioned(
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.cancel),
                    color: Colors.grey,
                    onPressed: () {
                      // _contentPadding = EdgeInsets.only(bottom: 8);
                      _controller.clear();
                      _nextBtnEnable = false;
                      setState(() {});
                    },
                  ),
                  bottom: 6,
                  top: 3,
                )
              : Text(''),
        ]));
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
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
              });
            },
          ),
          RichText(
            text: TextSpan(
                text: '《用户协议》',
                style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    FocusScope.of(context).unfocus(); //取消焦点
                    Get.to(() => PrivacyPolicyPage(false));
                  },
                children: [
                  TextSpan(
                      text: '与',
                      style:
                          TextStyle(color: Colours.color_6A6E7E, fontSize: 12)),
                  TextSpan(
                    text: '《隐私政策》',
                    style: TextStyle(color: Colours.color_6A6E7E, fontSize: 12),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        FocusScope.of(context).unfocus(); //取消焦点
                        Get.to(() => PrivacyPolicyPage(true));
                      },
                  ),
                ]),
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
        onPressed: _nextBtnEnable
            ? () {
                // getInfo();
                toLogin();
              }
            : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_nextBtnEnable
              ? Colours.color_FF193C
              : Colours.color_gray_EFF0F2),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: Text(
          '登录',
          style: TextStyle(
              fontSize: 16,
              color: _nextBtnEnable ? Colors.white : Colours.color_6A6E7E),
        ),
      ),
    );
  }

  void onTextChange() {
    if (_controllerPwd.text.length != 0 && _controllerPhone.text.length != 0) {
      _nextBtnEnable = true;
    } else {
      _nextBtnEnable = false;
    }
    setState(() {});
  }

  void getInfo() {
    SPUtils.setUserToken(
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsIkF1dGhvciI6bnVsbH0.eyJpc3MiOiJHT1VRSSIsImF1ZCI6Imh0dHA6Ly80NS43Ny4yMTYuMjQxIiwiaWF0IjoxNjQwMjQ1NDIxLjEzMTQyNCwibmJmIjoxNzAzMzE3NDIxLjEzMTQyNCwiaWQiOjcsInBob25lIjoiZXlKcGRpSTZJaTh5WmpOc1JrSktZMHc1WVhGeFEzaHZPRVpFSzJjOVBTSXNJblpoYkhWbElqb2lMMHg0Um1WVVZXdEdla2MxWjFwdVdVTm1PVTlCUVQwOUlpd2liV0ZqSWpvaVpUSXdOelJrWmpnME5UY3laamN3Wm1ZM01XRTVaakF4TmpkallqTmtOMkZpT1RneU1qSXhNV0poTWpJNU4ySm1OVEpqT0dRNFpURXdabU5qTmpsaU1TSjkiLCJzdGF0dXMiOjF9.BaCVllxXkharXdL-GWgB6yfvXbHx9ZMA4njFSk8FVtU');
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.getGlobalConfig,
        onSuccess: (data) {
      BaseEntity<GlobalEntity> entity = BaseEntity.fromJson(data!);
      ToastUtils.toast('成功');
    }, onError: (msg) {});
  }

  void toLogin() {
    if(!_checkSelected){
      ToastUtils.toast('请同意并勾选用户协议和隐私政策');
      return;
    }
    if (_controllerPhone.text.length == 0) {
      ToastUtils.toast('请填写您的账号');
      return;
    }
    if (_controllerPwd.text.length == 0) {
      ToastUtils.toast('请填写您的密码');
      return;
    }
    Map<String, dynamic> map = new Map();
    String phone = _controllerPhone.value.text;
    String pwd = _controllerPwd.value.text;
    map['phone'] = phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    map['password'] = pwd.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.login, data: map,
        onSuccess: (data) {
      BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
      if (!entity.isSuccess) {
        ToastUtils.toast(entity.message ?? '');
        return;
      }
      // ToastUtils.toast('登录成功');
      SPUtils.setUserId(entity.data?.accountId ?? '');
      SPUtils.setUserToken(entity.data?.token ?? '');
      SPUtils.setUserAccount(phone);
      SPUtils.setUserNickName(entity.data?.nickname ?? '');
      SPUtils.setAvatar(entity.data?.avatar ?? '');
      EventBusUtils.getInstance().fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
      Get.offAll(() => MainHomePage());
    }, onError: (msg) {
      ToastUtils.toast(msg);
    });
  }
}
