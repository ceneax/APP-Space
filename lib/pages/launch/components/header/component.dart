import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LaunchHeaderComponent extends Component<LaunchHeaderState> {
  LaunchHeaderComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LaunchHeaderState>(
                adapter: null,
                slots: <String, Dependent<LaunchHeaderState>>{
                }),);

}
