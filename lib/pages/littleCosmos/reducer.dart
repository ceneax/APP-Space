import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LittleCosmosState> buildReducer() {
  return asReducer(
    <Object, Reducer<LittleCosmosState>>{
      LittleCosmosAction.inited: _inited,
    },
  );
}

LittleCosmosState _inited(LittleCosmosState state, Action action) {
  return state.clone()
    ..tabController = action.payload;
}