import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PolularScienceDetailPage extends Page<PolularScienceDetailState, Map<String, dynamic>> {
  PolularScienceDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PolularScienceDetailState>(
                adapter: null,
                slots: <String, Dependent<PolularScienceDetailState>>{
                }),
            middleware: <Middleware<PolularScienceDetailState>>[
            ],);

}
