import 'package:flutter_movie_list/src/repositories/tvmazeinfo_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final reposity = TvMazeRepositoryInfo();
  test('Deve trazer a Informação da pagina do Show Escolhido', () async {
    final listinfo = await reposity.fetchinfo();
    print(listinfo.toString());
    // expect(list);
  });
}
