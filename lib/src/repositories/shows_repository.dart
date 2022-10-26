import 'package:dio/dio.dart';
import '../models/shows_models.dart';

class RepositoryShows {
  final client = Dio(BaseOptions(baseUrl: 'https://api.tvmaze.com'));

  Future<List<ShowsModels>> fetchshow(pagina) async {
    final response = await client.get('/shows?page=$pagina');
    final list = response.data as List;

    return list.map((json) => ShowsModels.fromJson(json)).toList();
  }
}
