import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PolularScienceState> buildReducer() {
  return asReducer(
    <Object, Reducer<PolularScienceState>>{
      PolularScienceAction.indexChanged: _indexChanged,
      PolularScienceAction.refreshed: _refreshed,
      PolularScienceAction.loadMoreFinished: _loadMoreFinished,
    },
  );
}

PolularScienceState _indexChanged(PolularScienceState state, Action action) {
  return state.clone()
    ..currentIndex = action.payload;
}

PolularScienceState _refreshed(PolularScienceState state, Action action) {
  return state.clone()
    ..currentPage = 1
    ..polularSciences = action.payload;
}

PolularScienceState _loadMoreFinished(PolularScienceState state, Action action) {
  var tmpData = state.polularSciences;
  tmpData.addAll(action.payload);

  return state.clone()
    ..currentPage = state.currentPage + 1
    ..polularSciences = tmpData;
}