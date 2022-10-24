import 'package:flutter_movie_list/src/repositories/tvmazeshows_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final reposity = TvMazeRepositoryShows();
  test('Deve trazer a primeira pagina do TVMaze Show Model', () async {
    final list = await reposity.fetchshow();
    // print(list[0]);
    expect(list[0].id, 1);
  });
}
