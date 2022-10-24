import 'package:dio/dio.dart';
import '../models/tvmaze_info_models.dart';

class TvMazeRepositoryInfo {
  final dio = Dio();
  final url = 'https://api.tvmaze.com/shows/250';

  Future<List<TvMazeInfoModel>> fetchinfo() async {
    final response = await dio.get(url);
    final listinfo = response.data as List;

    return listinfo.map((json) => TvMazeInfoModel.fromJson(json)).toList();
  }
}
