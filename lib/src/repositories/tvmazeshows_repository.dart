import 'package:dio/dio.dart';
import '../models/tvmaze_shows_models.dart';

class TvMazeRepositoryShows {
  final dio = Dio();
  final url = 'https://api.tvmaze.com/shows?page=1';

  Future<List<TvMazeShowsModels>> fetchshow() async {
    final response = await dio.get(url);
    final list = response.data as List;

    return list.map((json) => TvMazeShowsModels.fromJson(json)).toList();
  }
}
