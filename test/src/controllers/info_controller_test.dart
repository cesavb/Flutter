import 'package:flutter_movie_list/src/controllers/home_controller.dart';
import 'package:flutter_movie_list/src/controllers/info_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final controller = Infocontroller();

  test('Deve preencher a variavel', () async {
    await controller.start();
    expect(controller.info.isNotEmpty, true);
  });
}
