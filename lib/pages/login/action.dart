import 'package:fish_redux/fish_redux.dart';

enum LoginAction { changeUsername, changePassword, registerPage, login }

class LoginActionCreator {

  static Action onChangeUsername(String data) {
    return Action(LoginAction.changeUsername, payload: data);
  }

  static Action onChangePassword(String data) {
    return Action(LoginAction.changePassword, payload: data);
  }

  static Action onRegisterPage() {
    return Action(LoginAction.registerPage);
  }

  static Action onLogin() {
    return Action(LoginAction.login);
  }

}
