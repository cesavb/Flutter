import 'package:dio/dio.dart';
import '../models/info_models.dart';

class RepositoryInfo {
  final client = Dio(BaseOptions(baseUrl: 'https://api.tvmaze.com'));

  Future<InfoModel> fetchinfo(id) async {
    final response = await client.get('/shows/$id');
    final list = response.data;

    return list;
  }
}
