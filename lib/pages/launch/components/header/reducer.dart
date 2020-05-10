import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LaunchHeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<LaunchHeaderState>>{
//      LaunchHeaderAction.action: _onAction,
    },
  );
}

//LaunchHeaderState _onAction(LaunchHeaderState state, Action action) {
//  final LaunchHeaderState newState = state.clone();
//  return newState;
//}
