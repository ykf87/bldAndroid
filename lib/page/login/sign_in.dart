import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/theme.dart';
import 'package:SDZ/widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../index.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 200.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: loginEmailController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.phone,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: '请输入手机号',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                          ),
                          // onSubmitted: (_) {
                          //   focusNodePassword.requestFocus();
                          // },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: loginPasswordController,
                          obscureText: _obscureTextPassword,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: '请输入密码',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {

                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    // BoxShadow(
                    //   color: CustomTheme.loginGradientStart,
                    //   offset: Offset(1.0, 6.0),
                    //   blurRadius: 20.0,
                    // ),
                    // BoxShadow(
                    //   color: CustomTheme.loginGradientEnd,
                    //   offset: Offset(1.0, 6.0),
                    //   blurRadius: 20.0,
                    // ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientStart,
                        CustomTheme.loginGradientEnd,
                      ],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(3.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 52.0),
                    child: Text(
                      '登 录',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () => toLogin(),
                ),
              )
            ],
          ),
          agreementWidget()
          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0),
          //   child: TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Forgot Password?',
          //         style: TextStyle(
          //             decoration: TextDecoration.underline,
          //             color: Colors.white,
          //             fontSize: 16.0,
          //             fontFamily: 'WorkSansMedium'),
          //       )),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Container(
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: <Color>[
          //                 Colors.white10,
          //                 Colors.white,
          //               ],
          //               begin: FractionalOffset(0.0, 0.0),
          //               end: FractionalOffset(1.0, 1.0),
          //               stops: <double>[0.0, 1.0],
          //               tileMode: TileMode.clamp),
          //         ),
          //         width: 100.0,
          //         height: 1.0,
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 15.0, right: 15.0),
          //         child: Text(
          //           'Or',
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 16.0,
          //               fontFamily: 'WorkSansMedium'),
          //         ),
          //       ),
          //       Container(
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: <Color>[
          //                 Colors.white,
          //                 Colors.white10,
          //               ],
          //               begin: FractionalOffset(0.0, 0.0),
          //               end: FractionalOffset(1.0, 1.0),
          //               stops: <double>[0.0, 1.0],
          //               tileMode: TileMode.clamp),
          //         ),
          //         width: 100.0,
          //         height: 1.0,
          //       ),
          //     ],
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10.0, right: 40.0),
          //       child: GestureDetector(
          //         onTap: () => CustomSnackBar(
          //             context, const Text('Facebook button pressed')),
          //         child: Container(
          //           padding: const EdgeInsets.all(15.0),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: const Icon(
          //             FontAwesomeIcons.facebookF,
          //             color: Color(0xFF0084ff),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10.0),
          //       child: GestureDetector(
          //         onTap: () => CustomSnackBar(
          //             context, const Text('Google button pressed')),
          //         child: Container(
          //           padding: const EdgeInsets.all(15.0),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: const Icon(
          //             FontAwesomeIcons.google,
          //             color: Color(0xFF0084ff),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  bool _checkSelected = false; //维护复选框开关状态
  Widget agreementWidget(){
    return new Container(
      margin: new EdgeInsets.all(26.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
            child: new Checkbox(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              value: _checkSelected,
              checkColor: Colours.color_orange_ffFF7648,
              activeColor: const Color(0xffffffff),
              onChanged: (bool) {
                print(bool);
                setState(() {
                  _checkSelected = bool!;
                });
              },
            ),
            width: 10,
            height: 10,
          ),
          new Container(
            child: new Text(
              " 阅读并同意",
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: 15.0,
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
                  color: const Color(0xff000000),
                  fontSize: 15.0,
                ),
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
                  color: const Color(0xff000000),
                  fontSize: 15.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void toLogin() {
    if(!_checkSelected){
      ToastUtils.toast('请同意并勾选用户协议和隐私政策');
      return;
    }
    if (loginEmailController.text.length == 0) {
      ToastUtils.toast('请填写您的账号');
      return;
    }
    if (loginPasswordController.text.length == 0) {
      ToastUtils.toast('请填写您的密码');
      return;
    }
    Map<String, dynamic> map = new Map();
    String phone = loginEmailController.value.text;
    String pwd = loginPasswordController.value.text;
    map['phone'] = phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    map['password'] = pwd.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.login, data: map,
        onSuccess: (data) {
          BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
          if (!entity.isSuccess) {
            ToastUtils.toast(entity.message ?? '');
            return;
          }
          ToastUtils.toast('登录成功');
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

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
