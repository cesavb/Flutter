import 'package:flutter_movie_list/src/repositories/shows_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final reposity = RepositoryShows();
  test('Deve trazer a primeira pagina do TVMaze Show Model', () async {
    var pagina = 1;
    final list = await reposity.fetchshow(pagina);
    print(list);
    // expect(list[0].id, 1);
  });
}
