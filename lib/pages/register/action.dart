import 'package:fish_redux/fish_redux.dart';

enum RegisterAction { changeUsername, changeNickname, changePassword, changeSex, reg }

class RegisterActionCreator {

  static Action onChangeUsername(String data) {
    return Action(RegisterAction.changeUsername, payload: data);
  }

  static Action onChangeNickname(String data) {
    return Action(RegisterAction.changeNickname, payload: data);
  }

  static Action onChangePassword(String data) {
    return Action(RegisterAction.changePassword, payload: data);
  }

  static Action onChangeSex(int data) {
    return Action(RegisterAction.changeSex, payload: data);
  }

  static Action onReg() {
    return Action(RegisterAction.reg);
  }

}
