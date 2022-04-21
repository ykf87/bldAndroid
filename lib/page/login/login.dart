import 'dart:async';
import 'dart:io';

import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/page/login/register.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Container(
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffB5CBED),
        body: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
          ),
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 16),
          child: Column(
            children: <Widget>[
              bgWidget(),
              phoneInputWidget(),
              passwordInputWidget(),
              btnLoginWidget(),
              reigistFindpass(),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  agreementWidget()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneInputWidget() {
    return Column(
      children: [
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
          width: double.infinity,
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
            cursorColor: Colours.color_D8DADC,
            //只能输入数字
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: new InputDecoration(
              counterText: '',
              hintText: '请输入手机号码',
              hintStyle: TextStyle(color: Colours.color_D8DADC, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 0.0),
          width: double.infinity,
          height: 1,
          color: Colours.color_D8DADC,
        )
      ],
    );
  }

  Widget passwordInputWidget() {
    return Column(
      children: [
        new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
          width: double.infinity,
          child: new TextField(
            obscureText: true,
            cursorColor: Colours.color_D8DADC,
            keyboardType: TextInputType.number,
            controller: _controllerPwd,
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            decoration: new InputDecoration(
                hintText: '请输入密码',
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Colours.color_D8DADC, fontSize: 14)),
          ),
        ),
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 0.0),
          width: double.infinity,
          height: 1,
          color: Colours.color_D8DADC,
        )
      ],
    );
  }

  Widget agreementWidget() {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            width:20,
            height: 20,
            //padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new Checkbox(
              value: _checkSelected,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              checkColor: Colours.bg_ffffff,
              activeColor: Colours.color_login_77A7EF,
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
                  color: Colours.color_login_77A7EF,
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
                  color: Colours.color_login_77A7EF,
                  fontSize: 12.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget btnLoginWidget() {
    return new FlatButton(
        onPressed: () {
          toLogin();
        },
        child: new Container(
          height: 50.0,
          margin: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              gradient: new LinearGradient(colors: [
                Colours.color_login_77A7EF,
                Colours.color_login_77A7EF
              ])),
          child: new Center(
              child: new Text(
            "登 录",
            textScaleFactor: 1.1,
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          )),
        ));
  }

  Widget bgWidget() {
    return Opacity(
        opacity: 0.98,
        child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.4,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/bg_login.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }


  Widget reigistFindpass() {
    return DefaultTextStyle.merge(
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
            ])));
  }

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


  void toLogin() {
    if (!_checkSelected) {
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
      SPUtils.setUserId(entity.data?.id ?? '');
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
