import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_list/src/models/ep_models.dart';
import 'package:flutter_movie_list/src/repositories/shows_repository.dart';

class Epcontroller {
  List<EpModels> ep = [];
  final repository = RepositoryShows();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start(int id) async {
    state.value = HomeState.loading;
    try {
      ep = await repository.fetchep(id);
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
