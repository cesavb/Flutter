import 'package:dio/dio.dart';
import '../models/tvmaze_info_models.dart';

class TvMazeRepositoryInfo {
  final dio = Dio();
  final url = 'https://api.tvmaze.com/shows/';

  Future<List<TvMazeInfoModel>> fetchinfo() async {
    final response = await dio.get(url);
    final list = response.data as List;

    return list.map((json) => TvMazeInfoModel.fromJson(json)).toList();
  }
}
