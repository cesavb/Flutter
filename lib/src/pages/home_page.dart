import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Homecontroller();

  _success() {
    return ListView.builder(
        itemCount: controller.show.length,
        itemBuilder: ((context, index) {
          var show = controller.show[index];

          return ListTile(
            onTap: () {
              //Passar a url para pegar a informação aqui
            },
            leading: Container(
                width: 50,
                height: 50,
                child: Image.network(show.image!.medium.toString())),
            title: Text(show.name.toString()),
          );
        }));
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
    // TODO: implement initState
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
