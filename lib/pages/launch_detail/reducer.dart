import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LaunchDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<LaunchDetailState>>{
      LaunchDetailAction.inited: _inited,
    },
  );
}

LaunchDetailState _inited(LaunchDetailState state, Action action) {
  return state.clone()
    ..expandedHeight = action.payload;
}
