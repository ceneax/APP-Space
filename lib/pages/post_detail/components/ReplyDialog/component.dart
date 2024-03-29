import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PostDetailReplyDialogComponent extends Component<PostDetailReplyDialogState> {
  PostDetailReplyDialogComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PostDetailReplyDialogState>(
                adapter: null,
                slots: <String, Dependent<PostDetailReplyDialogState>>{
                }),);

}
