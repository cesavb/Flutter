import 'package:flutter/cupertino.dart';
import '../models/shows_models.dart';
import '../repositories/shows_repository.dart';

class Homecontroller {
  List<ShowsModels> show = [];
  final repository = RepositoryShows();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start(int pagina) async {
    state.value = HomeState.loading;
    try {
      show = await repository.fetchshow(pagina);
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error, id }
