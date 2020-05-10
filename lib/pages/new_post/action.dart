import 'package:fish_redux/fish_redux.dart';

enum NewPostAction { closePage, textFieldChanged, deleteImage, addEmojiClick, addImageClick, addedImage, sendPost }

class NewPostActionCreator {

  static Action onClosePage() {
    return Action(NewPostAction.closePage);
  }

  static Action onTextFieldChanged(String data) {
    return Action(NewPostAction.textFieldChanged, payload: data);
  }

  static Action onDeleteImage(int index) {
    return Action(NewPostAction.deleteImage, payload: index);
  }

  static Action onAddEmojiClick() {
    return Action(NewPostAction.addEmojiClick);
  }

  static Action onAddImageClick() {
    return Action(NewPostAction.addImageClick);
  }

  static Action onAddedImage(var data) {
    return Action(NewPostAction.addedImage, payload: data);
  }

  static Action onSendPost() {
    return Action(NewPostAction.sendPost);
  }

}
