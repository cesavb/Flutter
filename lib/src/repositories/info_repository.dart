import 'package:dio/dio.dart';
import '../models/info_models.dart';

class RepositoryInfo {
  final client = Dio(BaseOptions(baseUrl: 'https://api.tvmaze.com'));

  Future<List<InfoModel>> fetchinfo(id) async {
    final response = await client.get('/shows/$id');
    final list = response.data as List;

    return list.map((json) => InfoModel.fromJson(json)).toList();
  }
}
