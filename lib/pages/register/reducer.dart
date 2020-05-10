import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterState>>{
      RegisterAction.changeUsername: _changeUsername,
      RegisterAction.changeNickname: _changeNickname,
      RegisterAction.changePassword: _changePassword,
      RegisterAction.changeSex: _changeSex,
    },
  );
}

RegisterState _changeUsername(RegisterState state, Action action) {
  return state.clone()
    ..username = action.payload;
}

RegisterState _changeNickname(RegisterState state, Action action) {
  return state.clone()
    ..nickname = action.payload;
}

RegisterState _changePassword(RegisterState state, Action action) {
  return state.clone()
    ..password = action.payload;
}

RegisterState _changeSex(RegisterState state, Action action) {
  return state.clone()
    ..dropDownButtonValue = action.payload;
}