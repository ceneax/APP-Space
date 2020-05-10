import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LookState> buildReducer() {
  return asReducer(
    <Object, Reducer<LookState>>{
      LookAction.refreshed: _refreshed,
      LookAction.loadMoreFinished: _loadMoreFinished,
    },
  );
}

LookState _refreshed(LookState state, Action action) {
  return state.clone()
    ..currentPage = 1
    ..videos = action.payload;
}

LookState _loadMoreFinished(LookState state, Action action) {
  var tmpVideos = state.videos;
  tmpVideos.addAll(action.payload);

  return state.clone()
    ..currentPage = state.currentPage + 1
    ..videos = tmpVideos;
}