import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_list/src/models/ep_models.dart';
import 'package:flutter_movie_list/src/repositories/shows_repository.dart';

class Epcontroller {
  List<EpModels> ep = [];
  final repository = RepositoryShows();
  final state = ValueNotifier<EpState>(EpState.start);

  Future start(int id) async {
    state.value = EpState.loading;
    try {
      ep = await repository.fetchep(id);
      state.value = EpState.success;
    } catch (e) {
      state.value = EpState.error;
    }
  }
}

enum EpState { start, loading, success, error }
