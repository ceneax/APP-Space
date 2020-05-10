import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:space/pages/littleCosmos/state.dart';

/// 给tabController用
class LittleCosmosComponent extends Component<LittleCosmosState> {
  @override
  LittleCosmosComponentState createState() => LittleCosmosComponentState();
}

class LittleCosmosComponentState extends ComponentState<LittleCosmosState> with SingleTickerProviderStateMixin {}