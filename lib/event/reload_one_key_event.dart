/// @Author: ljx
/// @CreateDate: 2021/9/29 16:28
/// @Description: 
class ReLoadOneKeyLoginEvent {


  static int LOGIN = 1;

  static int BACK = 2;

  int? mLogin;

  ReLoadOneKeyLoginEvent(int login) {
    this.mLogin = login;
  }

}