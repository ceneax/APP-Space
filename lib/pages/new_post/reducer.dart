import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NewPostState> buildReducer() {
  return asReducer(
    <Object, Reducer<NewPostState>>{
      NewPostAction.textFieldChanged: _textFieldChanged,
      NewPostAction.deleteImage: _deleteImage,
      NewPostAction.addedImage: _addedImage,
    },
  );
}

NewPostState _textFieldChanged(NewPostState state, Action action) {
  return state.clone()
    ..textFieldContent = action.payload;
}

NewPostState _deleteImage(NewPostState state, Action action) {
  var tmpList = state.uploadImages;
  tmpList.removeAt(action.payload);

  return state.clone()
    ..uploadImages = tmpList;
}

NewPostState _addedImage(NewPostState state, Action action) {
  var tmpList = state.uploadImages;
  tmpList.add(action.payload);

  return state.clone()
    ..uploadImages = tmpList;
}
