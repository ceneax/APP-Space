import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.changeUsername: _changeUsername,
      LoginAction.changePassword: _changePassword,
    },
  );
}

LoginState _changeUsername(LoginState state, Action action) {
  return state.clone()
    ..username = action.payload;
}

LoginState _changePassword(LoginState state, Action action) {
  return state.clone()
    ..password = action.payload;
}