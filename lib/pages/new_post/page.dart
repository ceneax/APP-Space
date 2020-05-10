import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewPostPage extends Page<NewPostState, Map<String, dynamic>> {
  NewPostPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NewPostState>(
                adapter: null,
                slots: <String, Dependent<NewPostState>>{
                }),
            middleware: <Middleware<NewPostState>>[
            ],);

}
