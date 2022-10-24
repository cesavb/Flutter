import 'package:flutter/cupertino.dart';

import '../models/tvmaze_info_models.dart';
import '../repositories/tvmazeinfo_repository.dart';

class Infocontroller {
  List<TvMazeInfoModel> info = [];
  final repository = TvMazeRepositoryInfo();
  final state = ValueNotifier<InfoState>(InfoState.start);

  Future start() async {
    state.value = InfoState.loading;
    try {
      info = await repository.fetchinfo();
      state.value = InfoState.success;
    } catch (e) {
      state.value = InfoState.error;
    }
  }
}

enum InfoState { start, loading, success, error }
