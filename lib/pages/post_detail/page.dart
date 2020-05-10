import 'package:fish_redux/fish_redux.dart';
import 'package:space/pages/post_detail/components/ReplyDialog/component.dart';
import 'package:space/pages/post_detail/components/ReplyDialog/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PostDetailPage extends Page<PostDetailState, Map<String, dynamic>> {
  PostDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PostDetailState>(
                adapter: null,
                slots: <String, Dependent<PostDetailState>>{
                  'reply_dialog': PostDetailReplyDialogConnector() + PostDetailReplyDialogComponent(),
                }),
            middleware: <Middleware<PostDetailState>>[
            ],);

}
