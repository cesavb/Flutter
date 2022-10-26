import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/home_controller.dart';
import 'package:flutter_movie_list/src/pages/info_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Homecontroller();

  var pagina = 1;

  _success() {
    return ListView.builder(
        itemCount: controller.show.length,
        itemBuilder: ((context, index) {
          var show = controller.show[index];

          return Card(
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InfoPage(
                              title: show.name.toString(),
                              id: show.id!.toInt(),
                            )));
                  },
                  leading: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.network(show.image!.medium.toString())),
                  title: Text(show.name.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 39, 52, 34))),
                ),
              ),
            ),
          );
        }));
  }

  _error() {
    return Center(
        child: ElevatedButton(
            onPressed: (() {
              controller.start(pagina);
            }),
            child: const Text('Tente Novamente')));
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
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
    // controller = Homecontroller(page: pagina);
    controller.start(pagina);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                // controller.start(pagina);
              },
              icon: const Icon(Icons.search_outlined)),
          IconButton(
              onPressed: () => {pagina--, controller.start(pagina)},
              icon: const Icon(Icons.keyboard_arrow_left_outlined)),
          IconButton(
              onPressed: () => {pagina++, controller.start(pagina)},
              icon: const Icon(Icons.keyboard_arrow_right_outlined))
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagemente(controller.state.value);
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
