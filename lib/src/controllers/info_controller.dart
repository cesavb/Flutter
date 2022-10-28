import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_list/src/repositories/shows_repository.dart';
import '../models/shows_models.dart';
import '../models/info_models.dart';
import '../repositories/info_repository.dart';

class Infocontroller {
  List<InfoModel> info = [];
  final repository = RepositoryInfo();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start(int id) async {
    state.value = HomeState.loading;
    try {
      // info = await repository.fetchinfo(id);
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
