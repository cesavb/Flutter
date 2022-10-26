import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/info_controller.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key, required this.title, required this.id});
  final String title;
  final int id;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

// pegar direto da primeiro link as informações

class _InfoPageState extends State<InfoPage> {
  final controller = Infocontroller();

  _success() {
    return ListView.builder(
        itemCount: controller.info.length,
        itemBuilder: ((context, index) {
          var info = controller.info[index];

          return Card(
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(
                  child: ListTile(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => {});
                },
                leading: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(info.image!.medium.toString())),
                title: Text(info.name.toString(),
                    style: const TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 39, 52, 34))),
              )),
            ),
          );
        }));
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
                controller.start(id);
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
