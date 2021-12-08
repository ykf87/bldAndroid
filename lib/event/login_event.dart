import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class LoginEvent {
  /**
   * 登录成功
   */
  static int LOGIN_TYPE_LOGIN = 1;

  /**
   * 退出成功
   */
  static int LOGIN_TYPE_LOGINOUT = 2;

  int? mLogin;

  LoginEvent(int login) {
    this.mLogin = login;
  }
}
