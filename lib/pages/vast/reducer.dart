import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VastState> buildReducer() {
  return asReducer(
    <Object, Reducer<VastState>>{
      VastAction.action: _onAction,
    },
  );
}

VastState _onAction(VastState state, Action action) {
  final VastState newState = state.clone();
  return newState;
}
