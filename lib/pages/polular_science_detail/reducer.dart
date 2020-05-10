import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PolularScienceDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<PolularScienceDetailState>>{
      PolularScienceDetailAction.setData: _setData,
    },
  );
}

PolularScienceDetailState _setData(PolularScienceDetailState state, Action action) {
  return state.clone()
    ..data = action.payload;
}