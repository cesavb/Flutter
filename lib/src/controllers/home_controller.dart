import 'package:flutter/cupertino.dart';

import '../models/tvmaze_shows_models.dart';
import '../repositories/tvmazeshows_repository.dart';

class Homecontroller {
  List<TvMazeShowsModels> show = [];
  final repository = TvMazeRepositoryShows();
  final state = ValueNotifier<HomeState>(HomeState.start);

  // HomeState state = HomeState.start;

  Future start() async {
    state.value = HomeState.loading;
    try {
      show = await repository.fetchshow();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
