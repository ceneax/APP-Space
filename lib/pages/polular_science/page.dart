import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PolularSciencePage extends Page<PolularScienceState, Map<String, dynamic>> {
  PolularSciencePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PolularScienceState>(
                adapter: null,
                slots: <String, Dependent<PolularScienceState>>{
                }),
            middleware: <Middleware<PolularScienceState>>[
            ],);

}
