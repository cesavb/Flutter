import 'package:flutter/cupertino.dart';
import '../models/info_models.dart';
import '../repositories/info_repository.dart';

class Infocontroller {
  List<InfoModel> info = [];
  final repository = RepositoryInfo();
  final state = ValueNotifier<InfoState>(InfoState.start);

  Future start(int id) async {
    state.value = InfoState.loading;
    try {
      info = await repository.fetchinfo(id);
      state.value = InfoState.success;
    } catch (e) {
      state.value = InfoState.error;
    }
  }
}

enum InfoState { start, loading, success, error }
