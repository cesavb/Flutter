import 'package:flutter_movie_list/src/repositories/info_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final reposity = RepositoryInfo();
  int id = 250;

  test('Deve trazer a Informação da pagina do Show Escolhido', () async {
    final listinfo = await reposity.fetchinfo(id);
    print(listinfo);
    // expect(list);
  });
}
