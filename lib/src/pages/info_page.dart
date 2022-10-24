import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/home_controller.dart';
import 'package:flutter_movie_list/src/controllers/info_controller.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key, required this.title});
  final String title;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final controller = Infocontroller();

  _success() {
    return ListView.builder(
        itemCount: controller.info.length,
        itemBuilder: ((context, index) {
          var info = controller.info[index];

          return ListTile(
            onTap: () {
              //Passar a url para pegar a informação aqui
              Navigator.of(context).pushNamed('/home');
            },
            leading: Container(
                width: 50,
                height: 50,
                child: Image.network(info.image!.medium.toString())),
            title: Text(info.name.toString()),
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
