import 'package:flutter/cupertino.dart';
import '../models/shows_models.dart';
import '../repositories/shows_repository.dart';

class Searchcontroller {
  List<ShowsModels> show = [];
  final repository = RepositoryShows();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start(String searchFieldLabel) async {
    state.value = HomeState.loading;
    try {
      show = await repository.fetchshow(searchFieldLabel);
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error, id }
