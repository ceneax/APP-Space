import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscuzState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscuzState>>{
      DiscuzAction.reset: _reset,
      DiscuzAction.loadMoreFinished: _loadMoreFinished,
    },
  );
}

DiscuzState _reset(DiscuzState state, Action action) {
  final DiscuzState newState = state.clone();
  var posts = action.payload;

  newState.posts = posts;
  newState.currentPage = 1;

  return newState;
}

DiscuzState _loadMoreFinished(DiscuzState state, Action action) {
  var tmpPosts = state.posts;
  tmpPosts.addAll(action.payload);

  return state.clone()
    ..posts = tmpPosts
    ..currentPage = state.currentPage + 1;
}