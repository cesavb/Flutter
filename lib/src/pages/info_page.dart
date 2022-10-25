import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/info_controller.dart';

import '../models/tvmaze_info_models.dart';

class TvMazeRepositoryInfo {
  final dio = Dio();
  final url = 'https://api.tvmaze.com/shows/250';

  Future<List<TvMazeInfoModel>> fetchinfo() async {
    final response = await dio.get(url);
    final list = response.data as List;

    return list.map((json) => TvMazeInfoModel.fromJson(json)).toList();
  }
}

class InfoPage extends StatefulWidget {
  const InfoPage({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final controller = Infocontroller();

  _success() {
    return WidgetCard();
  }

  _error() {
    return Center(
        child: ElevatedButton(
            onPressed: (() {
              controller.start();
            }),
            child: Text('Tente Novamente')));
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  stateManagemente(InfoState state) {
    switch (state) {
      case InfoState.start:
        return _start();
      case InfoState.loading:
        return _loading();
      case InfoState.error:
        return _error();
      case InfoState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();

    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                controller.start();
              },
              icon: Icon(Icons.search_outlined))
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagemente(controller.state.value);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class WidgetCard extends StatelessWidget {
  const WidgetCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
