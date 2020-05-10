import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MeState> buildReducer() {
  return asReducer(
    <Object, Reducer<MeState>>{
      MeAction.changeVersionName: _changeVersionName,
    },
  );
}

MeState _changeVersionName(MeState state, Action action) {
  return state.clone()
    ..versionName = action.payload;
}
