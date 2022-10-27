import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/home_controller.dart';
// import 'package:flutter_movie_list/src/controllers/info_controller.dart';
import 'package:http/http.dart';

class InfoPage extends StatefulWidget {
  const InfoPage(
      {super.key,
      required this.title,
      required this.id,
      required this.poster,
      required this.gen,
      required this.summary});

  final String title;
  final int id;
  final String poster;
  final String gen;
  final String summary;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

// pegar direto da primeiro link as informações

class _InfoPageState extends State<InfoPage> {
  final controller = Homecontroller();

  _success() {
    // return ListView.builder(
    //     itemCount: controller.show.length,
    //     itemBuilder: ((context, index) {
    return Card(
      child: Container(
        child: Stack(children: [
          SizedBox(
              width: 350,
              height: 350,
              child: Image.network(widget.poster.toString())),
          SizedBox(
            width: 300,
            height: 100,
            child: Text(widget.title.toString()),
          ),
        ]),
      ),
    );
    // }));
  }

  _error() {
    return Center(
        child: ElevatedButton(
            onPressed: (() {
              controller.start(widget.id);
            }),
            child: Text('Tente Novamente')));
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  stateManagemente(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    var id = widget.id;
    controller.start(id);
  }

  @override
  Widget build(BuildContext context) {
    var id = widget.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                // controller.start(id);
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
